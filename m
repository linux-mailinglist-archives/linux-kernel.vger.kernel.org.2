Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9736279B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244715AbhDPSVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:21:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:43368 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244671AbhDPSVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:21:02 -0400
IronPort-SDR: Xz1HQx3BRBaVo2GHYuph23KCRZrzWEZFCuIAO1Wc3qZ87tZww/P2O5lDLIDQRifqCLEONClDQ5
 mgbk0rxV0tgw==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="194642279"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="194642279"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 11:20:35 -0700
IronPort-SDR: 8JH/wrhdnfF+kjURjC6Ozss1arp1ZZz7rh2Q11JZjMVqzDrTb+lwYiQIdzxSaJy37svU/9R9dp
 ZImzXwfK/v0Q==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="616026100"
Received: from jaolanlo-mobl.amr.corp.intel.com (HELO [10.212.2.231]) ([10.212.2.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 11:20:33 -0700
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
To:     Mark Brown <broonie@kernel.org>, Codrin.Ciubotariu@microchip.com
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <79161044-26b2-729a-b831-b79cc238e239@linux.intel.com>
Date:   Fri, 16 Apr 2021 11:47:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210416163131.GI5560@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/21 11:31 AM, Mark Brown wrote:
> On Fri, Apr 16, 2021 at 04:03:05PM +0000, Codrin.Ciubotariu@microchip.com wrote:
> 
>> Thank you for the links! So basically the machine driver disappears and
>> all the components will be visible in user-space.
> 
> Not entirely - you still need something to say how they're wired
> together but it'll be a *lot* simpler for anything that currently used
> DPCM.
> 
>> If there is a list with the 'steps' or tasks to achieve this? I can try
>> to pitch in.
> 
> Not really written down that I can think of.  I think the next steps
> that I can think of right now are unfortunately bigger and harder ones,
> mainly working out a way to represent digital configuration as a graph
> that can be attached to/run in parallel with DAPM other people might
> have some better ideas though.  Sorry, I appreciate that this isn't
> super helpful :/

I see a need for this in our future SoundWire/SDCA work. So far I was 
planning to model the entities as 'widgets' and lets DAPM propagate 
activation information for power management, however there are also bits 
of information in 'Clusters' (number of channels and spatial 
relationships) that could change dynamically and would be interesting to 
propagate across entities, so that when we get a stream of data on the 
bus we know what it is.

when we discussed the multi-configuration support for BT offload, it 
also became apparent that we don't fully control the sample rate changes 
between FE and BE, we only control the start and ends. I fully agree 
that the division between front- and back-ends is becoming limiting and 
DPCM is not only complicated but difficult to stretch further.
