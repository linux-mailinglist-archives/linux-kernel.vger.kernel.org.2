Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DA46014C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhK0T4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbhK0Tye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:54:34 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D005C0613D7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 11:48:37 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so53522533edd.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 11:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+WD13DnrXMzqv5sT4ElYQPrredLdicNs7FcvpypMvw=;
        b=ggD12LSgQGpOuKA978T0sePFYeQGzUd++Kya77nHEr8H2Y5U3s7Zev6jYWlM8g15zO
         5Nx2G7t6c+rf7GGAFSCpQZHxkt5OsQEtBXocSqZLsTflKlP069Y6vTvdom+R8sqCaKUw
         raWaWu426UTiqy4O9nfelPn8PFHOxakZIgTU2W7kcNGQpO0/++2YRvyDr2I3SrXmDQDu
         1WXMLGMEZkRCaF0fcMj7B97yK/UvWka83ZyeYu2k+zh5GsHFtnmwVVhil+n7bNYTEFKF
         X7uNLZtrn4UGiqMgjSrR41qUhKmTbXBfSPwcJban6ogspnPTMJr2I3EqiFsJEdHq0nAW
         GO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+WD13DnrXMzqv5sT4ElYQPrredLdicNs7FcvpypMvw=;
        b=4BrdhYpMk7qhIw8SOugXJkSWzrM6Lsq9J/Esm7C9GfqZS9DpLYOojYlD/xe/1N5WNc
         UNj7knFagRpXJ85nw0osYBZgpfsxMVVWX6WynkIOf6B1nO/8kALO7XtLxgsKah4YuNr3
         JLnsRKDx5UMqKNScsDdSM8TOFEGq7/1bZ3j4X2H1Jaa7390/RZYlEZw2do7v65CcOLV/
         eGfCzAeL1I3kVhg1VXX5BIezrsrozA8F3Y28qUTsehm6VobcOKnhC2GZjFNpvC9g5zbM
         ZTCDJkVluLSRhiiViwdDX57T7GLw55AqzcaWdw9dsv8cN70NY/4w5pS9l8dk4t/TefKI
         vpAA==
X-Gm-Message-State: AOAM5310Ca1SFs8pwNEF1gKRT+rPfDsvrPd6gCa8p5wibmsa3OYkd+2L
        x9qUogytlmQBsrLT1uHSK2JirRmrgq8qZtuXJ3aGBg==
X-Google-Smtp-Source: ABdhPJw0is2PzWlMWDR3TZyj9QAnUHxP4u+3yMhqpCEGNgRGps4GUpD1lk/8f8bPRqTYXYiiKhXliWlL2FAx25XiMY4=
X-Received: by 2002:a17:906:58ce:: with SMTP id e14mr46457043ejs.525.1638042515857;
 Sat, 27 Nov 2021 11:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-3-pasha.tatashin@soleen.com> <6d82e674-76dc-f3b0-2e53-a92eeb249eff@gmail.com>
In-Reply-To: <6d82e674-76dc-f3b0-2e53-a92eeb249eff@gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Sat, 27 Nov 2021 14:48:00 -0500
Message-ID: <CA+CK2bAX2XmMrt9RBGiUV7LG_sbpB7ov6bxMVjr5FSBVirE1CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: page table check
To:     Fusion Future <qydwhotmail@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 3:41 AM Fusion Future <qydwhotmail@gmail.com> wrote:
>
> It seems after updating to linux-next-20211125, my system is crashing
> frequently due to "kernel BUG at mm/page_table_check.c:101".

Thank you for reporting this issue:

 99                 if (anon) {
100                         BUG_ON(atomic_read(&ptc->file_map_count));
101                         BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);

This BUG_ON checks that during unmap anon map counter (cleared in
ptep_clear_flush()) does not become negative. If it becomes negative
it means that we missed accounting for this anon mapping during
set_pte(). Is there a config and environment that I could use to repro
this problem?

Thank you,
Pasha
