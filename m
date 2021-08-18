Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D752F3F0881
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhHRPyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:54:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:21820 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240304AbhHRPxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:53:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="280097040"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="280097040"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 08:53:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="449809140"
Received: from ksawchu-mobl.amr.corp.intel.com (HELO [10.212.83.236]) ([10.212.83.236])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 08:53:09 -0700
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210817190057.255264-1-pierre-louis.bossart@linux.intel.com>
 <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com> <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com> <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
 <YR0nAcC3wJd3b4Vu@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
Date:   Wed, 18 Aug 2021 10:53:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR0nAcC3wJd3b4Vu@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> a) we have to use request_module()
> 
> Wait, why?
> 
> module loading is async, use auto-loading when the hardware/device is
> found and reported to userspace.  Forcing a module to load by the kernel
> is not always wise as the module is not always present in the filesystem
> at that point in time at boot (think modules on the filesystem, not in
> the initramfs).
> 
> Try fixing this issue and maybe it will resolve itself as you should be
> working async.

It's been that way for a very long time (2015?) for HDAudio support, see
sound/pci/hda/hda_bind.c. It's my understanding that it was a conscious
design decision to use vendor-specific modules, if available, and
fallback to generic modules if the first pass failed.

Takashi, you may want to chime in...




