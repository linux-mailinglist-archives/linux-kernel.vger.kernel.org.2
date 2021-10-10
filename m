Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5609B42814B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhJJMmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhJJMmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:42:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E523760D07;
        Sun, 10 Oct 2021 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633869646;
        bh=oaYB3NF9gEsWf0KpJdgbjCYjcL0/kIjSGtIHoxA4PAc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=yrpoRCU3L9czZ4JE9gFE1f7AvdyrtYEcinTdEvxJaqFJkqUSzRs2b4JKv2dQfbN1u
         OJosxLnVIwfyUPaG3oHv+Kz8LpFDHaJMdtb+cPocKBTDnhL0V5RxK9uhDkJveKszyx
         k5oiW8o3Id9jpAGvXXB0Z3ZtFXyLG86sKlVv/UZ8=
Date:   Sun, 10 Oct 2021 14:40:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: move dma-buf symbols into the DMA_BUF module
 namespace
Message-ID: <YWLfS/VDRrMdj0r2@kroah.com>
References: <YU8oVDFoeD5YYeDT@kroah.com>
 <YVLE4b/nG5/qCOJN@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVLE4b/nG5/qCOJN@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 09:31:45AM +0200, Daniel Vetter wrote:
> On Sat, Sep 25, 2021 at 03:47:00PM +0200, Greg Kroah-Hartman wrote:
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
> > ---
> > 
> > The topic of dma-buf came up in the Maintainer's summit yesterday, and
> > one comment was to put the symbols in their own module namespace, to
> > make it easier to notice and track who was using them.  This patch does
> > so, and finds some "interesting" users of the api already in the tree.
> 
> Yeah, the interesting ones is why I added the dma-buf wildcard match a
> while ago.  Since that landed I don't think anything escaped. Should we
> perhaps also add
> 
> K: MODULE_IMPORT_NS(DMA_BUF);
> 
> to the dma-buf MAINATINERS entry? Entirely untested, also no idea whether
> there's not a better way to match for module namespaces. Either way:

I think MAINTAINERS is already overloaded with too many of these things,
but feel free to mess with it if you want to :)

> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks for the ack!

greg k-h
