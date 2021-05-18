Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C442038751D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbhERJaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:30:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:41388 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240100AbhERJaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:30:14 -0400
IronPort-SDR: smUdeMnoUi1ZZQRUB7/Un8sNZze/VRR4OJjLXLtZ9V9Tx0vjwKFZMzRH0L26V6b+1FH8+7pD5a
 BlGWGvgU/2oA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200721317"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="200721317"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 02:28:42 -0700
IronPort-SDR: s4/YpV65u7qXWBbIU0VNgF7/SmPU4nIjltm3nEUBtyCU5H9hSAdzXPavgQQUxBqQq5K+xZfc0+
 jGB0mWSRMF5w==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="472869205"
Received: from lmrad-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.115])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 02:28:39 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     intel-gfx@lists.freedesktop.org, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hch@lst.de
Subject: Re: [Intel-gfx] 5.13 i915/PAT regression on Brasswell, adding nopat to the kernel commandline worksaround this
In-Reply-To: <20210512115736.GA10444@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <b6b61cf0-5874-f4c0-1fcc-4b3848451c31@redhat.com> <YJu4tzXmCJbKp7Fm@hirez.programming.kicks-ass.net> <20210512115736.GA10444@lst.de>
Date:   Tue, 18 May 2021 12:28:36 +0300
Message-ID: <87eee4fl17.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, May 12, 2021 at 01:15:03PM +0200, Peter Zijlstra wrote:
>> IIRC it's because of 74ffa5a3e685 ("mm: add remap_pfn_range_notrack"),
>> which added a sanity check to make sure expectations were met. It turns
>> out they were not.
>> 
>> The bug is not new, the warning is. AFAIK the i915 team is aware, but
>> other than that I've not followed.
>
>
> The actual culprit is b12d691ea5e0 ("i915: fix remap_io_sg to verify the
> pgprot"), but otherwise agreed.  Someone the i915 maintainers all seem
> to be on vacation as the previous report did not manage to trigger any
> kind of reply.

We are aware. I've been rattling the cages to get more attention.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
