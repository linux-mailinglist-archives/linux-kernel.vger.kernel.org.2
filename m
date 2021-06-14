Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56EB3A5C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 06:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFNEow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 00:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhFNEos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 00:44:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9502161283;
        Mon, 14 Jun 2021 04:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623645766;
        bh=aI8cMZgT9nGkbzOwk4swnaCdK6M1OPDEIveCp5UKvNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kswggof0QOHxDsakxaZXl6U0LzceZK1TdqpkxcrKI1jHBW1YQAft7E6cax7/dq8ko
         7PQFW2M1QtmoD9dWaKPA3lFOEA/jPcsD6Q52XB4/9AbBNXLGNQnPsKqKOjl92czxs6
         tKoMfvKzIZZqoHvBEUUvuBnnw+0PAwq32gY21xf3POd1PT494EQmYZO7PuvH4mp6GW
         kVifhMaGcYO+PwSup8nWtUf4yiy4Q8iinBa0XR6Xf3y2mSNOT7CFKAZiajAcigeUhD
         vAYiHeLQ9LqgZoII0ylrke+YDVxiONz/Ro1kppRHEWvXSthsAUgQC1t19OaFl8OlfN
         2pTViCBwh3XFw==
Date:   Mon, 14 Jun 2021 10:12:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
Message-ID: <YMbeQkK3EKsgkLj4@vkoul-mobl>
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-21, 13:21, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Now that the auxiliary_bus exists, there's no reason to use platform
> devices as children of a PCI device any longer.
> 
> This patch refactors the code by extending a basic auxiliary device
> with Intel link-specific structures that need to be passed between
> controller and link levels. This refactoring is much cleaner with no
> need for cross-pointers between device and link structures.
> 
> Note that the auxiliary bus API has separate init and add steps, which
> requires more attention in the error unwinding paths. The main loop
> needs to deal with kfree() and auxiliary_device_uninit() for the
> current iteration before jumping to the common label which releases
> everything allocated in prior iterations.

Applied, thanks

-- 
~Vinod
