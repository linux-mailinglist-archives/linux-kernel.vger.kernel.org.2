Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6A34EF65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhC3R0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhC3RZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4607619CD;
        Tue, 30 Mar 2021 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617125137;
        bh=ePSuJ8ma3WpYWbEYHTIMeW/KYbq45titohW1Q7tiVr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KwuUtHZbz2yvKjdswt8BJBz5YKVW90Dd9TM+Qru9XS+lpxpq9ycmk90bgvwRpgpDS
         lk+Tf6NXTZz6naWbv2IrWmnWHgOcwDKR+iiS0gtp94UwVRX4ryiiVRqA1v9uSUJNNG
         P2FLglHf/TyN1L1pnJt5GUCSVQHLTgePMFrtYMN7CFTPn61tDCtd8QiDfp61+hCpYl
         lT9WdmLgzL6nXRusfag2jJ6sk+oyRgMXqTIqLCCS5ZP/UywrUHs3ofVLtnpxxEPy2+
         +R/hS+cbsN0uNDQbxZrZNlU5BpuybIskgafPQdzT58HUGUz9EGCf6SU66AAUi86vAo
         G99zYmJOY3GiQ==
Date:   Tue, 30 Mar 2021 22:55:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/9] soundwire: qcom: various improvements
Message-ID: <YGNfDUV5GO/kYQ2R@vkoul-mobl.Dlink>
References: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-03-21, 15:47, Srinivas Kandagatla wrote:
> Thanks for reviewing v5 of this patchset!
> 
> During testing SoundWire controller on SM8250 MTP, we found
> few issues like all the interrupts are not handled,
> all transport parameters are not read from device tree.
> Patch to add Auto Enumeration supported by the controller
> is also part of this series.
> 
> Other major issue was register read/writes which was interrupt based
> was an overhead and puts lot of limitation on context it can be used from.
> 
> With previous approach number of interrupts generated
> after enumeration are around 130:
> $ cat /proc/interrupts  | grep soundwire
> 21: 130 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire
>     
> after this patch they are just 3 interrupts
> $ cat /proc/interrupts  | grep soundwire
> 21: 3 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire
> 
> So this patchset add various improvements to the existing driver
> to address above issues.
> 
> Tested it on SM8250 MTP with 2x WSA881x speakers, HeadPhones on
> WCD938x via lpass-rx-macro and Analog MICs via lpass-tx-macro.
> Also tested on DragonBoard DB845c with 2xWSA881x speakers.

Applied, thanks

-- 
~Vinod
