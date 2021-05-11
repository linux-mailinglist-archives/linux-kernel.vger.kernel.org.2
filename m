Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25637A679
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhEKMXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEKMXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:23:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B5426134F;
        Tue, 11 May 2021 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620735745;
        bh=O3QNVnsC5TeoMy1cHhV+c5blmkdN6rA7UB4HtR2t8Hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoCuNSFYdcNdSfmbWXNuq51uAjg7g6HiSWYgvVNmiyC1RPGJKLdH0Yy83M/FuSWv5
         UmAUztotp5tBuNwnmufdMnASuYbSTJywEGa85H5CeExBuLINTe3pQM9WdX4bwRwhWf
         qnFKbYmY4xw2uw8OOfB9GCMLY++OA5n8zuFldDkFnsU/61212RILk7T/G73KQLbR/G
         cov+8AadDl1MbrvnHksb9O/O+s8qquxAf4IhBjWdKDbgIPR3D/79zBCXkNUwA5hUFr
         8d/3x/XrBvlg6bXdHqiH/aJYm9K/OZYCiYblT6iVUV0uKuJsbdzLgV12ZIHv4JRChd
         es4u0U5g1pwvg==
Date:   Tue, 11 May 2021 17:52:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [RESEND PATCH] soundwire: cadence_master: always set CMD_ACCEPT
Message-ID: <YJp2/cnaXbMTkzTq@vkoul-mobl.Dlink>
References: <20210511025247.25339-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511025247.25339-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-21, 10:52, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The Cadence IP can be configured in two different ways to deal with
> CMD_IGNORED replies to broadcast commands. The CMD_ACCEPT bitfield
> controls whether the command is discarded or if the IP proceeds with
> the change (typically a bank switch or clock stop command).
> 
> The existing code seems to be inconsistent:
> a) For some historical reason, we set this CMD_ACCEPT bitfield during
> the initialization, but we don't during a resume from a clock-stoppped
> state.
> b) In addition, the loop used in the clock-stop sequence is quite
> racy, it's possible that a device has lost sync but it's still tagged
> as ATTACHED.
> c) If somehow a Device loses sync and is unable to ack a broadcast
> command, we do not have an error handling mechanism anyways. The IP
> should go ahead and let the Device regain sync at a later time.
> 
> Make sure the CMD_ACCEPT bit is always set.

Applied, thanks

-- 
~Vinod
