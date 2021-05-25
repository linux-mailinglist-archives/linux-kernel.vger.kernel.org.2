Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0079D39060D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhEYP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:59:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:8902 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231521AbhEYP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:59:02 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PFuagx024245;
        Tue, 25 May 2021 10:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=MKbSHkBi8ZqZV+9gevCZwv2nXLiIgxzBmj2LD8lultc=;
 b=Pq4bpFiAAHokAQZc59H7TVXvSrN9nBCLVNxQVrffQwUIJsiyp+DFxlZYxhueAZgzHqjM
 akz8Yu+qkapIRDDwbh2RzFQA+wcn3aDPqyEOXQgsy1R+wfLNGo8TmaIIhufvHiXJJ+Qj
 OuzVfHqCdBfahmD9I5ey99t0a1Yog03P249NuPPCYX0QPH19dR5jmzEOAFP87qoHUQKY
 U7zM9SxR/zhXHnm0baTdau6VKjtyhtZulpnHf2ML7bC6/ptWCLViwTYlBz6/O78ZtLt7
 oSwZcL10+j1/hL5v5ukateOLhpdL5pF/1UlDOL8TNGQ/9RPjauT75HaxuI2myUbWDomP Bw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 38r7ck9xnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 10:56:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 16:56:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 16:56:44 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AA62411D6;
        Tue, 25 May 2021 15:56:44 +0000 (UTC)
Date:   Tue, 25 May 2021 15:56:44 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ASoC: wm8962: Use DEVICE_ATTR_WO macro
Message-ID: <20210525155644.GP64205@ediswmail.ad.cirrus.com>
References: <20210524114753.39544-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210524114753.39544-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: kYZUiMkd_eYj6nozUWGs8Lqn9rqJfsmV
X-Proofpoint-ORIG-GUID: kYZUiMkd_eYj6nozUWGs8Lqn9rqJfsmV
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=895
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 07:47:53PM +0800, YueHaibing wrote:
> Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
