Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976A03971D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhFAKx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:53:27 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59862 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230282AbhFAKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:53:25 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151Afmcq008038;
        Tue, 1 Jun 2021 05:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=kttahVLl585IscFfSbkAFw1hdSQotk8tKL9yGoHTAyw=;
 b=WAwZNb89GmvAsdyJ+KKVmkXNXTiqoweSiIqIi6nT7jaj+xMMIpXJhcRQeZQy48XjenS9
 Sru0+ejfiBkcu/smdJAcxNHjIyGqC26XNGETLG4DjPhoSNIyaWEulYQSsb8wAPqyVoHq
 yTORvIneAXY9utu7buC/FHQeS0omINdjxwWkAYUL0uVw5WATt8JNTCj+JsIAykBKTkT5
 vQ73FSYBDcyKVmQGB26T2TXQA3BSI4ArNOZfANUSeD6n/3NP2ej2SsmuP7qxeV8+GBta
 9Z71CqB+kIOaBDl/63KTn06ZPqFFELhb1iOnRz/kxAMe6VLksKVn2HzZp1Eu8I90Z8ru tw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 38vv1h159h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Jun 2021 05:51:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 11:51:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 1 Jun 2021 11:51:33 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 377272B2;
        Tue,  1 Jun 2021 10:51:33 +0000 (UTC)
Date:   Tue, 1 Jun 2021 10:51:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mfd: wm831x: Use DEFINE_RES_IRQ_NAMED() and
 DEFINE_RES_IRQ() to simplify code
Message-ID: <20210601105133.GD9223@ediswmail.ad.cirrus.com>
References: <20210601070009.10098-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210601070009.10098-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: bhxdNQDtpPn2i8H6jJ8sP-r3YYSfdD3i
X-Proofpoint-GUID: bhxdNQDtpPn2i8H6jJ8sP-r3YYSfdD3i
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=901 clxscore=1011 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 03:00:09PM +0800, Zhen Lei wrote:
> No functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
