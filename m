Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84FD34E400
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhC3JHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhC3JG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:06:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF88161929;
        Tue, 30 Mar 2021 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617095188;
        bh=xKYdQCZ7/B2bej8hL7VrKLm+d3H8hUAchReKhoOxgBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcYIbULcJShX8+WUNtkLCosfz0mNLAc/USK/KYW3RKwD+YTZB+Q7JDWh6jrrTomiY
         5FZ5W/xbehRBDKYZKc5uedMoHbK8Er2ylkvX2GZVwe86pjLAEweBnhOz2KLm/Aom1H
         0/HLw4kq9ylKcO8YuRCNYP/GnZN6pInHXLTMBXs1Iq7miY3aynmehYnegZMPiNJQkn
         OIZlvptqIZS8Ad28NQgChRNjHVSYbzvcQ4KdGycWWefQGHye9x+cRRCTFu67S56Ee8
         B2AFcL/3mmdcwc4D9kzOF35GkNiHFt2H+RS6lZlNqHvDEFyL0OjJH3MvKTdSiwoRDO
         ZR/q8zGjxrQ2w==
Date:   Tue, 30 Mar 2021 14:36:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: only prepare attached devices on
 clock stop
Message-ID: <YGLqEEVTf9a8UUbi@vkoul-mobl.Dlink>
References: <20210323013707.21455-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323013707.21455-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-21, 09:37, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We sometimes see COMMAND_IGNORED responses during the clock stop
> sequence. It turns out we already have information if devices are
> present on a link, so we should only prepare those when they
> are attached.
> 
> In addition, even when COMMAND_IGNORED are received, we should still
> proceed with the clock stop. The device will not be prepared but
> that's not a problem.
> 
> The only case where the clock stop will fail is if the Cadence IP
> reports an error (including a timeout), or if the devices throw a
> COMMAND_FAILED response.

Applied, thanks

-- 
~Vinod
