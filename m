Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEE933D9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhCPQqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239017AbhCPQpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C555B65108;
        Tue, 16 Mar 2021 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615913100;
        bh=9zLhKiVHAgyyK8oYnzHuLlLBAJxVrUA70tvGL4FZSUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BH+GDHYqWLMIdNKIUcnquojX769fwk2JyZbzEABp8EQAX5BjtjZNW8bbnLXnOO7fZ
         TwtvYe94mAXMPF0yySQrdcxZ6XZj+n+YlEww9xPgEgstAJeJLu0d/EFFKFKGU2+Xmg
         iR3ssinRHfI2KyD/6GjDdiZGAClKnCmB30Be9Etg=
Date:   Tue, 16 Mar 2021 17:44:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 1/3] misc/pvpanic: split-up generic and platform
 dependent code
Message-ID: <YFDgictc4oFuJYc2@kroah.com>
References: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
 <1615897229-4055-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615897229-4055-2-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:20:27PM +0200, Mihai Carabas wrote:
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

This isn't even needed given you do not have any pr_* calls in this
code.  As you shouldn't this is driver stuff, you should always use the
dev_* calls instead.

But you can delete that later, this is fine for now.  However generally
you do not set this value in a .h file, but rather in the individual .c
files if you really need it.

thanks,

greg k-h
