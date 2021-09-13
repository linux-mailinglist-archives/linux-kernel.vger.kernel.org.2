Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040CE409C98
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhIMSy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347499AbhIMSyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:54:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E652860F24;
        Mon, 13 Sep 2021 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631559214;
        bh=YILugTkzyXwATz0qqlrum5V7nKWX1bT+knVxHyNOA9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=praELURUY/GLHNH2qLYD3tZceMheOY18RPQhQiMQCPjfVZpsmnneQtHS5FNI6TXH4
         etPVoeAjdqozGMclhnHW2ljAb7IAAgVcC7aW5TIn/3K5iob65roL3Y5n6AOx+vSG+F
         v7QKVlxfrh9lw7uS6bvfxMWsTyM4PK7I+jMxmtB/L5Vi3rgRfKIEXs9xepn6EJInGL
         xcVuQZya4J0GO7Ve6u7kC65oHBNKUe65vf79hYmBOWkpXWr2zEoi28Fo96+XGOfuJr
         xGzSKIhkdo5ZItryKc5xNjcZcCjIQB7KRgrmsqKvnsa7yH20asN2JMqHaKVf6B89dN
         El52q5qXVbFPg==
Date:   Mon, 13 Sep 2021 11:53:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error:
 static_assert expression is not an integral constant expression
Message-ID: <YT+eJY4JoobVsKWu@archlinux-ax161>
References: <202109112002.NZceUwiC-lkp@intel.com>
 <20210913165317.GX2505917@nvidia.com>
 <CAKwvOdnGaVb1XGwYpNK_3zAEyZ0JC1SDjC1UzzFEH=d_Mdi7Fw@mail.gmail.com>
 <20210913183813.GY2505917@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913183813.GY2505917@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 03:38:13PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 13, 2021 at 10:00:02AM -0700, Nick Desaulniers wrote:
> 
> > > This macro would like to know that the passed in member name has a u64
> > > type, all the things I've come up with fail on clang - but many work
> > > fine on gcc. Frankly I think this case is a clang bug myself..
> > 
> > Perhaps, though this assertion looks a bit like offsetof() to me. I
> > wonder if that can help here?
> 
> The assertion would logically like to be this:
> 
>          static_assert(typecheck(((struct qib_port *)0)->N, u64))

This works for me with both GCC and clang, if that is acceptable to you?
It fails if you change one of the variables to 'u32'.

Cheers,
Nathan

diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 452e2355d24e..0a3b28142c05 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -403,7 +403,7 @@ static ssize_t diagc_attr_store(struct ib_device *ibdev, u32 port_num,
 }
 
 #define QIB_DIAGC_ATTR(N)                                                      \
-	static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
+	static_assert(__same_type(((struct qib_ibport *)0)->rvp.n_##N, u64));  \
 	static struct qib_diagc_attr qib_diagc_attr_##N = {                    \
 		.attr = __ATTR(N, 0664, diagc_attr_show, diagc_attr_store),    \
 		.counter =                                                     \
