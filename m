Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890B83A942E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhFPHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:40:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:9537 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbhFPHkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:40:25 -0400
IronPort-SDR: mL+FXAwXHdySB1GlY5YbRwyKoq1dI5VBkjORNVqCkerUoxEZjCuCXV/2MCdEpWhqwEF1gwCviv
 bHr+4XZMKLew==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="269981464"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="269981464"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 00:38:19 -0700
IronPort-SDR: NEvdgERSNa9vBxhBO7s2KpVehRjMWhcOWfiUhJrgx0+R/0JBhEf/P6Ad9MiKY9doOAg+scG97w
 XAY5c0Fyou/w==
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="484783727"
Received: from gna-dev.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 00:38:16 -0700
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com> <YJ42MEgwDZrAEQLl@kroah.com>
User-agent: mu4e 1.4.13; emacs 26.3
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Guy Zadicario <guy.zadicario@intel.com>
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
In-reply-to: <YJ42MEgwDZrAEQLl@kroah.com>
Date:   Wed, 16 Jun 2021 09:38:14 +0200
Message-ID: <85a6nq45uh.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, May 13, 2021 at 01:00:26PM +0200, Maciej Kwapulinski wrote:
>> Dear kernel maintainers,
>> 
>> This submission is a kernel driver to support Intel(R) Gaussian & Neural
>> Accelerator (Intel(R) GNA). Intel(R) GNA is a PCI-based neural co-processor
>> available on multiple Intel platforms. AI developers and users can offload
>> continuous inference workloads to an Intel(R) GNA device in order to free
>> processor resources and save power. Noise reduction and speech recognition
>> are the examples of the workloads Intel(R) GNA deals with while its usage
>> is not limited to the two.
>
> How does this compare with the "nnpi" driver being proposed here:
> 	https://lore.kernel.org/r/20210513085725.45528-1-guy.zadicario@intel.com
>
> Please work with those developers to share code and userspace api and
> tools.  Having the community review two totally different apis and
> drivers for the same type of functionality from the same company is
> totally wasteful of our time and energy.
>
> thanks,
>
> greg k-h

after consulting, we will try to share api and some kernel code
between the two drivers.

Following is the reference for more information:
https://lore.kernel.org/lkml/20210615145755.GA25911@aipg-stp-03.iil.intel.com/

regards,
Maciej
