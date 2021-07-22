Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456B93D25AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhGVNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhGVNpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:45:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A848561264;
        Thu, 22 Jul 2021 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626963952;
        bh=c/Ys/hpnBH4d69fBDHfMsfkITtHR3CBpaqSOrsNHHxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVErfNobTt33zsXPdXm/Vfj8yOOe3/mJ86IF/qtmIyDuDujjJdRJuErrSjJ5s6oNu
         uUAVKzbftKcEqgfvopNe0exwGiJPxUJnRXUguz75Qz6yIp0NQxIU+ePVAvqpXoqm+j
         ilIG8ta2hbsW07XhPs2vv5+JF6VYHIAnBIkKkyjQ/oP4AGRt+eHPjz3Ccu+0xQhrnj
         jjYUdZ/OJJr6Dppoip5QZzO/6MDqcZMJnMqw/CCybrtUEhx590+HgcsjuMt7n0lPfd
         SGNzIDRcv89L6VI5ao7TUKYKkw2b2ZcrMARxxKVYWNSnJkpL9hwx2+Ui+6TMcngRc0
         ZfFgZLaujCwoQ==
Date:   Thu, 22 Jul 2021 19:55:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus: update Slave status in
 sdw_clear_slave_status
Message-ID: <YPl/7LtAzElmrFah@matsya>
References: <20210714033609.11963-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714033609.11963-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 11:36, Bard Liao wrote:
> Call to sdw_update_slave_status() needs to be added to sdw_clear_slave_
> status() to ensure Slaves are informed of the new status via update_
> status() callback.
> 
> This will enable codec drivers to reset their internal states and make
> sure the register settings are properly restored on pm_runtime or
> system resume

Applied, thanks

-- 
~Vinod
