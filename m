Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C111730B6A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhBBEqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231725AbhBBEqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:46:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6A0B64EDA;
        Tue,  2 Feb 2021 04:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612241171;
        bh=UW1qYPGwhsrczGp+QodpcDp1sn17mWrlWhPimNr/dJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToqwdBePyZjZTmFxaueUVOtPVDDB+lTx0pDEinu/5fOGPdG1o/Xy77HW6QKrB+TcU
         25EOoqsi9laIoQ6F7CJXRF2s1eF3sEa0mVCb5Kl1aQfodSuUEQ8//zgJWmrsmDDbrQ
         mrlQrUJq/VbOoPFwqK/Br5/fDlEo/799QBNXgtLX1B5Lv6Lh12yZPN63rbt1NKkNTK
         E8kOup4zxSlXGg6kBfNteMFAQVdt8rc7BgV0vBB37YUSWfnolXPHi7KGbDdpXwbAuH
         +ghniSsFnDqMTYM2CEn3HfOaUOfEPAqWxR0VEefPySPa5OF4D0kCCWDmYYAGANCSVb
         pFbZQZ19EOCeg==
Date:   Tue, 2 Feb 2021 10:16:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/6] soundwire: qcom: set continue execution flag for
 ignored commands
Message-ID: <20210202044607.GJ2771@vkoul-mobl>
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
 <20210201141642.GB2771@vkoul-mobl>
 <1fef14fe-b254-9282-c213-d23e3b7d5f61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fef14fe-b254-9282-c213-d23e3b7d5f61@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 15:50, Srinivas Kandagatla wrote:
> 
> 
> On 01/02/2021 14:16, Vinod Koul wrote:
> > >   	/* Configure number of retries of a read/write cmd */
> > > -	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, SWRM_RD_WR_CMD_RETRIES);
> > > +	if (ctrl->version_major == 1 && ctrl->version_minor >= 5 &&
> > > +	    ctrl->version_step >= 1) {
> > why not use raw version value?
> > 
> >          if (ctrl->raw > 0x10501 )
> > 
> We can do that way as well, but Major Minor seems much clear to readers!

yes but comparison with numbers is always easiest and better :) We can
always add comment that check version 1.5.1 which will make it clear

-- 
~Vinod
