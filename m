Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A593A3DCEFB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 05:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhHBDug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 23:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231962AbhHBDud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B740660EE3;
        Mon,  2 Aug 2021 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627876224;
        bh=opJ5gu9x7UciOeMeynSO0qidOZojcFELh0cNar5tv/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFeaS362ZUS5m316imhTVo9z0CVK3McRy3h1KCr5ib7dNnMJ2ZgJ6DJ9JpjBxbfKA
         4dLLQbE1ZpKI2jSDO7JJPwsE76z7S26pPC+qymP3LL2nRd6lPpW5dIBbUthBwf7cA2
         wMDYdRvKXjavH1q46GhJPh+8gqQjGMLt2uMh4JKzxMZbaYiSFlhTLx99NJvUj98Ndm
         vzCf13gejtK7uVlvrrvjoqXojN7GpK5+COrBhPrMXvQCqqTM3rVYU+hIm7naXuKAfe
         DEPuJ2roU2G13Gq26YU2XLc9HoogMVb1quU0z39nKCayDl6m2t4gOj05hWAWSnQv9X
         DKOWLO7AmyH3g==
Date:   Mon, 2 Aug 2021 09:20:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: add paranoid check on self-clearing
 bits
Message-ID: <YQdrfNA08UITBjvB@matsya>
References: <20210714051349.13064-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714051349.13064-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 13:13, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The Cadence IP exposes a small number of self-clearing bits in
> the MCP_CONTROL and MCP_CONFIG_UPDATE registers.
> 
> We currently do not check that those bits are indeed cleared,
> e.g. during resume operations. That could lead to resuming peripheral
> devices too early.
> 
> In addition, if we happen to read these registers, update one of the
> fields and write the register back, we may be writing stale data that
> might have been cleared in hardware. These sort of race conditions
> could lead to e.g. doing a hw_reset twice or stopping a clock that
> just restarted. There is no clear way of avoiding these potential race
> conditions other than making sure that these registers fields are
> cleared before any read-modify-write sequence. If we detect this sort
> of errors, we only log them since there is no clear recovery
> possible. The only way out is likely to restart the IP with a
> suspend/resume cycle.
> 
> Note that the checks are performed before updating the registers, as
> well as after the Intel 'sync go' sequence in multi-link mode. That
> should cover both the start and end of suspend/resume hardware
> configurations. The Multi-Master mode gates the configuration updates
> until the 'sync go' signal is asserted, so we only check on init and
> after the end of the 'sync go' sequence.
> 
> The duration of the usleep_range() was defined by the GSYNC frequency
> used in multi-master mode. With a 4kHz frequency, any configuration
> change might be deferred by up to 250us. Extending the range to
> 1000-1500us should guarantee that the configuration change is
> completed without any significant impact on the overall resume
> time.

There were some checkpatch warns, but I think code will looks worse if
we split lines up, so applied now

-- 
~Vinod
