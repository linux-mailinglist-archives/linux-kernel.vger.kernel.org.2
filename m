Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46A93881BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352246AbhERU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:57:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:39808 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhERU52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:57:28 -0400
IronPort-SDR: JTE2RAx8cJ9PKv9e0HnTXoqrkP21rkFotI3mvCYrTFMKjXFNyPqfm6gVbxkJo3BGZPVWckd9N6
 gnCbLhuTeJqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="198866640"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="198866640"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:56:08 -0700
IronPort-SDR: s06I5TTBHMH4bwu9CZzkd4l44Z+GxnDh/nQszhtHlUQKwHpbRccurmG6wlkaQwxdC2j3j4naGt
 kCaK/+LPFw6w==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439630881"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:56:06 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <YKP1Xty7EEzHkZ6Y@google.com>
 <8fb0e52c-ed0a-2185-585a-27007c27ed56@linux.intel.com>
 <YKQF08wqTsCQ3qHL@google.com>
 <3a037a43-435b-fc28-63d0-48e543cddfdd@linux.intel.com>
 <YKQlpuKHb7DFFG8y@google.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <387d81b4-37d6-65ac-6bc6-f96980450d4d@linux.intel.com>
Date:   Tue, 18 May 2021 13:56:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKQlpuKHb7DFFG8y@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> virtio-pci, which is going to used by pretty much all traditional VMs, uses iomap.
> See vp_get(), vp_set(), and all the vp_io{read,write}*() wrappers.

That's true. But there are still all the other users. So it doesn't 
solve the problem. In the end I'm fairly sure we would need to patch 
readl/writel and friends.

-Andi

