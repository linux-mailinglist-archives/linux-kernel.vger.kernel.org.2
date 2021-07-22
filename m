Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AF23D1FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhGVHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 03:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhGVHvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:51:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C1C961241;
        Thu, 22 Jul 2021 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626942746;
        bh=niNHd63T7Hfv8exXKXCzIyEqfeyiFjFH+p0lOaYwNYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xYlXm64p2faz+xq3Xc7xdW7owVxJjFUHkpToCncrzPP1qiJpZvctAm1Ld1u3vkFgA
         Q0cHl7LUKOpmtwzLcD1cHIUUHWA2pyXjuZqJjMblWEq06SEmM0CHOCShdZ+0nCjYO0
         AUq+k5D0FbAGqBptXVJBhakxeQIk2PDoGQSrl6EY=
Date:   Thu, 22 Jul 2021 10:32:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <19210240158@fudan.edu.cn>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: Re: [PATCH] kernfs: Convert from atomic_t to refcount_t on
 kernfs_node->count
Message-ID: <YPktF6NKg9DvKfnH@kroah.com>
References: <60f8506d.1c69fb81.d8d4d.3bceSMTPIN_ADDED_BROKEN@mx.google.com>
 <YPkHAX1YdmxZtW49@kroah.com>
 <350c2c44.5a22.17acce3c8f4.Coremail.19210240158@fudan.edu.cn>
 <YPkQ8M9CLqeBvN2W@kroah.com>
 <57e48621.5aed.17accfa0d36.Coremail.19210240158@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e48621.5aed.17accfa0d36.Coremail.19210240158@fudan.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Jul 22, 2021 at 02:49:37PM +0800, Xiyu Yang wrote:
> Hi Greg,
> 
> I consider it as a reference count due to its related operations and
> the developer's comments, such as "put a reference count on a
> kernfs_node" around the kernfs_put(). If anything wrong, please let me
> know.

Did you test this?  Is this really a reference count when looking at the
code?  Or is it just a counter that we use for dealing with vfs issues?

Usually filesystems and the vfs can not use the refcount_t type for
various reasons, please do some research on that before making these
changes.

And of course, please explain how you tested this patch if you resubmit
it with the needed information.

thanks,

greg k-h
