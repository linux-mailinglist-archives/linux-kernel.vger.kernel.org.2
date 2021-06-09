Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9713A1A66
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhFIQFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:05:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:40801 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232025AbhFIQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:05:03 -0400
IronPort-SDR: GzErOFtKzYPQ/Jl+JPZ2ut5bytNFkKbYjUzcPoVBL1vvCe+31zPVvPYtLHkmlLtWYmGAYLMB4O
 WDLykCWqeueg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="266255172"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="266255172"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:00:45 -0700
IronPort-SDR: nDTNVHA/qQCLHFA9rd7orNM3Rsp8rwRrTbxF8uBuz2eCosRkhbvl0XJMQKuDameZn3zktTPDpt
 +Ekcuda2NmDg==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402486252"
Received: from adrianam-mobl.amr.corp.intel.com (HELO [10.209.130.43]) ([10.209.130.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:00:42 -0700
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        gregkh@linuxfoundation.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        Vinod Koul <vkoul@kernel.org>,
        Dave Ertman <david.m.ertman@intel.com>,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
 <YMBHj6PBzeHexXJb@vkoul-mobl>
 <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
 <20210609151022.GF1002214@nvidia.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <34cc0671-96a3-95e6-a3e3-3ebfacb4d370@linux.intel.com>
Date:   Wed, 9 Jun 2021 11:00:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609151022.GF1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> The consensus for the auxiliary_device model was hard to reach, and the
>> agreement was to align on a minimal model. If you disagree with the
>> directions, you will have to convince Nvidia/Mellanox and Intel networking
>> folks who contributed the solution to do something different.
> 
> The purpose of the aux devices was primarily to bind a *software*
> interface between two parts of the kernel.

The auxiliary bus documentation states clearly that we wanted to 
partition the functionality of a specific hardware into separate parts 
that are not exposed through ACPI/DT.

See excerpts from 
https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html

"In some subsystems, the functionality of the core device 
(PCI/ACPI/other) is too complex for a single device to be managed by a 
monolithic driver (e.g. Sound Open Firmware)" <- that's us.

This is the case for our audio controller, which exposes 4 SoundWire 
links. Since the links can be individually power-managed, creating 4 
subdevices below the PCI parent is a natural design.

"An example for this kind of requirement is the audio subsystem where a 
single IP is handling multiple entities such as HDMI, Soundwire, local 
devices such as mics/speakers etc:" <- that's also us

Péter Ujfalusi is working on this part to split the DSP capabilities and 
let different 'clients' control them. That's a different case where we 
partition 'firmware' capabilities, not hardware as in the case of SoundWire.

> If there is a strong defined HW boundary and no software interface
> then the mfd subsytem may be a better choice.

That objection has been made before, there were lengthy threads on this 
between GregKH, Mark Brown and others. Clearly if we go back to this 
kind of debates I will respectfully stick to platform devices until 
maintainers agree.

This is beyond my area of expertise, outside of my control, and I've 
spent enough time trying to move away from platform devices - we've been 
at it for 2 years.

The auxiliary bus as suggested in this patch works fine. We don't have 
any needs that are not handled by the auxiliary bus code as of today, 
and we are not planning any future extensions.

> For a software layer I expect to see some 'handle' and then a set of
> APIs to work within that. It is OK if that 'handle' refers to some HW
> resources that the API needs to work, the purpose of this is to
> control HW after all.
> 
> You might help Vinod by explaining what the SW API is here.

There is no suggested change in API, what we use today for the platform 
devices is exactly the same as what we need for auxiliary bus devices. 
We are not creating something new for SoundWire, just substituting one 
type of devices for another.
