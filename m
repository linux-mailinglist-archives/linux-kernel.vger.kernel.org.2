Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF8D3D2580
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhGVNgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhGVNga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:36:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED06A6128D;
        Thu, 22 Jul 2021 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626963425;
        bh=EMz3MoIH6oilj/w4Eak46dXF6qgmQ7i1PkMKQ+PtdmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iagwb3SPOUuPeZ+DkZCOSQzpxLQevduQVSPZAJuRQnQYSRtZypPuiW5mLsdpAHUPJ
         z/Xb1keQTvNLQZs1e5yF0Gu+yJfyZ8e8I9uaJGxCvC9MhbJKLGMx3j7BPv9h3tDDE3
         6W1B2QPN5tD33EBnZj1LqENFW9i7f+LTUpQqDAqLZwSKpSKAsLae9wt3U8DI+s/E9M
         HJQjG3h9FNAFIwZ/bjMdDwd5qVq47apMTlRXF0RCwJ5bh8UiSOxIbJpH225Ptqf/Cm
         EmyRjjhuaBhcW4XP778U4wmm8JemIVU9H2m2yZH9ztOD8x1a9dlqk9k0XVY3iPNOBZ
         CTAYrhYo29PXQ==
Date:   Thu, 22 Jul 2021 19:47:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus: filter out more -EDATA errors on clock
 stop
Message-ID: <YPl93hm715Nm6ZEe@matsya>
References: <20210714014209.17357-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714014209.17357-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 09:42, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We've added quite a few filters to avoid throwing errors if a Device
> does not respond to commands during the clock stop sequences, but we
> missed one.
> 
> This will lead to an isolated message
> [ 6115.294412] soundwire sdw-master-1: SDW_SCP_STAT bread failed:-61
> 
> The callers already filter this error code, so there's no point in
> keeping it at the lower level.
> 
> Since this is a recoverable error, make this dev_err() conditional and
> only log cases with Command Failed.

Applied, thanks

-- 
~Vinod
