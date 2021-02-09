Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D58314A62
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBIIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhBIIeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:34:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33AB264EBD;
        Tue,  9 Feb 2021 08:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612859601;
        bh=3OKP0t58xOeHhLwNxgD7fVnUWxz8bzp1vk0ElNTo5wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWYv1xHEOI8XlnXzMvh+ECVS4PEDOA1/8WwcKp1ZOK+FCP1m7VCe5IAxK8tS43G/l
         sb5eJ7UTEqd6Ydsb+rkCw712++dEGx0vr5+Ur/OAp6hGGGiFy64JS8bPjliRg/1UMO
         OfwXDVjCYeP33bSyiTod4wO7sm3D8RFRDXovPcOo=
Date:   Tue, 9 Feb 2021 09:33:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: Linux-phy updates for v5.12
Message-ID: <YCJIvtTwc79fPbJK@kroah.com>
References: <20210207174907.GB879029@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207174907.GB879029@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 11:19:07PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive Linus-phy updates for v5.12
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.12

Pulled and pushed out, thanks.

greg k-h
