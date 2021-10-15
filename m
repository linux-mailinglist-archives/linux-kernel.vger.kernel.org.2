Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953CC42EA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhJOHbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232822AbhJOHbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:31:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF97E61073;
        Fri, 15 Oct 2021 07:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634282981;
        bh=GpLk6e/kfT08iB8+4sS7B1SSKbg3UUAT5s8pgszX7dU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghsP9BGCfU1h5zRWtpABOcx+ABN/6pNw9qS2xBfVkMA5KT9Z/QhvZqfGlhIE5v47n
         KmKQ/6SAVQ6JhyJGItuHYV6GHgUklPwbgyik+abAawsM0qbX2vIUd87qu1rR1zp2gb
         f8vywN9y4aLyrcJiJ6P5R3WMHl+geAF/L7sdBq1U=
Date:   Fri, 15 Oct 2021 09:29:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     "efremov@linux.com" <efremov@linux.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= tty: vt:
 replace snprintf in show functions with sysfs_emit
Message-ID: <YWkt4qt0pcORpkge@kroah.com>
References: <1634280696-5056-1-git-send-email-wangqing@vivo.com>
 <APcArgDIEqvUlprBO4*Tk4rA.9.1634281148594.Hmail.wangqing@vivo.com>
 <SL2PR06MB3082E66577E193F9EE9A09F8BDB99@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB3082E66577E193F9EE9A09F8BDB99@SL2PR06MB3082.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 07:10:42AM +0000, 王擎 wrote:
> 
> >> show() must not use snprintf() when formatting the value to be
> >> returned to user space.
> >
> >Again, who is making this "must" requirement?
> >
> >I, as the sysfs maintainer, am not saying that all existing show
> >functions MUST be converted, so I find it hard to believe that someone
> >else is...
> >
> 
> According to Documentation/filesystems/sysfs.txt:
> show() methods of device attributes should return the number
> of bytes printed into the buffer. This is the return value of 
> scnprintf(). snprintf() returns the length the resulting string.
> 
> So, show() must not use snprintf() when formatting 
> the value to be returned to user space. 

Ok, then you need to document this _MUCH_ better, saying that the value
returned by the kernel today is WRONG, and that this is a bugfix.

And can you see the difference here?  Have you tested these?

> Also, use sysfs_emit directly makes more sense.

I agree, but your changelog did not mention that at all.

thanks,

greg k-h
