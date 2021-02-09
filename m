Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624C2314A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBIIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhBIIcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:32:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72C2C64E92;
        Tue,  9 Feb 2021 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612859520;
        bh=0/oi2skBq5piZUUVGQh3teGjtISF10arflwIeT7Kj68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irQI+oLFEkqEfXsZV7mBREHLQoqmHIRumEenpgX1+xkC2YZcgpbL5Pe9bTA0mAZx8
         UyEflctzqXyCuLlM53US7yChIEUPBIav/Hv2EsjlFL2YFov54sgtFdmkiBHw7eEI6n
         vhtfh0x5rhRBjUpHnPGBH1S7dqonsDjc/CA2n5Tg=
Date:   Tue, 9 Feb 2021 09:31:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [GIT PULL]: soundwire: updates for v5.12-rc1
Message-ID: <YCJIbTFRUqZOl5pL@kroah.com>
References: <20210207173601.GA879029@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207173601.GA879029@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 11:06:01PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive update for v5.12-rc1. This update includes new
> no_pm IO routines and bunch of updates for intel & cadence drivers.
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.12-rc1

Pulled and pushed out, thanks.

greg k-h
