Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79514361AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbhDPH7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:59:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239859AbhDPH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:59:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13G7XxHN138687;
        Fri, 16 Apr 2021 03:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=a60hQsz0xpYXDiJLKWxC2W4MYc6pkB5sdNqBWr6ssRM=;
 b=spzbPzZMF3zeVl4NFNSTDSMdK0r/jGaaX6AKC9buToIO8TcKoy8+E04Sb87Bnp+FAt9a
 buSSS2hjv6/og1ImD1DElmf67k4ZbaPnrE4iVPCnDFW26DbCwQA/3xNW55Vg9jNRLBPx
 n4B2iqeJYktPHfWjnH0w3hy5s5yBY4p9R3djnyZlHY68SGlgrP8QEuayCVfui4b27vHm
 B89lz1zNIefD2PSjRRdLnScwYYl1YOBVZyqyqk4B4CkMgSZetAAEbjulx4tjqzZqPpr9
 wt//4Bv3MrwSVM1KC10aybQRxIgfXyoGhOclGMmegUqF8MdhSWSmotczkI0R3wh9rtpu sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xtqa07cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 03:58:29 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13G7Z88Q141859;
        Fri, 16 Apr 2021 03:58:29 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xtqa07c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 03:58:29 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13G7vGCH020596;
        Fri, 16 Apr 2021 07:58:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 37u39hmb6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 07:58:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13G7wO4W34341168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 07:58:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D00ADA4051;
        Fri, 16 Apr 2021 07:58:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85222A4040;
        Fri, 16 Apr 2021 07:58:22 +0000 (GMT)
Received: from [9.85.71.75] (unknown [9.85.71.75])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Apr 2021 07:58:22 +0000 (GMT)
Subject: Re: [PATCH v1 1/1] powerpc/papr_scm: Properly handle UUID types and
 API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
References: <20210415134637.17770-1-andriy.shevchenko@linux.intel.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <af677216-82b4-f1fa-1d90-3d32dabf8583@linux.ibm.com>
Date:   Fri, 16 Apr 2021 13:28:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415134637.17770-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rnJsI56rpExDF3Bo1wlmngO1NTDBBViL
X-Proofpoint-ORIG-GUID: VhrjLmthWVmM633LBBbNsjhsOjnPESOb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 7:16 PM, Andy Shevchenko wrote:
> Parse to and export from UUID own type, before dereferencing.
> This also fixes wrong comment (Little Endian UUID is something else)
> and should fix Sparse warnings about assigning strict types to POD.
> 
> Fixes: 43001c52b603 ("powerpc/papr_scm: Use ibm,unit-guid as the iset cookie")
> Fixes: 259a948c4ba1 ("powerpc/pseries/scm: Use a specific endian format for storing uuid from the device tree")
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Not tested
>   arch/powerpc/platforms/pseries/papr_scm.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index ae6f5d80d5ce..4366e1902890 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -1085,8 +1085,9 @@ static int papr_scm_probe(struct platform_device *pdev)
>   	u32 drc_index, metadata_size;
>   	u64 blocks, block_size;
>   	struct papr_scm_priv *p;
> +	u8 uuid_raw[UUID_SIZE];
>   	const char *uuid_str;
> -	u64 uuid[2];
> +	uuid_t uuid;
>   	int rc;
>   
>   	/* check we have all the required DT properties */
> @@ -1129,16 +1130,18 @@ static int papr_scm_probe(struct platform_device *pdev)
>   	p->hcall_flush_required = of_property_read_bool(dn, "ibm,hcall-flush-required");
>   
>   	/* We just need to ensure that set cookies are unique across */
> -	uuid_parse(uuid_str, (uuid_t *) uuid);
> +	uuid_parse(uuid_str, &uuid);
> +
>   	/*
>   	 * cookie1 and cookie2 are not really little endian
> -	 * we store a little endian representation of the
> +	 * we store a raw buffer representation of the
>   	 * uuid str so that we can compare this with the label
>   	 * area cookie irrespective of the endian config with which
>   	 * the kernel is built.
>   	 */
> -	p->nd_set.cookie1 = cpu_to_le64(uuid[0]);
> -	p->nd_set.cookie2 = cpu_to_le64(uuid[1]);
> +	export_uuid(uuid_raw, &uuid);
> +	p->nd_set.cookie1 = get_unaligned_le64(&uuid_raw[0]);
> +	p->nd_set.cookie2 = get_unaligned_le64(&uuid_raw[8]);
>   

ok that does the equivalent of cpu_to_le64 there. So we are good. But 
the comment update is missing the details why we did that 
get_unaligned_le64. Maybe raw buffer representation is the correct term?
Should we add an example in the comment. ie,

/*
  * Historically we stored the cookie in the below format.
for a uuid str 72511b67-0b3b-42fd-8d1d-5be3cae8bcaa
cookie1 was  0xfd423b0b671b5172 cookie2 was 0xaabce8cae35b1d8d
*/



>   	/* might be zero */
>   	p->metadata_size = metadata_size;
> 

