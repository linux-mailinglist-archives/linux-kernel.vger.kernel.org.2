Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969C8347CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhCXPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236650AbhCXPgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:36:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28AAD619E5;
        Wed, 24 Mar 2021 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616600200;
        bh=um4bomVqQ2yJoGyNGBuY83Bs+0PURfJEENQtr73jsvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmEeirt6LIWYbt7FbaQaVAKjzNYEH0R0YEGBeOxxyM1xaLIM11vjDMWsv/xD1QjcE
         IKcHhdvnN9qw9K/WiSHxLDQqCVwsDkkGHaLl+LAlXlrcL/GmW3e5ljmDQ97JnXIF9I
         +y9pyOkkyXrgjWhDB3qrehGsa59ciCcqX6GM86RI=
Date:   Wed, 24 Mar 2021 16:36:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        vkoul@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
Message-ID: <YFtchhxHDjfbyY46@kroah.com>
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmatyAoMZmBmkuZ@kroah.com>
 <777b4ca6-0d51-285d-549f-6ef768f2a523@linux.intel.com>
 <YFo0WW8hOsHesSFC@kroah.com>
 <35cc8d35-a778-d8b2-bee3-bb53f8a6c51e@linux.intel.com>
 <YFsG00+iDV/A4i3y@kroah.com>
 <357d9576-f79a-0ea6-eee4-292e27597565@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357d9576-f79a-0ea6-eee4-292e27597565@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 09:55:01AM -0500, Pierre-Louis Bossart wrote:
> Note at this point it would mean an API change and impact the existing
> Nvidia/Mellanox code, we are using the same sequence as them

THere is no "stable api" in the kernel, so if something has to change,
that's fine, we can change the users at the same time, not an issue.

thanks,

greg k-h
