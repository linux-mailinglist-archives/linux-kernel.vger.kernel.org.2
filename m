Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7138C3A3E49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFKIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhFKIuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:50:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F458613B3;
        Fri, 11 Jun 2021 08:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401327;
        bh=wzmDPkke5nl/r29FApCGodpa36rwZcyFe+jPlmHPVXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ow93uj3r7aT8gtsXugXwfEKnRIYGheuI7QX0FCLBi9GpulkJePXXN9hcCZDj0Ns8W
         DQYT+GIDfXDIIoZRc9NzI2qC9c2pO/BIX6PQcxzImq0e7ZLEX5LMTY6YMkTS8UUImK
         v9kWexTAsSEGugX9jRhrxDP5PdMyEcrlGLVPEhiY=
Date:   Fri, 11 Jun 2021 10:48:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/5] nvmem: prepare basics for FRAM support
Message-ID: <YMMjbCFzsfiT8dMA@kroah.com>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-2-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611052652.7894-2-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:26:48AM +0200, Jiri Prchal wrote:
> Added enum and string for FRAM to expose it as "fram".

I have no idea what "FRAM" is, nor what "fram" is.

And why do you not add the documentation update here in this same
commit?  This is where you are adding it, trying to dig later in the
series to notice that you really did provide this is a pain, and is
harder to track.

Please provide more information here in the changelog and move the
Documentation addition here into this patch.

thanks,

greg k-h
