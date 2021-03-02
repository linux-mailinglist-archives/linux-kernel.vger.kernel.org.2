Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0826A32A685
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574317AbhCBPPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344857AbhCBMxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:53:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AD5464EDC;
        Tue,  2 Mar 2021 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614689564;
        bh=CkZKJPtzXZXJZ5eVrLx5iMDfMrks4jHrBLTPDUgOCGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXZvXrUaFS7abvR1qLKtZAVY4mCG38m9IjwUQspZvRosEKvsluIFYcnPnY2zbZaVE
         OJWJ4AzYglIKIXgkhAIz7d0gJzYEs7uR0HhizKrUG3XbDt06oM43V2hnj7V48STJ6E
         7ufn1Ku9e8B4YL+eUUAV8tI0BcbIVSClZKitk6qngtJH1qCvAj0Gv9bHZeXZg3vIwY
         UODvTROWFZVvngppZmUAiKvIAU14mcndU38DXLi9xVSWz7iK2SpkpEhcU5EE7OxdvD
         qCpQRME63KoaVQ+HA/Szq9+9bubUF+xFSc0cE1iim7wOO5EbrbAQdGM3iXmVoA9qh2
         0u6fT4LfSPlHg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A06140CD9; Tue,  2 Mar 2021 09:52:41 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:52:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
Message-ID: <YD41GUtuq8fVa4Q6@kernel.org>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 24, 2021 at 09:48:29AM -0700, Mathieu Poirier escreveu:
> Good day Arnaldo,
> 
> I noticed there is a couple of patchsets [1][2] that haven't made it
> to your tree for the coming v5.12 cycle.  Do you think that can still
> be done? 
> 
> I tallied the patches here to make it easier for you to pick up.
> 
> Applies cleanly on perf/core (84b7725536d8)
> 
> Thanks,
> Mathieu
> 
> [1]. https://lore.kernel.org/lkml/20210202214040.32349-1-mike.leach@linaro.org/
> [2]. https://lore.kernel.org/lkml/20210213113220.292229-1-leo.yan@linaro.org/

These are not applying right now, I've pushed what I have to
tmp.perf/core, please take a look, I'll get back to this after
processing fixes for v5.12 and what is outstanding for v5.13.

- Arnaldo
