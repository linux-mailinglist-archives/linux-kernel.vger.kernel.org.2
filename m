Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E343FD8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbhIALeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243816AbhIALeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:34:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A6D560F42;
        Wed,  1 Sep 2021 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630495994;
        bh=5MiKDi8uZb8lcIaWPiVc2fEJkv1iyxMhULIUNb5ZKH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMGwuf0leYe/yOJfg99NtM5zLDyfqIsZ1b/TgVmIqWQigeeGdJSw+byVB2Vpvb83e
         FyvhgtgmIzLSYLiPgpUZQPmBcSKWTmO7+ODvmeg+b76KPmGPDf8G2PwVWxBIllthwG
         +gCveoaf2cdhWbl+iVXCtOj+SqrXYe2xNb/AnS8c=
Date:   Wed, 1 Sep 2021 13:33:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ebiggers@google.com, toybox@lists.landley.net,
        stable-commits@vger.kernel.org
Subject: Re: Patch "fscrypt: add fscrypt_symlink_getattr() for computing
 st_size" has been added to the 5.4-stable tree
Message-ID: <YS9k9wK5zPSL6VGn@kroah.com>
References: <1630493566193250@kroah.com>
 <YS9c4qZP9MeiEp2U@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS9c4qZP9MeiEp2U@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 12:58:42PM +0200, Greg KH wrote:
> On Wed, Sep 01, 2021 at 12:52:46PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     fscrypt: add fscrypt_symlink_getattr() for computing st_size
> > 
> > to the 5.4-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> Dropped from 5.4 as there is no need for it now that the other patches
> failed :(

Same thing for 5.10, all 4 are now dropped from there as well as they do
not build.

thanks,

greg k-h
