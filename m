Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB67D45DEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356519AbhKYQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237180AbhKYQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:46:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 418986112D;
        Thu, 25 Nov 2021 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637858596;
        bh=N/jdimBGeacM/sqHqyrWLbH0xJ6Ub0wkYUVmtUU3vzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Myb59he5cu2+2ClHd93Jw5jhE3gRQvrbmeHrI0gNncRvvOjBKSZszotgCm3mYWGM9
         OxpDTwNXoVXchkZCJpzPLllBuqsqA4CuCZ/r45yOUJJElYuX476aScLkM8B4BwLHt3
         85tIXzGxhs4KWjtTXsOWfEUxzuAMFvjbPHbYtAGs=
Date:   Thu, 25 Nov 2021 17:43:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Satoshi Ikeke <satoshi.ikeke@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: replace printk(KERN_CRIT...) by
 netdev_crit()
Message-ID: <YZ+9ICwGXxuIJ6g7@kroah.com>
References: <YZkb3t83RFxVMWH4@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZkb3t83RFxVMWH4@debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 11:01:34AM -0500, Satoshi Ikeke wrote:
> Replace printk(KERN_CRIT...) by netdev_crit() for more uniform error reporting. Issue found by checkpatch.

Please properly wrap your changelog comments at the correct line width.

Please fix up and send a v2.

thanks,

greg k-h
