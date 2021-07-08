Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C663C161C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhGHPjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhGHPjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:39:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEC226186A;
        Thu,  8 Jul 2021 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625758612;
        bh=wseLBnjAibGIxhA/WADEubcjORxxlZR37p2FTF3iJMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gffoeIavl/L2txYo39Vda0QFrciLTKORom3INbuNt2qO+/D6CiH6m4hMmMF0gcRcz
         gMYiU/ekfr3BdBy7aNdgfjkFojOVs5WdNNU9H9BX31R4N6BZKGHKaqbgj97se3CRD/
         u+m0MUJchAiCaMJh3g1YhY/aBg4ngbsnKO+l8M0Q=
Date:   Thu, 8 Jul 2021 17:36:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Weber <matthew.weber@collins.com>
Cc:     sashal@kernel.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Stefani Seibold <stefani@seibold.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kfifo: DECLARE_KIFO_PTR(fifo, u64) does not work on arm
 32 bit
Message-ID: <YOcbkagxoPS2AreG@kroah.com>
References: <20210708152342.59635-1-matthew.weber@collins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708152342.59635-1-matthew.weber@collins.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 10:23:41AM -0500, Matthew Weber wrote:
> From: Sean Young <sean@mess.org>
> 
> If you try to store u64 in a kfifo (or a struct with u64 members),
> then the buf member of __STRUCT_KFIFO_PTR will cause 4 bytes
> padding due to alignment (note that struct __kfifo is 20 bytes
> on 32 bit).
> 
> That in turn causes the __is_kfifo_ptr() to fail, which is caught
> by kfifo_alloc(), which now returns EINVAL.
> 
> So, ensure that __is_kfifo_ptr() compares to the right structure.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> Acked-by: Stefani Seibold <stefani@seibold.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Matthew Weber <matthew.weber@collins.com>
> ---
> 
> This patch originally made it into 4.16 as 
> 8a866fee3909c49738e1c4429a8d2b9bf27e015d but is a bug on at least 4.14
> for any 32bit system(PPC/ARM/...) using kfifo with u64 datatypes.
> 
> Please add to linux-4.14.y for the next LTS tag.
> (Below patch is a cherry-pick of the commit onto linux-4.14.y and was
>  verified on 32bit hardware.)

Now queued up, thanks.

greg k-h
