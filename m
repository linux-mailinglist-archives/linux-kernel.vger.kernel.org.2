Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2E37A58F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhEKLT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230401AbhEKLTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:19:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19CD561363;
        Tue, 11 May 2021 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620731929;
        bh=3965pDIxL3ePZ2py6vgy+3FF19ziZfQsspyiY3RjjYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEWeDWBkJCFFXTbE3xs724vpb7eYa3LrCSF3Lw+g8mQbYRHwjddabjl6rV11nKyAe
         5ZMT4xYx5cZMXxOfzugimPrQu9LsBYDU+sNoqmR7ioRzQkft4tb3zf9La0JY3ZTswg
         6X0SsIB6Zmn8sLkCCanPzVzlqcUQl658fBP+P4tci3n0ZenMJmtDAuhOKvwG06lCuS
         avfcmU5dxkJo91JTv6x0xxyPswG6zwHqUfEEfUQPsBm+hv0deDT8dtFDf/zEb/HKG+
         2P6j/loU6mCA+MWk7Q6WJNjSy8UwqWj4g0juHYqcH8iwCgR7VX+e7UXb1fhttdqAe9
         Kl+6KefOpCu1g==
Date:   Tue, 11 May 2021 16:48:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, amit.pundir@linaro.org
Subject: Re: [PATCH] soundwire: qcom: fix handling of
 qcom,ports-block-pack-mode
Message-ID: <YJpoFQkvbXLOe6ik@vkoul-mobl.Dlink>
References: <20210504125909.16108-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504125909.16108-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-21, 13:59, Srinivas Kandagatla wrote:
> Support to "qcom,ports-block-pack-mode" was added at later stages
> to support a variant of Qualcomm SoundWire controllers available
> on Apps processor. However the older versions of the SoundWire
> controller which are embedded in WCD Codecs do not need this property.
> 
> So returning on error for those cases will break boards like DragonBoard
> DB845c and Lenovo Yoga C630.
> 
> This patch fixes error handling on this property considering older usecases.

Applied, thanks

-- 
~Vinod
