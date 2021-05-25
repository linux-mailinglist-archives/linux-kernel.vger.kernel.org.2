Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004BF3905FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEYP6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:58:36 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49402 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232634AbhEYP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:58:35 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PFlE5W011728;
        Tue, 25 May 2021 10:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0CPhgMB2lgOup1kygifBFb39H803MbQgcG6514/E4h8=;
 b=nF5ygvZCgxxCqFQ2GAsQh+J/YbmAC3si9oXzKrItCB/2XYi7F+NDh4ovQzAvvw+FLlIf
 DfTtXDevS+G9iZwXC3Ua/mKtJQSRG428riWHxCSY3uu0BOBrlYisw2UMWN+5C6efjuOM
 qR9nkqKd9zQMzelj4dPLgr/xiUn5K30k6rog0vGcWyt2mSHlNiHFfqtXZw8JGgXDz132
 kpLCcyRg4nAhVn3zONfmSMQJ9T+W/XW4JYoQukUYXYV7tw8aaVf1eNdsUGXvjNrnsAot
 f98qYgYnEbsg22v5RhHbyujQ62hAkmcmHbOi+LpQuWJTo+IHZZesy7+yK+C/F6ZPRZFw 8g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 38r7ck9xmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 10:56:14 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 16:56:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 16:56:12 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A51CD11CD;
        Tue, 25 May 2021 15:56:12 +0000 (UTC)
Date:   Tue, 25 May 2021 15:56:12 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ASoC: cs42l52: use DEVICE_ATTR_WO macro
Message-ID: <20210525155612.GN64205@ediswmail.ad.cirrus.com>
References: <20210524114239.7960-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210524114239.7960-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 3p6-TkACwukyvofnZ_frdG3D58RMClOd
X-Proofpoint-ORIG-GUID: 3p6-TkACwukyvofnZ_frdG3D58RMClOd
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=913
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 07:42:39PM +0800, YueHaibing wrote:
> Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
