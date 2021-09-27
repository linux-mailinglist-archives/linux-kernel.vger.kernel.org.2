Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F8D419236
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhI0K3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:29:39 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51592 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233772AbhI0K3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:29:36 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18R5pYMh012811;
        Mon, 27 Sep 2021 05:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=80U4T1j6QMclsU1j5YsiJFMIGIzx0aWuECyB83ujxvQ=;
 b=JGwawMfVOPqhumC/j0ooLqopzuaJMvqb0LpwP87D2LZ5pMwrTLbD6HYx2WGs+/AJ78YX
 GQYWniCkFg4t68uaNOsuv+Uzy942bK+d+c0brbrsWoIqk87SaD0toH2dY/F9/qJuzT/r
 LqLs4BANO79SgJZtbQXwBDkvINoDmte3xHMgf0Jris1h9A98xNX/qX9xRI/wuCRebPRm
 IUxFxwXT6U5fvKL1FpUqDJP3vqB0SKuuaw8UzDkTgyrC9Zbon16hyayDjFPXB8Q2wh/G
 DZ3w9GSc2yaow4gLgzMKzyQeomrQiGSRdrP7F4o9YOGPG7fKj8F678TzuloMvm5cROf2 wQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3barbh8t5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Sep 2021 05:27:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 27 Sep
 2021 11:27:55 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 27 Sep 2021 11:27:54 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 61EC8B10;
        Mon, 27 Sep 2021 10:27:54 +0000 (UTC)
Date:   Mon, 27 Sep 2021 10:27:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 2/4] mfd: arizona: Add missing entries SPI to device
 ID table
Message-ID: <20210927102754.GE9223@ediswmail.ad.cirrus.com>
References: <20210923194645.53046-1-broonie@kernel.org>
 <20210923194645.53046-3-broonie@kernel.org>
 <538c0c79-d568-be03-e524-01f5c6429554@opensource.cirrus.com>
 <20210924112000.GB4840@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210924112000.GB4840@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: NZLDB0sjVPXYqzutM0ERgAY-XIvkIWFj
X-Proofpoint-ORIG-GUID: NZLDB0sjVPXYqzutM0ERgAY-XIvkIWFj
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:20:01PM +0100, Mark Brown wrote:
> On Fri, Sep 24, 2021 at 10:24:17AM +0100, Richard Fitzgerald wrote:
> > On 23/09/2021 20:46, Mark Brown wrote:
> 
> > > Currently autoloading for SPI devices does not use the DT ID table, it uses
> > > SPI modalises. Supporting OF modalises is going to be difficult if not
> > > impractical, an attempt was made but has been reverted, so ensure that
> > > module autoloading works for this driver by adding SPI IDs for parts that
> > > only have a compatible listed.
> 
> > >   static const struct spi_device_id arizona_spi_ids[] = {
> > > +	{ "wm1814", WM1814 },
> > >   	{ "wm5102", WM5102 },
> > >   	{ "wm5110", WM5110 },
> > >   	{ "wm8280", WM8280 },
> > > +	{ "wm8997", WM8997 },
> > > +	{ "wm8998", WM8998 },
> 
> > WM1814, WM8997 and WM8998 do not have a SPI interface, which is why they
> > aren't in the table of SPI IDs.
> 
> They're listed as valid DT compatibles for SPI so will now generate
> warnings on boot, the driver should not list those compatibles if
> they're not valid.

Yeah we should really be having different lists for SPI and I2C
here I guess. I am happy to have a quick look at doing a patch
for that, unless you particularly want to fix it up?

Thanks,
Charles
