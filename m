Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E004C3D3AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhGWMhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234988AbhGWMh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:37:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A13660EBC;
        Fri, 23 Jul 2021 13:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627046283;
        bh=D9F/PrvMx7ClAfHjvAQRMP65PgHLMUqenNZXU47Nh6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IDnY+oBu728h4yuld22jcFUfya0d6lwWf1lMvGCrNpyuJz8xf7n6p/Sp31I8G3fNA
         RBJuhZd3cDLTw6j9CN/nkgepZ2B3dYH+raD4zWI7qQcwjTQcT9xQVQjT0JZh39yGM0
         Dp7acdcbz6+GT6anm9F4ijP8JOmq5AuN3Y29kSEY=
Date:   Fri, 23 Jul 2021 15:18:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Artem Baxtiarov <baxtiarovartem@gmail.com>
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: comedi: drivers: ni_routing: ni_device_routes:
 pci-6070e.c Lindented
Message-ID: <YPrBiNPdeyTfpkUE@kroah.com>
References: <20210723122749.GA41336@ideapad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723122749.GA41336@ideapad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 03:27:49PM +0300, Artem Baxtiarov wrote:
> I found "Lindent" item in drivers/comedi/TODO.
> I used scripts/Lindent to indent

Please never use that on files.  checkpatch is what you should be using
for this, and odds are the TODO file should just be removed instead.

> drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c

If you look, your changes make the code harder to read, sorry, but this
isn't needed.

thanks,

greg k-h
