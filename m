Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780F43D0F82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhGUMrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:47:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:59252 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232672AbhGUMrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:47:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211432735"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="211432735"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 06:28:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="662114672"
Received: from tamoore1-mobl3.amr.corp.intel.com (HELO [10.209.131.176]) ([10.209.131.176])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 06:28:20 -0700
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
To:     Mark Brown <broonie@kernel.org>
Cc:     Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
 <20210715143906.GD4590@sirena.org.uk>
 <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
 <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
 <bd85ea7c-e9b5-de67-07ce-7104a1e19805@linux.intel.com>
 <20210721125912.GE4259@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eb98c10a-cc04-dbcf-b5cf-511703dc22fb@linux.intel.com>
Date:   Wed, 21 Jul 2021 08:28:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721125912.GE4259@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.

Oops.

>> - we currently don't support 'shipping the topology and firmware
>> bundled up in a single image to avoid them getting out of sync'. No
>> idea how that might work.
> 
> Seems like it'd be trivial to arrange in the kernel, or with userspace
> firmware loading the loader could do the unpacking.

I think we can bundle the firmware inside of the kernel image itself,
but we've never tried so it doesn't work by default.
I don't know what userspace loading means, we rely on request_firmware
and don't assume any specific support from userspace.

>> - if the machine driver is specified in DeviceTree, then the topology
>> used is *required* to be aligned with the machine driver. The rules
>> are that a topology may not make references to a BE dailink exposed in
>> the machine driver, but conversely if the topology makes a reference
>> to a BE dailink that is not exposed in the machine driver the topology
>> parsing will fail. It's one of the current weaknesses of
>> topology-based solutions, we have non-configurable hardware-related
>> things that are described in topology but should really be described
>> in platform firmware, be it ACPI or DT, and provided to the topology.
> 
> That seems like an orthogonal issue here?  The requirement for a
> firmware that's joined up with the hardware (and system description)
> that it's being used with exists regardless of how we rename things.

It's not completely orthogonal. The topology currently defines e.g. the
I2S interface index, Mclk, bclk, fsync, etc, and my point is that these
bits of information are completely related to the hardware and should
probably come from platform firmware/ACPI.

The topology framework currently provides too much freedom to
developers, it's fine to add new pipelines, PCM devices and new
processing, but when it comes to the hardware interfaces the topology is
completely constrained. I've been arguing for a while now that the
dailink descriptions and configurations should be treated as an input to
the topology, not something that the topology can configure. I don't
know how many issues we had to deal with because the topology settings
were not supported by the hardware, or mismatches between topology and
machine drivers (missing dailinks, bad dailink index, etc).

