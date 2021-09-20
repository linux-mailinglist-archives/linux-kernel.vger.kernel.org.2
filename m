Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86578411219
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhITJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhITJwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FE8960F93;
        Mon, 20 Sep 2021 09:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632131443;
        bh=TiDuQ/Kuv6TlqXYyNLmZjWU+QS3qvHNDIWXbA46cd2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhCo32IUaoZMyaiMLtUrpg0wVRk9uTbe1i+sFzkoDe5h3dIQQF3aYeFwv/6ChT7t7
         OuTnMDlSdTdrdJe7nOa+v7qFcTygz45skE62nXL8BiWztFr9hVTGfKfnzErLGxXHTA
         ZxjwdIkSVOKhA4y7WHcdMcnu9UJ/uYIEBFRFrO/Ajxr2+4mKr/OX7npxdbQtiFVVw7
         9rvc7ZtWBJ6RdwXw29GfE4XB4SlxQJBOzVWTdreH/rE222kk7Ks+pGzXhY6bseL38b
         eZU9favSuXdrSegRgfnpeaCB+M8C+yWOb8p1mrs48U9NjKREO1Pj7aHcyaT3rbJ4Mw
         GLQuNSNrc9hlg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSFwg-0004MG-PC; Mon, 20 Sep 2021 11:50:42 +0200
Date:   Mon, 20 Sep 2021 11:50:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] USB: serial: allow hung up ports to be suspended
Message-ID: <YUhZcvOx/R0IpWEg@hovoldconsulting.com>
References: <20210910121128.18664-1-johan@kernel.org>
 <YTtSdGTYAv53XdoI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTtSdGTYAv53XdoI@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 02:41:24PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 10, 2021 at 02:11:26PM +0200, Johan Hovold wrote:
> > User space can keep a tty open indefinitely and that should not prevent
> > a hung up port and its USB device from being runtime suspended.
> > 
> > Also clean up a few related error labels in a preparatory patch.
> > 
> > Johan
> > 
> > 
> > Johan Hovold (2):
> >   USB: serial: clean up core error labels
> >   USB: serial: allow hung up ports to be suspended
> > 
> >  drivers/usb/serial/usb-serial.c | 59 +++++++++++++++++----------------
> >  1 file changed, 30 insertions(+), 29 deletions(-)
> > 
> > -- 
> > 2.32.0
> > 
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing. Now applied.

Johan
