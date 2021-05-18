Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1274A387E31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351064AbhERRG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:06:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:15523 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239478AbhERRGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:06:54 -0400
IronPort-SDR: QPdF1ztT0rFD0osdKBojHSuUz3+WAjxlTf8xmNDI7RZPDz6v79WX9voKjHbjorVoEB79oM6WjI
 TVpnGAq8VKVw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="261992703"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="261992703"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:05:33 -0700
IronPort-SDR: 9Y5XrH47M7H7EM4RTFwgxagVk60ykgSs7wGCsE0xsSga+ZhMcAIxRscCSejx3ios1gnrmp/Cna
 DGvFlZjlwOhQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439526861"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:05:33 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <94dc5a5a-8c51-8624-5810-e6278783789c@intel.com>
 <c07e1f1e-f93d-dbc6-f7bb-11c7488f4e2f@linux.intel.com>
 <e657e1ed-d86e-f033-151a-21057b979f9f@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <6f2c97b3-8cfe-9f08-7f70-525039e3d00e@linux.intel.com>
Date:   Tue, 18 May 2021 10:05:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e657e1ed-d86e-f033-151a-21057b979f9f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   Or, do we expect the first folks who expose a movdir64b-using driver to
> TDX to go and update this code?

That's what we want to do.


>
> Also, the sev_key_active() stuff in there makes me nervous.  Does this
> scheme work with these:
>
>> static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>> static inline void ins##bwl(int port, void *addr, unsigned long count)  \
> ?


This is not MMIO, but port IO. We do similar changes as AMD for TDX.


-Andi

