Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B233955CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEaHMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEaHMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:12:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFE1261186;
        Mon, 31 May 2021 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622445022;
        bh=gkPHYD/9mhHxwEi+04PaHjL1GOD94kD6M2w9N1jdGWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2v0UMZbQnlWKSL3gEa2DPXyKdZTBINeNc/uExrTSMxvgFIssclLx5mWZgLM9y/Um
         zP+9sy33IEaQkuUtHeyXmImMTiQhnohoA5Z/36WJbLOXQl1UsDC7cia/eIVEOSmHN6
         4aJV+yxqUq6rPTRpJuAFWdkRPR4erz3RtcXd1CdGPseJgi2LRggH+hE+TjwEF4Km30
         p9ejz7tU6qRU2zppoboiduQQrAK1mnKuMo8IrLKvIt3E71iGoHOWxgcob2CV1O/zFk
         nhjfF9LqknSQltPgtygRCH+LJb00rHcr88EJFY/Vj1OQwOMfDnRoRI/D4MFHBsp4/n
         7ZQF64JAuhRFw==
Date:   Mon, 31 May 2021 12:40:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: phy: phy-xgene.c: Fix alignment of comment
Message-ID: <YLSL2z8vsY5L43mh@vkoul-mobl.Dlink>
References: <20210428165515.o47o5awzdxirxkqi@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428165515.o47o5awzdxirxkqi@kewl-virtual-machine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-21, 22:25, Shubhankar Kuranagatti wrote:
> A * has been added at the starting of new line
> The closing */ of multi line comment shifted to new line
> This is done to maintain code uniformity.

Applied, thanks

-- 
~Vinod
