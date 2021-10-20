Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E675434EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhJTP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTP0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:26:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2EC061355;
        Wed, 20 Oct 2021 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634743471;
        bh=4at9laVcHUrA2VynzjrHKUHCmy2i6sSQIhtzKA3Gtr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ha8tHPUkUoXsE7OF4EzLXaUq2+Oj+uD6MqGbVGphBKQqbnu8/YLI+Jqjk5DWEV6lo
         F2ZnpDpjTyS1FJjn3Cp+31ZqVIYsolNtASCGYmS8CgxGvXM2Q7UZokFG9DssH+ENKn
         LYTiDaJeHUMGefkaK0LKJEEMeCq5tuV/TVTK7Qdo0YVaLOd476mMtxtOUcXqQsbJaH
         mm+8nkYnDa4J9EAOc8gdbTGw/yR8Cbpi36o4CkYLag+VKLTABwzO6uwNzgOrqgk3Jm
         b0T5KjXyzNsvhVBhuALSg+57mB8eapOsiQco1BAls+deRSjVECEsH0xFJeThYao7mq
         8bUOYBsNWdVAQ==
Date:   Wed, 20 Oct 2021 20:54:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: qcom: add debugfs entry for soundwire
 register dump
Message-ID: <YXA0q+3ER3zFpyOw@matsya>
References: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-21, 11:56, Srinivas Kandagatla wrote:
> For debug purposes add an entry in debugfs to dump Qualcomm
> SoundWire Controller registers.

Applied, thanks

-- 
~Vinod
