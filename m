Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE303E1B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbhHESpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:45:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:3907 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241704AbhHESpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:45:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="201414252"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="201414252"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 11:44:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="437890038"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.183.241]) ([10.212.183.241])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 11:44:47 -0700
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <1e0967ee-c41e-fd5d-f553-e4d7ab88838c@linux.intel.com>
Date:   Thu, 5 Aug 2021 11:44:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQwpa+LAYt7YZ5dh@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/5/2021 11:09 AM, Greg Kroah-Hartman wrote:
> On Thu, Aug 05, 2021 at 10:58:46AM -0700, Andi Kleen wrote:
>> On 8/5/2021 10:51 AM, Greg Kroah-Hartman wrote:
>>> It's controlled by whatever you want to use in userspace.  usbguard has
>>> been handling this logic in userspace for over a decade now just fine.
>>
>> So how does that work with builtin USB drivers? Do you delay the USB binding
>> until usbguard starts up?
> Yes.

That won't work for confidential guests, e.g. we need a virtio driver 
for the console and some other things.


>
>>>> This doesn't help us handle builtin drivers that initialize before user
>>>> space is up.
>>> Then have the default setting for your bus be "unauthorized" like we
>>> allow for some busses today.
>> We need some early boot drivers, just not all of them. For example in your
>> scheme we would need to reject all early platform drivers, which would break
>> booting. Or allow all early platform drivers, but then we exactly get into
>> the problem that there are far too many of them to properly harden.
> Define "harden" please.  Why not just allow all platform drivers, they
> should all be trusted.  If not, well, you have bigger problems...

Trusted here means someone audited them and also fuzzed them. That's all 
a lot of work and also needs to be maintained forever so we're trying to 
do only a minimum set. There are actually quite a few platform drivers, 
it's difficult to audit them all.


>
> Anyway, feel free to build on top of the existing scheme please, but do
> not ignore it and try to create yet-another-way-to-do-this that I have
> to maintain for the next 20+ years.

We have to establish the existing scheme solves the problem statement 
first. So far it seems it doesn't seem to solve the problem at all for 
early drivers that are needed for booting. Unless I'm missing something?

For late (e.g. modular) drivers it would probably be usable, but it 
would complicate deployment quite a bit with complex user space changes, 
so I can't say it looks very attractive.

But if we solve the problem for the early drivers then I don't think we 
need the user space controlled scheme at all, because it should work all 
the same.

So it seems they existing approach is not really cutting it.

That's why I think the builtin allow list hook is still needed. Thoughts?


-Andi


>
