Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD33040FAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhIQOrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhIQOp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:45:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D24860F5B;
        Fri, 17 Sep 2021 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631889875;
        bh=+Hg/+BfWwo03yKEs5Bbuny3+dk6KDoxUqDrZJkTkIM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3zRsZNEddp6obXcwYzM/GjWxK+HxAoSYubfD8EcE37EiYioYi7QmPRdyOJdsCueM
         m1TLt856AWgCdw4D7vJMYaUttfngVoI+1nO6sUQzbBkJsAqYo+azJffUVUFDvJA4YF
         WoY8G3T0GBrXxito+C0oKplLWtZ/AQGmUr2GleBw=
Date:   Fri, 17 Sep 2021 16:44:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 16/19] staging: r8188eu: clean up rtw_read*() and
 rtw_write*()
Message-ID: <YUSp0eIu22iiT58f@kroah.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-17-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917071837.10926-17-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:18:34AM +0200, Fabio M. De Francesco wrote:
> Clean up rtw_read{8,16,32}() and rtw_write{8,16,32,N}() in usb_ops_linux.c.
> 
> 1) Rename variables:
>         length => len
>         pio_priv => io_priv
>         pintfhdl => intfhdl
>         wvalue => address.
> 2) Remove unnecessary casts.
> 3) Fix types.  Use __le16 instead of __le32.

Again, should be 3 changes.

thanks,

greg k-h
