Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1923D2309
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhGVLN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGVLNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:13:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F597C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:54:27 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c13so4025400qtd.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhIyxXiIbu1rU1cVmeY2N8seyHsByuWZoVqbL9JnpnI=;
        b=YZXYW4TfH4IGqIIgF8R137rFfe7tzpSYVlRVSO18GN5UpOk1YvnuTUHxgi4nV7hai8
         LppFmS256q2lduWSyKGMQToKOQtN14U13v/uuuC8XznjzwoyGlxyvuBknrmLHrATxBK2
         QLxuK4zEykFC8mGmFr3OXVKz8q4bWrewp7hTcCF2zb5A1ACB/O/9zvP6dwxozawJR8AI
         GdwdWy/bIBx8lTaw51964oh9wPAhY3TIEkmvrrUPYs9QLT4XrjrkE3S/Ah3D4ygYX7ka
         2+NN1WXn1kYiqFK+GgEKPlA/2nREyFc54T4AybXaUF6gFF0DPCK+1vEdkhfH8py2HQwX
         O3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zhIyxXiIbu1rU1cVmeY2N8seyHsByuWZoVqbL9JnpnI=;
        b=SsJdBPZPUrVpUmIA//H+UOvIdmcyMisbHEw64vvJCbf4AyO14HRLfUpsZEX+qn0E3l
         cqaRPezLWorRXpML47oqsGZ+8jiF47m1rFBpERGkuOl7rps74UFv3xs30rsYjDLraqZ3
         WZAEb2PwRjJ9yFz8W7czibtE8YMLrbhjjwl5h/Ae+OAocIw3FWEnu6kZftsiq+L7LtWa
         VXt9+a6J9FOax8BsH/Cthi1hDcWEzlu/DdpxyawerezIqJj0Sfx36OQM5het8Ga+xel7
         rcUTH+P7FTnUp8jUtghA1FvMhT1LB86hGYcx79TG6RPbDMd9U3Er1Ziyuci1NYv14O0W
         GJKg==
X-Gm-Message-State: AOAM531bXpo6eBAhkCQqIEbEVXnGow6R103PnPHudA46Pkcwcu+hLslv
        cheOiEALFpWTzM3O1MFPdboOLw==
X-Google-Smtp-Source: ABdhPJwin6WqV2CARkjjL0txCKbW66NjBuLPCSQp7QzQQz7IlS/DweegkfIEn2AxXpesZZDahE5yEQ==
X-Received: by 2002:ac8:674d:: with SMTP id n13mr6809635qtp.63.1626954866343;
        Thu, 22 Jul 2021 04:54:26 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id f2sm10188219qth.11.2021.07.22.04.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 04:54:23 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, jianyong.wu@arm.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] include: linux: Reorganize timekeeping and ktime headers
Date:   Thu, 22 Jul 2021 07:54:22 -0400
Message-ID: <5481133.DvuYhMxLoT@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <87fsw7pe5d.ffs@nanos.tec.linutronix.de>
References: <5729424.lOV4Wx5bFT@iron-maiden> <4663325.31r3eYUQgx@iron-maiden> <87fsw7pe5d.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 21, 2021 5:09:50 PM EDT Thomas Gleixner wrote:
> 
> I have no objections against this change per se, but I'm missing the
> actual problem it is trying to solve. What's the fail it fixes or is it
> just a general consolidation? The above is blury in that regard.
> 

Well, at first I just wanted to fix the header dependencies, since timekeeping.h
is using ktime_to_ns(), a static function defined ktime.h, but it does not 
include the header. Then Arnd rightly pointed out this was an opportunity to
perform a bit more housekeeping and consolidation, yes.

> > This patch also includes the header timekeeping.h wherever it is
> > necessary for a successful compilation after the header code
> > reorganization.
> 
> Please do:
> 
>   git grep 'This patch' Documentation/process/
> 
> and follow the instructions there.

All right, I understand I should be following the imperative mood there.

> 
> Aside of that I assume that you only covered x86 in build testing which
> is not cutting it as this is generic infrastructure affecting _all_
> architectures.
> 
> Thanks,
> 
>         tglx

Thanks for the feedback Thomas, I will cross compile with the other archs
to make sure we are not leaving anyone behind and send updated version (v3).

Carlos-






