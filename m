Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED4137AD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhEKRt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:49:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:49851 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhEKRtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:49:55 -0400
IronPort-SDR: 8jauGyadY6V+E0devMv0uF8u4vO4CfxyeOmmsqpsoqFO++phs/iBXB/YuhscetadyCKnPlWqvt
 uMpQxlbdgTYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199185957"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="199185957"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 10:48:48 -0700
IronPort-SDR: 72faQjpAY4lKRNahWBGfO9AC6niJ6R39iKz6fqXAImoeSwx0a8EHZxde2uQdH8GICoxa+Rm0ML
 UAMeiwGSs5fA==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="434704547"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.131.161]) ([10.212.131.161])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 10:48:47 -0700
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com>
 <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com>
 <CAPcyv4jLMA=jehxdFi=A-xtjSRQ_v7XxSVYrZPAU3XKC39qWRA@mail.gmail.com>
 <43e0a5cc-721a-04f1-50b6-b1319da10bac@intel.com>
 <CAPcyv4gEROpgvf+3Drgso1O6ENQ=2xBoKHqC6d4fWvdDNVSNjA@mail.gmail.com>
 <01b0e007-6af6-ca2e-2a0d-7ff4ca2a2927@linux.intel.com>
 <4456b0d0-c392-4691-2963-c349369158c3@intel.com>
 <497d9293-9111-5d2e-2d19-7343467ff9cd@linux.intel.com>
 <55fd7fbe-4d36-1c1d-532b-bfa876542cd7@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
Date:   Tue, 11 May 2021 10:48:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <55fd7fbe-4d36-1c1d-532b-bfa876542cd7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Is there a good reason for the enduring "general protection fault..."
> message other than an aversion to refactoring the code?

You're the first ever to think it's a problem.

We're assuming that kernel developers are smart enough to understand this.

Please I implore everyone to move on from this patch. This is my last 
email on this topic.

-Andi

