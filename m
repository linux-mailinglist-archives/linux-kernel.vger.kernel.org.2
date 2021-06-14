Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202E53A5E59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhFNI2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:28:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhFNI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:28:18 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E83sMK185918;
        Mon, 14 Jun 2021 04:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=V4snhQx1PZPcpA3xshDX0Y0qMosYGU9NJNTOmzv5Afo=;
 b=Jk+Wfbslm10B2P8nA2QaDW/0kuPpWrGpMeU6ClwiuGTisazNQbx3C1qzRdu6KVbq5Fxf
 S+Nu0WBRpM9j0pqhcl1/jJ8L+oqZVFqTjqbrCZITOwBJo/CqLxYAixhCOY9rCCymLJ1D
 YI9hwlTivolnfZr7eBTXJdXrrQYfYAhkKDg5mjuBZ0iNItjNAQxhA+Bdj66x9cH4+A5c
 vg1Qa4Fu5bd0kHv8GEvoouwwsq68jVNoROPk1mMbRMW7z/xZEXdyE6Qe75XeD0tAl82D
 /fQ7p7cgMmjojNrQBFUs8obZcM8x58dauPejq5KTgwFIHPcfvoaOIai2CZU3wYWM0DKK gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3962m09k08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 04:26:03 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15E84LpQ189355;
        Mon, 14 Jun 2021 04:26:03 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3962m09jwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 04:26:02 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E8ESAJ020759;
        Mon, 14 Jun 2021 08:26:00 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 394mj8geky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 08:26:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E8PvBG32506338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 08:25:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA8A2A4055;
        Mon, 14 Jun 2021 08:25:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D624A4051;
        Mon, 14 Jun 2021 08:25:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.184.40])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Jun 2021 08:25:56 +0000 (GMT)
Date:   Mon, 14 Jun 2021 11:25:54 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <YMcSkvXrsDMPLicd@linux.ibm.com>
References: <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
 <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
 <YK/HKMgajBCwpLt8@linux.ibm.com>
 <20210527175047.GK8661@arm.com>
 <20210527155644.7792b4eaa16ec56645e1080c@linux-foundation.org>
 <YLB8AvgC2Ov6N6Pt@linux.ibm.com>
 <daaf6faa-b5c1-b201-28c9-07f8e1fe4a82@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daaf6faa-b5c1-b201-28c9-07f8e1fe4a82@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3C0z_IZB8lFnb7edX8JX7iWqshvOOXYY
X-Proofpoint-GUID: ZCmJ0fybogtg16WYfB7grkWEHCV0Z2hM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_01:2021-06-11,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=879 clxscore=1011 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 12:36:21PM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/28/21 10:43 AM, Mike Rapoport wrote:
> > On Thu, May 27, 2021 at 03:56:44PM -0700, Andrew Morton wrote:
> >> On Thu, 27 May 2021 18:50:48 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>
> >>>> Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
> >>>>
> >>>> https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> >>>>
> >>>> It seems to me that the check for memblock_is_memory() in
> >>>> arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
> >>>> section parts that are not actually populated and then we have
> >>>> VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.
> >>>
> >>> I acked Anshuman's patch, I think they all need to go in together.
> >>
> >> That's neat.   Specifically which patches are we referring to here?
> > 
> > arm64: drop pfn_valid_within() and simplify pfn_valid():
> > https://lore.kernel.org/lkml/20210511100550.28178-5-rppt@kernel.org
> > 
> > arm64/mm: Drop HAVE_ARCH_PFN_VALID:
> > https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> 
> I dont see the above patch (which drops HAVE_ARCH_PFN_VALID on arm64) on linux-next
> i.e. next-20210607. I might have missed some earlier context here but do not we want
> to fallback on generic pfn_valid() after Mike's series ?

Andrew,

Can you please pick the two patches above?

-- 
Sincerely yours,
Mike.
