Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C42355C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbhDFTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241315AbhDFTgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6777613A9;
        Tue,  6 Apr 2021 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617737776;
        bh=MJKZMQKHJHY6Vc9TMSOIgqmLg1at+USHkUd5zXJWp4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQs+DIBu7bc3HH4i/wM6Vq+v8ecI711FauSPxZYFbEyoIyieRBKlyQdgfdDaKRM41
         IH83oRKcpoNg2QSYNHPuukF9fc+R+G5W6JMzk+NDoXtCaKDEi3WFV9XAOAyuAmcDSp
         ALvjCkvqdRVKKi/wHvvxSPbOj/owZqQVZYhE7GJA=
Date:   Tue, 6 Apr 2021 21:36:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [RESEND PATCH] staging: emxx_udc: Ending line with argument
Message-ID: <YGy4LXHBrBb/r3dk@kroah.com>
References: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406193409.96428-1-martinsdecarvalhobeatriz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 08:34:09PM +0100, Beatriz Martins de Carvalho wrote:
> Cleans up check of "Lines should not end with a '('"
> with argument present in next line in file emxx_udc.c
> 
> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Why is this a [RESEND] ?

What happened to the first version?

Also, your subject is odd, please look at the documentation for how to
write good subject lines for patches.

thanks,

greg k-h
