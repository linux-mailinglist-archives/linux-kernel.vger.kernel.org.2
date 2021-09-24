Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7B417C90
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbhIXUyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:54:41 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:36912 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhIXUyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632516787; x=1664052787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NWi+/obJ5SRPKntuFtbOfRlh9MXiWPHJ5Z9qzdR+g9w=;
  b=pgS08UP88HxYm/8iRmRD5YTagj373aMBuujMqyV6FV89nfkef8pqMPQO
   a2ERtLzTelTjkNyhnkXezyn7uU/PuN2Gwj8ZdalQxVonqUnUBbkfbnviU
   oJ+FwYnq62BFHXjTNgi3x4Dv9b6NlmYNdjlNxk1sPkOQ6PgEBicU9iaLa
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Sep 2021 13:53:06 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 13:53:06 -0700
Received: from hu-cgoldswo-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 24 Sep 2021 13:53:05 -0700
Date:   Fri, 24 Sep 2021 13:52:58 -0700
From:   Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        "Doug Berger" <opendmb@gmail.com>
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Message-ID: <20210924205258.GA17966@hu-cgoldswo-sd.qualcomm.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <6eb8319d-acba-b69a-5db3-5dca9ef426e8@gmail.com>
 <41789cad-76c6-0ea5-4aa1-3e4a52acff86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <41789cad-76c6-0ea5-4aa1-3e4a52acff86@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the response David.

On Fri, Sep 24, 2021 at 10:17:46AM +0200, David Hildenbrand wrote:
> no-map means that no direct mapping is to be created, right? We would still
> have a memmap IIRC, and the pages are PG_reserved.
> 
> Again, I think this is very similar to just having no-map regions like
> random memory holes within the existing memory layout.

For those curious, see __reserved_mem_alloc_size() >
early_init_dt_alloc_reserved_memory_arch() > memblock_mark_nomap() - the
'no-map' attribute is read in __reserved_mem_alloc_size() and the pre-requisite
steps need to have the relevant struct pages marked as PG_reserved 
are taken in memblock_mark_nomap().

> What Chris proposes here is very similar to
> arch/x86/mm/init_64.c:update_end_of_memory_vars() called during
> arch_add_memory()->add_pages() on x86-64.
> 

For other's reference, the patch was derived from what x86 is doing with max_pfn
(such that we also set max_low_pfn as is done in arm64's mm/init.c.
