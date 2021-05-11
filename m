Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1A37AAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhEKPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:43:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:18632 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231851AbhEKPnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:43:53 -0400
IronPort-SDR: OrpArYHUy97RlCm3sphoN8YW2P6A1lL4AZMaOYtxhIPUSSdBYDRyMAGaHA79NLuEtreh6BD0ED
 oc6rbSLE5DVg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179736627"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="179736627"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 08:42:46 -0700
IronPort-SDR: K2SCQfHgEmPmRA7D2fYVmLD3IzbIz5C1AYPo1rmfpYZlfvqmDge5ZUrWyD++URsoqaV6svMU7u
 N9SjR7qWARmA==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="434606478"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.131.161]) ([10.212.131.161])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 08:42:45 -0700
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <c4cde8b1-978f-e631-91be-900f9efd8f37@linux.intel.com>
Date:   Tue, 11 May 2021 08:42:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jLMA=jehxdFi=A-xtjSRQ_v7XxSVYrZPAU3XKC39qWRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/2021 8:37 AM, Dan Williams wrote:
> O
> Why not just drop the patch if it continues to cause people to spend
> cycles on it and it addresses a problem that will never happen?

We want to at least get some kind of warning if there is really a 
mistake. Just dropping such an ability wouldn't seem right.

That's all that the patch does really.

-Andi


