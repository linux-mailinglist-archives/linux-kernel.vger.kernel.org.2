Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3653ADE0D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhFTLKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhFTLK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:10:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B98C760FEE;
        Sun, 20 Jun 2021 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624187293;
        bh=ysuTIytzhYGpN6sB7X0cshVo6zQPn51Xxk1B7js3ERc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVMwlwZlhWubUqLRm0qzfJJ32BFf2Vo/WxH2kb91Ix7FQj9KaKF2jVg6quwZ8ptPA
         xoNnwinhKE2s/62Z72hZB9hhQdQF+Xe6VzmBNlX9Y0KO5Xq+aTCCUaMbNZugi0v+If
         JbgKls+yhpyhgnvVtIaso+7robyjAHKW+4J2ReqeujiPt7no1V2A2oUWnGE/pTAavE
         Pz397FgM+56jqqO9C+RojoKXTEpoFn0W+zGPbBfpuDrLAsT0h9CIm8dZP6Z3D8xGXo
         ExFVc+S+ZrPV+ftNQIcY39wzxolz6ruvlYeVhXRlKYCBZMh4HiTBi0dmwZZL1TinYz
         WOgP8YnQt0aaA==
Date:   Sun, 20 Jun 2021 16:38:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Shuming Fan <shumingf@realtek.com>,
        Jack Yu <jack.yu@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Hui Wang <hui.wang@canonical.com>,
        Bard Liao <bard.liao@intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] soundwire: export sdw_update() and sdw_update_no_pm()
Message-ID: <YM8hmXvz9XxkbQyt@vkoul-mobl>
References: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com>
 <20210614180815.153711-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614180815.153711-2-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-21, 13:08, Pierre-Louis Bossart wrote:
> We currently export sdw_read() and sdw_write() but the sdw_update()
> and sdw_update_no_pm() are currently available only to the bus
> code. This was missed in an earlier contribution.
> 
> Export both functions so that codec drivers can perform
> read-modify-write operations without duplicating the code.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
