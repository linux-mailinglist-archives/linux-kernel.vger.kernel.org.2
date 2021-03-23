Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36B53458AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhCWH2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhCWH2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:28:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A87C619B2;
        Tue, 23 Mar 2021 07:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616484484;
        bh=4DVYsL8aC5zK4lFEUymSCq9jscwZnKFMJYdueKLFPo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzlIuCd+0stZ4n4SJ8jvKbl6SUTPuC4SXLr+EbWrUPV9FvtmfNHfb3A7TMiPMfS79
         6ZuDpvry/GVHWOFYaTBZVJZmtyPpBAiWunPiIHRjrbLu7YYjjiGkFK8i2aQLUAt1A8
         jWzoKvRRNOHkgSO0kiIr245MZJq4r1rBakJqKknQ=
Date:   Tue, 23 Mar 2021 08:28:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Ingo Molnar <mingo@elte.hu>,
        Douglas Anderson <dianders@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kgdb: fix gcc-11 warning on indentation
Message-ID: <YFmYgk2HDrIx1VNp@kroah.com>
References: <20210322164308.827846-1-arnd@kernel.org>
 <20210322170330.wil52d2geopfnfka@maple.lan>
 <CAK8P3a30_E5ouw2eGF0wAYd0CiKcekKkEe9xBay2K+OXkyx-gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a30_E5ouw2eGF0wAYd0CiKcekKkEe9xBay2K+OXkyx-gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:03:45PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 22, 2021 at 6:03 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> >
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> >
> > Which tree do you want to merge this one though? I've got nothing else
> > pending for this file so I am very relaxed about the route...
> 
> I don't plan to merge any of the build fixes through my own tree.
> If you don't have anything else, maybe Greg can pick it up
> in the char-misc tree.

Yes, I can take it, thanks.

greg k-h
