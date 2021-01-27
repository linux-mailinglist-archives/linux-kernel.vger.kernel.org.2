Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5010930677E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhA0XFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbhA0XBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:01:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FABC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kZWSNPqEKQx9oaCAZI/IANPCF8QkzWgu1zUqU8OXMEY=; b=ifvVOVVxYfXfYKhM2Xa7zGG/lC
        Pff/1FS4RmBAAFrFurrQziXiY9iOvKmr7LGry9j5CL4Dtc/ln2o43Bdp1zynC1KlX/PO/xpmzW2VQ
        6VWTEcUvJUr8q6DekcJ7dszjGk1Nqdr+9PLERVgv6wubgOE+ahLlv719Cpy+splY1tUrSomb1jMQO
        awd2nHVL1CBlLVh20CbFPnOCrUw83pRnQaskIxvf9MvQIab1H66KvIL92chOic/lcgATqmJB+6TUR
        qDX3mm2uHRO0QwGzhI9Zb4O/C0KnuBVgMZI2m/P6HlpZjVAO0Bh4tfeSQZyjZpprlxicH1B2SzV8x
        zUvqrcfQ==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4tnN-0007rY-D7; Wed, 27 Jan 2021 23:00:17 +0000
Subject: Re: [PATCH V3] x86/mm: Tracking linear mapping split events
To:     Saravanan D <saravanand@fb.com>, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <YBHc4JHc4ogwV93W@slm.duckdns.org>
 <20210127225059.246646-1-saravanand@fb.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ea21e39-5642-cc84-ab2d-a813cdb773cd@infradead.org>
Date:   Wed, 27 Jan 2021 15:00:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210127225059.246646-1-saravanand@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 2:50 PM, Saravanan D wrote:
> To help with debugging the sluggishness caused by TLB miss/reload,
> we introduce monotonic lifetime hugepage split event counts since
> system state: SYSTEM_RUNNING to be displayed as part of
> /proc/vmstat in x86 servers
> 
> The lifetime split event information will be displayed at the bottom of
> /proc/vmstat
> ....
> swap_ra 0
> swap_ra_hit 0
> direct_map_2M_splits 167
> direct_map_1G_splits 6
> nr_unstable 0
> ....
> 
> One of the many lasting (as we don't coalesce back) sources for huge page
> splits is tracing as the granular page attribute/permission changes would
> force the kernel to split code segments mapped to huge pages to smaller
> ones thereby increasing the probability of TLB miss/reload even after
> tracing has been stopped.
> 
> Signed-off-by: Saravanan D <saravanand@fb.com>
> ---
>  arch/x86/mm/pat/set_memory.c  | 18 ++++++++++++++++++
>  include/linux/vm_event_item.h |  8 ++++++++
>  mm/vmstat.c                   |  8 ++++++++
>  3 files changed, 34 insertions(+)

Documenation/ update, please.

-- 
~Randy

