Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595CF3628BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbhDPTkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:40:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:23538 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236021AbhDPTjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:39:53 -0400
IronPort-SDR: 8DGXM7xq9OgS0mm8tr13BpTQ1s8u8dyAI5UWYG5pDbNStJfLIezvzMGMkjDnbwWgvKeWcuTRwG
 jReYwxVj/wEw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="259055291"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="259055291"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 12:39:28 -0700
IronPort-SDR: TgYFmc1TUDQHE1/z0EdC61yKFSvMHL4BM/zw1xlFAfqE10/PxRQ7Cr3rgOxqfx8BZJ4e0upa3K
 azOAIRmfVJ2Q==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="453452132"
Received: from ganeshsu-mobl.amr.corp.intel.com (HELO [10.254.191.217]) ([10.254.191.217])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 12:39:27 -0700
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
To:     Mark Brown <broonie@kernel.org>
Cc:     Codrin.Ciubotariu@microchip.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        gustavoars@kernel.org, mirq-linux@rere.qmqm.pl
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
 <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
 <5e1fb981-48c1-7d5a-79a6-ba54bac26165@microchip.com>
 <4f401536-5a66-0d65-30cb-7ecf6b235539@microchip.com>
 <20210415161743.GH5514@sirena.org.uk>
 <1aff49d4-5691-67cb-3fe7-979d476f1edb@microchip.com>
 <20210415172554.GI5514@sirena.org.uk>
 <ad5d556b-601f-c6f6-347e-86a235237c02@microchip.com>
 <20210416163131.GI5560@sirena.org.uk>
 <79161044-26b2-729a-b831-b79cc238e239@linux.intel.com>
 <20210416185538.GK5560@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dfcf8b69-6ede-7344-79c0-cb572e03359c@linux.intel.com>
Date:   Fri, 16 Apr 2021 14:39:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210416185538.GK5560@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/21 1:55 PM, Mark Brown wrote:
> On Fri, Apr 16, 2021 at 11:47:01AM -0500, Pierre-Louis Bossart wrote:
>> On 4/16/21 11:31 AM, Mark Brown wrote:
> 
>>> Not really written down that I can think of.  I think the next steps
>>> that I can think of right now are unfortunately bigger and harder ones,
>>> mainly working out a way to represent digital configuration as a graph
>>> that can be attached to/run in parallel with DAPM other people might
>>> have some better ideas though.  Sorry, I appreciate that this isn't
>>> super helpful :/
> 
>> I see a need for this in our future SoundWire/SDCA work. So far I was
>> planning to model the entities as 'widgets' and lets DAPM propagate
>> activation information for power management, however there are also bits of
>> information in 'Clusters' (number of channels and spatial relationships)
>> that could change dynamically and would be interesting to propagate across
>> entities, so that when we get a stream of data on the bus we know what it
>> is.
> 
> Yes, I was thinking along similar lines last time I looked at it - I was
> using the term digital domains.  You'd need some impedence matching
> objects for things like SRCs, and the ability to flag which
> configuration matters within a domain (eg, a lot of things will covert
> to the maximum supported bit width for internal operation so bit width
> only matters on external interfaces) but I think for a first pass we can
> get away with forcing everything other than what DPCM has as front ends
> into static configurations.

You lost me on the last sentence. did you mean "forcing everything into 
static configurations except for what DPCM has as front-ends"?

It may already be too late for static configurations, Intel, NXP and 
others have started to enable cases where the dailink configuration varies.

FWIW both the USB and SDCA class document are very careful with the 
notion of constraints and whether an entity is implemented in the analog 
or digital domains. There are 'clock sources' that may be used in 
specific terminals but no notion of explicit SRC in the graph to leave 
implementers a lot of freedom. There is a notion of 'Usage' that 
describes e.g. FullBand or WideBand without defining what the 
representation is. The bit width is also not described except where 
necessary (history buffers and external bus-facing interfaces). Like you 
said it's mostly the boundaries of the domains that matter.
