Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4358B344936
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhCVP0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:26:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhCVPZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:25:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MF42og097905;
        Mon, 22 Mar 2021 11:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QMpxk0Nq7Qz393K1QjsySKFZuPDm1IX26bDlAVSgukM=;
 b=nShhujtwrv7XIWzX7YON9GvDWzquNLGGpvQAAZzKqKaNnwL/r3kz4Nhmhmi9aPxtC43P
 mxckvL3oar4UvEnq0oWapHe7bWmf2gCyPQ5lAjBv0XEwwYdPHNb2y5UeYyM7DlWDCWxB
 5Ir3sX53Rosk0utIuO+JICLFtDi6lH8RBp7pQE1xoXQ6l+cnY7E1V8FlYisKr5IPpOoW
 5Mu8eXOASLVfD0qV6clOEVXZrW7lOsBVOGlXRlCc8c1vAWlHyL9823wYyh5HWp09PVF/
 M8ILgPwvemMHpY28HxqyE6hG+TycKO6jYPmPJoGE7yOo00qrYkJzc1cvLAgG/rJ26VdS 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dwy5mxyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 11:25:17 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12MF6R97109185;
        Mon, 22 Mar 2021 11:25:16 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dwy5mxxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 11:25:16 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12MFIqia001384;
        Mon, 22 Mar 2021 15:25:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 37d9a619kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 15:25:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12MFOrhD14614980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 15:24:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9465EA4072;
        Mon, 22 Mar 2021 15:25:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48FC0A4065;
        Mon, 22 Mar 2021 15:25:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Mar 2021 15:25:10 +0000 (GMT)
Received: from [9.102.36.130] (unknown [9.102.36.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B70EE601F4;
        Tue, 23 Mar 2021 02:25:06 +1100 (AEDT)
Subject: Re: [PATCH] cxl: Fix couple of spellings
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, fbarrat@linux.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210322023307.168754-1-unixbhaskar@gmail.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <744eb25f-c043-dcb0-b711-4d16c776835f@linux.ibm.com>
Date:   Tue, 23 Mar 2021 02:24:58 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322023307.168754-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_07:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1011 phishscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103220109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/3/21 1:33 pm, Bhaskar Chowdhury wrote:
> 
> s/filesytem/filesystem/
> s/symantics/semantics/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
>   drivers/misc/cxl/context.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index fb2eff69e449..e627b4056623 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -52,7 +52,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
>   		 * can always access it when dereferenced from IDR. For the same
>   		 * reason, the segment table is only destroyed after the context is
>   		 * removed from the IDR.  Access to this in the IOCTL is protected by
> -		 * Linux filesytem symantics (can't IOCTL until open is complete).
> +		 * Linux filesystem semantics (can't IOCTL until open is complete).
>   		 */
>   		i = cxl_alloc_sst(ctx);
>   		if (i)
> --
> 2.31.0
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
