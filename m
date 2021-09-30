Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40241DA72
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbhI3NFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:05:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33411 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349366AbhI3NFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:05:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UBU3nJ025871;
        Thu, 30 Sep 2021 09:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2vbgoJEmdLYy74PUu6Dx+MN4WyBEtT8QqoIPEwitx9Q=;
 b=AuhrWffColR48bBt0Fp0GLQbcn32SNsysWRFGisxsDVH8RWo8bKPhDASvGt5kCosnwMp
 RrPZkx/2kzm5yMuwY64xQj7ATZbbN/J+e0c/QXdZ3QFiShlLMQsTPmeYsPcnrZ4cGJdp
 eUgTRnb4/m+jTRwSFiGUUiM1U8tuk9d/I3kEi90q6B2tGAqyBIJOxO5G9q/dkfcZOpZC
 4gbdMgcAruRy4AgB3cgpuZiAAjXxL3BqhCpbYOverLAEIDemJz13r+grRs6d291Nqmow
 BgMXKaRJBzVrN0loqHOhQVJux8i4g2xSo8n+xF4oMte9zpHdD3sZCRY5X4YozU+GbAw6 mg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bdcdwj6k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 09:02:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18UCvIPJ009029;
        Thu, 30 Sep 2021 13:02:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3b9udabq00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 13:02:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18UD2Mna28246324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 13:02:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC5ACAE058;
        Thu, 30 Sep 2021 13:02:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C474AE059;
        Thu, 30 Sep 2021 13:02:22 +0000 (GMT)
Received: from osiris (unknown [9.145.155.146])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Sep 2021 13:02:22 +0000 (GMT)
Date:   Thu, 30 Sep 2021 15:02:20 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/7] s390: add CPU field to struct thread_info
Message-ID: <YVW1XKJcKpuOxAaf@osiris>
References: <20210930125813.197418-1-ardb@kernel.org>
 <20210930125813.197418-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930125813.197418-4-ardb@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4eB2KPvfu0QXrdNWhcV6PVvoeXenPjlf
X-Proofpoint-GUID: 4eB2KPvfu0QXrdNWhcV6PVvoeXenPjlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_04,2021-09-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=590 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:58:09PM +0200, Ard Biesheuvel wrote:
> The CPU field will be moved back into thread_info even when
> THREAD_INFO_IN_TASK is enabled, so add it back to s390's definition of
> struct thread_info.
> 
> Note that s390 always has CONFIG_SMP=y so there is no point in guarding
> the CPU field with an #ifdef.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/s390/include/asm/thread_info.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
