Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05A63AD63A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 02:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhFSAPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 20:15:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:48584 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhFSAPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 20:15:52 -0400
IronPort-SDR: tL28V7wWVIRtVZ5yBE6eh2af8718vDWr3V1/fxIoPEl2Jm8eeeBK9OBHqj+j/D/Wni/h0IB2sS
 MbLkKnLrBuJw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="228173432"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="228173432"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 17:13:42 -0700
IronPort-SDR: FRm3gdpP3kLwArLQu2OTBW5eEj++BC0TuRb4tB13omjeiSASd1x9bQ4NExU74uImEcBtQLeGNZ
 AEaFokRRfs4A==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="451569001"
Received: from msayeed-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.172.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 17:13:41 -0700
Subject: Re: [PATCH v3 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YM0uoTnAi7TpU5fF@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6b68dc50-4d4c-f724-8ab8-0a12a07d42aa@linux.intel.com>
Date:   Fri, 18 Jun 2021 17:13:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YM0uoTnAi7TpU5fF@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/21 4:39 PM, Borislav Petkov wrote:
>  From Documentation/process/submitting-patches.rst:
> 
> "Both Tested-by and Reviewed-by tags, once received on mailing list from tester
> or reviewer, should be added by author to the applicable patches when sending
> next versions.  However if the patch has changed substantially in following
> version, these tags might not be applicable anymore and thus should be removed.
> Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
> in the patch changelog (after the '---' separator)."
> 
> IOW, for the next revisions of your patchsets, you should drop
> Reviewed-by: tags on patches when they've changed more than trivially
> because otherwise those tags have no meaning at all.
> 
> Also, please take the time to peruse the above document on the kernel
> process while waiting.

I will make sure to remove the Reviewed-by/Tested-by tags for the changed patches
in the next submission. But, IMO, changes made in this patch is minimal. Nothing
changed functionally. So, do we still need to remove the tags for this patch?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
