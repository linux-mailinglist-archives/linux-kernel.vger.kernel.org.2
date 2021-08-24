Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06C3F637B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhHXQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:56:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37589 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230269AbhHXQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:56:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17OGaHEt152808;
        Tue, 24 Aug 2021 12:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xBRrl6q1tAEzgNHto0KdQA0U4vzN5WkUxIlVbgFBVTY=;
 b=VL00tAHP5L8m5E3lvj8YFyex+WcogWsNT03uph/YAIjAUXOFQbyIs7oBpxYIQWS1S/PJ
 pKe/OYBHJmuUPKsd3Qp4MViCPfGbNQCaevaKbWA6R7TiPjmSFXAZ99YwapQkDgSi85z1
 Jo1wELw7jpmNYhIyhRCNO6c0YnMMyAXQOQStuyLSUwrgTpgjsW7rNj6Lta7r/YrIV1IO
 kjxKdruTX/KPxY7IBNVdnVd11tZIy4grogrT0Vxe2oyRb/79ahZa1xzaaFTg/B+53HbG
 7rpU7wXniz8vl2+ACPgMW6wam1my0UpB5El9mGlbhZBG46vI26JiFW3lfAb6tSD+VJp7 Hw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3an2kbvn43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 12:55:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17OGmB9s028203;
        Tue, 24 Aug 2021 16:55:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ajrrhdk3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 16:55:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17OGpEJK56361334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 16:51:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C8EBA4053;
        Tue, 24 Aug 2021 16:54:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E48FEA404D;
        Tue, 24 Aug 2021 16:54:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.49.193])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Aug 2021 16:54:56 +0000 (GMT)
Date:   Tue, 24 Aug 2021 19:54:54 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rppt@kernel.org" <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>
Subject: Re: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag
 to allocate pte-mapped pages
Message-ID: <YSUkXqC7P+a0NZeE@linux.ibm.com>
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-4-rppt@kernel.org>
 <889bdfef8b4acbe840668f27782c3d39a987c368.camel@intel.com>
 <YSTt9XEDfbPOpab4@kernel.org>
 <f4a428040f822d7181acfc6c1658173373f28e40.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4a428040f822d7181acfc6c1658173373f28e40.camel@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fQV51_JZkUQ5l5BfAVs3hpKoDQarwNda
X-Proofpoint-GUID: fQV51_JZkUQ5l5BfAVs3hpKoDQarwNda
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_05:2021-08-24,2021-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1011 adultscore=0
 mlxlogscore=954 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108240109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 04:38:03PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2021-08-24 at 16:02 +0300, Mike Rapoport wrote:
> > > We probably want to exclude GFP_ATOMIC before calling into CPA
> > > unless
> > > debug page alloc is on, because it may need to split and sleep for
> > > the
> > > allocation. There is a page table allocation with GFP_ATOMIC passed
> > > actually.
> > 
> > Looking at the callers of alloc_low_pages() it seems that GFP_ATOMIC
> > there
> > is stale...
>
> Well two actually, there is also spp_getpage(). I tried to determine if
> that was also stale but wasn't confident. There were a lot of paths in.
  
It's also used at init and during memory hotplug, so I really doubt it
needs GFP_ATOMIC.

> > > In my next series of this I added support for GFP_ATOMIC to this
> > > code,
> > > but that solution should only work for permission changing grouped
> > > page
> > > allocators in the protected page tables case where the direct map
> > > tables are handled differently. As a general solution though
> > > (that's
> > > the long term intention right?), GFP_ATOMIC might deserve some
> > > consideration.
> > 
> > ... but for the general solution GFP_ATOMIC indeed deserves some
> > consideration.
> >  
> > > The other thing is we probably don't want to clean out the atomic
> > > reserves and add them to a cache just for one page. I opted to just
> > > convert one page in the GFP_ATOMIC case.
> >  
> > Do you mean to allocate one page in GFP_ATOMIC case and bypass high
> > order
> > allocation?
> > But the CPA split is still necessary here, isn't it?
>
> Yes, grabs one atomic page and fragments it in the case of no pages in
> the grouped page cache. The CPA split is necessary still, but it should
> be ok because of the special way direct map page table allocations are
> handled for pks tables. Has not been reviewed by anyone yet, and
> wouldn't work as a general solution anyway.

-- 
Sincerely yours,
Mike.
