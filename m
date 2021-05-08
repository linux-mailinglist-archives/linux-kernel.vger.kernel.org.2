Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6C376DFB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhEHBAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 21:00:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:30746 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhEHBAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 21:00:37 -0400
IronPort-SDR: qj+QrWZ3Jp/F7OcRVz77fmrzpz/951h+j+Rrbl+AEV0cYfTWnuRNSP5nxx+nqhGZ3tgcFn5qC2
 YFEEwnEG7aHA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="196832329"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="196832329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:59:37 -0700
IronPort-SDR: pu6Y7bK85F7tIRBaQZbqYFMgg2DHqwSFjMZ1wvogw/zF3lSFr59u45v1yTGWt1xmyahgWpAd4P
 W/AC1uJfOAtg==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="533888109"
Received: from shibalik-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.190.154])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:59:36 -0700
Subject: Re: [RFC v2 10/32] x86/tdx: Wire up KVM hypercalls
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <04de6cd6549eee0b77fe3b0937c4b4b7f0e3ff2e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <bc2e6da5-f35d-6574-52d0-82d996e56920@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b836a6a2-3bbe-d568-50f0-0b6b8dbe3133@linux.intel.com>
Date:   Fri, 7 May 2021 17:59:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc2e6da5-f35d-6574-52d0-82d996e56920@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/21 2:46 PM, Dave Hansen wrote:
> I know KVM does weird stuff.  But, this is*really*  weird.  Why are we
> #including a .c file into another .c file?

I think Kirill implemented it this way to skip Makefile changes for it. I don't
see any other KVM direct dependencies in tdx.c.

I will fix it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
