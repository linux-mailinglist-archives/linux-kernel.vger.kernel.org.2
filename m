Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0343CFDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbhGTO6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:58:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:51153 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234579AbhGTOs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:48:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="233040558"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="233040558"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 08:29:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="462083552"
Received: from aremenni-mobl.amr.corp.intel.com (HELO [10.209.130.10]) ([10.209.130.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 08:28:59 -0700
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
 <20210715143906.GD4590@sirena.org.uk>
 <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
 <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bd85ea7c-e9b5-de67-07ce-7104a1e19805@linux.intel.com>
Date:   Tue, 20 Jul 2021 10:28:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>> Introduce two DT properties in dsp node:
>>>>       * fw-filename, optional property giving the firmware filename
>>>>       (if this is missing fw filename is read from board description)
>>>>       * tplg-filename, mandatory giving the topology filename.
>>>
>>> These sound entirely like operating system configuration which I'd
>>> expect to be inferred from the machine identification.  What happens if
>>> a system has multiple options for firmware files, or if the OS ships the
>>> topology and firmware bundled up in a single image to avoid them getting
>>> out of sync?  What's the benefit of putting them in the DT?
> 
> Can you help me with this, specifically for selecting topology name.
> 
> I think I'm fine selecting a default value for SOF firmware name. It
> looks like even
> for Intel platforms there is no way of changing the firmware name.
> 
> But how about selecting topology name? We have lots of audio scenarios
> that can run on the exact same hardware:
> - e.g
>    - Audio PCM playback + Post Processing
>    - Audio Compress playback
>    - Keyword detection
> 
> 
> So, we need to use different topologies to select the scenario we want
> to demonstrate.
> 
> Would it be acceptable to add tplg_name as a module parameter?

we already have a "tplg_path" module parameter which was intended to differentiate between product skews/versions using the same hardware and firmware version. A typical example would be an OEM using 'public' firmware + topology for basic audio support, distributed through sof-bin and packaged by distros, and 3rd-party/closed sources firmware modules in more advanced packages distributed separately by the OEM. In the latter case you do want the same path for firmware and topology, otherwise you'd have a risk of using a topology making references to a library not bundled in the firmware.

There was an initial ask from Curtis to have the ability to override the firmware/topology names, but they've been able to work with the path parameters - set with udev rules for specific models.

If you wanted to demonstrate 'scenarios', you could use the same approach?

Two other points to reply to Mark:

- we currently don't support 'shipping the topology and firmware bundled up in a single image to avoid them getting out of sync'. No idea how that might work.

- if the machine driver is specified in DeviceTree, then the topology used is *required* to be aligned with the machine driver. The rules are that a topology may not make references to a BE dailink exposed in the machine driver, but conversely if the topology makes a reference to a BE dailink that is not exposed in the machine driver the topology parsing will fail. It's one of the current weaknesses of topology-based solutions, we have non-configurable hardware-related things that are described in topology but should really be described in platform firmware, be it ACPI or DT, and provided to the topology.



