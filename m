Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A0356F52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbhDGOwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243657AbhDGOwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:52:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A146C6121E;
        Wed,  7 Apr 2021 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617807155;
        bh=7OBuDkzMlNYJBZ+PQnAsaH0bTpXq5Kj8Fuex1CaLahM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOMkqt1tHDJ5Z3B0/HlJ5bFP2mbjfn21CdJEgTUnT9iBsABgFqa6PVYlj5qh04KE0
         xm4kIX+nqDbFEWbSi1oni6T03OnfnvoR2fDG5mPYOr4c1thGns19JxLK2bSbCDibOh
         6LwLllLca/wEqW2EDEdErX08JSPu3ibVzFWjCTJU=
Date:   Wed, 7 Apr 2021 16:51:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.13-rc1
Message-ID: <YG3HBkVB1Kt41rLa@kroah.com>
References: <YG2mCCQUiSrouQoo@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG2mCCQUiSrouQoo@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 06:01:04PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Here is the soundwire pull request for this cycle. Bunch of core cleanup
> and changes along with driver updates
> 
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.13-rc1

Pulled and pushed out, thanks.

greg k-h
