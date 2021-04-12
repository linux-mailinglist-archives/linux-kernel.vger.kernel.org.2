Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03FA35B9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 07:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhDLFF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 01:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhDLFFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 01:05:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74E2E610C8;
        Mon, 12 Apr 2021 05:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618203938;
        bh=yeXv1VrFrrOxwBupLJbnw2n2xCQ5E67r16qIw0dYYSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3pykSZJ5Ssw7LwCjs0/vZ8En/M3f8VQiU94Ll1EgAJuG5SWYoc6eXG+E4v+yNC+F
         YgcEBg2U8qVllVAAWtNgMa9/ZJe+uiCFoLvr3Mb6EYxEBR+ALrNU0k4TBZ4XjZ5AiK
         X88gNl4T5UZeRlECUSClEzIa9MPECviXjRCfcdeYjoi67FP8ENW95kXdHpfMNUzNjh
         cuiUUMezLB5XKsH/MfzMmN0aH3kk4/U/ReX0mTfYEJbwsp3wCTkUrwUZJlRHR40CxR
         5ovBHDVccc3MtdJoIfvd3t7OPPnHZJxWjDG2mtq5uIUeDJI2Of/GOyTqKMnhHoM2Kw
         /ZUzLI/CNokxw==
Date:   Mon, 12 Apr 2021 10:35:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shixin Liu <liushixin2@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] phy: ti: j721e-wiz: Add missing include
 linux/slab.h
Message-ID: <YHPVHkayrZFAsq+X@vkoul-mobl.Dlink>
References: <20210408012829.432938-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408012829.432938-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-21, 09:28, Shixin Liu wrote:
> When compiling with CONFIG_PHY_J721E_WIZ, Hulk Robot reported:
> 
> drivers/phy/ti/phy-j721e-wiz.c: In function ‘wiz_mux_clk_register’:
> drivers/phy/ti/phy-j721e-wiz.c:659:17: error: implicit declaration of function ‘kzalloc’; did you mean ‘vzalloc’? [-Werror=implicit-function-declaration]
>   659 |  parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
>       |                 ^~~~~~~
>       |                 vzalloc
> drivers/phy/ti/phy-j721e-wiz.c:659:15: warning: assignment to ‘const char **’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>   659 |  parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
>       |               ^
> drivers/phy/ti/phy-j721e-wiz.c:697:2: error: implicit declaration of function ‘kfree’; did you mean ‘vfree’? [-Werror=implicit-function-declaration]
>   697 |  kfree(parent_names);
>       |  ^~~~~
>       |  vfre

Applied, thanks

-- 
~Vinod
