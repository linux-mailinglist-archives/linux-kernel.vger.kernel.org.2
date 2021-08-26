Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5113F84C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhHZJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240642AbhHZJtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB052610C8;
        Thu, 26 Aug 2021 09:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629971334;
        bh=pws6yEMx5CQmxG0eSLGORmnzzlW+g+uW697IABxaYho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdiKDdJQaCgiI+CuSLchYjZxNEa5AFlK4fqD9UCqMy1HSYmaTE87blVHY7l6HTO5I
         extVD7JjuSCJDW820nlPC1cGFaEdbMGv370LCEfvarOynGK4wb5S39qkxldtkG+dsl
         oadM1CysowNN7XicGgQ5u6mznotOleCtDntyr9xc=
Date:   Thu, 26 Aug 2021 11:48:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Woody Lin <woodylin@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] ANDROID: staging: add userpanic-dev driver
Message-ID: <YSdjgnUwt76cknQ6@kroah.com>
References: <20210826092854.58694-1-woodylin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826092854.58694-1-woodylin@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 05:28:54PM +0800, Woody Lin wrote:
> Add char device driver 'userpanic-dev' that exposes an interface to
> userspace processes to request a system panic with customized panic
> message.
> 
> Signed-off-by: Woody Lin <woodylin@google.com>
> ---
>  drivers/staging/android/Kconfig         |  12 +++
>  drivers/staging/android/Makefile        |   1 +
>  drivers/staging/android/userpanic-dev.c | 110 ++++++++++++++++++++++++

Why is this in staging?  What is wrong with it that it can not just go
into the real part of the kernel?  A TODO file is needed explaining what
needs to be done here in order for it to be accepted.

But why is this really needed at all?  Why would userspace want to panic
the kernel in yet-another-way?

thanks,

greg k-h
