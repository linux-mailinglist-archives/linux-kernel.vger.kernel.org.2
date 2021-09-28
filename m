Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422A841B0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbhI1Nis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:38:48 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:64078 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241017AbhI1Niq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:38:46 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S9qt1h019420;
        Tue, 28 Sep 2021 08:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Hs4RLdDAQbWR2TaLXdih6j+1o3VeO8UfOlieyTYX/K0=;
 b=SpS+34nx9wWUXf9HYZqBlpfAIP3JuPtr6Tsc5xBIk/PrCookzbEAZbSfPdPHhLNn+uxI
 hb1MJifblUoOjK3jEeT7ujhrg4UiHVwCDrGf7NlgOdmxYaqNrRy3ucEr2LAoswO+nt+9
 lzkkMP5hYv1LPz+/kEt31CYuHjjD8AYsscR8G3qd8dnoHaqnM2Wsjc3cPUEAdiosccIb
 ZFRHSp6QM/00/7i74/TEgb54WxR8Dmq0g6kP1qlxOnXqZS5BfSn4Q3WebsUJxFLdb+Ah
 66UDvskCEOEnKRPFZkLPJ3YJH/x8aaTiesPJetxwlflaxJSx7jUQvV1Fejnkk2pPlbEB qQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bbgmyh6w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Sep 2021 08:37:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 28 Sep
 2021 14:36:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 28 Sep 2021 14:36:59 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7BA2111AF;
        Tue, 28 Sep 2021 13:36:59 +0000 (UTC)
Date:   Tue, 28 Sep 2021 13:36:59 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] mfd: arizona: Split of_match table into I2C and SPI
 versions
Message-ID: <20210928133659.GI9223@ediswmail.ad.cirrus.com>
References: <20210928131145.17159-1-ckeepax@opensource.cirrus.com>
 <20210928131326.GL4199@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210928131326.GL4199@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: kLpO_b0ESq9NJhfjhDZ7lXpakkWiEqv1
X-Proofpoint-GUID: kLpO_b0ESq9NJhfjhDZ7lXpakkWiEqv1
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:13:26PM +0100, Mark Brown wrote:
> On Tue, Sep 28, 2021 at 02:11:45PM +0100, Charles Keepax wrote:
> 
> > rather untidy, after recent changes this will also cause a warning
> > on boot for the SPI subsystem. Tidy this up by creating a table
> > for each interface listing only the appropriate compatibles.
> 
> > Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> 
> This has been an issue for a long time regardless of what the SPI core
> does, and if you're trying to identify the patch that introduced the
> warning that's not it.

Apologies misunderstood you last email. Probably simplest to just
drop the fixes, otherwise I guess we are talking about multiple
patches that introduced each of the affected codecs. I guess
fixes is more for stuff that needs backported as well, and since
things work fine this probably doesn't need to go to stable.

Thanks,
Charles
