Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D17D3EB283
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhHMIUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239581AbhHMIUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:20:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29B2960FC3;
        Fri, 13 Aug 2021 08:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628842815;
        bh=R2t/HkTfw4iNuHnkpQLxoKAEyy4GosUZbPrQovzCfTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nyuqa5aQXSZ6GUZWcEcZv0Id4SVtTlXsNz9UtCd4ZlNnFf4KQEEgFX5crXQm/E1ya
         +6yBMTJAZZcoN9SYQjy7q4KOq1n2Mz93W7A1yOUmlYE4gr4tSFzYNDn819Ds5EjetO
         TZFVZBa2vnDIRfxw88FJFcMUTWRBQRzoTdvppxRM=
Date:   Fri, 13 Aug 2021 10:20:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     oliver.graute@gmail.com, Carlis <zhangxuezhi1@yulong.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] fbtft: fb_st7789v: added reset on init_display()
Message-ID: <YRYrPfEHrcvDL4va@kroah.com>
References: <20210813062511.14537-1-oliver.graute@kococonnector.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813062511.14537-1-oliver.graute@kococonnector.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 08:25:10AM +0200, Oliver Graute wrote:
> staging: fbtft: fb_st7789v: reset display before initialization

What is this line here, and why is this not your subject line instead?

> 
> In rare cases the display is flipped or mirrored. This was observed more
> often in a low temperature environment. A clean reset on init_display()
> should help to get registers in a sane state.
> 
> Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>

What commit does this fix?

thanks,

greg k-h
