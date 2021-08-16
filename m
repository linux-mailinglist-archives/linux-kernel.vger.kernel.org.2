Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250D53ECCD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhHPC7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 22:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHPC7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:59:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CEAC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t9so31616487lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8TKR7dPS2xB58sRpJji2JNSpt16+OSyn8n/iAsqgJw=;
        b=B045Riqq+Vf1qfKMdoGgXuJsMOt6UHN4bIvZcQbjGNf/5/JVW25y8g6/nRfF6jCMSf
         D8NnJG52qPMY+2VhUP17RIKRy9V2LM4GWZeKNy1VBvZkMDiVgaQ15kxaiLPvS/aNbCvC
         BHxOuqATgCUMbNlXpEE0mWpI96ilzWjA8sfKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8TKR7dPS2xB58sRpJji2JNSpt16+OSyn8n/iAsqgJw=;
        b=ReDtyAy99rgrIQM3BZGQbAe6UQF9igMVhS3UyLujmjf39zicEmnGOTbwj0wC3V0/yF
         6dsB+UTh7PpV/+ln4Wj14V9pmZR1BkXjPZcFIO9Kubpp4+s28VgyKW5wrx4cF59mxx/K
         kNwitWEH832pkW7BOxLS1WYRTPm8K9zz7PGlxtixlHy8fTB45WSRilLLoQPvGMp9kZ/N
         l8u8VLOS2N57ecmLP20MI4Goz2xZvw4giIfuXRbpC9VOCbZFQ0AYu9SVCA+Q6NUVsdvf
         Vr4NjbmGhh8t80ujtCvlm8v3ngu6l9pNWhZPr5ShFa9AShkj4BqZMmqEFs71qZ7Uu8cf
         v/Hg==
X-Gm-Message-State: AOAM533Fs/bXBQp/KkyuMSWmbGG8jmlMEly2FMRMI1Q9y3CeK1RlO5bd
        wiz/oOmffKkBpdcqQeIjsbAUMnA06ytQIfFY
X-Google-Smtp-Source: ABdhPJznsBvwxRZErEALyjS9miQENS+/t7dzomuSRbi2v7T/ldIm2BRzvLUPCHpW/MK96RmMWk14wA==
X-Received: by 2002:a05:6512:2602:: with SMTP id bt2mr9674378lfb.47.1629082756188;
        Sun, 15 Aug 2021 19:59:16 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l6sm1034804ljj.40.2021.08.15.19.59.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 19:59:15 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i9so10856802lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:15 -0700 (PDT)
X-Received: by 2002:ac2:4c55:: with SMTP id o21mr9757503lfk.201.1629082755247;
 Sun, 15 Aug 2021 19:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi8=9QbNFFZ1PwZ=J-3w6LkhF68_rEns-mN1DCJrYo1qQ@mail.gmail.com>
 <20210816024656.GA212454@roeck-us.net>
In-Reply-To: <20210816024656.GA212454@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Aug 2021 16:58:59 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiWo3sRhEm69XprffzNpvcDOiK=X56G1H5A4Of4LdwaKQ@mail.gmail.com>
Message-ID: <CAHk-=wiWo3sRhEm69XprffzNpvcDOiK=X56G1H5A4Of4LdwaKQ@mail.gmail.com>
Subject: Re: Linux 5.14-rc6
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 4:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Failed tests:
>arm:z2:pxa_defconfig:nodebug:nocd:nofs:nonvme:noscsi:notests:novirt:nofdt:flash8,384k,2:rootfs

Miquel? Guenter has been reporting this failure since -rc1. It's rc6
now. The fix has been discussed, and is available since early July -
so why isn't this getting sent to me, and why do we still have that
known failure going on?

              Linus
