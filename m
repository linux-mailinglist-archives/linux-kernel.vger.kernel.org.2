Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723BE39EC73
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhFHC7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:59:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:56453 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhFHC7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:59:36 -0400
IronPort-SDR: tdFJY7Y2vcCwLnK2KLOM8HL6HjS9JeVxB3S1gguIzQ8V6z19V7ciLeLvdtF4ISoQp77POo+37e
 ImbJPCcLdIKA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="290390456"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="290390456"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 19:57:44 -0700
IronPort-SDR: wd5XJNjPUXoZ951IwOlPYQTMyoik1TIRWWiW8En2dyVZsUr2k9/snG9HoOcAJcyB/lZmIsS6ls
 Sprj8OQrxhyA==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="481775066"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.158.33]) ([10.212.158.33])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 19:57:44 -0700
Subject: Re: [RFC v2-fix-v1 3/3] x86/tdx: Handle port I/O
To:     Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
 <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210527042356.3983284-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jRCZwoJoKGP4v3e8V6u4Y+1VZo_k=umQuh-rrAoMKg4Q@mail.gmail.com>
 <ca836226-46e1-389c-e5c8-c5f1c91130ea@linux.intel.com>
 <CAPcyv4gmokd5YTbL0X8w3KKV6EEO0xraaB-OEFJyncjaHQUUuw@mail.gmail.com>
 <2aba694b-ec36-d57f-06e0-a269f9953bb3@linux.intel.com>
 <CAPcyv4iOJJjghTPTLCkvT-Y_SJOhCbfm66m_NO5Ue+eVr_0NZA@mail.gmail.com>
 <cd4983e4-a3e8-7c33-3197-dd3f7e8f7538@linux.intel.com>
 <CAPcyv4hBiDNOQ-2b5zxaUUyHo9k2h5UOQvM_wGtw_XTok-BmAQ@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <cca48fe7-2717-8eb0-a6c1-a548ff256572@linux.intel.com>
Date:   Mon, 7 Jun 2021 19:57:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hBiDNOQ-2b5zxaUUyHo9k2h5UOQvM_wGtw_XTok-BmAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ps://elixir.bootlin.com/linux/latest/source/kernel/printk/printk_safe.c#L382

> That depends on printk_nmi_direct_enter() to set the context, wouldn't
> an equivalent printk_ve_direct_enter() context flag be needed as well?

Even without it the console semaphore is always trylocked. So recursion 
is just not possible.

What would be possible is a endless loop (printk adding more information 
to the log buffer, which is then printed etc.), but that's true for 
everywhere in the console/serial driver subsystem.


-Andi

