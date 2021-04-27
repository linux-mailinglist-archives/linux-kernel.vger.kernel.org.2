Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5585A36C5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhD0MAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237083AbhD0MAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7168613E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619524804;
        bh=LORufGwtspZtG8l74V8h1YxAHWRT1kPObsMneukjSZw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u+oliQtDSuv7N3YOypuqcW968/rhNti+f30hcEvJtm8SJHF4GMeZazgZ8W5wG126s
         RFsi8jxJssh6VvjaY8EOIjv6vYdi3/giUI4S1tXZTSpQJZ/4IAG4i3sEc3CFwIuyqB
         IKba3r4UP0ozSX4UmhNekX0ReGEMjHrlwJdZbdIUPAKw3a0qSUo6GpZ19W78GhSecl
         dJWDeh+U7kMWOWVcuXwAyQTdA+HCMaQgPFBjM75AdApFxz/anwvF3K42fk5dzbQrl7
         vTJ/0phoROMdkoMoUqhe6skixbrmT71rHObGfGPa0vohPrKjSQnCHOBiM2PP0i8pwk
         mkwCStPjfb+EA==
Received: by mail-wr1-f46.google.com with SMTP id a4so59210332wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 05:00:04 -0700 (PDT)
X-Gm-Message-State: AOAM532GAS2FoEBFqlvAIfSEQRq+zHc9Naekl0sXwCcQ12sfENXDh0QE
        gKkPyhQEH5lpP+/v+W371MUCjzWUVw0qa95tPuY=
X-Google-Smtp-Source: ABdhPJwVtcot37BMO0hOk6Q9dqBzPv/I79SZGIWotCenkzJV+fcVVplU4zpnzrw+KohBLFEmuHAcFF6Xid8KgrmcQ4c=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr29883750wrz.105.1619524803195;
 Tue, 27 Apr 2021 05:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210422152648.2891996-1-arnd@kernel.org> <YIfaLbsAUjs86418@kroah.com>
In-Reply-To: <YIfaLbsAUjs86418@kroah.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Apr 2021 13:59:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1N-JV-yJSVCXT__Aqdkj6LgdHqemPo2=7iZg+-EL32KA@mail.gmail.com>
Message-ID: <CAK8P3a1N-JV-yJSVCXT__Aqdkj6LgdHqemPo2=7iZg+-EL32KA@mail.gmail.com>
Subject: Re: [PATCH] [v2] staging: rtl8723bs: avoid bogus gcc warning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 22, 2021 at 05:26:19PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > gcc gets confused by some of the type casts and produces an
> > apparently senseless warning about an out-of-bound memcpy to
> > an unrelated array in the same structure:
> >
> > drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c: In function 'rtw_cfg80211_ap_set_encryption':
> > cc1: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
> > In file included from drivers/staging/rtl8723bs/include/drv_types.h:32,
> >                  from drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:10:
> > drivers/staging/rtl8723bs/include/rtw_security.h:98:15: note: at offset [184, 4264] into destination object 'dot11AuthAlgrthm' of size 4
> >    98 |         u32   dot11AuthAlgrthm;         /*  802.11 auth, could be open, shared, 8021x and authswitch */
> >       |               ^~~~~~~~~~~~~~~~
> > cc1: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
> > drivers/staging/rtl8723bs/include/rtw_security.h:98:15: note: at offset [264, 4344] into destination object 'dot11AuthAlgrthm' of size 4
> >
> > This is a known gcc bug, and the patch here is only a workaround,
> > but the approach of using a temporary variable to hold a pointer
> > to the key also improves readability in addition to avoiding the
> > warning, so overall this should still help.
>
> What version of gcc causes this?  Should this go into 5.13-final and be
> backported?  Or is this only showing up on "unreleased" versions of gcc
> and it is safe to wait until 5.14?

As I understand, this is related to
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673

gcc-11.1.0 has now been released and it produces this warning.

        Arnd
