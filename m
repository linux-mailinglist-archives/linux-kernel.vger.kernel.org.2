Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26330A5B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhBAKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233267AbhBAKlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:41:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0468E64E9D;
        Mon,  1 Feb 2021 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612176070;
        bh=TVANGH7ZETuH0LoK/AHXwSPPc/+hi8n0Z9uIpWL3w74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3EiX6nD+2WLy/6GybVaI4EEP2tYQg/LS0DNglkkgN750mbUtPx90ocGsYqB+lMZr
         +t8GYcMHa+0QVVDkW/4hiB81+5nhh4xFDnyZw8ErFDDLlR0ygauzj+JoUicT9c4sdn
         JKzDnJbRWq20UY/gWoL1maVy8/uoHxifhC5DFey/uX+YrX+5VjqvK+0ftgyXhdAG5a
         zDAhUNDeCLQW/oKNf4qpzYK2NPtOWSIOa/LpQwjx4/ff7jpYzZ9+wGtGJ/h/SaKYsD
         XA3pK1yZv6gn1LJCefMRttTgQMGKJXTiScRc8V0i+kaaT2NTvOa1sO0dWIjyYgiM7A
         2e5UNWcEv+XmA==
Date:   Mon, 1 Feb 2021 16:11:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: return earlier if no slave is attached
Message-ID: <20210201104105.GX2771@vkoul-mobl>
References: <20210126085439.4349-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126085439.4349-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-21, 16:54, Bard Liao wrote:
> From: Chao Song <chao.song@linux.intel.com>
> 
> If there is no slave attached to soundwire bus, we
> can return earlier from sdw_bus_prep_clk_stop() and
> sdw_bus_exit_clk_stop(), this saves a redundant value
> check.

Applied, thanks

-- 
~Vinod
