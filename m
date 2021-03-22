Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D694E344082
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCVMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhCVMKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D64EE6196F;
        Mon, 22 Mar 2021 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415046;
        bh=sKtlNsySk+3lyJOkySuRpOVg/xOmHDzdz+lMwu8QQCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRYjw8ZCNBp0L7vFuUU45dCImCBbOYOxgFBqhA5Qx0CFcNxdwQwhft+e1OnYkEZF6
         nQ6i6kR5mq2BwC3uZpBz5j5d8xr/GmJRLA6pNOn2q4N+UOocTKD6Xo0TiicpTKIr8a
         oXgKPnXZ+cCyyI77ZGIQYeIrRMW4B/1Ved9UcArf4oyQFw5ybpUH/MsJRo+pMTXJe3
         zrb/DHRmKAWMBUYaUqMdnLKPtViPw/D0r+vVdvFNA+nDp+6ASPoEISa93gLj7m5pVv
         kXO5wQfDakTV7/T8b8q/D3zxR/SfpCIJ7gEFNFs/o9yz4/8+Bu5aXhxQhMpY8GH6Ez
         0QpnLB/rymcvw==
Date:   Mon, 22 Mar 2021 17:40:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 0/3] soundwire: clear bus clash/parity interrupt
 before the mask is enabled
Message-ID: <YFiJQlmJH8TX46IU@vkoul-mobl.Dlink>
References: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302082720.12322-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-21, 16:27, Bard Liao wrote:
> The SoundWire specification allows a Slave device to report a bus clash
> or parity error with the in-band interrupt mechanism.
> Unfortunately, on some platforms, these errors are randomly reported and
> don't seem to be valid.
> This series suggests the addition of a Master level quirk to discard such
> interrupts. The quirk should in theory have been added at the Slave level,
> but since the problem was detected with different generations of Slave
> devices it's hard to point to a specific IP. The problem might also be
> board-dependent and hence dealing with a Master quirk is simpler.

I think this is fine approach to deal with quirks... Controllers can set
the quirk as required. I have fixed up blank line in patch 1 and applied

-- 
~Vinod
