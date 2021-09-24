Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BFE416A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbhIXC5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhIXC5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:57:36 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9934CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:56:04 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTbNY-006qBt-0g; Fri, 24 Sep 2021 02:56:00 +0000
Date:   Fri, 24 Sep 2021 02:56:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: socket: integrate sockfd_lookup() and
 sockfd_lookup_light()
Message-ID: <YU0+QDerqF5+pPB7@zeniv-ca.linux.org.uk>
References: <20210922063106.4272-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922063106.4272-1-yajun.deng@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 02:31:06PM +0800, Yajun Deng wrote:

> -#define		     sockfd_put(sock) fput(sock->file)
>  int net_ratelimit(void);
> +#define		     sockfd_put(sock)             \
> +do {                                              \
> +	struct fd *fd = (struct fd *)&sock->file; \

Have you even bothered to take a look at struct fd declaration?
Or struct socket one, for that matter...  What we have there is
	...
        struct file             *file;
	struct sock             *sk;
	...

You are taking the address of 'file' field.  And treat it as
a pointer to a structure consisting of struct file * and
unsigned int.

> +						  \
> +	if (fd->flags & FDPUT_FPUT)               \

... so that would take first 4 bytes in the memory occupied
by 'sk' field of struct socket and check if bit 0 is set.

And what significance would that bit have, pray tell?  On
little-endian architectures it's going to be the least
significant bit in the first byte in 'sk' field.  I.e.
there you are testing if the contents of 'sk' (a pointer
to struct sock) happens to be odd.  It won't be.  The
same goes for 32bit big-endian - there you will be checking
the least significant bit of the 4th byte of 'sk', which
again is asking 'is the pointer stored there odd for some
reason?'

On 64bit big-endian you are checking if the bit 32 of
the address of object sock->sk points to is set.  And the
answer to that is "hell knows and how could that possibly
be relevant to anything?"
