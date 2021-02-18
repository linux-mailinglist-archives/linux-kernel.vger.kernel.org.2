Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02C31EF69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhBRTME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234621AbhBRRos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:44:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23FDE64E3E;
        Thu, 18 Feb 2021 17:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613670247;
        bh=dN5Lz8Nkhcc+7OtiNpQTs1HcBWR9lBrcFyuDejV+psY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfRPveNc8xRM3n0ukIEnd+ripXxdzndk5VzdXkYpOa836nxXkxoxNvuo/dStwBIvO
         xsBxpmiihK+RdWVilZS3Vn2G1i3j1uNHOMTctUysu01t18gb3cd5lhlCn0BFn9XUq/
         cENt4RkhlZV7eJsEwz6bPg7mnPXwGubuzJgH2Xw0=
Date:   Thu, 18 Feb 2021 18:44:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jariruusu@protonmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC6nZH/4CkLLsxxB@kroah.com>
References: <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com>
 <20210218113107.GA12547@1wt.eu>
 <602E766F.758C74D8@users.sourceforge.net>
 <20210218143341.GB13671@1wt.eu>
 <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:19:54PM +0000, Jari Ruusu wrote:
> On Thursday, February 18, 2021 4:33 PM, Willy Tarreau <w@1wt.eu> wrote:
> > Usually you pick an LTS kernel for a specific hardware. If it
> > works that's great. But you cannot expect hardware to suddenly start to
> > work in the middle of a stable kernel. Sometimes it happens (PCI IDs) but
> > that's basically all and that's not their purpose.
> 
> It was the other way around. Fine working in-tree driver got
> broken by backported "fixes". I did mention bit-rot.

It did?  Please let us stable maintainers know about, we will always
gladly revert problems patches.  What commits caused the problem?

> In-tree iwlwifi worked half-ok on early 4.9.y stable. If
> connection somehow de-autheticated (out of radio range or
> whatever) it crashed the kernel spectacularly. Eventually that was
> fixed and in-tree iwlwifi worked fine on 4.9.y and 4.14.y stable
> kernels. On second half of year 2020 (don't remember exactly when)
> iwlwifi started causing erratic behavior when some random process
> terminated, as if some exit processing left some resources
> un-freed or something weird like that. Upgraded to 4.19.y kernels
> in hope to fix the issue. Nope, same problems continued there as
> well. Replacing in-tree iwlwifi with out-of-tree upstream Intel
> version solved the problem for me.

So something in the 4.9.y and 4.14.y stable kernels caused a regression,
can you please do 'git bisect' to let us know what broke?

And if 4.19.0 was always broken, why didn't you report that as well?

How about 5.11, have you tried that?  If not, please do so and report it
to the developers, otherwise how can it ever get fixed?

thanks,

greg k-h
