Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DEA37A67A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhEKMXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEKMXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:23:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A26D36188B;
        Tue, 11 May 2021 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620735758;
        bh=X8uCfoXChvJt+A61wxP97/Duyh0eA1PLMqEuUrFJZmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJNvb65uBKAwOunAlm64YwGcjt1VsoXbJy7plw3KN8BZIhu/GAbs2Fl3KVDzaVqzu
         ze5l3e1Dxv/AJywjnglBXsRa0Z3pMhx3HaRkeN87wDOi6l3jvl+k3Iexdyk4lT19sI
         K80HKSDNG8inxdjNi5qjzlOT6H9lcX+F1pDaydJMfh+uw+iv0nXCEFUgyyrXjbgOVZ
         lmBJJWF8/x981ZJeq6QGro7mgMQSDtrspB7WRnm8Dwk6XHqqjNFrFZXkoHzwZiCcTV
         NFELAoINlYkqFY0KXTVUEg2lUwumP393QaOU/SAzwiHN9Z0b7vF8qjdTTg41vudYZg
         ZIqUhrCi9nUKg==
Date:   Tue, 11 May 2021 17:52:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [RESEND PATCH 0/4] soundwire: only use CLOCK_STOP_MODE0 and
 handle -ENODATA errors in clock stop/start sequences
Message-ID: <YJp3CvCLt/xWDxgr@vkoul-mobl.Dlink>
References: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-21, 11:00, Bard Liao wrote:
> Existing devices and implementations only support the required
> CLOCK_STOP_MODE0. All the code related to CLOCK_STOP_MODE1 has not
> been tested and is highly questionable, with a clear confusion between
> CLOCK_STOP_MODE1 and the simple clock stop state machine.
> 
> This patch removes all usages of CLOCK_STOP_MODE1 - which has no
> impact on any solution - and fixes the use of the simple clock stop
> state machine. The resulting code should be a lot more symmetrical and
> easier to maintain.
> 
> Note that CLOCK_STOP_MODE1 is not supported in the SoundWire Device
> Class specification so it's rather unlikely that we need to re-add
> this mode later.
> 
> If a device lost sync and can no longer ACK a command, it may not be
> able to enter a lower-power state but it will still be able to resync
> when the clock restarts. In those cases, we want to continue with the
> clock stop sequence.
> 
> This patch modifies the behavior during clock stop sequences to only
> log errors unrelated to -ENODATA/Command_Ignored. The flow is also
> modified so that loops continue to prepare/deprepare other devices
> even when one seems to have lost sync.
> 
> When resuming the clocks, all issues are logged with a dev_warn(),
> previously only some of them were checked. This is the only part that
> now differs between the clock stop entry and clock stop exit
> sequences: while we don't want to stop the suspend flow, we do want
> information on potential issues while resuming, as they may have
> ripple effects.
> 
> For consistency the log messages are also modified to be unique and
> self-explanatory. Errors in sdw_slave_clk_stop_callback() were
> removed, they are now handled in the caller.

Applied, thanks

-- 
~Vinod
