Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96FB30706F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhA1H6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:58:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44126 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231454AbhA1HF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10S73u1Q006151;
        Thu, 28 Jan 2021 02:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=i3eZX5wLKqAPu+8nGiutxBBktIA4YknOw5zLE/RzlT4=;
 b=OUzHzo0KS/x7kn/OClE1VUW8HY6wByBHktB5dJTmTSn5KTpjXwxOSScVqvMWhTtlz/pK
 RRhL9/OD3UUIBtr02Bo4f73kEsaTC9DOz2hhMeXVOXset6YaWbTo3FfxF74Q0SX2zQY6
 mtEPl8sUwz+OopXKsyUfEbO77vFCkDhuMym3v4Ob9afbeW9ZSzo9X/tel3QlpR1ax75/
 h49FRqcW/pvHzWWkAQGMkdZU5g3mcS43lQyiaNPE0QbaRL5tM2RdH8UDgazUZzVgxF17
 2lZr+HTVN7HkAXRbQ14KsiynPAYroDofNRXlJ73g4nScPd0xi1aBHdOD8IZaVXv+DYYP 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36bqekhmu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 02:05:11 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10S74HJ5008113;
        Thu, 28 Jan 2021 02:05:11 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36bqekhmt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 02:05:11 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10S721Mv031282;
        Thu, 28 Jan 2021 07:05:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 368be82c42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 07:05:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10S756Fn44564974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 07:05:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42C0811C054;
        Thu, 28 Jan 2021 07:05:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E88CA11C05C;
        Thu, 28 Jan 2021 07:05:05 +0000 (GMT)
Received: from oc6887364776.ibm.com (unknown [9.145.32.177])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jan 2021 07:05:05 +0000 (GMT)
Subject: Re: [abaci-bugfix@linux.alibaba.com: [PATCH] s390: Simplify the
 calculation of variables]
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <your-ad-here.call-01611751928-ext-4146@work.hours>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
Message-ID: <7cb0b636-35b2-21d9-af92-37431f1d0e2e@linux.ibm.com>
Date:   Thu, 28 Jan 2021 08:05:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <your-ad-here.call-01611751928-ext-4146@work.hours>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_02:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 26 Jan 2021 17:09:12 +0800
> From: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> To: hca@linux.ibm.com
> Cc: , Jiapeng Zhong
> 	<abaci-bugfix@linux.alibaba.com>
> Subject: [PATCH] s390: Simplify the calculation of variables
> Message-Id: <1611652152-58139-1-git-send-email-abaci-bugfix@linux.alibaba.com>
> X-Mailer: git-send-email 1.8.3.1
>
> Fix the following coccicheck warnings:
>
> ./arch/s390/include/asm/scsw.h:528:48-50: WARNING !A || A && B is
> equivalent to !A || B.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> ---
>   arch/s390/include/asm/scsw.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
> index c00f7b0..a7c3ccf 100644
> --- a/arch/s390/include/asm/scsw.h
> +++ b/arch/s390/include/asm/scsw.h
> @@ -525,8 +525,7 @@ static inline int scsw_cmd_is_valid_pno(union scsw *scsw)
>   	return (scsw->cmd.fctl != 0) &&
>   	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
>   	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
> -		 ((scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
> -		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED)));
> +		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED));
>   }
>   
>   /**

Thank you.

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>

this will go via next s390-tree upstream-release.

Regards
Vineeth Vijayan.



