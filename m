Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B48434EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhJTP0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTP0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D6C561359;
        Wed, 20 Oct 2021 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634743459;
        bh=AOrEQwh34odxrVdGxLcZw5Q/dM4ELKaoGa+EpDOkYOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jL2FLachzm67lr6dxj9OWerbp5bmJW7FMsLMsn7pXERMPhOVjqkuzcQjKxcESGGVH
         LVRf5YlF7F2M5gYXGVYqWZnli9Bf3XI0snkhWDwKN6Mbuui2g4tG6Q9Df6ZDyKZhTf
         o2iISKn4ziIe5MT/I9JjUcUFRjQJxyWI4coVzoTM4gqHKgNamzSoI5ulqmFrb8TIH7
         qmm0jRbEDLi/LQr5IydPIvaZhFg4ohSiWvnpvvUZYRu3SiqPBBuJ3WVyNOYE2eBLHV
         QXXI+p+Gg44PtCIoS8k3YZY65kRNTucmakRtjCK9/MkDHTwXpv7RZXUyYu1EabFw5b
         GXuZlfEHCvMFw==
Date:   Wed, 20 Oct 2021 20:54:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        guennadi.liakhovetski@linux.intel.com, rander.wang@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: bus: stop dereferencing invalid slave pointer
Message-ID: <YXA0nyvwuC+qWu+C@matsya>
References: <20211012101521.32087-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012101521.32087-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-21, 11:15, Srinivas Kandagatla wrote:
> Slave pointer is invalid after end of list iteration, using this
> would result in below Memory abort.

Applied, thanks

-- 
~Vinod
