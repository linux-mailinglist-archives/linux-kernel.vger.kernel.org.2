Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92E30619C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhA0RMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235149AbhA0RKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:10:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D356364DBC;
        Wed, 27 Jan 2021 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611767391;
        bh=vAyHUjRxmUKvV4VWWU9NWmSFziAmKNYG2gJKYHP4mFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgqHXdYZobnk/nSKGpahrrw3hpvv6RJc/Xv11MRRJ0cak7F/cCYa6105jBXdq42v1
         A2RWZxgCV6LBW8kCmcywcfBiSv9iIdJn/CBrvCdSCSvWomKnh5jsQajB4cjttpqOT8
         tPqhcZraYDkcwuojT39vVVwUP2UAlcM5q+dQ4ZwE=
Date:   Wed, 27 Jan 2021 18:09:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] firmware: Add ZSTD-compressed file support
Message-ID: <YBGeXDTEy8myghot@kroah.com>
References: <20210127154939.13288-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127154939.13288-1-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:49:35PM +0100, Takashi Iwai wrote:
> Hi,
> 
> it seems that ZSTD format is getting popular, and I've been asked
> about the firmware loader support.  So I took a quick glance, and it
> turned out that it's fairly easy thanks to the existing ZSTD API.
> Now high time to submit something.
> 
> The first patch adds a new Kconfig CONFIG_FW_LOADER_COMPRESS_ZSTD and
> the corresponding decompression function to the firmware loader code.
> For the already supported XZ-compression, CONFIG_FW_LOADER_COMPRESS_XZ
> is added to make it selectable explicitly, too.
> 
> The rest three patches are for selftest: a cleanup, a fix and the
> additional support of ZSTD format.
> 
> Currently, I have no idea whether any distro would use ZSTD files for
> firmware files in near future, though.  That's the reason of this
> patch set being an RFC for now.

Looks sane enough to me, if we have a real user, I see no reason why to
not merge this.

thanks,

greg k-h
