Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78D530A056
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhBAC0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhBAC0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:26:38 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA53C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:25:57 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id m25so3598875vkk.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=0ICf8NjpN0hioiKdOAWvppEPLQDsPV7oWSM7AOAfuUY=;
        b=r0sE/R25jxEdSdV058goeA1oA9KNGgQ5G2mPGouanaFGffcXdOR1cRJl+fsyt6grQ/
         yZixRJLyJICn8eDJv3UpYhExr0m9QOsau6UxGu17zg8aNXuhgbweuTTKV3ejO+ARMutb
         xqoYC91G9yWZMEMi7kMKDWB/gLhCX/edviKitJYOGx632+Qgc5czzkgH5Zef1WtDcPVa
         egH+rfojVuFbG1in/wBSzs9ZV52ABg6Z+f0Hhc/F5IS8fcj/HehjsQghZXYiVJ0I00Fx
         hNf8LHs4h9aMU51y/mgIpQnBrbOmnhsn08MUTLmLuSb3uWHcu8/9MbcEq02EiRw3jcXW
         uvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=0ICf8NjpN0hioiKdOAWvppEPLQDsPV7oWSM7AOAfuUY=;
        b=py9M5wmzQeXF0vLeMnFcMt70eQr4BRboEs7yNzguqYU+1TOz8TWtELdKHL9stqw8GI
         tlOWjVHbJchgfLYPf+N6PeXfrzVgxznlCim1XNpoB5oSeSpimrQb5RtL5Ayp3/4UIbPn
         qiHXWvKDffKMkTjd/JUcppFJz8cmhTUdYtg5CzZWrvoJ+2+bG8+H3ILEFWsV/zb7Sdpm
         wTAl6lvbfUzwPqmC1td8y1fmQrI08oByAn527PlzgatZLqTbMvhcYqJ60G/1Qzp7Zmvb
         iR4zKodso2wqR3In8lhjyB79noerh6nmx/sNFA4VqGCn+jNN15CIabejYGyGk04qnVRS
         basw==
X-Gm-Message-State: AOAM531qT9ZaziweJpZ57q8mf2NbBZFuY60FbTybc+d12xB0wgsD69wQ
        wuVWkEoqIyrka6Qu0H21qgystt7xartxi0y9j+c=
X-Google-Smtp-Source: ABdhPJx0Ly8KZ+O1oYniJLWFj/fZv3vD/MWOPedIe6C0Xs97s/817nz7qFuAPT18HpERzRa9iEjhrB6EFLEzW0PDBRs=
X-Received: by 2002:a1f:fecb:: with SMTP id l194mr7930420vki.23.1612146357081;
 Sun, 31 Jan 2021 18:25:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjhQkZ=mUxPog4+kU1y5BRKw2DpbFXsEP=31fgX4KfBZQ@mail.gmail.com>
 <BFAB82E3-267B-4CF5-B6F2-8E6A2A3DB42B@amacapital.net> <CAP045Aq7PNQyhkT0S5GBzSRUTY4-SGsjs47Z0cCxoPeE-Od_+A@mail.gmail.com>
 <CALCETrVZp6-1Rg_DEKggUqZAzQ_iXXMd4d690ByPGb8B9F6dzQ@mail.gmail.com>
In-Reply-To: <CALCETrVZp6-1Rg_DEKggUqZAzQ_iXXMd4d690ByPGb8B9F6dzQ@mail.gmail.com>
Reply-To: robert@ocallahan.org
From:   "Robert O'Callahan" <rocallahan@gmail.com>
Date:   Mon, 1 Feb 2021 15:25:44 +1300
Message-ID: <CAOp6jLaKR3zJDg9bNFkTcj78kKDtrdnMF4U-mxzkXDRgHu94GA@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 12:40 PM Andy Lutomirski <luto@kernel.org> wrote:
> I admit that PTRACE_SINGLESTEP seems like an odd way to spell "advance
> to the end of the syscall", but you're right, it should work.

We don't know of any better way to advance to the end of the syscall
without executing any userspace instructions. We could set a
breakpoint at the syscall return address but weird edge cases
complicate that.

Rob
-- 
"He was pierced for our transgressions, he was crushed for our
iniquities; the punishment that brought us peace was upon him, and by
his wounds we are healed. We all, like sheep, have gone astray, each
of us has turned to his own way; and the LORD has laid on him the
iniquity of us all." [Isaiah 53:5-6]
