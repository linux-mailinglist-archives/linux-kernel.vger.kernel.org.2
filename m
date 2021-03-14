Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88F233A7C6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhCNUQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhCNUPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:15:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A77C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:15:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r20so13806565ljk.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xma/bdvmmFMw2PLCFGEbKiEv/Ght4XSeyenvew7tC5o=;
        b=ILomUDLlMdcL3V4idIDb3hHq1VHX4UjziMkU+JOhFQl+GGLYZaFz6MAE8pYdSHSvh7
         0X4rd9bbhTAPfgQFaJpMIDpXlloxfgwIISem86ylOBnmidljeHk9wUYPual72KuFLdey
         koiM1TycGECxWQL/Nx9WfD3yRXljDE1s2jkaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xma/bdvmmFMw2PLCFGEbKiEv/Ght4XSeyenvew7tC5o=;
        b=Llpr7/uzvzViLTrlKOFmhhzrnRjOrFX8uX678N+nOYDBIdyzlAoQuVGEzkqCLHKFQp
         p7qOeUP3/jhJCv/2Tx28MOKtrIz7O0Sxs9axJWJ+uHkq6yhijuyga4X0HXoyS3hPxj82
         /K1EaR9DqUfIO1jYFEVUTBGjjxJFtS08sUWw1+weHRPpb9Kj5kHeRaga7BGZD/2VMAQ2
         ktgyPTPxNxTXduT8SiKrEixJfrLOEMR0hE+GdW6B8fgFAD48PAXy3mSI7H8ikMczH5Za
         PxRoVtddhpDwqy+QxY1OobcRLB5HZQbrPW+67UQIouKGxX1mahZ4R66nxINke1t2TS/e
         bnvw==
X-Gm-Message-State: AOAM5336tXt3JOPgT+EVYC4HyKuG55GPa8Z6szXQG29tc31EhUNTcSlB
        BywPcceOYTAeDxtXFX8jRCFogZcOak/mOA==
X-Google-Smtp-Source: ABdhPJzg9m6laMX8jUIBJYoO9UzEaFvaa7C+sR/BnDur4yn0zj0FM+n/A5pjVQ0sHn2G0tiyZWWbyQ==
X-Received: by 2002:a2e:8e6e:: with SMTP id t14mr8387059ljk.23.1615752942394;
        Sun, 14 Mar 2021 13:15:42 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y23sm2736352ljm.53.2021.03.14.13.15.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 13:15:41 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id t18so5889485lfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:15:41 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr5686514lfo.201.1615752941402;
 Sun, 14 Mar 2021 13:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <161573639668.27979.17827928369874291298.tglx@nanos>
In-Reply-To: <161573639668.27979.17827928369874291298.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Mar 2021 13:15:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
Message-ID: <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 8:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>  - A fix for the static_call mechanism so it handles unaligned
>    addresses correctly.

I'm not disputing the fix in any way, but why weren't the relocation
info and function start addresses mutually aligned?

Are we perhaps missing some .align directive somewhere?

Or am I missing something?

             Linus
