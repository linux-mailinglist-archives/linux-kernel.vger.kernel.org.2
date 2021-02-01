Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AFB30A012
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhBABpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:45:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229656AbhBABpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:45:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1111VIje095320;
        Sun, 31 Jan 2021 20:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cHsIuP5Z4/Yi57ZdkhzxQxn/1cUm9hMlQlWW/53b2gw=;
 b=m2Ga3wy8KrLyob3g1hTIuWqw++iG1G9EmaO6lE38oUGgkCM2ILfzU0lMsKp7dogkbTeS
 3mG+f/5RZ09UmByNvZiQxmeY6S+VySf8JeTgZbtcV6ta14G13C5Zph4nvFmX4osdoazv
 ck43LvxvWycUgomLrd3WMKpC2yVKcYHt5jvUQJbzCYprQ/pClQCfvjIT/+AEQ0FLEnyC
 bm4LZ9YrZ4VO8auKR/k2Zv9+J75EPEMRKipLQoFeH/IsyVNT57fw1D72bCsAfQCHDSVR
 DcxZAPt5BCTmnRkaYMB2RgXO6Y0WyLMkjfkuCwRFs3jRjfK4YwGg1OMQ8FXk6XYQ87HX rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36e828g7kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 20:44:22 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1111Wsur098740;
        Sun, 31 Jan 2021 20:44:22 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36e828g7kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 20:44:22 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1111ZxHY010170;
        Mon, 1 Feb 2021 01:44:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 36cy38hcq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 01:44:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1111iHnE42664346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 01:44:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39BBA5204F;
        Mon,  1 Feb 2021 01:44:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DDA495204E;
        Mon,  1 Feb 2021 01:44:16 +0000 (GMT)
Received: from [9.206.149.12] (unknown [9.206.149.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 98B2C60036;
        Mon,  1 Feb 2021 12:44:15 +1100 (AEDT)
Subject: Re: [PATCH] cxl: Simplify bool conversion
To:     Yang Li <yang.lee@linux.alibaba.com>, fbarrat@linux.ibm.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1611908705-98507-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <58b3b4f2-09eb-841e-406b-4ec836eaebab@linux.ibm.com>
Date:   Mon, 1 Feb 2021 12:44:12 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611908705-98507-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_09:2021-01-29,2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010003
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/1/21 7:25 pm, Yang Li wrote:
> Fix the following coccicheck warning:
> ./drivers/misc/cxl/sysfs.c:181:48-53: WARNING: conversion to bool not
> needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

Thanks!

> ---
>   drivers/misc/cxl/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index d97a243..c173a5e 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -178,7 +178,7 @@ static ssize_t perst_reloads_same_image_store(struct device *device,
>   	if ((rc != 1) || !(val == 1 || val == 0))
>   		return -EINVAL;
>   
> -	adapter->perst_same_image = (val == 1 ? true : false);
> +	adapter->perst_same_image = (val == 1);
>   	return count;
>   }
>   
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
