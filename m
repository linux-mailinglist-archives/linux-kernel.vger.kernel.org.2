Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3306E38C54E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhEUK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhEUK6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:58:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D26CD611AD;
        Fri, 21 May 2021 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621594605;
        bh=Vp0rNB2vyFr7yGmIjFqJame/RWmqjoonkgATDlX42yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZz/KcVWEO2irJeDy/4+gJUldoiTkoM9jJ68mroVcV47+vCI5xXgPJZEp8xYir7sW
         BBwFy7YLyfknF9qeuLWzmZaqO4Dq9EDElo0Cu5N7wQJqA3oUaVA3yyjan6lS1Wp+AF
         mC5JLRyKGWsp+tTDOPGJv1SltrLSL+z6j98r7diE=
Date:   Fri, 21 May 2021 12:56:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire fixes for v5.13
Message-ID: <YKeR66HVoExjLXeE@kroah.com>
References: <YKYTR+oPW1XEBIi7@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKYTR+oPW1XEBIi7@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:14:07PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to recieve the fix for v5.13. This is one patch fix for
> regression in qcom boards.
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.13-fixes

Pulled and pushed out, thanks.

greg k-h
