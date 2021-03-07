Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF3330D27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCHMOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:14:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CE5C06174A;
        Mon,  8 Mar 2021 04:14:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mj10so19894131ejb.5;
        Mon, 08 Mar 2021 04:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6WsXzkZKIYmpOl1DOZ8e9KcUHnOCDuB8xzdtvk/6Xdo=;
        b=tY67xB9c8hqIQkvjIng0PppegIpOpcGXasj6a9/dnB5oZi7Ot/Xx00Gehas46AW7fR
         EkaW2sabLLQMC5l++v1yktxVbbb4i0jbQYWLDJNcGDD6kdRLjLFv+mFiAkjftQt6k96E
         fqRtvb/LpnBstc18gjbfyL/c0Yb/Vauj6vPQ8SOIOiHhYZkG2AWgmkWN1Ob3mdgkWZbA
         Yqvvr3/rVNgR96LVaPrLZRLM29P+SzxxOvinZvYXlaYVyYpNnVV0o8U9TKp4Gvm0Mj4G
         +xzEDPDJmBNoklaYh4+Mymv+ap84mK1GpeaJMmVMGAiJ77BYz4hnVPRyREeX4H1pVFgx
         0JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6WsXzkZKIYmpOl1DOZ8e9KcUHnOCDuB8xzdtvk/6Xdo=;
        b=exCijcCzli59XFsx/ABWE9hpqAIh17b7t/JFtU44cMJ0kFavI809A6AZQ8Vq6bbxVy
         6C0Vt+nzNb4iVDDSQZbZB55IYkhPpnOV+IjecniAaZMjou3d1mnrNfHnN9PGa8u4FE5L
         MAog9Xr4Eab5h8VXqPJliQEeSfjOZsNLW1qp3UeIsYKW/ULSwhGK9rBsCb0gHypXI5+q
         b46bf8iWEFPt4orTEIdjUVSc+39zyigTQWomzFJyr3X10qKFns8VDeFKQEu7f3eA7xSU
         PWCuoBLUZWeKdXPoSGbQlD0KpIJnMlxMpIx1OvPYwWs7sq600QfUqmcbwVxDbiPYdiPQ
         FzwA==
X-Gm-Message-State: AOAM530eHTJ35EiySzVOTDyMmnC+7HdhGHOZHdwTwgcYDQwJ7r/Or25P
        PJoi1s9iNlet4oSNIKZPjLY=
X-Google-Smtp-Source: ABdhPJySpce7SOXohqD5qYMyCqCZyhKpRu5rz4gqkNl/Cr51BXCwbGbx1NgeJLOYzTl6Ma10oQsxBg==
X-Received: by 2002:a17:907:1b1c:: with SMTP id mp28mr14355219ejc.243.1615205648310;
        Mon, 08 Mar 2021 04:14:08 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-82-61-23-35.retail.telecomitalia.it. [82.61.23.35])
        by smtp.gmail.com with ESMTPSA id kj3sm6545922ejc.117.2021.03.08.04.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:14:07 -0800 (PST)
Date:   Sun, 7 Mar 2021 18:04:50 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: Document use of
 nvmem-partitions compatible
Message-ID: <YEUHsoC4V+H6PCHL@Ansuel-xps.localdomain>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-4-ansuelsmth@gmail.com>
 <ee596471-db9b-43e4-c085-9bd938101587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee596471-db9b-43e4-c085-9bd938101587@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:48:32AM +0100, Rafał Miłecki wrote:
> On 16.02.2021 22:26, Ansuel Smith wrote:
> > Document nvmem-partitions compatible used to treat mtd partitions as a
> > nvmem provider.
> 
> I'm just wondering if "nvmem-partitions" is accurate enough. Partitions
> bit sounds a bit ambiguous in the mtd context.
> 
> What do you think about "mtd-nvmem-cells" or just "nvmem-cells"?

I read somewhere that mtd is not so standard so "nvmem-cells" should be the
right compatible.
To sum up, with v2 I should change the compatible name and just push the
2 and 3 patch. (waiting your fix to be accepted) Correct?

