Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540F93995C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 00:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBWQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 18:16:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:19527 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhFBWQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 18:16:24 -0400
IronPort-SDR: yzICUBlXM6V4LfjXrepOIeBLs9KKCKRPl6AelqqK63wlrUFtH8NO1/7yot3ZPijLArPIROXlWO
 tTLSctN5SlZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191020805"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="191020805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 15:14:40 -0700
IronPort-SDR: YAjX4CAamwgH87NmgM6s1/GllXvTxwdgDgDrXKODCggorBot3EGz4Em5hkQuV75+mKLQDhpPHY
 SiORGJQVUfOw==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="417100003"
Received: from sboinap-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.149])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 15:14:39 -0700
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Handle in-kernel MMIO
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210602194220.2227863-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602194220.2227863-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aac39d2e-c812-71c0-c769-e505ff6c5b40@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9aa8b9b1-3cfa-b126-9cf5-f183126d21bb@linux.intel.com>
Date:   Wed, 2 Jun 2021 15:14:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <aac39d2e-c812-71c0-c769-e505ff6c5b40@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/21 2:01 PM, Andi Kleen wrote:
> Actually it looks like it's implemented below now, so that sentence could be dropped.

Will fix it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
