Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7037AA02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEKO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:58:03 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:2544 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231684AbhEKO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:58:02 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BEupep010329;
        Tue, 11 May 2021 09:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=GUmiTsZa2D857EWY992Tdk6Pb79y3HyBhwjXfDZvVG0=;
 b=mVjrQoup1CR3wWN0VXqRXFsbE/WsqDDN+pqmWNKjSIalCwnPY1R65/yO53EHMzq819zX
 u2rMmKPfRbMnrZ8vrIMMCFh0CiqNA6kFmlAkoObnsext5Pa8T/eAmKECos0ou18kxa9F
 KadiC3PLlNNhwoA+BqpfKTlrTkSGdRQ5jA/DdMdTm3DjrNDhiBAqi0id+zI4ab/CIsYr
 LAoemqOeAyfdnUqjxps2U/MS2aPCNbmBf3R/XTV4JGAMmnJVpB+lrBtx1h6X//d0vmvy
 L6ZH2x56DkK01xQuNCZgWS6P6vN8mhoDcAyZL6DhT8ZQrV0WQGU0w+Zs3GPtD2T2FXWI Aw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38f2d4sq7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 May 2021 09:56:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 15:56:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 15:56:43 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9CDEC11D1;
        Tue, 11 May 2021 14:56:43 +0000 (UTC)
Date:   Tue, 11 May 2021 14:56:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs42l42: Regmap must use_single_read/write
Message-ID: <20210511145643.GE64205@ediswmail.ad.cirrus.com>
References: <20210511132855.27159-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210511132855.27159-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: fLHwtQWyn3_S9k3ZbLHWEMkDvaDOfPUH
X-Proofpoint-ORIG-GUID: fLHwtQWyn3_S9k3ZbLHWEMkDvaDOfPUH
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=757
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 02:28:55PM +0100, Richard Fitzgerald wrote:
> cs42l42 does not support standard burst transfers so the use_single_read
> and use_single_write flags must be set in the regmap config.
> 
> Because of this bug, the patch:
> 
> commit 0a0eb567e1d4 ("ASoC: cs42l42: Minor error paths fixups")
> 
> broke cs42l42 probe() because without the use_single_* flags it causes
> regmap to issue a burst read.
> 
> However, the missing use_single_* could cause problems anyway because the
> regmap cache can attempt burst transfers if these flags are not set.
> 
> Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks Richard, I guess I better check the other devices I fixed
up for the same issue, as I am guessing that could probably
affect a few more. The few I have hardware to test already have
the single stuff set.

Thanks,
Charles
