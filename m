Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13653184DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBKF0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 00:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBKF0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:26:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4930064DE7;
        Thu, 11 Feb 2021 05:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613021137;
        bh=h5qwqZK2v4tdK9nIHKiCW5NmwXEhhYW4EEFSTa3w37o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTsLaUZYOyaQYHwdruBO4TeM+4vmqOCBiE3Tv8Y/imJhj2UEbl+IH6u4rUO2xP0no
         9NGidz/UPIPtIu7r1vSIFYjX4SGc1cwSspEfuT09WMLmxnYIsyAY3l3meJgGij69aK
         bkUU7aNq4ylQGwO8kEPZJ+HmvLVJLnBoE/2//zWoSrKfi7n3qSgW9sBXZSerwGG5wj
         S38x4rk8L65h5h1C8o+6oOEsJ/u0RtknlXOM8jjNR9A+cHJqv0dcMDcxa8o7Th9/ci
         /uk3IwK/gswGKoOGW6nDVEbEO9a1SYr0J1Po3AQfNdMKD0mNdTKL1uTp52hhSVAiIJ
         lGbuabZuEZLmg==
Date:   Thu, 11 Feb 2021 10:55:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [RESEND PATCH v2 0/9] soundwire/regmap: use _no_pm routines
Message-ID: <20210211052533.GI2774@vkoul-mobl.Dlink>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
 <20210206102644.GN2656@vkoul-mobl.Dlink>
 <20210208125032.GF8645@sirena.org.uk>
 <20210208150449.GF879029@vkoul-mobl.Dlink>
 <20210210195818.GH4748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210195818.GH4748@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-02-21, 19:58, Mark Brown wrote:
> On Mon, Feb 08, 2021 at 08:34:49PM +0530, Vinod Koul wrote:
> > On 08-02-21, 12:50, Mark Brown wrote:
> 
> > > Is there a tag I can pull the new APIs from?
> 
> > Yes, please pull from below:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.12-rc1
> 
> Ah, that's the entire Soundwire pull request including driver updates -
> that's a bit more than is ideal.  Instead if you want to pull in the
> regmap bits that might be easier:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Since I had a fix to send to Greg, I am adding these as well..

Thanks
-- 
~Vinod
