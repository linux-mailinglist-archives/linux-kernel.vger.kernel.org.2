Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08731F65E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBSJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230132AbhBSJJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:09:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37C1364EAF;
        Fri, 19 Feb 2021 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613725716;
        bh=xo0O5jvUsla+GXOspK/qojERplWSgqrPcSMY6EULirM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lENAqZxVDz3R3QIOXNUFTurEprt8rqeAZ4JJw39i49HrKwlOsARlB7wYSOJeA93Tq
         DQLf8J9nZqQW7EgQNktRpIZ4RFpZeQ6CCA9UpeOAh5O0Y/kSJH2CRyWJkY7UT6LTaY
         U3tKjcPyuqgtZ2psx/tDa9Xh0nA6tHK3E17gCTqI=
Date:   Fri, 19 Feb 2021 10:08:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        PEIXIN HOU <PEIXIN.HOU@huawei.com>,
        Yanjin <yanjin.yan@huawei.com>,
        "Zhangdianfang (Dianfang, OS Lab)" <zhangdianfang@huawei.com>,
        Zhaohongjiang <zhaohongjiang@huawei.com>,
        Huxinwei <huxinwei@huawei.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC+AEcuXhPXXtmRB@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <595affb4-36e8-0a63-ebb3-a4fd0e3c243a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595affb4-36e8-0a63-ebb3-a4fd0e3c243a@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 04:54:24PM +0800, Hanjun Guo wrote:
> Hi Greg,
> 
> On 2021/1/26 15:29, Greg Kroah-Hartman wrote:
> [...]
> > 
> > I want to see companies _using_ the kernel, and most importantly,
> > _updating_ their devices with it, to know if it is worth to keep around
> > for longer than 2 years.  I also, hopefully, want to see how those
> > companies will help me out in the testing and maintenance of that kernel
> > version in order to make supporting it for 6 years actually possible.
> > 
> > So, are you planning on using 5.10?  Will you will be willing to help
> > out in testing the -rc releases I make to let me know if there are any
> > problems, and to help in pointing out and backporting any specific
> > patches that your platforms need for that kernel release?
> 
> We(Huawei) are willing to commit resources to help out in testing the
> stable -rc releases, and to help to backport patches for stable kernels.

Wonderful!

> 5.10 stable kernel will be used for openEuler [1] kernel and also inside
> Huawei. From customer's feedback, it's very important to see the stable
> kernel we used to be maintained for 6 years in the community, and we
> will use 5.10 kernel for at least 6 years, so we are willing to help
> you and help ourselves :)
> 
> In specific, we will start from the testing work, using HULK robot
> (reports lots of bugs to mainline kernel) testing framework to test
> compile, reboot, functional testing, and will extend to basic
> performance regression testing in the future.

Great!  Do you all need an email notification when the -rc releases come
out for the stable trees, or can you trigger off of the -rc stable git
tree?  Different CI systems work in different ways :)

And if you can reply to the -rc release emails with a "Tested-by:" tag,
I will be glad to add that to the release commit when that happens to
show that you all have tested the release.

> And we will start from ARM64 and X86 architecture first, and then extend
> to other platforms.

That's a good start, the useful ones :)

> For patch backporting, will send the bugfix patches (from mainline)
> we spotted, but I think this work may not doing in regular but will
> be triggered as needed.

That's fine, it is not something that happens at a regular interval.

> Does this sound good to you?

Yes it does, thank you so much.

greg k-h
