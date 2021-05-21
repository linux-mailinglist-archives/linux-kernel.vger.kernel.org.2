Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87E38C285
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhEUJDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:03:52 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45282 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234881AbhEUJDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:03:51 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14L8uHmB012397;
        Fri, 21 May 2021 04:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=FDnjBuJeyguLnnjPWZeo1wOjjCJFYx4qwcu4iSKlwYw=;
 b=oyZfRdIwiat22s+G46RMfM/1Dh0JNxPj47VabllPDanT48obqP+FrgoS1R303v7nsavH
 +5zzT91qOzSWACeg+Tl5XMn6JSuBilZpq7/JPdtiz5ie6fsQmu5woIGtgegikkiuQzdL
 lPAR35jMYuNDb8lOZ2DQG9N1izIBqQ+c/IFnVuXMJSZ7hJkB3b4c5jCv4Fp2RCNkZeKW
 PtNstKXUdXXFR0+kLnb17WZeod7x98okGbtEyEvSXXQpp6H1EIiMxDoJcQbyknRH1iZX
 4wrGqFG6TMx05UrwExX6sRy+UGGH9oail1oqlweqnP1JVvjxYXMVMHCwoX9zYZB4XjVW 0Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38p6err6qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 May 2021 04:02:28 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 10:02:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 21 May 2021 10:02:26 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 59EEC11CD;
        Fri, 21 May 2021 09:02:26 +0000 (UTC)
Date:   Fri, 21 May 2021 09:02:26 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/7] mfd: wm831x-core: Fix incorrect function name
 wm831x_reg_unlock()
Message-ID: <20210521090226.GJ64205@ediswmail.ad.cirrus.com>
References: <20210520120820.3465562-1-lee.jones@linaro.org>
 <20210520120820.3465562-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210520120820.3465562-2-lee.jones@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Vh4oMtzRk1w_XtU7f_nVlUmfbMjstQe_
X-Proofpoint-ORIG-GUID: Vh4oMtzRk1w_XtU7f_nVlUmfbMjstQe_
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:08:14PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mfd/wm831x-core.c:121: warning: expecting prototype for wm831x_reg_unlock(). Prototype was for wm831x_reg_lock() instead
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: patches@opensource.cirrus.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
