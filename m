Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D237ACF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhEKRSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbhEKRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:18:30 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1CAC061760
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:17:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p11so18855284iob.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1ikXxcqKrSHiqHbTxzG/b3SitTHUqs3FscUloJXfR0=;
        b=h0A/eHVWSfLs2iKG4oXHHlaLsntu794GokKbkIlThVusc6OKHjoxCz0TXmvu9M+bHQ
         0BCDw0BFPt05lkSQbq/PhzYJWu1Wa7bYwiDAziNTMoybxeYuXnnyjA5FESAjXwui1weB
         7JK4oktzP7/cbNL/KaI92yS4BJ2oy6+rn8hOE8FuCQQpIbE7+akpR7HOmbcjbP4s7sOo
         SaY7el/oa3BZAAhXGkdx4nhr97Pv5SyQoDzBhmmrzjLDAyjQGn+PCS71AMmT01JYmJhm
         i2YBnxdUJfZ4gtJoebS3LaGpiDz9gKsVe+WrqUg2tvyfZtwdHnuhxR5PkwpggqEhCxo+
         NcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1ikXxcqKrSHiqHbTxzG/b3SitTHUqs3FscUloJXfR0=;
        b=Ta3q+1M45LFAev0BbBSU2CRiScAfbKz/1ah6Szh8WGpXKH/yrS1HnX8zUA5Vq7Vjzc
         srISQC8cWD0lDMlO+kwPom5nsye9pSnmEdbajVntPfG8yMqLtyKN81V2X65R9kd1jV4f
         V3fPw/j/7AG2o+pPRRHPhwS4FzBhOUCDwZ/2OOvdLcHOX08fmpdI+/lEDC7/Dh1iHFQv
         HDCJdlNvci+4I1ctYOhu2aw0ysa3i+Ud+yMcLIqfP6ltlieCXVLuWOT1f/VaghLReaxj
         ZCnYPcUhCXoVCUnXX0hs4KFYavGv2X4hbbPQktJuHbtBCT4DiHCtoMZ+/aEb5eWsLpi5
         ZC6w==
X-Gm-Message-State: AOAM531yoVc87j7/q8tKiaz+L1q76i95niquZRoxgHsveINGyhcaoL4J
        kUFdxogIEQ07DgWx8izwb4VV51dY5sJW1WgxzKV4/qB2EYECzg==
X-Google-Smtp-Source: ABdhPJy8wJE8JusWiz4Be/4kp5uvb0MYFBhn/psBH+2NbQeijNUEHwFfRq7b60MjOMc1i+07xz4lN1/A/WYzEw9mAhU=
X-Received: by 2002:a02:6d09:: with SMTP id m9mr27964954jac.131.1620753442848;
 Tue, 11 May 2021 10:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210426220728.1230340-1-ztong0001@gmail.com> <YJlE+Z2VKhamVWaw@kroah.com>
 <CAA5qM4CAdb_Aaay1_gjy_AC48Doxtga0f69E1P36=8vscsR9Eg@mail.gmail.com> <YJosRuXcSKiFemC8@kroah.com>
In-Reply-To: <YJosRuXcSKiFemC8@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 11 May 2021 10:17:12 -0700
Message-ID: <CAA5qM4CWNsjupqOy+-xKuhT7wSK33r5m_VtvxUikkTi+LA8rHA@mail.gmail.com>
Subject: Re: [PATCH] misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 12:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 10, 2021 at 03:20:02PM -0700, Tong Zhang wrote:
> > On Mon, May 10, 2021 at 7:36 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Apr 26, 2021 at 06:07:27PM -0400, Tong Zhang wrote:
> > > > the PCI bridge might be NULL, so we'd better check before use it
> > >
> > > I do not understand, how can pci ever be NULL?  There is only 1 way this
> >
> > Hi Greg,
> > I think the problem is with
> >     priv->parent_pdev = pdev->bus->self
> > where bus->self can be NULL. when bus->self is NULL, calling
>
> How can bus->self be NULL?

Hi Greg,
Please correct me if I am wrong,
when bus->self is not NULL, it means there is a bridge,
However, a device can be directly attached to the port on the root
complex. In this case, the bus->self is NULL.

> Did you see this on a real system?  How did you duplicate the error
> listed here?
I did this in QEMU. If QEMU is considered not real, then I haven't
seen an alcor controller configured in this way in a real system.
That being said, this kind of configuration is still legit IMHO.
Best,
- Tong

> thanks,
>
> greg k-h
