Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5102B31DB49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhBQOSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232371AbhBQOSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:18:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD17C64DBD;
        Wed, 17 Feb 2021 14:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613571475;
        bh=9DtE28FgJnN9z9xq9OPPtCLnloyzssm4m4fGCOYg9Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o5wafKTdgY0WWFUxF9kARDCaFzQRev6VAoYAMmpGwvR8PuDZA8Jh/CUf535/3GUqn
         TAP2/M2hR268xiAc/buBQv018xNaT5+1dS+1AJx5IqLaIljMtcvsBKOjquwr+RC1vZ
         ynRk2VI7sq9l8nXGn1V0d2PwfUtc2SJKbCIksXgg=
Date:   Wed, 17 Feb 2021 15:17:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] firmware: Add the support for ZSTD-compressed
 firmware files
Message-ID: <YC0lkDRXcR8Rg7+h@kroah.com>
References: <20210127154939.13288-1-tiwai@suse.de>
 <20210127154939.13288-2-tiwai@suse.de>
 <20210217132419.GN4332@42.do-not-panic.com>
 <s5ha6s24y39.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6s24y39.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 02:34:34PM +0100, Takashi Iwai wrote:
> On Wed, 17 Feb 2021 14:24:19 +0100,
> Luis Chamberlain wrote:
> > 
> > On Wed, Jan 27, 2021 at 04:49:36PM +0100, Takashi Iwai wrote:
> > > Due to the popular demands on ZSTD, here is a patch to add a support
> > > of ZSTD-compressed firmware files via the direct firmware loader.
> > > It's just like XZ-compressed file support, providing a decompressor
> > > with ZSTD.  Since ZSTD API can give the decompression size beforehand,
> > > the code is even simpler than XZ.
> > > 
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > It also occurs to me that having a simple like #define HAVE_FIRMWARE_COMPRESS_ZSTD
> > on include/linux/firmware.h would enable userspace to be aware (if they
> > have kernel sources) to determine if the kernels supports this format.
> 
> Extending that idea, we might want to have a sysfs entry showing the
> supported formats instead?  This will allow to judge dynamically.

What could userspace do with that information?
