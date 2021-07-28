Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8B3D960A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhG1T2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 15:28:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhG1T2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:28:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SJ5RmD195628;
        Wed, 28 Jul 2021 15:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kyaZ4GYcmSZei/dzdWHkHv20uzLVnPG2c8tJNuEPL68=;
 b=fMInDaUjIeHnHcGBqL0NfjXi6aU70UAEdaw1z2BTXKV4a1ujgYzVZWLiarWTOfo7HrFj
 7gu9k8bgGZy71OaOqLW5JhngHoEXb1NQ066HOmCydbjnEw8blDg8ll0qJeWUxpow+Lmk
 KUzTb3aaTTNRYWepwKe7sn7ThzpjH12PpaDjn7F0LEVWf8tMnowpTNrxJ0c7CELof58H
 xuWp+DS2yUAzMcctA+BSrQkDq6zcrVxdq3KqJ+Eif7XJ7zRBcsAWHNzN1LezfuQbDKsf
 JPhZeO1CQRFO5F9NhEbL5NDuTVs5SuBzOlmYJtyeQSFjSYgEeH249uz9gNQAjtjKQU9i eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3b0xv17v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:28:34 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SJ6lF1010114;
        Wed, 28 Jul 2021 15:28:34 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3b0xv17b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 15:28:34 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJNRSv012081;
        Wed, 28 Jul 2021 19:28:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3a235kgu3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 19:28:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SJSSmU30278036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 19:28:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A572AE051;
        Wed, 28 Jul 2021 19:28:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1C7EAE045;
        Wed, 28 Jul 2021 19:28:27 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.170.45])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 19:28:27 +0000 (GMT)
Subject: Re: [PATCH 2/4] kfence: add function to mask address bits
To:     Heiko Carstens <hca@linux.ibm.com>, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210728190254.3921642-1-hca@linux.ibm.com>
 <20210728190254.3921642-3-hca@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <ed973c3c-2f2f-0f01-d4d1-96c83daff1b1@de.ibm.com>
Date:   Wed, 28 Jul 2021 21:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210728190254.3921642-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0m4aXonDSTnYHZBiEnr2dNIdvC3bWxar
X-Proofpoint-ORIG-GUID: xxPKxHU_4mDiA__dUAxdGqsDT-zwgXzO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_09:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.07.21 21:02, Heiko Carstens wrote:
> From: Sven Schnelle <svens@linux.ibm.com>
> 
> s390 only reports the page address during a translation fault.
> To make the kfence unit tests pass, add a function that might
> be implemented by architectures to mask out address bits.

FWIW, the s390 hardware does indeed only provide the page address
for page faults. We had to do the same trick for other software,
e.g. see valgrind
https://sourceware.org/git/?p=valgrind.git;a=blob;f=coregrind/m_signals.c;h=b45afe59923245352ac17fdd1eeeb5e220f912be;hb=HEAD#l2702


> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   mm/kfence/kfence_test.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index 942cbc16ad26..eb6307c199ea 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -23,8 +23,15 @@
>   #include <linux/tracepoint.h>
>   #include <trace/events/printk.h>
>   
> +#include <asm/kfence.h>
> +
>   #include "kfence.h"
>   
> +/* May be overridden by <asm/kfence.h>. */
> +#ifndef arch_kfence_test_address
> +#define arch_kfence_test_address(addr) (addr)
> +#endif
> +
>   /* Report as observed from console. */
>   static struct {
>   	spinlock_t lock;
> @@ -82,6 +89,7 @@ static const char *get_access_type(const struct expect_report *r)
>   /* Check observed report matches information in @r. */
>   static bool report_matches(const struct expect_report *r)
>   {
> +	unsigned long addr = (unsigned long)r->addr;
>   	bool ret = false;
>   	unsigned long flags;
>   	typeof(observed.lines) expect;
> @@ -131,22 +139,25 @@ static bool report_matches(const struct expect_report *r)
>   	switch (r->type) {
>   	case KFENCE_ERROR_OOB:
>   		cur += scnprintf(cur, end - cur, "Out-of-bounds %s at", get_access_type(r));
> +		addr = arch_kfence_test_address(addr);
>   		break;
>   	case KFENCE_ERROR_UAF:
>   		cur += scnprintf(cur, end - cur, "Use-after-free %s at", get_access_type(r));
> +		addr = arch_kfence_test_address(addr);
>   		break;
>   	case KFENCE_ERROR_CORRUPTION:
>   		cur += scnprintf(cur, end - cur, "Corrupted memory at");
>   		break;
>   	case KFENCE_ERROR_INVALID:
>   		cur += scnprintf(cur, end - cur, "Invalid %s at", get_access_type(r));
> +		addr = arch_kfence_test_address(addr);
>   		break;
>   	case KFENCE_ERROR_INVALID_FREE:
>   		cur += scnprintf(cur, end - cur, "Invalid free of");
>   		break;
>   	}
>   
> -	cur += scnprintf(cur, end - cur, " 0x%p", (void *)r->addr);
> +	cur += scnprintf(cur, end - cur, " 0x%p", (void *)addr);
>   
>   	spin_lock_irqsave(&observed.lock, flags);
>   	if (!report_available())
> 
