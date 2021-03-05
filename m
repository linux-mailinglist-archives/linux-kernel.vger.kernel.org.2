Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734F432DECE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCEBKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:10:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:33105 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhCEBKU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:10:20 -0500
IronPort-SDR: F8woVAZ9oV42mNP0k4IakWQXjQ8bgRjFA/kswIeBFB+IlPnWJRhrIvxqauZMNqK519vJLDvEx3
 VZDcGDRdAcgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="248930895"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="248930895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 17:10:19 -0800
IronPort-SDR: UIzbXCVQYEJ/zD6grTfxo/M9YSWVrYyga9y6hcgfZfGjk32KBjSJKVFI0Mzw68O9+RXBs1XfxN
 mZnu8SIYImxQ==
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="408065591"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 17:10:19 -0800
Date:   Thu, 4 Mar 2021 17:10:18 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf pmu: Validate raw event with sysfs exported format
 bits
Message-ID: <20210305011018.GL472138@tassilo.jf.intel.com>
References: <20210303051736.26974-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303051736.26974-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Single event:
> 
>   # ./perf stat -e cpu/r031234/ -a -- sleep 1
>   WARNING: event config '31234' not valid (bits 16 17 not supported by kernel)!

Just noticed that again. Can you please print the original event as 
string in the message? While it's obvious with rXXX which one it is, 
it may not be obvious with offsetted fields (like umask=0x121212),
and hard to find in a long command line.

-Andi
