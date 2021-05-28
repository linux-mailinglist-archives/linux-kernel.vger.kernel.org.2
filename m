Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E94393CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 07:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhE1FPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 01:15:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234573AbhE1FPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 01:15:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14S52qFd140317;
        Fri, 28 May 2021 01:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=UiKekC5zenLEC0oiLXbWNjq2YAV5vKtNk4ruw7i2o/E=;
 b=ooQumS1ThFz0Tk4i41h0UNMuB0iLSZYz3A769Ej0GS1qlvElmA8vQTDuA0iJ6OfLelso
 kyomktDQXaagyBDLDRyQtAsHPVdausRjQiRQrEFdPbNC38APg6R8U9Ox/H7/5dnvpsye
 gTc3VSILgM1aKmzYJ0KTSYxViEXzArffuqeGrls0pmm/5lfPmrufGPEV+3mRSjkKKd3J
 Bozd4sUufGiUC0dPBkBL69fvgcw3VIF3o+H4kpPUloilcK0gPVmU6e8G+m5dr5913WfM
 TdXhcOlj93JE1WFIHsa/LzWTLGvueDPmNKTH61DSezg9MfCXWQrATOLYSlCde2NFRUoD XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ts251e67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 01:13:46 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14S53UY3143128;
        Fri, 28 May 2021 01:13:46 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ts251e5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 01:13:46 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14S59iHe003612;
        Fri, 28 May 2021 05:13:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38s1r49j1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 05:13:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14S5DC1m36569548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 05:13:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C059A4054;
        Fri, 28 May 2021 05:13:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E8B1A405B;
        Fri, 28 May 2021 05:13:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.39.77])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 28 May 2021 05:13:40 +0000 (GMT)
Date:   Fri, 28 May 2021 08:13:38 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <YLB8AvgC2Ov6N6Pt@linux.ibm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
 <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
 <YK/HKMgajBCwpLt8@linux.ibm.com>
 <20210527175047.GK8661@arm.com>
 <20210527155644.7792b4eaa16ec56645e1080c@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527155644.7792b4eaa16ec56645e1080c@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _CCvDuIOOIv9xCKh0MxlB1QK02SSnVij
X-Proofpoint-GUID: xKj0ytwkT9eL06qp4cBrTpqhJfi10oKo
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_02:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=744 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 03:56:44PM -0700, Andrew Morton wrote:
> On Thu, 27 May 2021 18:50:48 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > > Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
> > > 
> > > https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> > > 
> > > It seems to me that the check for memblock_is_memory() in
> > > arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
> > > section parts that are not actually populated and then we have
> > > VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.
> > 
> > I acked Anshuman's patch, I think they all need to go in together.
> 
> That's neat.   Specifically which patches are we referring to here?

arm64: drop pfn_valid_within() and simplify pfn_valid():
https://lore.kernel.org/lkml/20210511100550.28178-5-rppt@kernel.org

arm64/mm: Drop HAVE_ARCH_PFN_VALID:
https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com

-- 
Sincerely yours,
Mike.
