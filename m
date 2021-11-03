Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76738443DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhKCIEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhKCIEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:04:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 449456109F;
        Wed,  3 Nov 2021 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635926496;
        bh=MEbMStlRHIURQGIgVoxXKtkhqBcONNCCgaRMqrtd1/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gP0Wa5kDK/fMZ1m6CDxzVddXfYZUBLqFlOVpihDWsuECd3UwG67GfD4+4hBsSfBra
         l75BYYkCzzbLWqckw3oxoUUupyLgOgXfKInjmCDyUILBTuNKTeVQa66d5pQqT/KtAy
         gThGAxw52SJei1nMME77x42+9qqyz4nn/NYPJevwGVbmJkm6Kxn8iZnoCp8HGMZhH8
         Xt0txa651kSBU69ukl5GKO3vHhqyV48zIMx/o++0o64WY6PGslYmOKYLs1B56b0Go7
         DCJ2uXNYpD58QJTTNPWyzVq0oiMFvdT/JwjZ6AspjcQNoCOrbpwitxQ4EDoiEGE7Vi
         CkkR1RfLGvN0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1miBDE-0003Gz-SJ; Wed, 03 Nov 2021 09:01:36 +0100
Date:   Wed, 3 Nov 2021 09:01:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jingjing Liu <liujingjing@cdjrlc.com>
Cc:     ysato@users.sourceforge.jp, uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] h8300: Prefer unsigned int to bare use of unsigned
Message-ID: <YYJB4J5poEpvQIWT@hovoldconsulting.com>
References: <20211103070247.24216-1-liujingjing@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103070247.24216-1-liujingjing@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 03:02:47PM +0800, Jingjing Liu wrote:
> Fix checkpatch warnings:
> 	WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Please don't run checkpatch.pl on code that's already in the kernel. Use
it to check your own patches before submitting them.

If you want to practise the patch submission process you can do so in
drivers/staging/ where "clean ups" such as this one are currently
accepted.

Johan
