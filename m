Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A113F4A66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhHWMNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236846AbhHWMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB4236137F;
        Mon, 23 Aug 2021 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629720779;
        bh=rXa58bEpK1TJTYaskl8eajtA23xdKsOQ8KdDNB4UIi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=At2fhNL3DlA6ciYyIrmGX5vZ/Zgsqv+G0RarW3YcBcxat64UzdzoKTZWaKxQEIO6+
         XBRV/QB08brgm8qUGlX9QpwY9/rmFHF2ZgISRFvPJTOYoSfLuL7/oGB/SawLMGtdoT
         ntANYVR9K7Kd3AgWNFzZjmrafQRgS+7ez79IcJ47MmbYEq1JFE/JDkKrQpAEFmz8+I
         GP+sM94ht9Mao6aAyRHHu29Tzw5kYpmXO2+8uuB6oes1FCznQssVKtuwBOgr6/tqum
         hpcp9Xo+aX+lcXWa1Okx100oT/Xpxg45y8pdc5y0QFGoXOAp7VsOcwxW0sNhVUjjPL
         QpASYVXPRrSvg==
Date:   Mon, 23 Aug 2021 17:42:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: do not extend reset delay
Message-ID: <YSOQxk7qHaj184J1@matsya>
References: <20210818030130.17113-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818030130.17113-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-21, 11:01, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The duration of the hw_reset is defined as 4096 cycles. The Cadence IP
> allows for an additional delay which doesn't seem necessary in
> practice: the actual reset sequence duration is defined by the sync_go
> mechanism, not by the IP itself.

Applied, thanks

-- 
~Vinod
