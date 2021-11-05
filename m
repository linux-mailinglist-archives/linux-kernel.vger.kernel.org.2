Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246E14466DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhKEQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:21:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:4900 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232718AbhKEQVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:21:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="229396982"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="229396982"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:16:09 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="502004186"
Received: from yanbiaoc-mobl.amr.corp.intel.com (HELO [10.209.173.63]) ([10.209.173.63])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:16:08 -0700
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code from
 machine driver
To:     Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, yc.hung@mediatek.com,
        matthias.bgg@gmail.com, daniel.baluta@nxp.com,
        linux-arm-kernel@lists.infradead.org
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
 <20211103100040.11933-4-trevor.wu@mediatek.com>
 <YYP+l7tMofYoB+aC@sirena.org.uk>
 <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
 <YYVQC7KLZx8oxdXT@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
Date:   Fri, 5 Nov 2021 11:16:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYVQC7KLZx8oxdXT@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/21 10:38 AM, Mark Brown wrote:
> On Fri, Nov 05, 2021 at 12:11:55PM +0800, Trevor Wu wrote:
>> On Thu, 2021-11-04 at 15:39 +0000, Mark Brown wrote:
> 
>>> I don't follow why the DSP support requires a new driver?  Shouldn't
>>> all
>>> systems with the DSP present be using it?
> 
>> We need to keep the solution without DSP, so we can replace DSP
>> solution with non-DSP when it's required. But when we introduce SOF for
>> DSP control, there will be more routes in machine driver and device
>> tree usage is different from the original. So it's hard to share the
>> same driver for these two solutions.
> 
> We shouldn't be requiring people to load completely different drivers
> based on software configuration, what if a system wants to bypass the
> DSP in some but not all configurations?  Can we not just have controls
> allowing users to route round the DSP where appropriate?

It was my understanding the card relies on separate components

- a SOF-based component to provide support for DSP-managed interfaces
- a 'non-SOF' component for 'regular' interfaces not handled by the DSP.

this was the basis for the changes discussed in
https://github.com/thesofproject/linux/pull/3217 and
https://github.com/thesofproject/linux/pull/3236

But indeed if the same interface can be managed by the DSP or not,
depending on software choices it's a different problem altogether.

We've looked into this recently, if the choice to involve the DSP or not
is at the interface level, it might be better to have both components
expose different DAIs for the same interface, with some sort of run-time
mutual exclusion, so that all possible/allowed permutations are allowed.
