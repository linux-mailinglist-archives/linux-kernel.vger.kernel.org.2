Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50569368343
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhDVP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236356AbhDVP0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:26:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF02E613F6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619105166;
        bh=cNV6IkI3EWzn8eh94ZL3mGzZvUvtIXIKPP3ff/Wu2r0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WJZxSKgRGaYojFqnI5Xw3j6lv7JhY7L98wi+C+a1WMBbFsFJ1H7l3zaqGAqDdwzS+
         IleJy4AsqgKVCCRwk1Z3sp72pXPeTTQnrtzW+RPNrizfomALb5atfy2nZg/rLhKuB/
         gW1K0myY7rh//GXDX4NPFFfZSpExnTWLiXIRYz3KEottrfk+4LNZ+X55vjxQMm2FiU
         YAprcp304ebdB5zm43yXtykwrFoaoT8qBblOSPgbW7jMLt6GcYNyjIUFb8gXrjQW9S
         lmVaXl202s2MrcE5HvT8Lte0ENIrNQpUTz4svtsy/QXoGzGWOJtVxZ2ZOsSK8B2Vd9
         cjCJeZmPJaUgQ==
Received: by mail-wm1-f53.google.com with SMTP id n4-20020a05600c4f84b029013151278decso3344707wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 08:26:06 -0700 (PDT)
X-Gm-Message-State: AOAM531qsLdgD2ToZOVJjJHbIgUa5fNRK8H26IS/U9XJHY3FXfKyU6IQ
        WGEUQRu5DsN86vGWFBPPwMYfmzm4Um9im0MirEY=
X-Google-Smtp-Source: ABdhPJw0ywSPUuI3ypsEpkKqT93BmtVIDmqQz9BrkPsEzaNRiU2utOqsHbURvWDUj66X33ir670K0POBCVRbOl/79Mk=
X-Received: by 2002:a7b:c344:: with SMTP id l4mr610378wmj.120.1619105165273;
 Thu, 22 Apr 2021 08:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210422133219.1689027-1-arnd@kernel.org> <20210422151740.GI1981@kadam>
In-Reply-To: <20210422151740.GI1981@kadam>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 22 Apr 2021 17:25:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0mMFesdg14s2WjL7txpryev7Jm0VN1Uy3c9vTDOybqaQ@mail.gmail.com>
Message-ID: <CAK8P3a0mMFesdg14s2WjL7txpryev7Jm0VN1Uy3c9vTDOybqaQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: avoid bogus gcc warning
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Apr 22, 2021 at 5:19 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Thu, Apr 22, 2021 at 03:32:04PM +0200, Arnd Bergmann wrote:
> > @@ -762,7 +764,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
> >               }
> >
> >       }
> > -
>
> Since you're going to need to redo this, then please don't do this
> unrelated whitespace change.
>
> > +#if 1
>
> These seems unintetional?
>

Indeed, both (and another removed line) are artifacts from debugging
that ended up making it into the commit by accident. Sending v2 now.

       Arnd
