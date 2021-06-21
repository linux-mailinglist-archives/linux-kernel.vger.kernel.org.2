Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D9A3AE34B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhFUGgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFUGgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:36:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EA8661002;
        Mon, 21 Jun 2021 06:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624257270;
        bh=J2UkjNiDVlVLQCJc+TT6Np0y26TvHkmM1b5v6axIous=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kmx6UT26l9lheOTOv4SaHpTyau3Qad/NwftoNAxG7GI/0N3d+t+V0Ci5gY5rQ8mSw
         bB7Liuut68rsh5j9mRkj4KJfVbfSclSH4wK4RiP3H2s9CQD0qsNnC1BulTaAtWk+L7
         F9E4eUWBtSMZn6qgVo4VDX/IG22dT6QfyI8z5vo67e6GblkYrI3duZpGe22kFjUi3p
         vHIkHYBKnhBX2NBzm8muvisi15f5sIpHDpNCAbb1CRI+m/g7kAIrVBGJ123xF8ssJp
         hfeZe/FWnVY39mlwHK3Yqrk94GoJGLq0BneeLwPXZojrRR+GcAohYZpY4iDSmgDZkT
         cijKiU26z1KbQ==
Date:   Mon, 21 Jun 2021 12:04:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kishon@ti.com, tony@atomide.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] phy: ti: dm816x: Fix the error handling path in
 'dm816x_usb_phy_probe()
Message-ID: <YNAy8hlj3upzshnD@vkoul-mobl>
References: <ac5136881f6bdec50be19b3bf73b3bc1b15ef1f1.1622898974.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5136881f6bdec50be19b3bf73b3bc1b15ef1f1.1622898974.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-21, 15:17, Christophe JAILLET wrote:
> Add an error handling path in the probe to release some resources, as
> already done in the remove function.

Applied, thanks

-- 
~Vinod
