Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92B141E694
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 06:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhJAEZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 00:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232679AbhJAEZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 00:25:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83DD3619F8;
        Fri,  1 Oct 2021 04:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633062239;
        bh=yPLO6sbNbrqRSdQVyGY0+tjRtqQaJKTwoi57bTd853k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0XOw8ZTUdtwwELC3AtLEiizytz7XGc5A3HDFi8RP8mGO6UVkZ5KCwfYHyRm8jzRU
         GFwAmXSsYsJg6sBmtAgxB7rSRZXaEclMZ/M6JgysifZXxzoiUndBFY8MiiW+m+HZkv
         3532b3ikJLxYD/RNfMuw14fqgX9XEKe/Ndk8AAdzc8hu1iHhKwheYmn3bY8mPfXS3O
         usZIWOIsgQVz8A/qa4E/WbMgW4baaTKAMxjI2MMO939ZOJycnL14jPQwfOd7sRoVQl
         hxc2I0Q/rvObtYKZZGCO/Lh+9kRY2O8FytqxPIF+fDwPzhF0yzjciqR5stM4WSVYIC
         e23JeTzP+hBEQ==
Date:   Fri, 1 Oct 2021 09:53:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soundwire: debugfs: use controller id and link_id for
 debugfs
Message-ID: <YVaNW1MuotWqakyK@matsya>
References: <20210907105332.1257-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907105332.1257-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-21, 11:53, Srinivas Kandagatla wrote:
> link_id can be zero and if we have multiple controller instances
> in a system like Qualcomm debugfs will end-up with duplicate namespace
> resulting in incorrect debugfs entries.
> 
> Using bus-id and link-id combination should give a unique debugfs directory
> entry and should fix below warning too.
> "debugfs: Directory 'master-0' with parent 'soundwire' already present!"

Applied, thanks

-- 
~Vinod
