Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEE03E1ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbhHERw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:52:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:36807 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236297AbhHERw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:52:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="275263248"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="275263248"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 10:52:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="437873096"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.183.241]) ([10.212.183.241])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 10:52:11 -0700
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com> <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <CAPcyv4iCBknhGyw-YjO7_Tua9Vkw_UCSHVj3prL3mVfz4nj-_g@mail.gmail.com>
 <1e9efeb3-4aef-68e2-6af3-cf6bb5decb38@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <f4dedead-5b6c-2712-deca-0d59d314016b@linux.intel.com>
Date:   Thu, 5 Aug 2021 10:52:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1e9efeb3-4aef-68e2-6af3-cf6bb5decb38@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/5/2021 10:25 AM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 8/5/21 9:37 AM, Dan Williams wrote:
>> I overlooked the "authorized" attribute in usb and thunderbolt. The
>> collision problem makes sense. Are you open to a core "authorized"
>> attribute that buses like usb and thunderbolt would override in favor
>> of their local implementation? I.e. similar to suppress_bind_attrs:
>
> Even if such overriding is allowed in default boot, it should not be
> allowed in protected guest + driver_filter model.


Allowing overriding would be acceptable, as long as nobody does it by 
default. In theory a (root) user program can already do other things 
that make the guest insecure.

Still it's not clear to me how this proposal solves the builtin and 
platform drivers problem. AFAIK that needs a builtin allowlist in any 
case. And once we have that likely we don't need anything else for 
current TDX at least, because the allowlist is so small and there is no 
concept of hotplug or similar.

Also another consideration is that we were trying to avoid relying too 
much on user space for this. One of the goals was to move an existing 
guest image to a confidential guest with only minor changes (new kernel 
/ enable attestation). Complex changes for securing it would make that 
much harder.

-Andi

