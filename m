Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF7B30ED3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhBDHWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhBDHWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:22:49 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF6C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:22:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g10so2896771eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8NA16pgrmr+hZCZ5N/nNI47zYO39E+Z5pyXAWJADZvM=;
        b=PcItGjwTS/37G6Az/tk9ZvGb4LiMfYQ+uLHWZqQ8V6/rQZvFLwnKvJDvmXaTVHwpD5
         qCwGe1OhOBhkpCQb7/Vkb9EJtfb9/HwsQa1szNrNtvY/bTXym+joShlGzJQd0VIxXp7L
         Qk8RDXYckHWpvLxyplqyn4XqaAd56I+adwzu4EMevtqJWXLePShBBfzEPwWenzWwXL72
         6JyjhU20p94t3Rv6G8aGv8qsGxBuPgSCz9zS3FHeCsv5RYe2fQC1oICzKmT+VUaZcBEV
         VsvYQaWNFlZ2URdsvgiCGCjsUMqhjLKWuIWQeOAIh2BREuBTRsKeZudAjVo1B0nBfn2/
         Xy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8NA16pgrmr+hZCZ5N/nNI47zYO39E+Z5pyXAWJADZvM=;
        b=HlJv/1FPPq5pkficO415xsvRlYJj7CnGf/7mfgEWZupLu5tErscjwtrvtEuUOjHIN+
         LUS1dSAukLcMRcWwAWIx/xsszflNJnUSvYV/yhMpZznX090RRh/vf9nNnck4pvFyTB5X
         bSv8QdZBsRE/UqgEEndff1QdUGPuJwXJUDtm/PFEEjzi1GyCFrGFuICRyxspjLVmWJiW
         X9/Hh/RdvMT6DpWbi1nQPh6HltQ/D4CFMoVjUIvX6CVTQp8kz/Nbtcl0DvbqlX4mf8Ml
         QPWO9SPE2odUCkoh32X0R15M3Sh6BuLDKAU6nt5n+Nwmpo/DgsM6Ci5OSkFy7YtVid2n
         ejmg==
X-Gm-Message-State: AOAM532s85Pk02mUL9ch3SCZfzF2crjx0b1uU4VPasG300pdNM9iBVcz
        3YcpShQkKlP9ecwSnf/PON7nacXXNryrx1bPVOU=
X-Google-Smtp-Source: ABdhPJxJfWqlLNHR5ISdl8b41n0Reuy1brMDjD/9op562cXjuhxbXDlUizK+AjF43QwSlV9Ftj/qwgTq1J4yUCtQsWI=
X-Received: by 2002:aa7:d692:: with SMTP id d18mr6790728edr.327.1612423327916;
 Wed, 03 Feb 2021 23:22:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:1959:0:0:0:0 with HTTP; Wed, 3 Feb 2021 23:22:07
 -0800 (PST)
In-Reply-To: <CABb+yY3P_iFnKamY=7z5rnNW+BQW4-vAbeS=S33BpqCKR1Rhuw@mail.gmail.com>
References: <1608022118-29993-1-git-send-email-yaohaidong369@gmail.com>
 <CA+kUaCeebDNXi12-nNpw4i_auZbM+JQUC5uNhEzXxqa7=W4LnQ@mail.gmail.com> <CABb+yY3P_iFnKamY=7z5rnNW+BQW4-vAbeS=S33BpqCKR1Rhuw@mail.gmail.com>
From:   Yao Haidong <yaohaidong369@gmail.com>
Date:   Thu, 4 Feb 2021 15:22:07 +0800
Message-ID: <CA+kUaCeJ_o4kdEtYP4MaDs7X87tCQK5UxQDj5f8EqGqxTPkvQg@mail.gmail.com>
Subject: Re: [PATCH] add chan->cl check in mbox_chan_received_data()
To:     Jassi Brar <jassisinghbrar@gmail.com>
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

 Oh, I see, thank you

2021-02-01 14:28 GMT+08:00, Jassi Brar <jassisinghbrar@gmail.com>:
> On Thu, Jan 7, 2021 at 5:53 AM haidong yao <yaohaidong369@gmail.com> wrote:
>>
>> Hi Jassi Brar
>>
>> Thank you very much for your reply.
>>
>> Look at the function sprd_mbox_outbox_isr .
>>
>> Chan is !NULL.
>>
>> chan->cl is NULL when the client driver not loaded, the controller
>> driver don't know the client driver loaded successfully, so, I do not
>> use mbox_free_channel.
>>
>> Here,How do you know chan->cl is ok?
>>
> The channel is supposed to get/send data _only_ if it is being used by a
> client.
> Which you can mark in .startup() and .shutdown().
>
> Checking for chan->cl will make your symptoms disappear but that is
> not the right fix for the issue.
> The right fix is to EITHER not cause Rx/Tx interrupt on a channel not
> being used, OR not send it to upper layers.
>
> thanks.
>
