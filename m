Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2980E37B7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhELIZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:25:33 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:23538 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhELIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:25:32 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14C8IT55003150;
        Wed, 12 May 2021 03:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=cuMhQe9yq154UjGxdpGpoxEWlFJU1yPPM7Nluq0FAQM=;
 b=dCnnKmcCzaXJr9I+WG5DwrftCatf232NQFx1CMRCPhXzzKU3hoas03Q7eUMRH8W+Q0t/
 LMhtbFCsFz485dLqr31A6eRAl8TtuJJeXve/hUKkzjj1Ab1EsOA4+IF/MdYNMcwl2ouu
 iRMWcfqcpnCOPZ+BbbD48YqGjZQYSIAeCN3BvA04Pj0v/H92LAII9iSWNvMOScWU6MKU
 C6AE4g9T2k6bjpFHm4lrIC1o/FAFSI96cvo0wGmGdvPmtBhMk3ZXeZ4DAurbFnGPiKJA
 OT2v4kVwiWJlMmXa7DRuVlY1ejWngT0Efd5oCyOoek06VDZ+Ap6HYLtvYUwuKxn0uOTO 4w== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38gay8g11y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 12 May 2021 03:24:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 12 May
 2021 09:24:16 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 12 May 2021 09:24:16 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F054511CD;
        Wed, 12 May 2021 08:24:15 +0000 (UTC)
Date:   Wed, 12 May 2021 08:24:15 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Simon Trimmer <simont@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm2200: remove include of wmfw.h
Message-ID: <20210512082415.GG64205@ediswmail.ad.cirrus.com>
References: <20210511171514.270219-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210511171514.270219-1-simont@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 4zk9NxgHR7ySqQrIit--I1alLSUZNvZ4
X-Proofpoint-ORIG-GUID: 4zk9NxgHR7ySqQrIit--I1alLSUZNvZ4
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=868 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105120060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 06:15:14PM +0100, Simon Trimmer wrote:
> We want all wm_adsp clients to use the wm_adsp.h header as they
> shouldn't need to include internal sub-headers.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
