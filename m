Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543B23EEAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbhHQKNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234895AbhHQKNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C401F60FD8;
        Tue, 17 Aug 2021 10:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629195181;
        bh=4F7fdKFyUEZWj0E/8F8dIeSaqH6q3diYSPRZQZMMyiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A19Xvrus49Lnhzl3aMazUp5nqsFGrE9Ya60O09HOrkVLBWTzp/+kYMHOKGHxRTUwY
         IlSzgQbbJAn/Zy+BpeMWBuY7qK54Q5pKtO/ox4qj3BXNazG+Yn4q2ykO6VKNxMdDMV
         YzAVNReBX4Hq5LFuAw4jLIq0eDAIIR9yvFp1z8upaXsVb0a2Z+ZEU4ZZvppoSxOJro
         lmhfgH16peUA5PWW+InmKJiQomLRuJBYMgPz1949zdWYDZEn6C036820Ah2pUJbKjQ
         XwGOKe/HRWZlChs0O8aWbjiel2HVo5EC8SCLnt1SsPSIxfdZjWnXdpSB2j79thY0os
         Z0AEJCisYBHrQ==
Date:   Tue, 17 Aug 2021 15:42:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, p.zabel@pengutronix.de,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        mparab@cadence.com, lokeshvutla@ti.com
Subject: Re: [PATCH v3 0/9] PHY: Prepare Cadence Torrent PHY driver to
 support multilink DP
Message-ID: <YRuLqAH12Llvbqti@matsya>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-07-21, 16:54, Swapnil Jakhade wrote:
> This patch series enables Torrent PHY driver to support different input
> reference clock frequencies. It also does the basic cleanup in order to
> add support for multilink DP configurations. The multilink DP series at
> [1] will be split in 2 parts and sent separately. This is part 1 of the
> series.
> 
> Support for DP multilink configurations with register sequences will be
> added in part 2 as a separate patch series after validation.

Applied, thanks

-- 
~Vinod
