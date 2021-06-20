Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB323ADE1E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhFTLTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFTLTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D448A610CA;
        Sun, 20 Jun 2021 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624187859;
        bh=XeKE2kaBHUnfzjf/vQMQrtOWbvMD97a5Jmepymkn9Ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MeyBG5pODNkYtlVHpduy19eTQ5T9Kl3qGffbyfIiVVU5alC1LzFsY5Hm9mgoeraDz
         IEjoXUXlrkHGApQEWNx7jHdIE3HiOqOJ4d942WfSPb8jxELbKFhYCjWhymcMO9UEJ8
         gF5QjiWKz5Xt+ENy5BqXaed6ASvgfFChUtWleTw0uikJIZk3uenSpukE5rt8Kh1sXP
         vuAAlEMkDCeO7s41pV8aJckfFGbJ6CqZLiSSDv29zYxbSjXVmycO9ChmOuMFkoTNjz
         hIPxbN5Vg4QYQrI2yofFm1TZYnESeAOvK3DClclXpFf39AHQcvfrPiNcYEPchBQhNP
         1GpUauIiwMy9w==
Date:   Sun, 20 Jun 2021 16:47:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] soundwire: stream: Fix test for DP prepare complete
Message-ID: <YM8jz8/kzMNg9xBB@vkoul-mobl>
References: <20210618144745.30629-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618144745.30629-1-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-21, 15:47, Richard Fitzgerald wrote:
> In sdw_prep_deprep_slave_ports(), after the wait_for_completion()
> the DP prepare status register is read. If this indicates that the
> port is now prepared, the code should continue with the port setup.
> It is irrelevant whether the wait_for_completion() timed out if the
> port is now ready.
> 
> The previous implementation would always fail if the
> wait_for_completion() timed out, even if the port was reporting
> successful prepare.
> 
> This patch also fixes a minor bug where the return from sdw_read()
> was not checked for error - any error code with LSBits clear could
> be misinterpreted as a successful port prepare.

Applied, thanks

-- 
~Vinod
