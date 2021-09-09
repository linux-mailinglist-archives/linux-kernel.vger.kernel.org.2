Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6B40482F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhIIKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhIIKDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:03:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7F3B611AD;
        Thu,  9 Sep 2021 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631181714;
        bh=/1f9r8n9WVDTH6/Q/V695DPtM4Oyh3rAnEy9HTpXCm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GaBNtYTxaCkbW00RDO9jLMx28TcPJ2arczOBGqvAa6l6vLBjt9nYPnTO8sf8d37j4
         SqR3oQan0g82yJ1F90YPW1cK9o2jeW2+sKJ2HgIIXtkYm2NwSY4+Q7qzZs/zJHSpGF
         7pdh/UB9TvVYOUn+xTSm5h4nduILlOBa1UXHgI5Q=
Date:   Thu, 9 Sep 2021 12:01:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove conditionals
 CONFIG_88EU_{AP_MODE,P2P}
Message-ID: <YTnbj+1fLVav5fyN@kroah.com>
References: <20210908050109.1279-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908050109.1279-1-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 12:01:09AM -0500, Larry Finger wrote:
> These two conditional compile symbols are explicitly defined.
> As a result, their included code is always compiled. They could be
> converted to Kconfig symbols; however, my experience with this driver
> in a GitHub repo is that many users of the device have it built into
> a SOC or SBC that they wish to use as an access point. As a result,
> CONFIG_88EU_APMODE would need to be selected. Thus it should be built in.
> 
> There have also been many users the wish to establish peer-to-peer
> networks with this device. For this reason, I am also proposing that
> CONFIG_88EU_P2P be automatically included.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Makes sense.  If this really does need to be split up in the future, it
can be done better without all of this #ifdef mess in the .c files.

thanks,

greg k-h
