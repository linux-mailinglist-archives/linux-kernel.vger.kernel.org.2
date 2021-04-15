Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E80360307
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhDOHNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhDOHNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:13:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACEFD611F1;
        Thu, 15 Apr 2021 07:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618470801;
        bh=lpWxRgXJSBBZ+/h21aDGOdU9sxO1H0Ab1tK4kG6NEPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=St8LyY9BNupzO8uJWM02Fb00F5gdM/h+EfeyWh6Dmy8BwWO6lgIiQ+Uhy8+TfU2en
         CoxZFZdYMC+kTYcMFS+5l1oZRGKmNo9Wxqtbq7Pzv/N9Otu68WzsVlb7MzIPSEv+yi
         DhMzcpoGhRGROF2JAPCa2f4o+GdM1iu/h4ooyG4E=
Date:   Thu, 15 Apr 2021 09:13:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.13 -second round
Message-ID: <YHfniUnGLP3gAeNE@kroah.com>
References: <YHcHjYv8HIaODa5t@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHcHjYv8HIaODa5t@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:47:33PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> As promised, here are some minor fixes for earlier pull request. This
> includes fixes which came in after the request was sent
> 
> The following changes since commit cbc336c09b6d6dfb24d20c955599123308fa2fe2:
> 
>   phy: fix resource_size.cocci warnings (2021-04-06 10:39:20 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.13-second

Pulled and pushed out, thanks.

greg k-h
