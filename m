Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF77440AE66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhINM7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:59:22 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45324 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232975AbhINM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:59:21 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E6ehV2028588;
        Tue, 14 Sep 2021 07:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Ev7PDwviB/H21Q6D4T0A2eQ5SfWWpnPdHClmvhk0068=;
 b=MN/Aw3m6QzsYv3qfqNExAfF27Q7p2/ypeD2SX0yZvFl+Gx+hbFm35R13zYk/dyGFm4ZC
 3U035HAMW0zkewpN5giViXmFosGer+EGZEM5x/JMzHg6VcZQercBSgctJNuhKVZMJ6ze
 xWkawDjkBT64w0Ev4LVUgg4E6QhzBQ2lpBI+v+o5CojUQHa590wxk5Aw1ZAeqW+YrPql
 oDQ2Vtu6ISsFjYS/9dLJ4aB9IqYspZ5/p46yo2hXBMpjrOlBXXc0U7XEOE/2M+X9RHmq
 ExwVPU3lecOGNGpTuc8Y7cZJ1x9S3m509NaAnjdi2jWPqjjFNxauFpxa7CwoJ//FFnV9 VQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3s0vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 07:58:02 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 14 Sep
 2021 13:58:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 14 Sep 2021 13:58:00 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7DBCA478;
        Tue, 14 Sep 2021 12:58:00 +0000 (UTC)
Date:   Tue, 14 Sep 2021 12:58:00 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Message-ID: <20210914125800.GB9223@ediswmail.ad.cirrus.com>
References: <20210913130101.1577964-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210913130101.1577964-1-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: _ZHUnUuOBKAahyV2zcjSZH3XcoXg7ly0
X-Proofpoint-ORIG-GUID: _ZHUnUuOBKAahyV2zcjSZH3XcoXg7ly0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 02:01:01PM +0100, Lucas Tanure wrote:
> Set regmap raw read/write from spi max_transfer_size
> so regmap_raw_read/write can split the access into chunks
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
