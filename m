Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566FD3989C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFBMlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:41:24 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:1824 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229975AbhFBMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:41:23 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152Ca3Hf015153;
        Wed, 2 Jun 2021 07:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=b+kZOYy8iFYeTlGyUQ+o3peomPw8V47ZU6e59cuq6sE=;
 b=cyF6i0qiCn65+uEcTZeUzTK3V40jyzAdgaZN/xGNc07zInlrfgo7LUfWL0RbiVLy1fGE
 JUB41adnpvpBTVhvcqSb/txapQlLS3K4lIWsfFXEzchawH0g2PyJ5a8KKYU0szs2jIn3
 PtWlpHLEXKSwTLVgJbhsjYSG1xwZ97vLxlAKsBl7Lt0tFg07Hpzpo6vtYWtU672tg3X9
 zQn+KYdB7cfVgKPUT2TRx4PI0e6PlRjay50yUXnz4HJslADIyrWL0GCikbgA7BVyy3ox
 VVQL3IbiHv7UyTBB7hgwgwZ/RQ229IJbraM1fkH0EyM+6ZQJzkPsbN4RSs1G3/ro4+AX YQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38x650r8uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Jun 2021 07:39:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 13:39:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 2 Jun 2021 13:39:25 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ACFE52BA;
        Wed,  2 Jun 2021 12:39:25 +0000 (UTC)
Date:   Wed, 2 Jun 2021 12:39:25 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] mfd: wm831x: use DEVICE_ATTR_RO macro
Message-ID: <20210602123925.GE9223@ediswmail.ad.cirrus.com>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210602114339.11223-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: -OU_U1jVTOwYmAeYQ1d9ICfcPtKJJwPb
X-Proofpoint-ORIG-GUID: -OU_U1jVTOwYmAeYQ1d9ICfcPtKJJwPb
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=936
 impostorscore=0 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 07:43:31PM +0800, Zhen Lei wrote:
> Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
