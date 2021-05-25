Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2997B3905FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhEYP6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:58:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:14224 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231521AbhEYP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:58:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PFlA1I006086;
        Tue, 25 May 2021 10:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/+rRydbIFLTJkR2+V++rMhfMFI/gZOqMU4e+/CmAhSw=;
 b=OgDMstRhrQYhnWEgSJAK10uhrqarUUVSJJORU6LzeKUmqeXKcARRLOf2qxV8yRn3GNcX
 raXvBYtVggIv8Iaw+tXMaBeMm0oRpKgES0q/3U0WpRFDTnQrh+TuPAc9KUuUhSh74t2U
 bhjUFuMqzij8Y6DOerGcdxLgnCu1ARlBH6bnz3iPIa6v7s80PADjBnHOSVRHymKXgWv/
 qGvvcUKH5XHhKVlGIKjGcA3EBlDCndCR8KtR8lH9H/zdFjsfahcMdICJbEYBi1MnuN/2
 cxUPQmvQuipVKAIiqCG18w9v87QR/nVvZ/NbOeqOovZV07pAvEQuNfx4DT9A4TX5UvAC 6w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38r28v24q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 10:56:31 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 16:56:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 16:56:29 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DDAB611CD;
        Tue, 25 May 2021 15:56:29 +0000 (UTC)
Date:   Tue, 25 May 2021 15:56:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ASoC: cs42l56: use DEVICE_ATTR_WO macro
Message-ID: <20210525155629.GO64205@ediswmail.ad.cirrus.com>
References: <20210524114503.26460-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210524114503.26460-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: t0jRmd2V6CKC-crYL4PEnTsFEhBR-REg
X-Proofpoint-GUID: t0jRmd2V6CKC-crYL4PEnTsFEhBR-REg
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=913 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 07:45:03PM +0800, YueHaibing wrote:
> Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
