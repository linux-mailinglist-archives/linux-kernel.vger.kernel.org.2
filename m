Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67236C635
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhD0Mmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235410AbhD0Mma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:42:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D47613BD;
        Tue, 27 Apr 2021 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619527306;
        bh=D/57EnUGbaoqCDHbcC6Bq25ljG5GmSHvIXMqeF1SSak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZ1JIi0NUvBneAgEQhhsycSWjkAqJEVYp4BKtndgkjfVmTX2eIYOfg5VCdlGFImK9
         OR/Hh14dI9F+YkxMImzBFTr2KTRD4nrus1jJ7lx1dhUXbkQK63rbRHrRRZlne0+s/V
         pAsaKpQ9hp4iAuGh0r+vYmYLsTPWZPC/KdY6xlAM=
Date:   Tue, 27 Apr 2021 14:41:44 +0200
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
Message-ID: <YIgGiMFvXlM4MYiK@kroah.com>
References: <20210422152648.2891996-1-arnd@kernel.org>
 <YIfaLbsAUjs86418@kroah.com>
 <CAK8P3a1N-JV-yJSVCXT__Aqdkj6LgdHqemPo2=7iZg+-EL32KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1N-JV-yJSVCXT__Aqdkj6LgdHqemPo2=7iZg+-EL32KA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:59:32PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 27, 2021 at 11:33 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 22, 2021 at 05:26:19PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > gcc gets confused by some of the type casts and produces an
> > > apparently senseless warning about an out-of-bound memcpy to
> > > an unrelated array in the same structure:
> > >
> > > drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c: In function 'rtw_cfg80211_ap_set_encryption':
> > > cc1: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
> > > In file included from drivers/staging/rtl8723bs/include/drv_types.h:32,
> > >                  from drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:10:
> > > drivers/staging/rtl8723bs/include/rtw_security.h:98:15: note: at offset [184, 4264] into destination object 'dot11AuthAlgrthm' of size 4
> > >    98 |         u32   dot11AuthAlgrthm;         /*  802.11 auth, could be open, shared, 8021x and authswitch */
> > >       |               ^~~~~~~~~~~~~~~~
> > > cc1: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
> > > drivers/staging/rtl8723bs/include/rtw_security.h:98:15: note: at offset [264, 4344] into destination object 'dot11AuthAlgrthm' of size 4
> > >
> > > This is a known gcc bug, and the patch here is only a workaround,
> > > but the approach of using a temporary variable to hold a pointer
> > > to the key also improves readability in addition to avoiding the
> > > warning, so overall this should still help.
> >
> > What version of gcc causes this?  Should this go into 5.13-final and be
> > backported?  Or is this only showing up on "unreleased" versions of gcc
> > and it is safe to wait until 5.14?
> 
> As I understand, this is related to
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> 
> gcc-11.1.0 has now been released and it produces this warning.

What's the odds we can get gcc to fix their bug, as it's not a kernel
issue?  :)

thanks,

greg k-h
