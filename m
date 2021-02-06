Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88917311C7E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 11:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBFJ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 04:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhBFJ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 04:59:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89B4D64E59;
        Sat,  6 Feb 2021 09:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612605509;
        bh=pvaPoEHS8eJgmIrbM3/fhoiucIR/+gIdleZqsdvsHZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEKfzd0ru4fwTWofO/RuyoiuhrMwcoxNIvY3GXNGhAGoX7R6KJyECYgxhlPWk5asv
         scc3eEDV4ctYq5s7GatHGnCd0R8I22B7ZIdKXecKbYGqoxAc/8Do0V9XzMISSgu96M
         1pjkVD2y8TykI2VPsIGkgArrz3jWcKxu5ZDjHX5GdYpZhXPUpBnfzoJyNkdiVAndRA
         CE38wOYnAvOdHOwzqSrsSLDWblB3G+Yjy9gVxMrhtX7WoPfG0MZd1kjWIVOotdlz9y
         eKn67c76amV4TyCibKpBecTTTseoFOSj20ENB0D7KXz5kJPE6E1iBxa7oHU6uB1rwR
         EVpwisW25tdJA==
Date:   Sat, 6 Feb 2021 15:28:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: zynqmp: Simplify code by using dev_err_probe()
Message-ID: <20210206095824.GJ2656@vkoul-mobl.Dlink>
References: <0df30548f721b10475a6cc5659beda102fec3c87.1612444300.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df30548f721b10475a6cc5659beda102fec3c87.1612444300.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-02-21, 14:11, Michal Simek wrote:
> Use already prepared dev_err_probe() introduced by commit a787e5400a1c
> ("driver core: add device probe log helper").
> It simplifies EPROBE_DEFER handling.

Applied, thanks

-- 
~Vinod
