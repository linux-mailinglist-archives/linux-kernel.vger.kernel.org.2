Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3C305DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhA0N7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233074AbhA0N67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:58:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A4612075E;
        Wed, 27 Jan 2021 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611755898;
        bh=eLStmM4r9HyJLx0khV+lOxfuUkZ2pGzJpeJwZl2bIkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMvDN0GTiZ3vvNVEXmcu9FWEUZW6UYKzAVMOxT//8TT4+SqNgp1hvGdzJ1fBbBBbV
         X766lbQG1fXnV7jhctWW7ktJr6kAEAI1Wrr1isvjMcAX0UXYye0hz/GzBASr/Xo+fm
         zgZytxIZelXGnsmTgbrXmzjFLG3ReYHkjbnSlou4=
Date:   Wed, 27 Jan 2021 14:58:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johannes Czekay <johannes.czekay@fau.de>
Cc:     nicolai.fischer@fau.de, jbwyatt4@gmail.com, rkovhaev@gmail.com,
        hqjagain@gmail.com, gustavo@embeddedor.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH 1/6] wlan-ng: clean up line ending
Message-ID: <YBFxd23HvY7ziOjB@kroah.com>
References: <20210118010955.48663-1-johannes.czekay@fau.de>
 <20210118010955.48663-2-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118010955.48663-2-johannes.czekay@fau.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 02:09:51AM +0100, Johannes Czekay wrote:
> This patch cleans up all the "Lines should not end with a '('" warnings.
> 
> Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
> Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
> Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

When you resend this series, please remember to add "staging: " to the
prefix of all of the commit so I know to pick it up.

thanks,

greg k-h
