Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F1E37AB27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhEKPx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:53:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:21768 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231764AbhEKPxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:53:54 -0400
IronPort-SDR: CdA/CeACSiTvlqb5ePMGvJSVZ6oVIAk6xnSY9LgqMr/iqx16lnw8yGTwfhepMl9pJHB/ojKYRd
 3UoXNQuDRwYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="186611066"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="186611066"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 08:52:44 -0700
IronPort-SDR: WE8qhOsKVmDOaVNf4taofiisTfVuocFI5boy3ekZvCq94mKOng3ZklGTKjKgMQmc/bmnZj+mkN
 a4WmZKIoWbJQ==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="434610762"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.131.161]) ([10.212.131.161])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 08:52:43 -0700
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <01b0e007-6af6-ca2e-2a0d-7ff4ca2a2927@linux.intel.com>
Date:   Tue, 11 May 2021 08:52:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gEROpgvf+3Drgso1O6ENQ=2xBoKHqC6d4fWvdDNVSNjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The 'default' case in this 'switch' prints the exit reason and faults,
> can't that also trigger a backtrace that dumps the exception stack and
> the faulting instruction? In other words shouldn't this just fail with
> a common way to provide better debug on any unhandled #VE and not try
> to continue running past something that "can't" happen?

It will use the #GP common code which will do all the backtracing etc.

We didn't think we would need anything else than what #GP already does.

-Andi


