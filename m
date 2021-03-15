Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B290E33AD66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCOI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:27:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54458 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhCOI1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:27:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12F8RELR106326;
        Mon, 15 Mar 2021 03:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615796834;
        bh=ThVlhMXeZ2BXtsWAnaBf+g8M4+4//YJhVJ5l/5E+JAM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Eeuq8+1AVXCDE8ZKGrEn+7JASnlayaeHo+OAenh7Ndgj8z/bOaxq2QRQ+ybkwZe5f
         PFlRtDJRwwrebx5oKVb3N8stN6Q0894IGzsFIhttvOnXtl17Fayb9qjYaekNO3DNMT
         RS2QhH+uS7ZScIdkdYlU3OOujPDymmYqp/iQLSEc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12F8REtc088419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Mar 2021 03:27:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 15
 Mar 2021 03:27:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 15 Mar 2021 03:27:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12F8RCux108246;
        Mon, 15 Mar 2021 03:27:13 -0500
Date:   Mon, 15 Mar 2021 13:57:12 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection
 logic out of the core
Message-ID: <20210315082710.l7esv3kwickj6yg3@ti.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <7fb8af561eda06444ee0e0c592147af7@walle.cc>
 <65691b2a-134d-b1f2-617e-5ef09df9a742@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65691b2a-134d-b1f2-617e-5ef09df9a742@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/21 06:09AM, Tudor.Ambarus@microchip.com wrote:
> On 3/6/21 1:19 PM, Michael Walle wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Am 2021-03-06 10:50, schrieb Tudor Ambarus:
> >> It makes the core file a bit smaller and provides better separation
> >> between the Software Write Protection features and the core logic.
> >> All the next generic software write protection features (e.g.
> >> Individual
> >> Block Protection) will reside in swp.c.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> > 
> > [..]
> > 
> >> @@ -3554,6 +3152,9 @@ int spi_nor_scan(struct spi_nor *nor, const char
> >> *name,
> >>       if (ret)
> >>               return ret;
> >>
> >> +     if (nor->params->locking_ops)
> > 
> > Should this be in spi_nor_register_locking_ops(), too? I.e.
> > 
> > void spi_nor_register_locking_ops() {
> >     if (!nor->params->locking_ops)
> >         return;
> > ..
> > }
> 
> Yes, the checking should be done inside spi_nor_register_locking_ops,
> will move it.
> 
> Btw, what do you find a better name, spi_nor_register_locking_ops or
> spi_nor_init_locking_ops? Applies to OTP as well.

On a quick glance, spi_nor_register_locking_ops() can be mistaken to 
mean "Register locking ops". That is, ops to lock/unlock flash 
registers. If you do want to keep using "register", IMO 
spi_nor_locking_ops_register() would be better.

> 
> Thanks,
> ta
> 
> > 
> > I don't have a strong opinion on that so far. I just noticed because
> > I put the check into spi_nor_otp_init() for my OTP series. They should
> > be the same though.
> > 
> >> +             spi_nor_register_locking_ops(nor);
> > 
> > -michael
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
