Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9530A5B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhBAKot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233184AbhBAKli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:41:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC5B764E98;
        Mon,  1 Feb 2021 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612176056;
        bh=2jh+fJAKzsRCx0tAq2KiU/OY1vRdWeJS3MENBzgi3Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psbVWCWxT2ELhKuPWLZh8RNyvdIHo1MwmMfXOjMoIS1/IbMpBWO5/Zk7f4b57Pgbh
         RoGCrnrDq6wXtBj59ylKXQqUA5XsmszF8h7mq1iPH+ZUITYnpvXzn3OjME7Bt7sygf
         AEg85HhParFbnDZApRP0XkL3MUNv+Y4+6FFMvTPDwfyRTGSIjivT7zfFNDPPtEBh3W
         E0ydZQ4fe1763PvgoYdsBMZ6t6cfd2V+fylI0Rm5rC0yiUjsCxeXzoUPgraZ3b7xDA
         mdgd8EWEuGlQbX6BYGgaMYjkuBmc+QJJbszHsAplypTr8ToWSeqlFklsP5Ge4pTNX5
         /cJwv4rJbnDOA==
Date:   Mon, 1 Feb 2021 16:10:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus: add better dev_dbg to track complete()
 calls
Message-ID: <20210201104051.GW2771@vkoul-mobl>
References: <20210126085402.4264-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126085402.4264-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 16:54, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Add a dev_dbg() log for both enumeration and initialization completion
> to better track suspend-resume issues.

Applied, thanks

-- 
~Vinod
