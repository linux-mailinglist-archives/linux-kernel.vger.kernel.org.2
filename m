Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743063F5F78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhHXNuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234881AbhHXNut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:50:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 197066103B;
        Tue, 24 Aug 2021 13:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629813005;
        bh=Jv6ulgpFIcSorBWo753QuKsQuk7e05SY9nBHbBwd730=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgHSdWT1JJ0sFN7VB3dGRmwAVIuZewwK03wH7GUNxIeaPU1KrU/LzKNUvUSLjTB9p
         3lnvqc6h8wabZkB6VuJNdBkRpVa326WMilrqQYk8D6Z7+AADJYZAvrmP2CD8+eKmKD
         9Nt42KDPeYCA/YUFmEIgsc2TugD09MY03XCmZaZ0=
Date:   Tue, 24 Aug 2021 15:39:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Soundwire updates for v5.15-rc1
Message-ID: <YST2mw4VZj8xGZ5E@kroah.com>
References: <YSSB1bmorkoV71KE@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSSB1bmorkoV71KE@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:51:25AM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Here is the PR for soundwire subsystem for v5.15-rc1.
> 
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.15-rc1

Pulled and pushed out, thanks.

greg k-h
