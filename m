Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD0730AF0E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhBASWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhBASTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:19:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB86C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:18:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m22so24121048lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UAbKT5Ya/3nmMicg3QL4hHMXb1Wf9l2636Y0rFmMTCI=;
        b=KxXEVt0+tyWiM4ueJ+oPNmP1vQumfFNdlkPtGeuT6M3fT8Ulvu4TrzLkYgbLqRcWyO
         pw244rLrs28gBE/Jupb2SO4ZoMRQ//wmyUsbNxbm5HOMA9bzbXT+fgdzkefD87RiUhUO
         v9RVbyybVt+LqKr6tc20520PzRGp0iZT3x5yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAbKT5Ya/3nmMicg3QL4hHMXb1Wf9l2636Y0rFmMTCI=;
        b=ake0IxWzkdnLA9yG9afCU2xijsUVXoHv62Pn8s8dM1PtpjgCvJB0XeOBknLyLfA0eK
         p+4snjznJHZPo6EBo9x5YVs+1Jcoyh/bkGSI4ET4AkFJu92kXHatNQwySJHOw4/9iZp0
         a9b5Ake0Ulc6P1s23tNVWKy8wEhsrd2chA7ZxauGsaeH6jsztGTrnv+vd0AIFDzqlykF
         PHlm0CiR+xTtUY/Ef4oTGv9yF4pF7+VQ1V5IH0igC8ulihEB/2lRA7EbMkAuB/htiUCk
         6ZyWsab+TQKgwBVQ0hRBLulHaS9npz5AYHYzNwxNL7lckWJudT4SEVsm7EGzfaQ2RyUZ
         Yytw==
X-Gm-Message-State: AOAM532bi3IVpzpHmL2hdTa97Em7FLPVEMbnGRkLhmRbX0a00ony3Kr7
        1rICARRv68sanzBVd4pt0EJdDPW4D8Ckow==
X-Google-Smtp-Source: ABdhPJxUiJYF76o6iF2R4OVLZIqUCchmmy6CKNyCGQl4YgZkGQzP/mqm3ilxiGD2twaoJriUfqloPw==
X-Received: by 2002:ac2:568e:: with SMTP id 14mr9003515lfr.413.1612203532911;
        Mon, 01 Feb 2021 10:18:52 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g27sm3058858lfh.291.2021.02.01.10.18.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 10:18:52 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id p21so24123318lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:18:51 -0800 (PST)
X-Received: by 2002:a05:6512:a8c:: with SMTP id m12mr9078111lfu.253.1612203531475;
 Mon, 01 Feb 2021 10:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20210201174555.GA17819@redhat.com>
In-Reply-To: <20210201174555.GA17819@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Feb 2021 10:18:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKeFHBn60eJJjvJOW2+bdtwbeSb12R+=PBQJSSHe+FbA@mail.gmail.com>
Message-ID: <CAHk-=wjKeFHBn60eJJjvJOW2+bdtwbeSb12R+=PBQJSSHe+FbA@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 0/4] x86: fix get_nr_restart_syscall()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 9:46 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Somehow I forgot about this problem. Let me resend the last version
> based on discussion with Linus. IIRC he was agree with this series.

Yeah, looks sane to me.

            Linus
