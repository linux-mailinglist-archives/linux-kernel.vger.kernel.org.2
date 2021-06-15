Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897393A76D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFOGII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:08:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229493AbhFOGID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:08:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15F63wol093434;
        Tue, 15 Jun 2021 02:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=WtH/0GDuIM1RFrGrskoqpH7PQOp/BTeVrZxhlAFHRZE=;
 b=GYAL7E+IBczpE20iirgmXA+QGaLlxmti+TTIaY5GP88Og/0eu1azEVxCsIKGMmqSGaLv
 B+GnZaDGUVLKMS7AqrR5vXurEc3y/1nz8ulDhJlZlLXo2o2rxcQz86J7MrclDmWHz1vm
 ymnlgeR1JHjLba9SC4vA32X0Z2BjswXdkiivqHGII0xOV9iyuaikzB5owrTeYORrJ7X0
 CJKRc+aXnBBACi1z8c212wIjeWgoTTvPsNhuWfx3G6Z6KGqUJ4vcEsF4Ey4e/EpXuy0H
 IEreGo3eeEmeynztulaIWac2bhJ6vMgTTCCw2CC6eMOvi0Bzke6Hps8hiWm66YHKmHAy rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396mp0jxsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 02:05:42 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15F64YO7096086;
        Tue, 15 Jun 2021 02:05:42 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396mp0jxs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 02:05:42 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15F5wL8u021010;
        Tue, 15 Jun 2021 06:05:40 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 394mj8gq4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 06:05:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15F65bFa23396680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 06:05:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1C544C05C;
        Tue, 15 Jun 2021 06:05:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4204D4C052;
        Tue, 15 Jun 2021 06:05:36 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.174.39])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Jun 2021 06:05:36 +0000 (GMT)
Date:   Tue, 15 Jun 2021 09:05:34 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <YMhDLs6/g51FJewr@linux.ibm.com>
References: <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
 <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
 <YK/HKMgajBCwpLt8@linux.ibm.com>
 <20210527175047.GK8661@arm.com>
 <20210527155644.7792b4eaa16ec56645e1080c@linux-foundation.org>
 <YLB8AvgC2Ov6N6Pt@linux.ibm.com>
 <daaf6faa-b5c1-b201-28c9-07f8e1fe4a82@arm.com>
 <YMcSkvXrsDMPLicd@linux.ibm.com>
 <20210614171351.8c778c335896285020846666@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614171351.8c778c335896285020846666@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ONjhl6Cd2f0Rg7KK76Xke8-q58659v2P
X-Proofpoint-GUID: 4XK5RnCoR-Oq6yLfqMGeL2qj-lbPtTqP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_03:2021-06-14,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:13:51PM -0700, Andrew Morton wrote:
> On Mon, 14 Jun 2021 11:25:54 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
> 
> > On Tue, Jun 08, 2021 at 12:36:21PM +0530, Anshuman Khandual wrote:
> > > 
> > > 
> > > On 5/28/21 10:43 AM, Mike Rapoport wrote:
> > > > On Thu, May 27, 2021 at 03:56:44PM -0700, Andrew Morton wrote:
> > > >> On Thu, 27 May 2021 18:50:48 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > >>
> > > >>>> Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
> > > >>>>
> > > >>>> https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> > > >>>>
> > > >>>> It seems to me that the check for memblock_is_memory() in
> > > >>>> arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
> > > >>>> section parts that are not actually populated and then we have
> > > >>>> VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.
> > > >>>
> > > >>> I acked Anshuman's patch, I think they all need to go in together.
> > > >>
> > > >> That's neat.   Specifically which patches are we referring to here?
> > > > 
> > > > arm64: drop pfn_valid_within() and simplify pfn_valid():
> > > > https://lore.kernel.org/lkml/20210511100550.28178-5-rppt@kernel.org
> > > > 
> > > > arm64/mm: Drop HAVE_ARCH_PFN_VALID:
> > > > https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> > > 
> > > I dont see the above patch (which drops HAVE_ARCH_PFN_VALID on arm64) on linux-next
> > > i.e. next-20210607. I might have missed some earlier context here but do not we want
> > > to fallback on generic pfn_valid() after Mike's series ?
> > 
> > Andrew,
> > 
> > Can you please pick the two patches above?
> 
> I already had
> 
> include-linux-mmzoneh-add-documentation-for-pfn_valid.patch
> memblock-update-initialization-of-reserved-pages.patch
> arm64-decouple-check-whether-pfn-is-in-linear-map-from-pfn_valid.patch
> arm64-drop-pfn_valid_within-and-simplify-pfn_valid.patch
> 
> and I just added
> 
> arm64-mm-drop-have_arch_pfn_valid.patch
> 
> so I think we're all good now?

Yes. 
 
> and I don't think any of this is needed in 5.13 or -stable, correct?

Right.
 
> I still have question marks over
> 
> https://lkml.kernel.org/r/YJ0Fhs5krPJ0FgiV@kernel.org and
> https://lkml.kernel.org/r/d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com
> 
> Is this all OK now?

Yes, it is.

-- 
Sincerely yours,
Mike.
