Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D936C36C911
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhD0QJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhD0QJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:09:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF63E6101E;
        Tue, 27 Apr 2021 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619539733;
        bh=MGTdEc1hoNf5ENVvBpk9WOWNX2m5f9EvQSNbL2ciWTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbfG95D5Uqnx8KHAW+8ZCOLlD33EU4leC0F8urVZg1K4UFatPOVA1dSbsG5MO29QS
         0tLe9hOynswu+1GuRz++KTyokdFuc+ON7CZxpcVmBf6LmLP0mrP0Nlk36SW0u00dBO
         NfK/wYvFREsp91Gd4u68piAal08k2Nz5v//5fJTw=
Date:   Tue, 27 Apr 2021 18:08:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] staging: rtl8723bs: avoid bogus gcc warning
Message-ID: <YIg3E2eBbv1KhVR3@kroah.com>
References: <20210422152648.2891996-1-arnd@kernel.org>
 <YIfaLbsAUjs86418@kroah.com>
 <CAK8P3a1N-JV-yJSVCXT__Aqdkj6LgdHqemPo2=7iZg+-EL32KA@mail.gmail.com>
 <YIgGiMFvXlM4MYiK@kroah.com>
 <CAK8P3a1TN6r6p=2ZTQ_3f=5hK7n31VwzagCiy7ukG4Occ_3GYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1TN6r6p=2ZTQ_3f=5hK7n31VwzagCiy7ukG4Occ_3GYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:00:28PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 27, 2021 at 2:42 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Apr 27, 2021 at 01:59:32PM +0200, Arnd Bergmann wrote:
> > > On Tue, Apr 27, 2021 at 11:33 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> 
> > > >
> > > > What version of gcc causes this?  Should this go into 5.13-final and be
> > > > backported?  Or is this only showing up on "unreleased" versions of gcc
> > > > and it is safe to wait until 5.14?
> > >
> > > As I understand, this is related to
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> > >
> > > gcc-11.1.0 has now been released and it produces this warning.
> >
> > What's the odds we can get gcc to fix their bug, as it's not a kernel
> > issue?  :)
> 
> I think there is a high chance it will get fixed in gcc-11.2 or 12.1, but
> anyone using gcc-11.1 will still have the problem.

Ugh, ok, I'll queue it up for 5.13-final.

thanks,

greg k-h
