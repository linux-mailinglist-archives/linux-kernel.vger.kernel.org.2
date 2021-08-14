Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0776A3EBEEA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 02:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhHNABv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 20:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhHNABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 20:01:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9899C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:01:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c12so4998176ljr.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0cQp32u2NcF373v0msQLwNnp6SgdDQeg+zlfqlBCVxs=;
        b=SJyek2YQs4GDm1j+iR12mh5bJ6WcoWHnhdxpt+Vhgxrlod0jOP5GKLmoHjrwhqjsWi
         u2V0jkpnLbuh67x7TlDaX9SNcNBLFOe36WHBPUU4HkqSTpUY3CnXZqYZyVa6zmdJtKY/
         9RA0VS4lPd4K7/d9SMH7XVFIYSR4u2zak2hVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cQp32u2NcF373v0msQLwNnp6SgdDQeg+zlfqlBCVxs=;
        b=q24214CbdqXfUaRUAkBx4OzHqm0v60QblBKssIGSklfkqO1fxYb/Dm3bsIWGtHtNvd
         jdj8Ua8dU53XFSG3Y7G5s5xWM3xNsgefhNqtDwP24zoCu6Z8dpiAnZFc25eQ2EEakO6Z
         qqGaHHX0UFQdP4k2eNajILEnThPoDsBQMfgqGcdTBOYT6XIqfuBkZg1k6UK+4Rn2xBts
         YIudIstZEEcy+wQbry2N9buUywLo7trUug9zROWLuiY0U1efx4MFAc8xMgEHaJfbxOL+
         4KuZyALhshygFkldrfqqlSqgz5f8vJ5iAIZLRfBbGhFLYf7cG+ufuZe2EhRy7wOY7FP2
         G+ZA==
X-Gm-Message-State: AOAM531Lfn7utKAe3dom6YgkafAoNZlTZBYT3W5SBpZx/61GePVBZS+F
        SULSLdl/afPkis9N0tfedPbGMgtWU/1qzZGw
X-Google-Smtp-Source: ABdhPJz1IUErzPYP9JtfoauHADrZTjBGb7tYEMDHl/0abYzs8+TjKj1jfORnlPlZ9lYUEFl9Yu9s4g==
X-Received: by 2002:a2e:a911:: with SMTP id j17mr3589877ljq.341.1628899277961;
        Fri, 13 Aug 2021 17:01:17 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id f14sm308760ljk.42.2021.08.13.17.01.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 17:01:17 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id p38so23138596lfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:01:17 -0700 (PDT)
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr3318792lfn.41.1628899276905;
 Fri, 13 Aug 2021 17:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210813224131.25803-1-rdunlap@infradead.org>
In-Reply-To: <20210813224131.25803-1-rdunlap@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Aug 2021 14:01:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj4chmL3TUdXHhAV+eU-YVNj-ZtZBjNJEFBzTnPMP3_bA@mail.gmail.com>
Message-ID: <CAHk-=wj4chmL3TUdXHhAV+eU-YVNj-ZtZBjNJEFBzTnPMP3_bA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: use -Wno-main in the full kernel tree
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:41 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Build-tested on most ARCHes.

How about old versions of gcc? Or clang?

From a quick google, it seems like '-Wmain' means something else for
clang. But it is probably ok.

                 Linus
