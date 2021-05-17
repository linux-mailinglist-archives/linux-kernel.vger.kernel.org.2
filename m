Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32E2382B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhEQL5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhEQL5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:57:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D20C6101E;
        Mon, 17 May 2021 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621252597;
        bh=Dj6gZws6a8rjbatIhlG40lHC0N0qKimZtARuilCF21E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bi1qEoLq5OymfCs8yWPk95LgHjsQfiwKFuronHICmu+CTSWKQu+73EcPn3JiyLuL0
         6Zp1PlP8L0pRiDI+p1ZeZ9qe4c/vPhvWB1oeHiTTwxkMTsKbY/HGqr8B8ff0dN7nVF
         tiXwhzlSDTqA3RMnJGz+jA1+x3CK8ONKMTJxrGfM=
Date:   Mon, 17 May 2021 13:56:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai(A)" <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH] uacce: use sysfs_emit instead of sprintf
Message-ID: <YKJZ8278k0GEcF87@kroah.com>
References: <1621247137-42693-1-git-send-email-yekai13@huawei.com>
 <YKJHGP9LTnCRfIx6@kroah.com>
 <e5290000-5481-c662-974f-85eea7660953@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5290000-5481-c662-974f-85eea7660953@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 07:49:37PM +0800, yekai(A) wrote:
> 
> 
> On 2021/5/17 18:36, Greg KH wrote:
> > On Mon, May 17, 2021 at 06:25:37PM +0800, Kai Ye wrote:
> > > Use the sysfs_emit to replace sprintf.
> > 
> > That says _what_ you did, not _why_ you are doing this.  What problem
> > are you solving with this change?
> > 
> > thanks,
> > 
> > greg k-h
> > .
> > 
> sprintf is not safe, and it not recommended to use.

Why not?  What is "unsafe" with it in this function?

> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content and it's possible to overrun the
> PAGE_SIZE buffer length. so used sysfs_emit that  knows that the size
> of the call situations that also ensures that no overrun is done. so use
> sysfs_emit to replace sprintf maybe better.

But that's not a problem at all for these calls, right?  If so, please
show me how that could ever happen.

thanks,

greg k-h
