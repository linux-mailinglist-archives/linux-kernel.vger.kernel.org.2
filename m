Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6437A62D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhEKMAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhEKMAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:00:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15E56613BC;
        Tue, 11 May 2021 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620734341;
        bh=bCfMYBm9bj3DpdDPiHHkxHjc9hQjxEEHrRs4ALJlbKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZskWK1iqCqh5h8yKujom1ymUXz8dJo6WA/XekhZx897r7VzrgMXFRxkKXqesa9Qfu
         PyHiFFZeShCr/Djy3F4fkOwX41cfwdWYXnZNdJ3aqqoGS6Ig61M4EL1ySOn5JHlEMr
         f24DpvoM8edviOojmGpf6Gbb+wwbz0Zfz33B2q2fY19/vsFE4KsBk6J9bdDnw3BqB1
         QzL9znyThLMCLO83W1SD6ESQlsdDLsyM3S6B6oU2gaIEox9yCC2Rr7wBYxp9OO1USd
         IB1fXLngFMZuWF3YsiVVEHkEFANOH5NfMrzDtCQaXdhVKnPArrfwQIcItesxWy4XE1
         ztBQeqbXsK33A==
Date:   Tue, 11 May 2021 17:28:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire/ASoC: add leading zeroes in peripheral device
 name
Message-ID: <YJpxgAYQDJLQg+yV@vkoul-mobl.Dlink>
References: <20210511060137.29856-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511060137.29856-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-21, 14:01, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We recently added leading zeroes in dev_dbg() messages but forgot to
> do the same for the peripheral device name. Adding leading zeroes
> makes it easier to read manufacturer ID and part ID, e.g.:
> 
> sdw:0:025d:0700:00
> sdw:0:025d:0711:00
> sdw:1:025d:0700:00
> sdw:1:025d:1308:00
> sdw:2:025d:0700:00
> sdw:2:025d:0701:00
> sdw:3:025d:0700:00
> sdw:3:025d:0715:00
> 
> The use of '01x' for link_id and unique_id is intentional to show the
> value range in the code, it's understood it does not actually change
> the format.
> 
> To avoid problems with git bisect, the same change needs to be applied
> to the Intel SoundWire machine driver, otherwise the components can't
> be found and the card registration fails.

Applied, thanks

-- 
~Vinod
