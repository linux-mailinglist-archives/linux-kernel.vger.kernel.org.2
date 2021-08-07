Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9FF3E35E0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhHGOYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 10:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhHGOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 10:24:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A73C0613CF;
        Sat,  7 Aug 2021 07:23:45 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id o185so16677945oih.13;
        Sat, 07 Aug 2021 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jwaph56CCDgDdImMiSjf+isqcknlSGb+f675andSZYA=;
        b=k57cIxS8lv6kfxK+Ao03JW8I6wNvrx6/q38Gkusl8n0kne6T2xk8DXpTIGciiLQY7t
         6XWW1JIwmuu43IsCcdDQiGvHjmkRnirnz/MRE2nVVDMVl1xRC9WpSJMVGbRZrKFR2M9v
         ErP2kFPI5nvexb6oO9QHOdGNA7G8QZqO6b5c4By3wS1fic+8yZQLP+2BmLXsJJlKuDhd
         GDxmicm43Wxl15+9e0fc0Rj9W2AEzT8O/yrNe1iEOR3ZX3YJcw0BTgFado+zIY/3FOEN
         yYXMs/JPaScd0qOO5lHfH+XPre6vx82hMsJ3YIFl3nF5/7EreLetlxrMJ4f7yqv8seZN
         +Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jwaph56CCDgDdImMiSjf+isqcknlSGb+f675andSZYA=;
        b=CWTlVKFIyDnYesxPSRCyOBFuDnQm2J+rXArYzfgHKBBhhLmjeVg/ESLuGGp6rTGPYD
         J628TY6Wtihls1Z46hJ3kK1EmRMCzchcif9Whgc9E9wX51Nuk2DVxEbM2H+SvteIKAjZ
         A209GRAXeO55eG7sx5XbmrcOd0Kn/MMx5YoV6v7PR+Iw5cAeXD2uARgfK4X5xHYihPRO
         gIeItlAOtVpXz1knUaoEgp3QFQeobZ4F/hTl5dF6Yur4w/eIT6KvQbQlYL7/UzzlPrDD
         eG1Ie9GA4ktOP1cSmDgv6q617shy2Z5wqOSLCZ7Yrq/CtcC6ericKJ855kWPjjVDe4XM
         yegw==
X-Gm-Message-State: AOAM531H48XNiIvdchx7GGO7c+58D4FdX9qzlXlBzzRFY5qnMrFdc8R2
        2QRURnxDXe8JI3mT3AaOIoZBoygAzkiSevNzX0k=
X-Google-Smtp-Source: ABdhPJz2F0qB+0GScZ8rhgaMKUvpPGJyDphaQUhG5/72eXAptpmpI1/V3WCVllnV/ore2zh5PKh878TDFMKYEVJiNDM=
X-Received: by 2002:aca:4587:: with SMTP id s129mr15109140oia.64.1628346225025;
 Sat, 07 Aug 2021 07:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAPY=qRS0F0iv15w34w13xutoUThbDqFtYniM=eLLmqaMdXya3g@mail.gmail.com>
 <YQTitrc49G7RxYi2@kroah.com>
In-Reply-To: <YQTitrc49G7RxYi2@kroah.com>
From:   Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date:   Sat, 7 Aug 2021 19:53:33 +0530
Message-ID: <CAPY=qRTx+V_P1390b09wyBwMqDOJ2MBH8=5iBgfLCz6t_mBKwQ@mail.gmail.com>
Subject: Re: Embedded USB Debug(EUD) driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 11:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 30, 2021 at 11:33:09PM +0530, Subhashini Rao Beerisetty wrote:
> > Hi All,
> >
> > I'm currently looking for the Embedded USB Debug (EUD) interface driver.
>
> For what specific hardware?  Do you have the needed "special" cable?  We
> have support in the kernel for some types of these cables, what kernel
> versions have you tried that did not work for this?
It's for MSM hardware and yes we have the "special" cable.
I could not find the device driver for this in the mainline tree. It
would be helpful if you could point me to the kernel tree which
supports this feature. We will compile this suggested kernel and
necessary drivers and then will give a try on our hardware

>
> thanks,
>
> greg k-h
