Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA28B3B26FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhFXFu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:50:27 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38801 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhFXFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:50:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id CF720580504;
        Thu, 24 Jun 2021 01:48:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 24 Jun 2021 01:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=B3aup8EMBKEU89ainQFs3BfuV3S
        em1fITz1JAMyRfd8=; b=gmzQvprDQPMgfl1vCbyF8iLzlervQaVPSr3DcX2Nmdi
        pBHEv4HZ9RU5H9jdBGh/rX7MkNaUbdsUeKlCBcxPfmYKo3KQVpCYBpbB2XyF0Dx0
        jIcadd+JysCr0zxrnRCfHH7WWCTdQjGT6lgqNwjoTng6mPcJdpgIq7MArr1Mf4j1
        gyFhkdQPaTfgDobkNt7LCidbCuGwzrcvs1X1oxIYCAxBGs+2gpVHbUzUvCl69BLk
        IIcrpuEiAxPbQAmJySalWewzOnCjsstLOD+7sb5OBKv7MKwvirzR82RHW22z1p1s
        hqJER9rgbjDtOF6UfH1pVJtg+nYkr6H9qVMPU/WWmlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=B3aup8
        EMBKEU89ainQFs3BfuV3Sem1fITz1JAMyRfd8=; b=DHwoh/stGJO2MbZq5JyF28
        3LebTgUv1vau4n0QDiKKXh30khIWuUqBZRH6DTwcwz7Iwsj18BrQ0425MpwXJGSm
        u8UxTWVEuubc2IDK/jW5OvPkJtxRhcRFDRHxdenYG7oSIfCAMl8XVDXh/iPDmBFE
        rlFN+1n6W+miQxR1LCFvtrY+/IV3esja++YJqAhi4ti71sw1MlV0tm+u241Grvw6
        rPyjw771cfbl5fTBPklAB3ITxlGtt6VKm4RbhIEUJHTKK8BinHeAjSDt+P7Bc7CN
        aPi2bdbTOiItiMRbnuPHoBqgg2w+ayoBW3tFidO7UVQlscZoYTI6zbxFeyhzlAZg
        ==
X-ME-Sender: <xms:lRzUYPRh7Fs9E4QNbjZeP4K_-BGdeQSGmdXwiSoyhL8qwVzhUUraew>
    <xme:lRzUYAwJjbDO478RJROqy_o5RD4O74yLmLc6Vn3yKAyG-9bNANrZMm0vVjrg7E-AO
    W03Y-ly3ppiKg>
X-ME-Received: <xmr:lRzUYE36nZikBCYlDY0fuy5N9P72VQnuWpEvfynW1wndIrDryoQlrmlCwAJAjKeu8Y0UsKNsbBr6lTOCk4tjBxWpt36KtQ-V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeggedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:lRzUYPAsBLRMbN_949gIiWtWavuMhFPrWxdOGDtoY2D5669dMLWzPg>
    <xmx:lRzUYIiGqi9U7ROWE-W5n6C2JlyCdy-BzxMyWLQ86JsUn5FjRbubDA>
    <xmx:lRzUYDoUwPY6kSpmEwrM8-Dm5muy59Scpqe4iW1Q09KPz11aC-BM6A>
    <xmx:lhzUYPSH0vgHFSsL2hjy9uJdoELsDyas11eo5cKvJcHaZDP3Z4iY2w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jun 2021 01:48:05 -0400 (EDT)
Date:   Thu, 24 Jun 2021 07:48:02 +0200
From:   Greg KH <greg@kroah.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNQckpOuw80uCUa1@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 06:22:04PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A perf PMU may have two PMU names. For example, Intel Sapphire Rapids
> server supports the discovery mechanism. Without the platform-specific
> support, an uncore PMU is named by a type ID plus a box ID, e.g.,
> uncore_type_0_0, because the real name of the uncore PMU cannot be
> retrieved from the discovery table. With the platform-specific support
> later, perf has the mapping information from a type ID to a specific
> uncore unit. Just like the previous platforms, the uncore PMU will be
> named by the real PMU name, e.g., uncore_cha_0. The user scripts which
> work well with the old name may not work anymore. To avoid the issue, a
> symlink should be created from the new to the old name.
> 
> The perf PMU devices are created under /sys/bus/event_source/devices/.
> The symlink should be created in the same directory to facilitate the
> perf tool.
> 
> Add a new variable, link_name, to store the new name of a PMU. Link it
> to the old name if applies.

Ah, here is the "new name".  This needs to be documented.

But first off, why is this symlink suddenly needed?  What is so special
about this new hardware that it breaks the existing model?

thanks,

greg k-h
