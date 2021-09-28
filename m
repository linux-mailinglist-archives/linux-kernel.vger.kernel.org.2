Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0873341A8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 08:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhI1GOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 02:14:07 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:61941 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhI1GOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632809546; x=1664345546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gs3m7sok0bsohq67jQzde48+nSgu0gFPpPY8ZHI02gg=;
  b=VoG9U/EfTtEbTEJRMWBBP95FYVyZXypnDaJ27py4jqydKrEVTP3JdMtH
   r2bQLwG5AtXlNaAdUoRBeVyZruMC3fbcouXuQ2LndCskLHzjtZfGpyj3O
   DqepHEzkHPSgxHcI7WOyKnxgsJ3utShaoaNJIjWXvEtSlCHLtENRfd+0r
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Sep 2021 23:12:26 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 23:12:25 -0700
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 27 Sep 2021 23:12:24 -0700
Date:   Mon, 27 Sep 2021 23:12:23 -0700
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
CC:     David Hildenbrand <david@redhat.com>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Message-ID: <20210928061016.GA28837@hu-cgoldswo-sd.qualcomm.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <833493d2-d585-47ee-c258-79eae5deff36@redhat.com>
 <ed2f59dc-ecd3-ae9c-e44c-81e903c6f08f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed2f59dc-ecd3-ae9c-e44c-81e903c6f08f@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:59AM +0300, Georgi Djakov wrote:
> On 9/27/2021 6:51 PM, David Hildenbrand wrote:
> >On 24.09.21 00:54, Chris Goldsworthy wrote:
> >>From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> >>
> >>After new memory blocks have been hotplugged, max_pfn and max_low_pfn
> >>needs updating to reflect on new PFNs being hot added to system.
> >>
> >>Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> >>Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> >>---
> >>  arch/arm64/mm/mmu.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >>diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >>index cfd9deb..fd85b51 100644
> >>--- a/arch/arm64/mm/mmu.c
> >>+++ b/arch/arm64/mm/mmu.c
> >>@@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >>      if (ret)
> >>          __remove_pgd_mapping(swapper_pg_dir,
> >>                       __phys_to_virt(start), size);
> >>+    else {
> >>+        max_pfn = PFN_UP(start + size);
> >>+        max_low_pfn = max_pfn;
> >>+    }
> >>+
> >>      return ret;
> >
> >Note: didn't verify if updating max_low_pfn is correct here.
> 
> My understanding is that max_low_pfn defines the low/high memory
> boundary and it should be also updated.
> 
> Thanks,
> Georgi

To build more on Georgi's response, our assumption here after an offline
discussion is that max_low_pfn would not be equal to max_pfn only if there is
high memory - another assumption is that arm64 kernels will not need high memory
due to their large logical mappings. Under these two assumptions, the patch is
correct. Perhaps Catalin can ack or critique this, as he initially set max_pfn =
max_low_pfn in the first arm64 mm initialization code:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1cc1552616d0f354d040823151e61634e7ad01f
