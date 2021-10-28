Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7643DC62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJ1HwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1HwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:52:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ADAE6058D;
        Thu, 28 Oct 2021 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635407394;
        bh=oi9ymG1v+oCBUDIlGx5DnnvriLCfYMpb+cSTzcx800c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xg1ZbmgNdM83roTL7HXlj1clBWM9uzkGbEuODAign2jHZrrOuxFEQwTrYTSN+uRtD
         LQcpz56Dq1WHtrRr/cLKhbttHn0+6exEBWZQvTBkPPiJZ5d/OjhfpOK4+jPzocSVkA
         xZi2S/sTXTYcZKzS8HIvpEp1E2bFI4DrLzV95zmH3j7vx7On9WRu/S2Gmrvp+QKg0a
         5NiC/qvKVV6jCTNJcB6cWXatlQ54JoW7uVfoTE4Td+XZLg+4MnflvBPSFvhngCl2Br
         lfB+FtyMORE/CBzxMJP0TunYuc3+tWXHh+hdEDcEFbsP1NOALGp5nxqN2vGl2nUKgf
         xHD14ICQAMkwg==
Date:   Thu, 28 Oct 2021 08:49:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Arm64 defconfig-debug
Message-ID: <20211028074949.GB23476@willie-the-truck>
References: <4aee8e37-b1f0-bd1c-9bf8-842c6cdc557e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aee8e37-b1f0-bd1c-9bf8-842c6cdc557e@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 03:45:32PM -0400, Qian Cai wrote:
> Hi there, some general debugging features like kmemleak, KASAN, lockdep,
> UBSAN etc help fix many bugs like a microscope. On the other hand, those
> features are scatter around and mixed up with more situational debugging
> options making them difficult to consume properly.
> 
> Since I have been deal with those options on a daily basis for the last
> a few years and accumulated the knowledge of their pros and cons, I am
> thinking about to create an initial defconfig-debug available inside the
> tree, so that it could amplify the general debugging/testing efforts for
> arm64 across the broad.
> 
> The downside is that this might open a gate for other people to push yet
> another subject-specific defconfig, but I don't see anything as
> important as general debugging/testing at the moment. Then, there are
> two defconfig need to be modified for some common changes, but I think
> that is quite trivial to do. We could even create a simple script to
> sync if that is not overkill.

I'm not in favour of adding a whole new debug-flavoured defconfig for arm64,
but you might be able to add some reduced config file containing just the
options you're interested in to kernel/configs/. That said, I'm not sure the
existing files under there are well-maintained at all. The Android ones,
especially, looks like they should just be removed.

Will
