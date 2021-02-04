Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9F30F0F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhBDKel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235603AbhBDKdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:33:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0520C64DDE;
        Thu,  4 Feb 2021 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612434757;
        bh=EArjMRkmeuzvN8JsNJ4vSIHnn+1xYVxH7SoMRVxmXw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nNzaMZmNi2fPLT5jJ1FU/xbW/ucUzV3vSg4M34QbPJf57oqeKuDiDCX2A6fk0+cBR
         YJPYCpmGENXHgmosjyejIsJKr/k6zLho9WPQ41KHook0yEolJc0Q69gD3RrUjq7ZJL
         XMlyJjHeG9/3DsVzsCYyRd7IwnbKOaFryKfBHyTk=
Date:   Thu, 4 Feb 2021 11:32:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ruifeng Zhang <ruifeng.zhang0110@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, ruifeng.zhang1@unisoc.com,
        linux-kernel@vger.kernel.org, chunyan.zhang@unisoc.com
Subject: Re: [PATCH] RFC syscore: add suspend type to syscore
Message-ID: <YBvNQfJyzEpuwcvl@kroah.com>
References: <20210129082726.19406-1-ruifeng.zhang0110@gmail.com>
 <YBPNAoitmgnTxiqQ@kroah.com>
 <CAG7+-3NGUgryomKB=_W=p9nADPJVnns_x9oWpAFCEei7RiyrOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG7+-3NGUgryomKB=_W=p9nADPJVnns_x9oWpAFCEei7RiyrOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 05:06:25PM +0800, Ruifeng Zhang wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2021年1月29日周五 下午4:53写道：
> >
> > On Fri, Jan 29, 2021 at 04:27:26PM +0800, Ruifeng Zhang wrote:
> > > From: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> > >
> > > Suspend type contains s2ram and s2idle, but syscore is only
> > > available for S2RAM.
> >
> > Who else needs this?
> In the s2idle suspend and resume, some vendors want to do some
> things, for example the vendor implemented the watchdog driver.

We can not add things to the kernel for code that is not in the kernel
tree itself, you know this.  Please don't try to go around this
well-known rule.

> The GKI requires that no modification of the kernel source is allowed,
> so an syscore_s2idle is added for use.

I have no idea what "GKI" is with regards to the kernel project, sorry.

> The reason device_suspend was not chosen was that I wanted it to
> monitor for longer periods, such as between device_suspend and
> syscore_suspend.

Why does that matter?  What do you do with that information?

> > > S2idle requires a similar feature, so a new parameter
> > > "enum suspend_type" is added to distinguish it.
> >
> > Who requires this export?
> >
> > I don't see a user of this new code/api in this patch, so why would it
> > be accepted?
> >
> > Also, you are doing many different things in the same patch, please
> > break this up into a patch series where you only do one logical change
> > at a time.
> I think it's only one things in patch
> 0001-RFC-syscore-add-suspend-type-to-syscore.patch,

I do not understand what you mean here, emails do not name patches :)

> add a new s2ildle type for syscore.

But why is that needed?

thanks,

greg k-h
