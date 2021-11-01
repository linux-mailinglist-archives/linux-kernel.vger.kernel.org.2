Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C021441AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhKAL7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 07:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231693AbhKAL67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 07:58:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24AFC60FE8;
        Mon,  1 Nov 2021 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635767785;
        bh=if2VG9FVJDgck36pg/yAThPEFRWXueQsiNTZl/KVw4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7YhA56jUh9C/+bHrJVkXYC/XNPIUnVpMx9h1IUdKD4SONWECboCFe4ZdqJT9wPZX
         nysQjATQVeKh9T8axxrIZtqIvDHM4cwKkqe/OVyEJ1CAanIRLRRmBxga583yLkhcqn
         GfqWl1YEkqCtIvR8mbY4XG8rToMWSjSSJ28bMlXs=
Date:   Mon, 1 Nov 2021 12:56:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Idzibear <Idzibear@kaputniks.org>
Cc:     regressions@leemhuis.info, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, torvalds@linux-foundation.org
Subject: Re: Thorsten is tracking regression again and could need a little
 help (was: Re: Linux 5.15)
Message-ID: <YX/V5o934uFhMdri@kroah.com>
References: <a365ffb9-a4d2-b1d7-7cd7-dd9d7039e04e@leemhuis.info>
 <c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11d94b4-1701-4e26-efd1-42038342c4aa@kaputniks.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 12:46:33PM +0100, Idzibear wrote:
> https://www.reddit.com/r/linux/comments/qjyxso/the_515_kernel_has_been_released/hitiykt/
> 
> I just noticed something strange. I'm experimenting with some repurposed
> Desktop-PC to make it maybe into a homelab server.
> 
> I ran Kernel 5.14.10, and I had an idle usage of 19-22 watts. Updated to
> 5.15 and it went to 27-29 watts. Went back to 5.14.10 and it went down to
> 19-22 watts again. WTF?

Odd, any chance you can use 'git bisect' and track down the offending
commit?

thanks,

greg k-h
