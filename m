Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7163DD012
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhHBFjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhHBFi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:38:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBED361029;
        Mon,  2 Aug 2021 05:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627882730;
        bh=8kYtOC910tonNaoxEFanDJ02YW15Ud8VJlLqDfTOjYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3YirZ0gAEvXnSprr5kmvyjTFCANMy6cfPJ8P2PD5xWRhOQqlN8keijTJzG0oDMdG
         fMj4ah4bTfLEOQj4E0MG7y3RTzfI0rY9DJXoP3EObwA5ATMOuhHfRuzXXpV+S/6mBz
         XUwCyZIs2/BY113Djr1zaHEKU9meMhSbexFM/Z6thnJpx4w7jLNbXUyznkGSbv5Ld0
         Uf58rsCjrLUca02rI91rUsa0A7QRO9+YI4eEXolZXk/kmpMO6khPIP0DJoenNqaLmL
         sU8OlKdntKnwzmcbb+CiNWeZ/LZJt3lafGwNhTSEjMwXLyAfGypZsoXBPV1QgvMTxH
         J/IuphIZuvPJA==
Date:   Mon, 2 Aug 2021 11:08:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 00/10] soundwire/ASoC: add mockup codec support
Message-ID: <YQeE5r8SCJV54TCK@matsya>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
 <20210714193315.GK4719@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714193315.GK4719@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 20:33, Mark Brown wrote:
> On Wed, Jul 14, 2021 at 11:21:59AM +0800, Bard Liao wrote:
> > Adding mockup SoundWire codec is useful to debug driver/topology changes
> > without having any actual device connected.
> 
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-sdw-mockup-codec
> 
> for you to fetch changes up to 0ccac3bcf3564cbcba483dec20c7550939873f59:
> 
>   ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests (2021-07-14 18:02:07 +0100)

Thank You! Merged to sdw-next



-- 
~Vinod
