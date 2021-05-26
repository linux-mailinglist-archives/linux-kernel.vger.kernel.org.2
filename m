Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281E5391838
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEZNAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:32838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232103AbhEZNAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:00:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9F5F61090;
        Wed, 26 May 2021 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622033923;
        bh=iF81SXN4wUoys97DIxIXY0XyFTVaKcQRXfthirSIQZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLoO6a8Gbgb0Xx5tfaE9RU6mOL4QcGTLGWGCDQPE0wNPXUa7fPHdFnyk9w7kOeOuh
         h31VzI9kRTCcngs1Hcy4EkL4VRj/ikMTQ0WX2MsHHWpyOSlo5SQZsC8knfbWiSb8/I
         mgeX65xkBzRSxsBqLC0NeNVVUE8y0ZTwptSGe9D/Hxuw8s/SeyLK9WOOh4KD+k/9gC
         NFO7lHxLKIFwJl6tpKvyRKR9k3+p2YKrM3E1aT5kqGTuTLYMiV8sq9Z08qIt8pf6ur
         4BGyBov5kfqMPUmwDdt5PUgemFUmOhZcD7EwUcXzvz/M49JE/VCM5PQ7QWBUGsAoBD
         jZmS2ZFOo57xQ==
Date:   Wed, 26 May 2021 14:58:39 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Jon Mediero <jmdr@disroot.org>
Cc:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: correctly exit module_kallsyms_on_each_symbol
 when fn() != 0
Message-ID: <YK5F/7LEWj0juiOw@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
References: <20210520122326.18563-1-jmdr@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210520122326.18563-1-jmdr@disroot.org>
X-OS:   Linux p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de
 5.12.0-2-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jon Mediero [20/05/21 14:23 +0200]:
>Commit 013c1667cf78 ("kallsyms: refactor
>{,module_}kallsyms_on_each_symbol") replaced the return inside the
>nested loop with a break, changing the semantics of the function: the
>break only exits the innermost loop, so the code continues iterating the
>symbols of the next module instead of exiting.
>
>Fixes: 013c1667cf78 ("kallsyms: refactor {,module_}kallsyms_on_each_symbol")
>Signed-off-by: Jon Mediero <jmdr@disroot.org>

Good catch, thanks a lot for the fix! Applied to modules-next.

Jessica
