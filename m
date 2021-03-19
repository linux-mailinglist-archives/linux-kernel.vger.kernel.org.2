Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D837341906
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCSJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhCSJ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:58:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A6F064DFB;
        Fri, 19 Mar 2021 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616147924;
        bh=JpeCK5UFqftKHcE7iyJRPQbZ/IrUvYuiOdGSr6qD9Kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjT4rkfacx0qBif9kkBLy/oRUtm5gYKghI7DoIEloBmyvH0+oq3IPHngl9h/+0qi9
         MOOMEBSE9jlivfmBchqG/b0jVFd3GfrWWvMZiWBdHJC/OwYB92NXW94hXJ1/M/MJKT
         1Q7UZkCZ77GeVCObcgshCZQ6Lzw2HMz9iYaaeiEw=
Date:   Fri, 19 Mar 2021 10:58:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, dbrazdil@google.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "arm64: Unconditionally set virtual cpu id registers" has
 been added to the 4.14-stable tree
Message-ID: <YFR10rgacwn/pJUj@kroah.com>
References: <20210316134319.89472-1-vladimir.murzin@arm.com>
 <161614754918214@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161614754918214@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:52:29AM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     arm64: Unconditionally set virtual cpu id registers
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

OOps, no, wrong branch, my fault.

greg k-h
