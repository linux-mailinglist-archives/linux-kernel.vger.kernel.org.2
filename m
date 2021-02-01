Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712FC30A20F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 07:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhBAGh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 01:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhBAGaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 01:30:22 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5ABC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 22:28:40 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i7so11371846pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 22:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmzqwJKaMep+rAWHEkV3E0XHPW5uGVDn/m8Uq3t6K1s=;
        b=gpbU2CR1bZA022s3oXgQXo3d4KUKkERQbixnJso9As04G5Mo5QPPwua7B9kQvPEH/R
         SvUQtg3bjmmpnmepuJYeR1lFMhTohjxeAALSFZTYgQOYDYy+23k5GAv6As5Nc7Sei8HY
         JbLGRjNiPqe5UDOwVuKs7VrSnLYYdpx4a3GnBkyaLcxnCEhYOcZi8AHYTFVl0YSB+Vfh
         IK7+L0E+8Pgx1WXFkDrjX/1TaPZttZIKplMlDGsv2h8mdD8HvbregthB4G6JH4rRFubi
         uT72t7R4MUK4KC8MygbFh3ogMTGnvAN6pvHhhVB/bSl5OqtAzmV6ikC2vCYVQRKesFNZ
         NgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmzqwJKaMep+rAWHEkV3E0XHPW5uGVDn/m8Uq3t6K1s=;
        b=ugZgcOanoMr8XQULhEObwmLR6NMjuLUCG+2cSkymPWadrF54rOp+FG8lMr7ZLvp6Nr
         zaQVVMiGg5YLuofS/grWeuZlwQiqaEucdz/0UfpyJkRZNJpXrxh1pwmTRHsVqY/uKx5Z
         FxrfXEtWU2tTGndo5l1NZ79nNyrS035P5NAOYW9Tlg//g7ICLJ7QytySpA+UaIoOKHYi
         pCVbWUKjRsobS8fWjYRsroxCj/mLltu+eTyNxHsuLB3GGukLO8kmcOd4CAwdZPAmSI6E
         UHcHDjKk70XBzkrRNPQbGPkZxslSKhswh3ULJiKGXTIUGKmfwurpKS+xcImr92JIuIyG
         NupA==
X-Gm-Message-State: AOAM53187UPHlB3KxuwGQsUQQ1bpknVyYKJnxPx1qGi8AMHc9a416apw
        5uOTxJX2rm/9jYG4NA/tUu5nmU8q1v23IGoKtwI=
X-Google-Smtp-Source: ABdhPJxKzGL91cxqqkH3J9kmCSMsBlJmRhJrBEpoe+IfqE/6GaB4Jy0pUARY5VgwjRiWSirvjG+pMZK+ltSWW7EFjAM=
X-Received: by 2002:a62:f202:0:b029:1bc:a634:8e9c with SMTP id
 m2-20020a62f2020000b02901bca6348e9cmr15084868pfh.49.1612160919974; Sun, 31
 Jan 2021 22:28:39 -0800 (PST)
MIME-Version: 1.0
References: <1608022118-29993-1-git-send-email-yaohaidong369@gmail.com> <CA+kUaCeebDNXi12-nNpw4i_auZbM+JQUC5uNhEzXxqa7=W4LnQ@mail.gmail.com>
In-Reply-To: <CA+kUaCeebDNXi12-nNpw4i_auZbM+JQUC5uNhEzXxqa7=W4LnQ@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 1 Feb 2021 00:28:29 -0600
Message-ID: <CABb+yY3P_iFnKamY=7z5rnNW+BQW4-vAbeS=S33BpqCKR1Rhuw@mail.gmail.com>
Subject: Re: [PATCH] add chan->cl check in mbox_chan_received_data()
To:     haidong yao <yaohaidong369@gmail.com>
Cc:     natechancellor@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 5:53 AM haidong yao <yaohaidong369@gmail.com> wrote:
>
> Hi Jassi Brar
>
> Thank you very much for your reply.
>
> Look at the function sprd_mbox_outbox_isr .
>
> Chan is !NULL.
>
> chan->cl is NULL when the client driver not loaded, the controller
> driver don't know the client driver loaded successfully, so, I do not
> use mbox_free_channel.
>
> Here,How do you know chan->cl is ok?
>
The channel is supposed to get/send data _only_ if it is being used by a client.
Which you can mark in .startup() and .shutdown().

Checking for chan->cl will make your symptoms disappear but that is
not the right fix for the issue.
The right fix is to EITHER not cause Rx/Tx interrupt on a channel not
being used, OR not send it to upper layers.

thanks.
