Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CE3E1BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbhHESyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:54:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:54973 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238848AbhHESyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:54:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="211125886"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="211125886"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 11:53:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="512862108"
Received: from dkdean-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.157.53])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 11:53:54 -0700
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com> <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
 <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
 <YQwpa+LAYt7YZ5dh@kroah.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <7d6751b1-c476-51d3-25c6-b65c0e93d23b@linux.intel.com>
Date:   Thu, 5 Aug 2021 11:53:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQwpa+LAYt7YZ5dh@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/21 11:09 AM, Greg Kroah-Hartman wrote:
> On Thu, Aug 05, 2021 at 10:58:46AM -0700, Andi Kleen wrote:
>>
>> On 8/5/2021 10:51 AM, Greg Kroah-Hartman wrote:
>>>
>>> It's controlled by whatever you want to use in userspace.  usbguard has
>>> been handling this logic in userspace for over a decade now just fine.
>>
>>
>> So how does that work with builtin USB drivers? Do you delay the USB binding
>> until usbguard starts up?
> 
> Yes.
> 
>>>> This doesn't help us handle builtin drivers that initialize before user
>>>> space is up.
>>> Then have the default setting for your bus be "unauthorized" like we
>>> allow for some busses today.
>>
>> We need some early boot drivers, just not all of them. For example in your
>> scheme we would need to reject all early platform drivers, which would break
>> booting. Or allow all early platform drivers, but then we exactly get into
>> the problem that there are far too many of them to properly harden.
> 
> Define "harden" please.  Why not just allow all platform drivers, they
> should all be trusted.  If not, well, you have bigger problems...

This driver filter framework will be mainly (at-least for now) used by
protected guest. "Protected guest" is the term we use define a VM
guest which ensures memory and data isolation when working with
untrusted VMM. You can find some basic introduction to it in following
links.

https://lwn.net/Articles/860352/
https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

In protected guest, since VMM is untrusted, device drivers that deals
with IO-memory and data had to audited and hardened against attack from
malicious VMM.

With this driver filter support, we can ensure only hardened drivers
are allowed to bind with device. This is applicable to built-in and
loadable kernel drivers.

I don't think there is a existing framework which does this right?

I am not sure how USB and Thunderbolt "authorzied" model works. But I
don't think it prevents built-in driver probes during kernel boot right?
I will also check this framework and get back to you.

> 
> Anyway, feel free to build on top of the existing scheme please, but do
> not ignore it and try to create yet-another-way-to-do-this that I have
> to maintain for the next 20+ years.
> 
> thanks,
> 
> greg k-h
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
