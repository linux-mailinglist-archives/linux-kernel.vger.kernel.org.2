Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254893D2589
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhGVNhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232361AbhGVNhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:37:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C12886128D;
        Thu, 22 Jul 2021 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626963466;
        bh=b1644+lt/CLt2y1BrUgtSKpye3yq+XLJ88kLrk3Z5sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0TehVqAPaV+xHqi7bCZDUIYUvLDFrpkWOYonPSMmu9m6pDE125bXXA3wPwsBY7xS
         tMTkQbN3qxPx6jI7S9/CmG105hZpF25mPYd1YBuHIxXAt2ioPKce8KgOXNhvMdZl5K
         Cn8tNIGaKvhq5/C7gxog5df2V630JaYUM2UOctlYCGyda7IPlVZ/pODJhy3l7/ia5A
         9rWgHoL2QHULqXWV7aO2Xu6Q37zFXNL80QKbZTv/+5I9WZ/X6Hj46DZibOILU2KQYZ
         x3u6S/3olVAANAa8fsQXQoqqKAS4dP7sr0XBmWoOkhsLNp5AqqhPKyubEkh6wYO6nN
         I6iargh1gwXOg==
Date:   Thu, 22 Jul 2021 19:47:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: cadence: Remove ret variable from
 sdw_cdns_irq()
Message-ID: <YPl+BrBL85aX1/uT@matsya>
References: <20210714015555.17685-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714015555.17685-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 09:55, Bard Liao wrote:
> From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> 
> The ret is not used in the interrupt handler, it is just returned without
> any condition or change.
> We can return the IRQ_HANDLED directly.

Applied, thanks

-- 
~Vinod
