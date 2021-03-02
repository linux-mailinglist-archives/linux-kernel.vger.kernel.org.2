Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226EF32AAD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839911AbhCBTzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574095AbhCBRVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:21:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB647C0611C0;
        Tue,  2 Mar 2021 09:20:17 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hs11so36732631ejc.1;
        Tue, 02 Mar 2021 09:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zK+KKzHDy96fD8Ado48n+v2+h+rSyFj7Z9Ecpa/L53g=;
        b=bxQ9hcxmqpIQuIT7HyUiBmiowbUr5yoAQwzUJ0yLJmKWH3dxtzvsEx3Who38HjGxMV
         sYn9UCQYWptvrBB+IrMJpvc+fu6cyrJzjxxkkjQlmBAt3fydztEECovNw6d+Wfx+EuLF
         kXlIE+6aC3EtvNiSeo7/i5NlCQdJ4a4peSR2jc6QzTYAYoy9VKxG3SKUKNrSumnC03jZ
         lOmv3gHVYafr5kKIKjg6qyZMeVgQLQpDCrcLnz4MTgMl1LeS3Jo02ak05MMsi6yb588z
         fiSQIT+yRuEjLdHs6tm+RJB9E2EA9fdyvq7/FrUcQV7kYF6yvEjYdVdjiS5Cl+tB3ezU
         XZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zK+KKzHDy96fD8Ado48n+v2+h+rSyFj7Z9Ecpa/L53g=;
        b=ANDY+NI1MHSqREeleU2CZS81rmkZL4Fa9+j9n49SEFu21MEPKtYTk1OyIk9usBfWXP
         oeqeitdIw+k7dJymo6NSlHOYtOuDbp5FyEn649k+fdQOGHzm+/ngY/VHT4zcNZIn6O5x
         dTdddK18OpOc8OW3A6UsNm/lja2X82e39V7zMD9yv2/VhOPqLOjnuXBDNDPRZNo/FT4V
         pqVLflXLBbWuexKGPgAKolscfF6zIgqcI7gN6gR/DvM3ilfBYr9nhtnID19ySMsf9Llb
         3Z/gezhR19SPNy/bu00o06x3J2nxoEmLo+aDORPo9mqAbchM/3xUyrbJGJRowoNkEq/F
         FzSw==
X-Gm-Message-State: AOAM5327Ojs9B890ni178TxJGVlfXstUeZLTcgkl13m+qybpDt5LmjOn
        cgl92PByUVCIjqGBP3/GXaNKTIrTjp8=
X-Google-Smtp-Source: ABdhPJw8v7voB0M6C4fWLSnzAXN/gXoc7QDPY/Irgd8F0TkInhF7apTUHh+FcZ0/2d+GalG1n5WEQw==
X-Received: by 2002:a17:907:9e6:: with SMTP id ce6mr21277639ejc.207.1614705616358;
        Tue, 02 Mar 2021 09:20:16 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-10-16-239.retail.telecomitalia.it. [87.10.16.239])
        by smtp.gmail.com with ESMTPSA id a9sm218574edt.82.2021.03.02.09.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 09:20:15 -0800 (PST)
Date:   Tue, 2 Mar 2021 05:50:07 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 1/3] mtd: partitions: ofpart: skip subnodes parse with
 compatible
Message-ID: <YD3D/zwfLlRITdHj@Ansuel-xps.localdomain>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-2-ansuelsmth@gmail.com>
 <d504a4df-b1f7-b7c9-e62a-599d114d8a18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d504a4df-b1f7-b7c9-e62a-599d114d8a18@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 05:53:54PM +0100, Rafał Miłecki wrote:
> On 16.02.2021 22:26, Ansuel Smith wrote:
> > If a partitions structure is not used, parse direct subnodes as
> > fixed-partitions only if a compatible is not found or is of type
> > fixed-partition. A parser can be used directly on the subnode and
> > subnodes should not be parsed as fixed-partitions by default.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >   drivers/mtd/parsers/ofpart.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/mtd/parsers/ofpart.c b/drivers/mtd/parsers/ofpart.c
> > index daf507c123e6..4b363dd0311c 100644
> > --- a/drivers/mtd/parsers/ofpart.c
> > +++ b/drivers/mtd/parsers/ofpart.c
> > @@ -50,6 +50,11 @@ static int parse_fixed_partitions(struct mtd_info *master,
> >   			 master->name, mtd_node);
> >   		ofpart_node = mtd_node;
> >   		dedicated = false;
> > +
> > +		/* Skip parsing direct subnodes if a compatible is found and is not fixed-partitions */
> > +		if (node_has_compatible(ofpart_node) &&
> > +		    !of_device_is_compatible(ofpart_node, "fixed-partitions"))
> > +			return 0;
> >   	} else if (!of_device_is_compatible(ofpart_node, "fixed-partitions")) {
> >   		/* The 'partitions' subnode might be used by another parser */
> >   		return 0;
> 
> I admit I'm not familiar with the old binding, so let me know if my
> understanding is incorrect.
> 
> It seems to me however that your change will break parsing in cases
> like:
> 
> spi-flash@0 {
> 	compatible = "jedec,spi-nor";
> 	reg = <0x0>;
> 
> 	partition@0 {
> 		label = "bootloader";
> 		reg = <0x0 0x100000>;
> 	};
> };
> 
> nandcs@0 {
> 	compatible = "brcm,nandcs";
> 	reg = <0>;
> 
> 	partition@0 {
> 		label = "bootloader";
> 		reg = <0x0000000 0x10000>;
> 	};
> };
> 
> Did we ever use "fixed-partitions" without partitions { } subnode?

Hi, very good point. You are right and I didin't think about this case.
I don't want to assume false statement, but since the ofpart parser and
the partitions structure should have been pushed at the same time, there
shouldn't be any use of "fixed-partitions" without partitions { }
subnodes. With this assumtion, the current implementation looks to be the 
cleanest way to skip parsing. (if the parsing is dubious, don't parse at
all... The idea was that)
The hacky and IMHO dirty way to solve this is add a bool to directly
skip the subnode parsing and check for that. Something like
"no-fixed-partition" that would disable the ofnode parser with no
partitions { } subnode would accomplish the same result of this patch
and keep compatibility with nodes scheme you pointed out.

