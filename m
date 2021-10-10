Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC87342814E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhJJMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232507AbhJJMnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:43:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E6AF60D07;
        Sun, 10 Oct 2021 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633869676;
        bh=o7w90LSNRYu3AezcvSR4dAernvfz123PxduSd3YmtCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdKE04NYiz7YZMW0mlmTDySLzhyqylYJl1Ey/fQ5uY6NRjLA1LKb8FkLbr42QFH1O
         MZRfs6rH8EsH0D7APJCwXc0rodR1l0lA5LBkdgv8x3kTrD5dCy3YZxG55pJGq0yOY1
         Dzmz8hzn6rdhQnh8DGzOo1s9lYByCXmcXLS7Gtno=
Date:   Sun, 10 Oct 2021 14:41:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: move dma-buf symbols into the DMA_BUF module
 namespace
Message-ID: <YWLfav3afArnyBFg@kroah.com>
References: <YU8oVDFoeD5YYeDT@kroah.com>
 <18108ec3-550f-be65-7fe6-655444b7f75b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18108ec3-550f-be65-7fe6-655444b7f75b@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 12:08:45PM +0200, Christian König wrote:
> Am 25.09.21 um 15:47 schrieb Greg Kroah-Hartman:
> > In order to better track where in the kernel the dma-buf code is used,
> > put the symbols in the namespace DMA_BUF and modify all users of the
> > symbols to properly import the namespace to not break the build at the
> > same time.
> > 
> > Now the output of modinfo shows the use of these symbols, making it
> > easier to watch for users over time:
> > 
> > $ modinfo drivers/misc/fastrpc.ko | grep import
> > import_ns:      DMA_BUF
> > 
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Christian König <christian.koenig@amd.com>

Thanks for the ack.

greg k-h
