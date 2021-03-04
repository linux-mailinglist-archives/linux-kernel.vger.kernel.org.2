Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38DD32DA1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhCDTLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhCDTLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:11:21 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BDBC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 11:10:40 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id t23so15193283vsk.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 11:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhbazE44Fq5VfyWjKwf9zuQsAn8On7g+SsZ62Ovv5F8=;
        b=C+c/9+vwbzsfKbij8AjOmUq58ukoKryzZ43Oi4y+MSpEXBwS2iKiuF+8DoMQ+gzvEP
         J4mgYFdtljDghVEszECgjhT1F+i0bS/c/Jz8FGOfU9RvZcFXCjjeVCiYP5J440IBAC+Q
         ztcBQwtSlOe8xzxT8QjD/N7PtwkjqCCJ37ZG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhbazE44Fq5VfyWjKwf9zuQsAn8On7g+SsZ62Ovv5F8=;
        b=Z+/w5TVPBM6bti0T2pkfgAZFG69IPJWeIFqlge3CGEAoPFxufcxgcpDHdi/8MnhfWA
         YZKyMMlAeSzG2Wf/mcM9+fL1b9JeNeM9V/Q3Bh07QI6w9TzDJJXH4NYexhOimni6mADk
         lklkQ37F6mIYbtrpIqFOwSQkiuyDWi2mztCsbEvLTyReU6exVqQaYXk3DHuaswVSqrXs
         tPDZbk8XV9o/DMhoS4+2wbDxmbBVOczQ0eXloNLcIH75j11amw5oio8BOYiBBmCbL3Oj
         Y4dpKOWsjWuNxLEJBkxTMPBYKGsxO7IuhhUNPZE19QxgQJOa8vroRBXNdF62WIoUovTI
         7Mow==
X-Gm-Message-State: AOAM533RTgagR9YCOMGj3Ut8KLXFz6ftNUMAqkZEPl9cFZIz8gsb4lqn
        p8ON+UZKCeJfKBegsP/RyxokgVZ/qJK8rtoKlH53Bw==
X-Google-Smtp-Source: ABdhPJzOfYmlSd897wkaIlC3GKlPTrkwUgr/BtnE3lesEsza2dlfKCvpLHqpP58/+PghdbiU/GxyNp1kUjFuDYhiKL0=
X-Received: by 2002:a05:6102:ac2:: with SMTP id m2mr3757112vsh.52.1614885039545;
 Thu, 04 Mar 2021 11:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20210120011208.3768105-1-grundler@chromium.org>
 <0a5e1dad04494f16869b44b8457f0980@realtek.com> <20210120090438.0f5bba6e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210120090438.0f5bba6e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Thu, 4 Mar 2021 19:10:28 +0000
Message-ID: <CANEJEGuBe3pN_erZZhNjfS+zP-qQnz=TaNO2jWkGhD3jUx0fOg@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: cdc_ncm: don't spew notifications
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Hayes Wang <hayeswang@realtek.com>,
        Grant Grundler <grundler@chromium.org>,
        Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        nic_swsd <nic_swsd@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 5:04 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 20 Jan 2021 03:38:32 +0000 Hayes Wang wrote:
> > Grant Grundler <grundler@chromium.org>
> > > Sent: Wednesday, January 20, 2021 9:12 AM
> > > Subject: [PATCH net] net: usb: cdc_ncm: don't spew notifications
> > >
> > > RTL8156 sends notifications about every 32ms.
> > > Only display/log notifications when something changes.
> > >
> > > This issue has been reported by others:
> > >     https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1832472
> > >     https://lkml.org/lkml/2020/8/27/1083
> > >
> > > Chrome OS cannot support RTL8156 until this is fixed.
> > >
> > > Signed-off-by: Grant Grundler <grundler@chromium.org>
> >
> > Reviewed-by: Hayes Wang <hayeswang@realtek.com>
>
> Applied, thanks!
>
> net should be merged back into net-next by the end of the day, so
> if the other patches depend on this one to apply cleanly please keep
> an eye and post after that happens. If there is no conflict you can
> just post them with [PATCH net-next] now.

Jakub, sorry, I "dropped the ball" on this one. I'll repost with
"net-next" a bit later today.

cheers,
grant
