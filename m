Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD6389658
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhESTOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:14:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:33088 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhESTOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:14:46 -0400
IronPort-SDR: OZy/X+vYvYjAtEW80DIRDK0pHUi9o82PRb+I1HIuJ5mTGFndpQJaSyVBTCEgRBTbK8pl/7awZe
 /KrHe73TZhMg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="180659959"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="180659959"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 12:13:15 -0700
IronPort-SDR: Ae8dI07kVOsRIiZ4vXjpax5QkYTX/uekLWZMhn+5AOM+9TRVqtUhH5PIYMFGmAbT0BgCnxHDLy
 WF0DVJJhx7bQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411861113"
Received: from ccheung-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.97.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 12:13:14 -0700
Subject: Re: [RFC v2-fix-v1 1/1] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3a7c0bba-cc43-e4ba-f7fe-43c8627c2fc2@intel.com>
 <20210519055842.2048957-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <568d2929-f366-e3be-96f9-0bfa91991ef2@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <02e7b229-4b6f-c1c7-bb63-48e5e9eca5db@linux.intel.com>
Date:   Wed, 19 May 2021 12:13:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <568d2929-f366-e3be-96f9-0bfa91991ef2@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 8:31 AM, Dave Hansen wrote:
> Was this "older compiler" argument really the reason?

It is a speculation. I haven't tried to reproduce it with old compiler. So
I have removed that point.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
