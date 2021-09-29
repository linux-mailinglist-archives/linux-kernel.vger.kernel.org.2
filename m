Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB5E41CCC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbhI2ToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbhI2ToK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:44:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C47EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:42:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i19so12366469lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fpTJo9PN19CwOpgH8yiUSJNn3It4EQ9dC+3Al0lph7I=;
        b=tl/tsT2Nrh6yQ+Rl3+dJK0ANroWNYbYFblftSnt7NYLQkg3QBbxlmOGrafH2Y9dq60
         T+9j4Aq0uVfWPZDjwLMqzhISmuzeLywWKwO3tUC6l+6mg1ycYLmEMc/sOK4jSrPbr/cT
         hYvlBN+kCNdan69XerxoD18kxuVU9ZCwThMkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fpTJo9PN19CwOpgH8yiUSJNn3It4EQ9dC+3Al0lph7I=;
        b=zDeLzCPrZcniPH+fFVlVlU7Q9FmyET8wBMuXwHx+Qz1Lw5NJLdRxG62iZofat9ES4f
         sY1guDSA+bzeulPpV6HWJNB6h2Yy01c2dLQCM0SynFzClW5MyXrzPEeAgsHfBMglOocH
         MPPzYQnc3ddCtJuIZqM7qUI+uVVumsy/h5+5bNw62rP5jH0wCae17l8sJ7wGOfGyRcmd
         ChhezpFZpWxAXJR+MpMgIruRsga/gRGmiLANcKowZfItwDsG+bhhthpdf6YTAHikfi4L
         19oqcHhUuSLUAwbX/oVuMkCRwZiEcuTTYO60LDTGx49s91DBIjPuuWJCT+XNPOCg7Yv4
         sVqw==
X-Gm-Message-State: AOAM530VYVHyIH7oLCpPOs/QarpuJhr2DSYtrj2USb/hZvDK92WBZaoW
        46N0t1/1lTPmOwMsiDfC1YttHw==
X-Google-Smtp-Source: ABdhPJwU4jfdBet2tozUxiHUN7/qai9e5NS39a/T8NwbrMvUA4f4qE1xXnzZqQLEzNTuswAvuUVpCg==
X-Received: by 2002:a05:6512:15a3:: with SMTP id bp35mr1436941lfb.11.1632944547503;
        Wed, 29 Sep 2021 12:42:27 -0700 (PDT)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id 23sm86008ljq.83.2021.09.29.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:42:26 -0700 (PDT)
Date:   Wed, 29 Sep 2021 21:42:24 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] mtd: add MEMREAD ioctl
Message-ID: <YVTBoAnQKYLNpOPc@larwa.hq.kempniu.pl>
References: <20210920070221.10173-1-kernel@kempniu.pl>
 <20210928155859.433844cb@xps13>
 <20210928162402.6bb64fcf@collabora.com>
 <20210928163519.08cd1138@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928163519.08cd1138@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel, Boris,

Thank you both for your input.

> > I do agree that a new interface is needed, but if we're adding a new
> > entry point, let's make sure it covers all possible use cases we have
> > now. At the very least, I think we're missing info about the maximum
> > number of corrected bits per ECC region on the portion being read.
> > Propagating EUCLEAN errors is nice, but it's not precise enough IMHO.
> > 
> > I remember discussing search a new READ ioctl with Sascha Hauer a few
> > years back, but I can't find the discussion...

I think this is the thread in question:

    https://www.infradead.org/pipermail/linux-mtd/2016-April/thread.html#67085

In fact, it looks like Boris beat me to preparing a draft patch adding a
MEMREAD ioctl by some five years:

    https://www.infradead.org/pipermail/linux-mtd/2016-April/067187.html

It is apparently true that "everything that can be invented has been
invented"... :-)  I did search the web for existing mentions of a
MEMREAD ioctl before submitting my patch, but this thread did not turn
up in the results :(

Anyway, back in 2016, Sascha hinted that he might move forward with the
draft prepared by Boris:

    https://www.infradead.org/pipermail/linux-mtd/2016-April/067215.html

but I cannot find any related submissions from Sascha in linux-mtd's
Patchwork.

> We also discussed a mtd_io_op some time ago, which would equivalently
> replace mtd_oob_ops at some point, including more information such as
> the bitflips which happened on every chunk instead of the information
> regarding the maximum number of bitflips in one of the chunks only.

Is that discussion available online?  Search engines seem to be
oblivious to that term, which makes it hard for me to get acquainted
with that idea and/or to comment on it ;)

> IIRC the point was to get rid of the mtd_{read,write}{,_oob} hooks and
> structures in favor of a more robust and complete set of operations.

That sounds like a major overhaul, right?

I guess the big question from my perspective is: should I revive Boris'
original effort on the MEMREAD ioctl (which returns more detailed
bitflip stats in the structure passed by user space) or would that be a
waste of time because the subsystem will be switched over wholesale to a
new way of doing I/O (mtd_io_op) in the foreseeable future and therefore
exposing yet another ioctl to user space today would be frowned upon?

-- 
Best regards,
Michał Kępień
