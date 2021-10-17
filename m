Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC07430BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344530AbhJQTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:30:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:18948 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233508AbhJQTau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:30:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="226903911"
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="226903911"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 12:28:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="565199838"
Received: from ericalo-mobl.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.45.96])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 12:28:39 -0700
Subject: Re: [PATCH v7 3/6] x86/topology: Disable CPU online/offline control
 for TDX guest
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005230550.1819406-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <877deb4frg.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8eef611f-77e1-aec5-3e1f-24a14ad50c91@linux.intel.com>
Date:   Sun, 17 Oct 2021 12:28:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <877deb4frg.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/21 12:23 PM, Thomas Gleixner wrote:
> Seriously? This lets the unplug start, which starts to kick off tasks
> from the CPU just to make it fail a few steps later?
>
> The obvious place to prevent this is the CPU hotplug code itself, right?
>
> Thanks,
>
>          tglx
> ---
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 192e43a87407..c544eb6c79d3 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1178,6 +1178,8 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>   
>   static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>   {
> +	if (cc_platform_has(CC_HOTPLUG_DISABLED))
> +		return -ENOTSUPP;
>   	if (cpu_hotplug_disabled)
>   		return -EBUSY;
>   	return _cpu_down(cpu, 0, target);

Makes sense. I will use it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

