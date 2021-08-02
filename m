Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2E3DD013
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhHBFj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhHBFj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:39:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D61561029;
        Mon,  2 Aug 2021 05:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627882760;
        bh=PUPqiGY1Lqs3wceq2cbTWPaFQYK7+AacH8oW093jjTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HokkQCmnsDlrMTzwbz9oR8wymqUwjm8+08bU9fyRSBmadtgrKc4fBMe+jKa4FFmG7
         wJPTl6m5lIJc7CBy1YyvdSd0VjnWCvIIPy42ax44SXGg3qzUOoa0xJPoLsa5wlDYCL
         WeXbqXDRVzpAaTfO0wiSKxA/45hfOsShy/qzC/C/yNqfl2JulQpsfJYrz9/zZZhyJv
         La1UL4girGVTgq/vuD5jXW2d5ivid4mC/ledo1U7IbWsmc8/47zcfF0PaLD/Czelco
         izc6tAn8P07YPn4ILECDxK5GtFXtdblXlGpvSYE5crTdRGSOxCLEJ31duhLV8oWrhi
         iZHumL7DOaC2w==
Date:   Mon, 2 Aug 2021 11:09:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 00/10] soundwire/ASoC: add mockup codec support
Message-ID: <YQeFA9/+OfLEftB2@matsya>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 11:21, Bard Liao wrote:
> Adding mockup SoundWire codec is useful to debug driver/topology changes
> without having any actual device connected.

Applied sdw patches to sdw-next, thanks

-- 
~Vinod
