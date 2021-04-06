Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B807354BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbhDFEz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhDFEz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:55:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EAE4613B8;
        Tue,  6 Apr 2021 04:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617684950;
        bh=Nzff4uwl0rkRttRQxit2T76kcWXchsz3Qc/XR4s5uDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=danws+v0AAa1UVEGWEsIYHP3YAhivhh+N6UlcZa93XYJc+yKgb52tFb2egktQnYXK
         v7ymCHzqU5cOr+uFHWp0Ed/kxLMWFgyvq6psQajqvisn7E/ylZ1i9cznXz3SdqzxU9
         /b0RtKmnI4eLKmc0jLv4NF9m5cOT2/70z8m9xwP1wdR1WhVcZtrVv96+5eIK/cUWab
         VD+YWz6vIC/W+peQS0MuDNKI7gezaP4951cNZQgwqC1pIjVE9JiYlJQn4wGELXQT4i
         ftJ+6+Omz23ABz5b0P8HjUieqBckfoib8vV1dTwiCyeG7mM8d2+vzyYK8z4Q7sgvyy
         o/+VUHqchUoJw==
Date:   Tue, 6 Apr 2021 10:25:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] soundwire: qcom: handle return correctly in
 qcom_swrm_transport_params
Message-ID: <YGvp0lbNkaukGxmE@vkoul-mobl.Dlink>
References: <20210401091502.15825-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401091502.15825-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-04-21, 10:15, Srinivas Kandagatla wrote:
> Looks like return from reg_write is set but not checked.
> Fix this by adding error return path.

Applied, thanks

-- 
~Vinod
