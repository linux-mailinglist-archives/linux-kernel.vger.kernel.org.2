Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F1A45CC52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbhKXSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:44:45 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:4294 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233126AbhKXSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:44:36 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AOCdIQr027676;
        Wed, 24 Nov 2021 12:41:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=pU5oPDwNb51xbR+dqzWio0+9rLLGRpYPqGSN7CQkcY8=;
 b=aZbe45j202Nc0xlZuaTj/Qf7pHvwphYzyay91bSdBc/NH0lBIjEunMnFbNuXlo0ySJJx
 URM7YVi6Gec4V3wKh8GYBQjVRNNtnpM1J0vFfa1w5J/byxf0wvluUiQvYyJX6vW4GjwI
 sqS4D4Q/XAIZs30YkBSIXutQ51MLd6RMfe3zEs7eFuhrnwGpTwAd1lk/9g6JEQvnVVBM
 p8U+u/28mSM0S0CbXzBY7bd9OqgrsU2wxnIBsvNJwZ0/jy6aRSapg/u9Vv3rz4b7bXUA
 +hgZFv1Lvtv3+e8UxJqVN9kw7gvlUTSJzDijjZP++l0f2+JZjxj/I0iPujJ//4BcQ9bs ag== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3chb8wgx9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Nov 2021 12:41:11 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 18:41:10 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 24 Nov 2021 18:41:10 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3FADB2A1;
        Wed, 24 Nov 2021 18:41:10 +0000 (UTC)
Date:   Wed, 24 Nov 2021 18:41:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     David Heidelberg <david@ixit.cz>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        - <patches@opensource.cirrus.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <~okias/devicetree@lists.sr.ht>, Rob Herring <robh@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8962: add missing interrupt
 property
Message-ID: <20211124184110.GH18506@ediswmail.ad.cirrus.com>
References: <20211124155101.59694-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211124155101.59694-1-david@ixit.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 8YLOc8iRxNGIJk4yPsfVx68GzCwvaUCs
X-Proofpoint-ORIG-GUID: 8YLOc8iRxNGIJk4yPsfVx68GzCwvaUCs
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:51:01PM +0100, David Heidelberg wrote:
> Both, hardware and drivers does support interrupts.
> 
> Fix warnings as:
> arch/arm/boot/dts/tegra30-microsoft-surface-rt-efi.dt.yaml: audio-codec@1a: 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/sound/wlf,wm8962.yaml
> 
> Fixes: cd51b942f344 ("ASoC: dt-bindings: wlf,wm8962: Convert to json-schema")
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
