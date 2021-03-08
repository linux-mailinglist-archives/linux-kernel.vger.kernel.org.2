Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F42330A7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCHJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:48:10 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54810 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230124AbhCHJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:47:54 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1289VcbB010106;
        Mon, 8 Mar 2021 03:46:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=WRBBl42OmvF/JPWrQ4eU/UZvz8wqfDrdOuxM4KcfRPw=;
 b=NwGGS9B3bqGznpTtAJKdUdDfntO9qG+VriMwwd+BInZo47Z9ew2QhiNxwubCQpW/G4L/
 zNQOaG6ffrmd5SizxzUyvx62ImPAtRaYMjeeuFDbgara0FMf7pHO0X5fwb2VXjVK85oB
 A58N4PzO4KmXYzxrGgCbo7WxXEe5aEYQPxWKpued5AdZRGh+HeOG4vOmErTyDGV8YKtX
 cXowPixyMSm/kjvUX1wG+7+gTRuKVuW7hCb1ourUFjP6rA3YzF2XQbVSDDlYQQvJTPB+
 gCL3cFehC/gomifByGU2bEgZxGwFij8y9TRbPp66cG2NrBBDb1ntN294gCIQhd87ISxK BQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3748199qmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Mar 2021 03:46:55 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 8 Mar 2021
 09:46:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 8 Mar 2021 09:46:52 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DC0DD11D6;
        Mon,  8 Mar 2021 09:46:52 +0000 (UTC)
Date:   Mon, 8 Mar 2021 09:46:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <festevam@gmail.com>, <gustavoars@kernel.org>,
        <sebastian.krzyszkowiak@puri.sm>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8962: Relax bit clock divider searching
Message-ID: <20210308094652.GH106851@ediswmail.ad.cirrus.com>
References: <1615170877-25918-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1615170877-25918-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:34:37AM +0800, Shengjiu Wang wrote:
> With S20_3LE format case, the sysclk = rate * 384,
> the bclk = rate * 20 * 2, there is no proper bclk divider
> for 384 / 40, because current condition needs exact match.
> So driver fails to configure the clocking:
> 
> wm8962 3-001a: Unsupported BCLK ratio 9
> 
> Fix this by relaxing bitclk divider searching, so that when
> no exact value can be derived from sysclk pick the closest
> value greater than expected bitclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
