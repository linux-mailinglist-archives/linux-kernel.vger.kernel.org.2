Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD223F683E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbhHXRlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:41:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58706 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239696AbhHXRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:38:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17OHWhth176257;
        Tue, 24 Aug 2021 13:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=apG70aJ/9/o91gaHVI8ONKpmjOKmh4LFjOVUyqSdfFc=;
 b=GlHwUQh3mM9BxPqIg3DelWrhvk3bTBPVGMBADwGkaSSxaOkHH6wydTn6oX7mPlgv+cYt
 rH5hPwwlX6bL4Bc28xagEpLptk/O7iPXObD37X3IuxnB+sOU+DQfCr4cfULQI3gV1sm9
 PCOX7kXluPJ8I8gsY84sK90D11JvFlckrukhiXpkkgEfmZsU5wzG6YfeuB4AJm2aa9fB
 XmeCWtDwlOAyiM0uty2b2qzjFvjhBlHg5dSOUY+FJ1Q+vxKw0PxfYds6PF2mayhb4tDu
 b2krYRNaJgZ28gc1+eR1hBCQC1E1RK8yoedv8BFwh0q+uLCq/BLAd76qiIBNlBJ5Agvs mA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3an57q862d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 13:37:49 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17OHWQAw004470;
        Tue, 24 Aug 2021 17:37:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3ajrrhdmsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 17:37:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17OHbibP49873250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 17:37:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D31C52059;
        Tue, 24 Aug 2021 17:37:44 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.49.193])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 5F9E65204F;
        Tue, 24 Aug 2021 17:37:43 +0000 (GMT)
Date:   Tue, 24 Aug 2021 20:37:41 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>
Subject: Re: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag
 to allocate pte-mapped pages
Message-ID: <YSUuZfUAub6wvG9L@linux.ibm.com>
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-4-rppt@kernel.org>
 <889bdfef8b4acbe840668f27782c3d39a987c368.camel@intel.com>
 <YSTt9XEDfbPOpab4@kernel.org>
 <f4a428040f822d7181acfc6c1658173373f28e40.camel@intel.com>
 <YSUkXqC7P+a0NZeE@linux.ibm.com>
 <c7ae898069360aff581be5eebeb74c0d03bb3bde.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ae898069360aff581be5eebeb74c0d03bb3bde.camel@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1UgSVA1b7GLlZAg0LPr1MyeHhJCJWssE
X-Proofpoint-ORIG-GUID: 1UgSVA1b7GLlZAg0LPr1MyeHhJCJWssE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_05:2021-08-24,2021-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 mlxlogscore=974 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 05:23:04PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2021-08-24 at 19:54 +0300, Mike Rapoport wrote:
> > On Tue, Aug 24, 2021 at 04:38:03PM +0000, Edgecombe, Rick P wrote:
> > > On Tue, 2021-08-24 at 16:02 +0300, Mike Rapoport wrote:
> > > > > We probably want to exclude GFP_ATOMIC before calling into CPA
> > > > > unless
> > > > > debug page alloc is on, because it may need to split and sleep
> > > > > for
> > > > > the
> > > > > allocation. There is a page table allocation with GFP_ATOMIC
> > > > > passed
> > > > > actually.
> > > > 
> > > > Looking at the callers of alloc_low_pages() it seems that
> > > > GFP_ATOMIC
> > > > there
> > > > is stale...
> > > 
> > > Well two actually, there is also spp_getpage(). I tried to
> > > determine if
> > > that was also stale but wasn't confident. There were a lot of paths
> > > in.
> > 
> >   
> > It's also used at init and during memory hotplug, so I really doubt
> > it
> > needs GFP_ATOMIC.
> 
> Pretty sure it gets called after init by at least something besides
> hotplug. I saw it during debugging with a little sanitizer I built to
> find any unprotected page tables missed. Something tweaking the fixmap
> IIRC. Did you look at the set_fixmap_() and set_pte_vaddr() family of
> functions? Now whether any of them actually need GFP_ATOMIC, I am less
> sure. There were a fair amount of drivers to analyze.

Oh, I've missed set_pte_vaddr(). I still doubt anything that uses those two
would need GFP_ATOMIC, but it's surely way harder to analyze.

-- 
Sincerely yours,
Mike.
