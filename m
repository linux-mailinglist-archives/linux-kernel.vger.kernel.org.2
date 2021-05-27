Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221323931A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhE0PE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:04:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45420 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhE0PE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:04:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14REsvvd115862;
        Thu, 27 May 2021 15:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=HFUg50sDjCv32k4k1my6Oh0vfejPTOTMSEJQKWLo/YA=;
 b=KRyUn8IXWOI/qjnoo/Pai500d2iW0WW1z/AzSjQxVN2Gu8Nxb3dxIjdXcqp/lxaE73V/
 Gp4E3DEY9U6R8TbnIUKJoDVEngn0aPtLfzS1GaSDdTU7LZnxI5mLtc0foGHVRBjKqJCm
 8Fhf3yT9aIi6YsZyyuYg0mb/FW72W9VwP/rFBpUaoYyZwXmhRI1kRmOaliRvZ2hfVhSL
 6K06KEZ6BBeuUBh4hoePnBbdmxopYJ0PdGs87KekiBkHimx5dnK5/ORFWdyaBCI+n7CA
 taKVo4MeDR6VuSrun1sThpDqZJBo9kBn0YVWkdLcMmLaIeswZvtlXe9LF9qu63b7m79y 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38pqfcmgtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:01:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RF0LAm160654;
        Thu, 27 May 2021 15:01:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38qbqudunb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:01:19 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14RF1JO6163457;
        Thu, 27 May 2021 15:01:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 38qbqudumv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 15:01:19 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14RF1GOe011052;
        Thu, 27 May 2021 15:01:16 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 May 2021 08:01:15 -0700
Date:   Thu, 27 May 2021 18:01:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liu Shuo <b35362@freescale.com>,
        Prabhakar Kushwaha <prabhakar@freescale.com>,
        Li Yang <leoyang.li@nxp.com>,
        Dipen Dudhat <Dipen.Dudhat@freescale.com>,
        linux-kernel@vger.kernel.org, Raghav Dogra <raghav.dogra@nxp.com>
Subject: Re: [RFT PATCH 2/2] memory: fsl_ifc: fix leak of private memory on
 probe failure
Message-ID: <20210527150109.GO24442@kadam>
References: <20210527144240.56365-1-krzysztof.kozlowski@canonical.com>
 <20210527144240.56365-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527144240.56365-2-krzysztof.kozlowski@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 35xpdmuINh0-_dI21K9dRu_4ayFQFGW_
X-Proofpoint-GUID: 35xpdmuINh0-_dI21K9dRu_4ayFQFGW_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 10:42:40AM -0400, Krzysztof Kozlowski wrote:
> On probe error the driver should free the memory allocated for private
> structure.  Fix this by using resource-managed allocation.
> 
> Fixes: a20cbdeffce2 ("powerpc/fsl: Add support for Integrated Flash Controller")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Only build tested.
> ---
>  drivers/memory/fsl_ifc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> index a6324044a085..3ee7183b20fb 100644
> --- a/drivers/memory/fsl_ifc.c
> +++ b/drivers/memory/fsl_ifc.c
> @@ -209,7 +209,8 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
>  
>  	dev_info(&dev->dev, "Freescale Integrated Flash Controller\n");
>  
> -	fsl_ifc_ctrl_dev = kzalloc(sizeof(*fsl_ifc_ctrl_dev), GFP_KERNEL);
> +	fsl_ifc_ctrl_dev = devm_kzalloc(&dev->dev, sizeof(*fsl_ifc_ctrl_dev),
> +					GFP_KERNEL);
>  	if (!fsl_ifc_ctrl_dev)
>  		return -ENOMEM;

You'd need to remove the kfree(ctrl) in the remove function as well or
it will lead to a double free.

Unrelated to your patch but related to Smatch.  The Smatch check for
resource leaks which I mentioned check_unwind.c doesn't look for
kmalloc() leaks because those are quite complicated to deal with.
kmalloc() allocations are so much more common and that if you have a 5%
false positive rate, then it's just overwhelming.  There is a separate
Smatch check for that but it's garbage and I need to re-write it.

Also I'm really inspired by Christophe JAILLET's Coccinelle checks which
compare the ->probe and ->remove() functions to see if they match.  So I
may attempt something similar.

regards,
dan carpenter

