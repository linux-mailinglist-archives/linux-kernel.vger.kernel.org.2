Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692F93F4A64
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhHWMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235095AbhHWMNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A237B6138F;
        Mon, 23 Aug 2021 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629720761;
        bh=yOn8Q96b3ZWPNpYdY73Ssh2UrArfVzWgJCKc29O5j8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3GgEMa+cB1Q418qtCyrUcTzEKX36r5L7sd7nCAiC/9ImMWFd0nmCjCukyi1ziZRU
         HjB886n3odrZKnxNssvJEZ+Mh+uqujyY7PPc5hCD6dhnvbtI3rdTz/J2G3JsNGrKyq
         PyjavIB4RRcCGvybOt8vHd6yG0zZHquwt5srmzSIkBNL3wHp9TV3leuANMcvnl1hPV
         lQL2YKNE3hkLCOVok8JUaPAh3Yf6kxWRv+cz1MynkaQu3v5wLw6uu71hvOVLG/1GI5
         fsmZS9B3FHukpjwbMYj4uo8OCQc5JJUFmL2KpR2+Do/AzYRCLDKp9+iXdJ9+ZKun86
         8X0iK4iUzUVlQ==
Date:   Mon, 23 Aug 2021 17:42:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 0/3] soundwire: intel: exit clock-stop mode before
 system suspend
Message-ID: <YSOQtUrFKzKZtDRf@matsya>
References: <20210818024954.16873-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818024954.16873-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-21, 10:49, Bard Liao wrote:
> Intel validation reported an issue where the HW_RST self-clearing bit
> is not cleared in hardware, which as a ripple effect creates issues
> with the clock stop mode.
> 
> This happens is a specific sequence where the Intel manager is
> pm_runtime suspended with the clock-stop mode enabled. During the
> system suspend, we currently do nothing, which can lead to potential
> issues on system resume and the following pm_runtime suspend,
> depending on the hardware state.
> 
> This patch suggests a full resume if the clock-stop mode is used. This
> may require extra time but will make the suspend/resume flows
> completely symmetric. This also removes a race condition where we
> could not access SHIM registers if the parent was suspended as
> well. Resuming the link also resumes the parent by construction.

Applied all, thanks

-- 
~Vinod
