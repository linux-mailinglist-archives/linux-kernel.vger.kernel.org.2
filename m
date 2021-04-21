Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341BB36672F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhDUIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:44:35 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42190 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235083AbhDUIod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:44:33 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13L8bSlw004719;
        Wed, 21 Apr 2021 03:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=nPczol+VR0KR9nJGshmhZqjVXxehr8YBfTima70vMQ4=;
 b=FF8yrK+TrvFPsj6oIGfOhVxAy/ZLNwMxTJtIssQ3eWRsxa1yX+ovoZYalxNjZf5ZGQdC
 j7uVxhm7R0/idzqj0mnAd9BfwWCPnjjBZMi+tujkAdIB26iJSlmAups7gTnOdDFbNR6D
 pWlv9M6+zhMySn9pQQeiHUMG7uldQlutL4Ji6uB++Nlh3bsazIVjvkxCa4I0o3yo4yDi
 avuIeBzBub6aBUuhQOUia+q13hHQOZvRZNQJmmwdVWIkTxPgh89xz1giZ7gs2M2SfEks
 8e93BRU/aMbd6PCryeMYfh83RgDpDt839Y/HhtvLcfo41UjW3WDPMtaD3bzkfPBsRgKR 0w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 381a0rjtcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 03:43:58 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Apr
 2021 09:43:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 21 Apr 2021 09:43:57 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 292D711D6;
        Wed, 21 Apr 2021 08:43:57 +0000 (UTC)
Date:   Wed, 21 Apr 2021 08:43:57 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] regulator: Avoid a double 'of_node_get' in
 'regulator_of_get_init_node()'
Message-ID: <20210421084357.GB64205@ediswmail.ad.cirrus.com>
References: <a79f0068812b89ff412d572a1171f22109c24132.1618947049.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a79f0068812b89ff412d572a1171f22109c24132.1618947049.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: WmW1AHhvl6ZsxFfNfknH2sKP5mZ1xlsz
X-Proofpoint-ORIG-GUID: WmW1AHhvl6ZsxFfNfknH2sKP5mZ1xlsz
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 phishscore=0 mlxlogscore=770 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 09:31:51PM +0200, Christophe JAILLET wrote:
> 'for_each_available_child_of_node()' already performs an 'of_node_get()'
> on child, so there is no need to perform another one before returning.
> Otherwise, a double 'get' is performed and a resource may never be
> released.
> 
> Fixes: 925c85e21ed8 ("regulator: Factor out location of init data OF node")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
