Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1AF30EE06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhBDIHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233387AbhBDIHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:07:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6423C64F4E;
        Thu,  4 Feb 2021 08:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612426018;
        bh=hm2tk9rjcjRCza/BteZrOsolwAbmaA/LwuIy71QdrAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SXK80UFvoYJjQ786KHOcRoi7yKypfPjgWWCh6g92Y3SAbJnIfDzIxTocAevzFiuBU
         +Wp8HaS4sXkDCgP0huAWp1JVZQ6uQkE42Waf8SJCENaaMDLzqB+Ty1NsIvgZdSNQoz
         JodNdwz1fPRSTszyWNaySkUlS59BxUGFSNVNdtVRH9xgMI4uBc2ZIwQG42CBEmVGiv
         BAD/vvUwUHLHSjZvILSuiLCS2qqGel56rTGQPEITTZYK9RhDhOCeR24G8Rp6r2hrsM
         fuZrZOFzYPrZJX3r2pGACuuY9/chY5HC3SqIsXkBI/3E6iaXsIDVw9BYdaLaC68fFv
         a+iLCIFNnaIhg==
Date:   Thu, 4 Feb 2021 13:36:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: phy-brcm-sata: remove unneeded semicolon
Message-ID: <20210204080654.GN3079@vkoul-mobl.Dlink>
References: <1612321087-14743-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612321087-14743-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-02-21, 10:58, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/phy/broadcom/phy-brcm-sata.c:654:2-3: Unneeded semicolon

Applied, thanks

-- 
~Vinod
