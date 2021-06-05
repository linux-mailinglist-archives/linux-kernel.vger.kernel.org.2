Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85339CA73
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 20:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFESPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 14:15:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:59825 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhFESPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:15:46 -0400
IronPort-SDR: yu7y87BfmbsFX5h8k7YNiuocqGVeQQNWV3TcIHBm85KAu7PefwzX3rEbIuS+tPwmtM7HaCvNNi
 96TA1IxvN7Vg==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="201432336"
X-IronPort-AV: E=Sophos;i="5.83,251,1616482800"; 
   d="scan'208";a="201432336"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 11:13:52 -0700
IronPort-SDR: AHVZQ0uPobEyzaZSnoCLf39lW16r4WOIZgJES25kmcWeBXmdZzd9OSaw0S4UsrU930/aYAk+F9
 8RRBuPijRDWQ==
X-IronPort-AV: E=Sophos;i="5.83,251,1616482800"; 
   d="scan'208";a="448631973"
Received: from eawilkin-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.172.148])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 11:13:52 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstractionn
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic> <YLkcUts9dWDkDKpY@zn.tnic>
 <1c8938fb-c9e9-af51-5224-70fc869eedea@amd.com> <YLqmGzgXo0jFRhpw@zn.tnic>
 <12bba26f-5605-fabf-53ea-f0bc1bb9db44@amd.com> <YLtaGXcjCMsSyT/a@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c25b334a-3c01-2af4-6374-883c19e3837a@linux.intel.com>
Date:   Sat, 5 Jun 2021 11:12:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLtaGXcjCMsSyT/a@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/21 4:03 AM, Borislav Petkov wrote:
> Aha,*now*, I see what you mean. Ok, so the reason why I added the
> WARN is to sanity-check whether we're handling all possible VM_* or
> PROT_GUEST_* flags properly and whether we're missing some. As a
> debugging help. It'll get removed before applying I guess.

Borislav/Tom,

Any consensus on function name and flag prefix?

Currently suggested function names are,

cc_has() or protected_guest_has() or prot_guest_has() or protected_boot_has()

For flag prefix either PR_GUEST_* or CC_*

I am planning to submit another version of this patch with suggested fixes.
If we could reach some consensus on function and flag names, I can include
them in it. If not, I will submit next version without any renames.

Please let me know your comments.

BTW, my choice is protected_guest_has() or CC_has().

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
