Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA27E36C69C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhD0NBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235446AbhD0NBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:01:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48B33613DA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619528461;
        bh=sMMeX2PJBF6m8rhX79ZC4RUHtpZBjUk0ZeG/LM2gpVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IgJi/PjtxUvkLHLdapC86+0IyRGH7XvEKprW7GejBSssd6hL8aFXd0FbHC0N6uAxS
         fFtZN88HEroYq4dWYL8j62WHIFWR6yZCo6uVgxeGl0d2DI8/6uXi9ZPjYNAjyE2Sj/
         DasibyaxchU3GYfQkNgW5tYW19GntGvaq3rJ699ENdGPkuqRd0lMZ27tpBTrEjjR+S
         kfn9PCQFXh4XZJdOQ1vhFEsl4nP8UVrZFO5nHi225Ng2xfCWWIzZFHHqtTIYq6s9kx
         UYD3rLfMXXtc3zsQ/jiGTxG0nJP8MZvmU21CaV4R0SEdZHH+zPEnD9RfIiX0IADRSl
         26WesdaiYI8kA==
Received: by mail-wm1-f50.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so7059195wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:01:01 -0700 (PDT)
X-Gm-Message-State: AOAM533w0upxmr35Sg39FANiNJ7JwwwEDRexN8WyqvC09cfEm+KAgmxJ
        cn5O3WAR7jDag6TFMNV3wOaTTGaTNxe3o4jQrF4=
X-Google-Smtp-Source: ABdhPJzWued0Rb/h+zEDra2lvsobjBacdViv7NvecpuHwCUC+7jhVY9MepeuKnu3kpaptlruxLb9OPFvyQJYWLjnGKk=
X-Received: by 2002:a1c:6382:: with SMTP id x124mr4264396wmb.142.1619528458888;
 Tue, 27 Apr 2021 06:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210422152648.2891996-1-arnd@kernel.org> <YIfaLbsAUjs86418@kroah.com>
 <CAK8P3a1N-JV-yJSVCXT__Aqdkj6LgdHqemPo2=7iZg+-EL32KA@mail.gmail.com> <YIgGiMFvXlM4MYiK@kroah.com>
In-Reply-To: <YIgGiMFvXlM4MYiK@kroah.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Apr 2021 15:00:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1TN6r6p=2ZTQ_3f=5hK7n31VwzagCiy7ukG4Occ_3GYA@mail.gmail.com>
Message-ID: <CAK8P3a1TN6r6p=2ZTQ_3f=5hK7n31VwzagCiy7ukG4Occ_3GYA@mail.gmail.com>
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

On Tue, Apr 27, 2021 at 2:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 27, 2021 at 01:59:32PM +0200, Arnd Bergmann wrote:
> > On Tue, Apr 27, 2021 at 11:33 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:

> > >
> > > What version of gcc causes this?  Should this go into 5.13-final and be
> > > backported?  Or is this only showing up on "unreleased" versions of gcc
> > > and it is safe to wait until 5.14?
> >
> > As I understand, this is related to
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99673
> >
> > gcc-11.1.0 has now been released and it produces this warning.
>
> What's the odds we can get gcc to fix their bug, as it's not a kernel
> issue?  :)

I think there is a high chance it will get fixed in gcc-11.2 or 12.1, but
anyone using gcc-11.1 will still have the problem.

        Arnd
