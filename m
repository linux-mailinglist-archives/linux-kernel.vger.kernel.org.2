Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20A73A0A65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhFIDEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:04:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54314 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhFIDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:04:01 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lqoTm-0002bm-Bm
        for linux-kernel@vger.kernel.org; Wed, 09 Jun 2021 03:02:06 +0000
Received: by mail-ot1-f70.google.com with SMTP id 88-20020a9d06e10000b029030513a66c79so15313872otx.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 20:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osdcSd2Q78FCh6r+gYatJ/VUJ3sKYNx//NpfCylf+fw=;
        b=O5SrC8Kd1vGHXLmSqfIpkA+kRv8VelppxJ29JHaVPyY3xgHCKdATFui4AHY3uNdBXF
         V2qP4Xn1+HMVidH/71trei4MZ/9KhfDHRKpgAOzBx5zaxw+M6lyOcCoY7gV7cnjy15Cj
         oMUjdFeToCzx17fHKtxKqWuurkNC4DW1EpLCsoklD9TuVBg5qwusbnduPYVc58thKgQo
         qiUT7SBxvDiTnP602Vfp7zLwNMEzgfqy0U733TevlOzDadyQp3sUmp7STh6vFqc050Ec
         JDPkn8L8ZHsyzkIzzOBZ7hLXBdo+73VcwfbvkJFIx5W+Qs27KHsr/NzyyFBcLjH9JPpM
         3LRA==
X-Gm-Message-State: AOAM5335LLRrNGdSor35AJYqNAGTY3lo58yrATj260wYneysIvmoGebV
        DYjkrd0qllF+T0dkyf1Dz8GI+1fKpUcndB4lZjptb9SffcwZmqxenaR5h6WMV2Olu+bjcI+SC4v
        EO52HG7KgRCjM/TlB/CozXnGLurUyMk+RhFS88rsg4j+FeP2/NdJk3WHzFw==
X-Received: by 2002:aca:b145:: with SMTP id a66mr4822394oif.177.1623207724755;
        Tue, 08 Jun 2021 20:02:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJp++dl7koAn2rc73UkETAsZNAzXDNAz4T0lAt/DBfYnwtVXKFUzzKMs0sLmZPKqJN2zfpXb4+gVDF2Vbnnfw=
X-Received: by 2002:aca:b145:: with SMTP id a66mr4822360oif.177.1623207724445;
 Tue, 08 Jun 2021 20:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210607101634.4948-1-ricky_wu@realtek.com> <CABTNMG1yoYPgs0gr1bHsrxCmpNM8fUB+3S5E+HS7c9pPGiFxrQ@mail.gmail.com>
 <YL8xYRwKfA5EtSqT@kroah.com> <CABTNMG2HZD52DmQ8iqC1jqLf6v4QpqCyxOXgjMjzD7rySgGa7A@mail.gmail.com>
 <YL9t/ZfRsIMSpXfm@kroah.com>
In-Reply-To: <YL9t/ZfRsIMSpXfm@kroah.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Wed, 9 Jun 2021 11:01:53 +0800
Message-ID: <CABTNMG0PfX=eC0=hyUexoomH83NYzePwVkf4P0FLE05=wSyssQ@mail.gmail.com>
Subject: Re: [PATCH v2] misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ricky WU <ricky_wu@realtek.com>, arnd@arndb.de,
        Bjorn Helgaas <bhelgaas@google.com>, ulf.hansson@linaro.org,
        rui_feng@realsil.com.cn, vaibhavgupta40@gmail.com,
        yang.lee@linux.alibaba.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 9:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 08, 2021 at 07:16:14PM +0800, Chris Chiu wrote:
> > On Tue, Jun 8, 2021 at 4:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 08, 2021 at 11:43:03AM +0800, Chris Chiu wrote:
> > > > On Mon, Jun 7, 2021 at 6:16 PM <ricky_wu@realtek.com> wrote:
> > > > >
> > > > > From: Ricky Wu <ricky_wu@realtek.com>
> > > > >
> > > > > aspm (Active State Power Management)
> > > > > rtsx_comm_set_aspm: this function is for driver to make sure
> > > > > not enter power saving when processing of init and card_detcct
> > > > > ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250
> > > > > Change back to use original way to control aspm
> > > > > ASPM_MODE_REG: 5227A 524A 5250A 5260 5261 5228
> > > > > Keep the new way to control aspm
> > > > >
> > > > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > > > ---
> > > > Reported-by: Chris Chiu <chris.chiu@canonical.com>

Tested-by: Gordon Lack <gordon.lack@dsl.pipex.com>
Fixes: 121e9c6b5c4c ("misc: rtsx: modify and fix init_hw function")

> > >
> > > Can you test this to verify it works?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > It's verified and confirmed by the user at comment #17 of
> > https://bugs.launchpad.net/bugs/1929444.
>
> That's not useful to put in a changelog text.  Please respond with a
> real tag that I can use.
>
> thanks,
>
> greg k-h
