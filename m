Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52D34F079
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhC3SFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232580AbhC3SEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:04:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EA2B619B9;
        Tue, 30 Mar 2021 18:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617127490;
        bh=oModXwUxmMyfRIh4whro1oarObAUSB3dp/vTGTrHtNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tG4VSIyBs+E9e2ru4dsikVZABSZML651QC1v1ISSa/lKZMSrvp3uKRD0Ig7g8j3KG
         mouSQDuhajQvw7bOASH+waX/Ub7iGx1do40PYEZ+dcY5iox7knO1PBSYOq+3/YXaeA
         UvMEZgMYJ+wc0PAE/3OONKlFtOQvqLtcO1GPMvXnqCEwUug6olaIy6F1FtdJaTOdmT
         dZbGVfJbO2GbESCJYojWfAPFtkvMrp7v8fXGhd+m2hDgN8YRdePHZyIThNnUcoyQy3
         I/BqcgrDFM+CKlYpfrAvn7AzbT2DZjaNx7WZGIZ1Ry+JRT9190igLgH7q1rV0/NCpo
         Z+v3sNeQwmmTQ==
Date:   Tue, 30 Mar 2021 23:34:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com, nsekhar@ti.com,
        lokeshvutla@ti.com
Subject: Re: [PATCH 0/4] PHY: Update Cadence Torrent PHY multilink
 configurations specific to TI
Message-ID: <YGNoPhhuTPfYRN+f@vkoul-mobl.Dlink>
References: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-03-21, 07:08, Swapnil Jakhade wrote:
> This patch series updates Torrent PHY driver for multilink configurations
> specific to TI platform. It also adds support for configuring QSGMII in
> TI Wiz driver.
> 
> This patch series is dependent on [1] and should be applied on
> top of this.

Applied, thanks

-- 
~Vinod
