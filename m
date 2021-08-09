Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66743E45E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhHIMr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhHIMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:47:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA8BC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 05:47:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oa17so2860125pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfxA3gsDaSxEy+9iphVwy0TG0m80l5lpwxz/GBrg+rc=;
        b=I2AyBSnrOnAp3FztkDuPcA97Qu0X62TuDZ0TF6q1uSrGf5IF2cOl8lhJh1ibFeslpA
         RVTDGqZd2Yv3sDAdqrhc7RfrAEqme6FgPdkp4Le5dJmuV/M/aReargMiuZPIItFbHKXg
         uLaoYG0yXrpZq8l/sMR2dX2fKn8vVfboLe/0KcYJFwd/tsTaOzWi+7EZhYYpTNcJEit5
         MB5Dti1JxnWPUIGeGv9yj/Q3+LcyGH5zWMFFWHAD9X0VIT3THSJ7cxkLwaL494GsPiCZ
         5vthBTiJXikrk/MGoYy3Bt/GpxwI/vQ9kMU6cc/Ptpat1anZ44MtMpbovHLZ794J76dC
         bzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfxA3gsDaSxEy+9iphVwy0TG0m80l5lpwxz/GBrg+rc=;
        b=kygqVcAeTBtPle4wYargEN69mY/Q2mONt+s789tfWGW7Pf8DbiwJRLPve2Qn/RnAWj
         8QpptiWlfWlHXnbe8zqEZFmbQeGUVY1NXnrCzKnekw7RMP9tuTSVw7Jccq/UDVK/yeXb
         PpJLoMEpRtyIvhvP2ACEqXkyMAI/R41j0UqqXs40db6NmSoxzr2CnAfWK3FcEohNoSxY
         ZOIiMveVJgirqcvF2Dr1T2eUzTYCtoE4ICtqVxV7rQYih5sNd/IPCJOvjuvTmBX8BOeP
         wzmFpHfsIeUoKHf+WdXZzy0+pr9vWNgWqP9pkLAPiWBtu0h7ld7PjECni8EU3O/59Aug
         fN/Q==
X-Gm-Message-State: AOAM5310s0xn7rchKE1mHj4h7boQUlLZ3Id+Rc1xKQ5T2JWDipw+2R6M
        PdYvnkUnENBb8Pgn5GCh8pR1X6hkC0nfvSuAmW0Q7Q==
X-Google-Smtp-Source: ABdhPJzDDcbPRdekHKX6UqgUOmND4RS/UrPR2vnOZz/atF4ytAKymvy0xMoLFf3gUQbyiE+PVZYmDInUjmlS+mNnCVs=
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id
 h4-20020a170902f704b029011acdee0490mr20209906plo.37.1628513226407; Mon, 09
 Aug 2021 05:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210802233339.25285-1-broonie@kernel.org> <CAA=Fs0k95E3FN-9rwzSQcK4JmejHDKBbvk-yhRynJBTbqBNVxQ@mail.gmail.com>
 <CAK8P3a0HWO1tPwCkhasRE1iXt+-rC72nAzsUuO6jb4XasGAAPg@mail.gmail.com> <20210809175502.226ce4cd@elm.ozlabs.ibm.com>
In-Reply-To: <20210809175502.226ce4cd@elm.ozlabs.ibm.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 9 Aug 2021 13:46:55 +0100
Message-ID: <CAA=Fs0nF31NdEoPLM-a2RCupQPtHgHMzxejK67UuLh0wu32EVA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the net-next tree
To:     Stephen Rothwell <sfr@rothwell.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Greg KH <greg@kroah.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 at 08:55, Stephen Rothwell <sfr@rothwell.id.au> wrote:
>
> Hi all,
>
> On Tue, 3 Aug 2021 11:23:29 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Aug 3, 2021 at 10:57 AM Phillip Potter <phil@philpotter.co.uk> wrote:
> > > On Tue, 3 Aug 2021 at 00:33, Mark Brown <broonie@kernel.org> wrote:
> > >
> > > Thank you for your e-mail - not sure what is going on here as the
> > > r8188eu files are totally new - the net-next commit is touching files
> > > from a different directory (rtl8188eu) so perhaps it is getting
> > > confused and considering it a rename or similar? Regardless, all
> > > commits for r8188eu subdirectory should come from staging, as it is a
> > > different driver.
> >
> > In net-next, the .ndo_do_ioctl() callback behaves differently, as it no
> > longer gets called from user space. If you have any
> > SIOCDEVPRIVATE ioctls in the driver, those need to be
> > moved over to the new .ndo_siocdevprivate callback, while any
> > nonstandard ioctl commands outside of that range can just be
> > removed.
>
> So, can that be done in the staging tree as it is, or does Greg need to
> merge (part of) the net-next tree?  Or will someone just supply me with
> a reasonable merge resolution patch?  Or does Greg reset the staging
> tree to 5c872e1d2595 and try again next time?  Or similar for Dave
> (revert Arnd's work)?
>
> Currently it is a mess in linux-next and probably will not work even
> though it does build.
>
> --
> Cheers,
> Stephen Rothwell

Dear Stephen,

Happy to try and provide a merge resolution patch if that is easier?
Will be this evening UK time though.

Regards,
Phil
