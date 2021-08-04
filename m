Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6763E0900
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhHDTum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:50:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:22487 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236893AbhHDTul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:50:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="212137695"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="212137695"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:50:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="522099861"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.32.138]) ([10.209.32.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:50:26 -0700
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
Date:   Wed, 4 Aug 2021 12:50:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQrqhYEL64CSLRTy@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> So you are trying to work around the "problem" that distro kernels
> provides drivers for everything by adding additional kernel complexity?
>
> What prevents you from using a sane, stripped down, kernel image for
> these vms which would keep things sane and simpler and easier to audit
> and most importantly, prove, that the image is not doing something you
> don't expect it to do?
>
> Why not just make distros that want to support this type of platform,
> also provide these tiny kernel images?  Why are you pushing this work on
> the kernel community instead?


Greg, I'm surprised by your comment. Traditionally we've been tried to 
support all platforms in unified binary kernels and gone to considerable 
complications to do so. That has been standard Linux practice for at 
least the 90ies. In some cases we went to considerable pain to support 
that, for example for the 5 level page tables or for paravirt ops.

Imagine there were 10 new features or platforms and they would all ask 
distributions to produce custom kernels for them, they would need to 
maintain 10 different kernel packages forever for all these different 
cases. It's totally reasonable that they don't want to do that.

Also even if they were willing to do custom configs it's not clear how 
this could be maintained and distributed. We would either have a 
standard TDX config and get everyone to agree on it (very difficult). Or 
some enforcement mechanism at the Kconfig level that forces most drivers 
to be disabled when TDX is on, which would be also a considerable new 
mechanism and complication. In addition there are drivers which are not 
covered by Kconfig today (like quite a few of the basic platform 
drivers), but which we still want to filter. So to implement a full 
build time mechanism would likely need more changes than this relatively 
straight forward run time mechanism based on the driver model.

And of course there other use cases for a run time filter mechanism. For 
example let's say you want filtering for Thunderbolt security. In this 
case it has to be done at runtime because it's not practical to have a 
kernel that is only built for Thunderbolt drivers, but doesn't support 
anything else that is on the SOC. The only sane way to handle such a 
case is to make a runtime distinction.

> And what's wrong with the current method of removing drivers from
> devices that you do not want them to be bound to?  We offer that support
> for all busses now that want to do it, what driver types are you needing
> to "control" here that does not take advantage of the existing
> infrastructure that we currently have for this type of thing?

I'm not sure what mechanism you're referring to here, but in general 
don't want the drivers to initialize at all because they might get 
exploited in any code that they execute.The intention is to disable all 
drivers except for a small allow list, because it's not practical to 
harden all 25M lines of Linux code.

-Andi

