Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BAF3A4613
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFKQEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:04:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:27117 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhFKQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:03:41 -0400
IronPort-SDR: /gPjWcXDEm1KS9CCdfUTA2xbdHD8bBZcAESNvyDvfYw9qaHKOY7XRGhkB5XZ+I2i2p74MX1mZX
 hnqriKDSclvg==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="185926869"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="185926869"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:01:04 -0700
IronPort-SDR: rFi6t35cd8XsBphG7z+d35GzVEcLMY3cshgxrVVxtgCufBVYZB9/2fCy0YXQr9/I2UTjYC2jg5
 Whun5RyFeROQ==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="553447477"
Received: from czanatax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.184.187])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:01:02 -0700
Subject: Re: [PATCH v1 1/7] x86/mm: Move force_dma_unencrypted() to common
 code
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210609215537.1956150-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <26979aed-bca0-7e0a-91af-f68da590454d@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0b33a843-d68e-657c-ff4d-239501fe05c8@linux.intel.com>
Date:   Fri, 11 Jun 2021 09:00:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <26979aed-bca0-7e0a-91af-f68da590454d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/21 7:43 AM, Tom Lendacky wrote:
> Until other stuff is added, this should probably just be:
> 
> 	return amd_force_dma_unencrypted(dev);

Make sense. I will add sev and sme related checks when I extend it
for TDX.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
