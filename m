Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B30D38229A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 03:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhEQB4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 21:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEQB4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 21:56:43 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C42C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 18:55:27 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id g24so1602892uak.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAqm8ZwHARd9qDoH8piEdy1zx5RC/XRMqtlBHFac8Iw=;
        b=gWvNp7rLiWKc3q6+XaPxjuFosEkykywx01QpvhkRLxLZqa03LR7bdEBFPk3+rS1rfT
         QU1h3z1uMf9rWnkIsEtLfzsJU9E4IBt4vm4d8GTdBQEKn8ccOn3R40dPPIf3j3sRcvBu
         YeQQLrFgeUMXXUSaf9HvocOXDQTRd2DIdzzfN9pnoPrhrQegug05ZlL8nl0/1iqKcrJv
         Nao21Qol5ubMGN+5xYhWLLdvOFMvf46jVymBW+cIMJy/9vtIPqcl98lq0d6XSeBL57yn
         rZErUFiDJTfeRpS8ZaB8MJ7SyOlIeeDFRXQM1Lk2OVztn4W+6FdkhYp6YL0EoXe/ATKn
         tIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAqm8ZwHARd9qDoH8piEdy1zx5RC/XRMqtlBHFac8Iw=;
        b=ISZSx9DP9NJ7mRzCsGgvAL0OVPItIUtfVIUZQsBTh8lHNgIldcPdKDWT7xYkA4E1s3
         00dRS3N1WvXkI/h2vnPxOEsatfW22GcmUzTVVkaatHJj0XFAoawW4NV+nc0yUa4nG6a9
         V1LOsyEIK7G1Z2Bouk13nGdEjv64yQAC/0ZCKIdOdxOs292ixco6OK0ED9wDxKq5EKji
         Tbu6WDksrXx2nUuMaIt8YdgaibOfdnh/lgw1etuNjoCfdtjguUCAWLzWmwOxKzsKUegQ
         zRurLn1lGL5B7veGot3lrynrYIFQ2Cl8Re17MMyd+ojI9Y2NNIgowyh+XGlLVzC6bQ2a
         XtfA==
X-Gm-Message-State: AOAM531oPGkZggrtMgAJORG1OvdrkBk1zhCIvWYPDsw0DIEjzPYJ3QTJ
        rAi06cDLo2sqhIbtLRElZJWKzj96bmqUzVIDIOTP1Q==
X-Google-Smtp-Source: ABdhPJzWSj4Ns6LHTFvVaAkcbZ+VhaYqN/CVWknOkhAw/umIXNm/XmJQtFIkdrpqq0w1jAsFQ45Aq0GAI6Omi3qdCm8=
X-Received: by 2002:a9f:382c:: with SMTP id p41mr14342763uad.65.1621216525807;
 Sun, 16 May 2021 18:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <5J_z4QNPMBAk4y0rGshI7mBykT1tivh3037CbQRYXTu_Ra6zuojEcI0RB04ghXQxgdtDbt3YFv6sA882mrFyTdzQePwHwvLoECnqFTnYNZI=@protonmail.com>
In-Reply-To: <5J_z4QNPMBAk4y0rGshI7mBykT1tivh3037CbQRYXTu_Ra6zuojEcI0RB04ghXQxgdtDbt3YFv6sA882mrFyTdzQePwHwvLoECnqFTnYNZI=@protonmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Sun, 16 May 2021 21:55:09 -0400
Message-ID: <CADVnQymGvCTEzdd8dSLZnn0dwnHAoNiwo72yEFeNr47+Na8GDg@mail.gmail.com>
Subject: Re: Listening on a TCP socket from a Kernel Module
To:     louisrossberg <louisrossberg@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 7:20 PM louisrossberg
<louisrossberg@protonmail.com> wrote:
>
> Hello, can somebody point me in the right direction for
> what I would use to listen on a TCP socket from the
> kernel? I am working on a kernel module and have spent the
> past day looking through include/net and include/linux for
> something that would allow me to do so. I know TCP
> listening is typically done in userspace, but it should be
> possible at the kernel level right?  tcp_diag looks
> promising, but it seems like that is mainly for monitoring
> sockets, and I'm not sure if I would be able to provide
> responses from it.
>
> Louis Rossberg,
> Warped Technologies

Perhaps kernel_listen() and related functions (kernel_bind(),
kernel_accept(), etc.) in net/socket.c might do the trick for your use
case? Looking at how the callers of these functions structure their
code might give you enough to go on.

(I'm adding the Linux kernel networking mailing list to this thread as well.)

best regards,
neal
