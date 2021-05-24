Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3374438DFEC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 05:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhEXDpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 23:45:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:52654 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhEXDpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 23:45:23 -0400
IronPort-SDR: oY4bzlUTkhEr9sL5Xha4b4s9PX4TjLd0popXdmFlO8hIQC1olqdzVZ6Ut9DkPFcjERVl1hcc/W
 qa2ZvhAZIUPw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="189231011"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="189231011"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 20:43:55 -0700
IronPort-SDR: D0SultR+b0y5j9AVbyB4E7fZhKPXBTF4lH6/zcDqzCK87sEkg/yf3bcRhNZx3/R79s0PNRWLiT
 U6IgGnMFqyfA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="545707424"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.230.88]) ([10.212.230.88])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 20:43:55 -0700
Subject: Re: [PATCH] x86/usercopy: speed up 64-bit __clear_user() with
 stos{b,q}
To:     Samuel Neves <sneves@dei.uc.pt>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210523180423.108087-1-sneves@dei.uc.pt>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <761811e5-d693-ed33-c6ba-ce8cf2e5046c@linux.intel.com>
Date:   Sun, 23 May 2021 20:43:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210523180423.108087-1-sneves@dei.uc.pt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2021 11:04 AM, Samuel Neves wrote:
> The
> This change is noticeable from userspace. That is in fact how I spotted it; in
> a hashing benchmark that read from /dev/zero, around 10-15% of the CPU time
> was spent in __clear_user. After this patch, on a Skylake CPU, these are the
> before/after figures:
>
> $ dd if=/dev/zero of=/dev/null bs=1024k status=progress
> 94402248704 bytes (94 GB, 88 GiB) copied, 6 s, 15.7 GB/s

The question is of course if this actually represents any real workload.

-Andi
