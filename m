Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C249339F4C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhFHLSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:18:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58774 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhFHLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:18:20 -0400
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lqZic-0008Ay-NF
        for linux-kernel@vger.kernel.org; Tue, 08 Jun 2021 11:16:26 +0000
Received: by mail-oo1-f69.google.com with SMTP id n62-20020a4a53410000b0290246a4799849so12478962oob.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fsvskcwT6SL9LDQeWmhuuxMe+eVOopTvyaBeF6nBAk=;
        b=AWb3gQdClzJk4c4euuaca0vtD8bc38CYBkBy2ZbYdlH3cGLxhs3JgL8fCrWzRZ/oNn
         /yV91e124kKT6PDCQiQ0MJ8QmxHfOcZdkgoqcUD9vukZOB6QdXOduzKSC9Z4Dw2EVrmg
         CeuIeetBlXdR9D3DHnshmj7qMtffirjvXevR8pckkko+B2fci7HBTdNmEZHiaISRXJQy
         h6HDvsKlCCG7B4qtGnLwHEFANmrsN3bmj/HZIcXb4CRCQPcRgMHi1a+8QoL+KyiQhGGk
         rHJK2ZhPaxSuO8o0REMFP8zDOpTcZ4XR8cbP4utNRgAhNyqTdc/j5LEdedAi6pz13QR5
         t8kg==
X-Gm-Message-State: AOAM533vQnSiZs8kMafhsxlodwyDyJFJd4MiXyLRclmv88uSynUIzYuv
        1N2cHUvH84p5a8TOEzdqHvXJTJ5Jn9+BUOnrcz6h7WUIedxBADg4WnKJfwksmGKtvxwS4vwkITF
        lhOqHvdgPsgRfWM5EBuaamVbiDvDf3dHsFlxyKs4OgkC3w7tE1emY3eHvyw==
X-Received: by 2002:a05:6808:142:: with SMTP id h2mr2377053oie.169.1623150985701;
        Tue, 08 Jun 2021 04:16:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqGM8lo5LSg/8OXL4XOHF5hygUOIjMJ0SZEvncHtzhQL5DXZc+kFC42Pfi97IPu1rEr8BeQseXZfnLtWpV3Ms=
X-Received: by 2002:a05:6808:142:: with SMTP id h2mr2377037oie.169.1623150985425;
 Tue, 08 Jun 2021 04:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210607101634.4948-1-ricky_wu@realtek.com> <CABTNMG1yoYPgs0gr1bHsrxCmpNM8fUB+3S5E+HS7c9pPGiFxrQ@mail.gmail.com>
 <YL8xYRwKfA5EtSqT@kroah.com>
In-Reply-To: <YL8xYRwKfA5EtSqT@kroah.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Tue, 8 Jun 2021 19:16:14 +0800
Message-ID: <CABTNMG2HZD52DmQ8iqC1jqLf6v4QpqCyxOXgjMjzD7rySgGa7A@mail.gmail.com>
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

On Tue, Jun 8, 2021 at 4:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 08, 2021 at 11:43:03AM +0800, Chris Chiu wrote:
> > On Mon, Jun 7, 2021 at 6:16 PM <ricky_wu@realtek.com> wrote:
> > >
> > > From: Ricky Wu <ricky_wu@realtek.com>
> > >
> > > aspm (Active State Power Management)
> > > rtsx_comm_set_aspm: this function is for driver to make sure
> > > not enter power saving when processing of init and card_detcct
> > > ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250
> > > Change back to use original way to control aspm
> > > ASPM_MODE_REG: 5227A 524A 5250A 5260 5261 5228
> > > Keep the new way to control aspm
> > >
> > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > ---
> > Reported-by: Chris Chiu <chris.chiu@canonical.com>
>
> Can you test this to verify it works?
>
> thanks,
>
> greg k-h

It's verified and confirmed by the user at comment #17 of
https://bugs.launchpad.net/bugs/1929444.
