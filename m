Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6C31383E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 16:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhBHPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 10:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbhBHPGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:06:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2F4464EE0;
        Mon,  8 Feb 2021 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612796693;
        bh=SdhQPOxHBaOxP7uB+n1WhqFyjom2B/zd3rQI/1wC7gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cntU4YDJiKilcC/iJrm8DtaeF5WeQp6wTyF0Xb/xLcgHVlU9/SQzLVipEptry/07C
         8ZM9IQvouzh+DcCN006qwUcgB+Rd1VtM0wAj2S3QTAq12ANP6ZopXvLmMg6eecvPk4
         NncFMHtV++/nkfq08EHGyS1IXQgqulSDe3VZag8pZUjbZi0h1MOxOB3NLPpx6azDtK
         7B5h5I7CV92SGe7bpfpqDYQk6szH87iVQqqKwINwnLSz5hXv0ZdKYXaD+dga4aVuHa
         Z3XIFr7mMKrJuka2MUTdnIbJHgqcNS2k3yYVzA6aRGskZlOCEmrL2GtA9Hs/3V8oYg
         00EB+/V/ssFVA==
Date:   Mon, 8 Feb 2021 20:34:49 +0530
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
Message-ID: <20210208150449.GF879029@vkoul-mobl.Dlink>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
 <20210206102644.GN2656@vkoul-mobl.Dlink>
 <20210208125032.GF8645@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208125032.GF8645@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 08-02-21, 12:50, Mark Brown wrote:
> On Sat, Feb 06, 2021 at 03:56:44PM +0530, Vinod Koul wrote:
> 
> > Applied all sdw patches, thanks
> 
> Is there a tag I can pull the new APIs from?

Yes, please pull from below:

git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.12-rc1

Thanks
-- 
~Vinod
