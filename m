Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331A637B0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhEKVdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:33:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C91FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:32:36 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r5so18458113ilb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+TJg+0/9pABZPSabpkrea7O7U//MsFONQgkQBi6BTw=;
        b=buiziFfdfvpmvShdxDF5Crg/pVdWp/os0vfpz7535C/gAGXFnJeRGPdiRTHp0678Nn
         Ib1jE3qnNpJvwWU9yPEGaPdFmwW77OA/+zxGfnAe66p6B6GAcUikG13vgtRsUEDicD5G
         MqO1NvnbHvRIbi4Y7gwo5Gbr98WjO34QcCR1m653m7rl9vZLPgwqeLSwiFjeJuv/7gqB
         8HCH+anKhjIW7t2ATCYE6A0FyQq7ldfWQsGuEwcwqfinbBkeloyNyOnYCHkCdXXazJvf
         +xbzYS1mx3G4uN7VuXqWYXkvFS4v3jtq0cO2OdHYVL3+SN2dIGHLb92sVP1Kco1hVPhG
         qQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+TJg+0/9pABZPSabpkrea7O7U//MsFONQgkQBi6BTw=;
        b=hy/mTHzty8MXfmGUsIVjOSnCPRo+fGA3MTkfTwktjRkVZHusL2TjsiPoiBzNi49jip
         HZJT0IQf88xRFQHbibL06oVqCjbjW6jiqK72JvbU5CK1lmy/+dbJAqOOzlJHA2qNXqic
         NX9m59Ipu1S3dltWMCA9TqTt/ELK/ybi2377KdJczmENm66qD+x5XKSY1zZH2lp9fQcr
         c5ZuvoJS9fGkOi40Uw1wGOIhQJLWvFGj0fDCdBkgmz+U78I1gVJ1/R8BtPmGoOSofa+w
         /EzMUBkL9tBolzZepHMI8ytNvV0F1EWTHyI+GsUEtJp3Ra8gl8Z9ZcOdoipMuDv55oNe
         t/HA==
X-Gm-Message-State: AOAM5338sgAY/HjNykMoEc1ECAwoxSPdLJ1spyZMkQZD8EZa4SNLUbIb
        nRi1s0Q/jRgVrut3hxK5z2qXWF4IIGH+iXAp2aCgQOw6+wM6rA==
X-Google-Smtp-Source: ABdhPJzEkXua3l0tvs9IifrhkN+V8Rpfn21hL3xuwyXlNUdLwmGKnOBpLAL4+fqPRQohB/0k66fIiYOl6kLTtGOK4KA=
X-Received: by 2002:a92:ab01:: with SMTP id v1mr29562764ilh.190.1620768755533;
 Tue, 11 May 2021 14:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210426220728.1230340-1-ztong0001@gmail.com> <YJlE+Z2VKhamVWaw@kroah.com>
 <CAA5qM4CAdb_Aaay1_gjy_AC48Doxtga0f69E1P36=8vscsR9Eg@mail.gmail.com>
 <YJosRuXcSKiFemC8@kroah.com> <CAA5qM4CWNsjupqOy+-xKuhT7wSK33r5m_VtvxUikkTi+LA8rHA@mail.gmail.com>
 <YJrFib6BD8JcX3DM@kroah.com>
In-Reply-To: <YJrFib6BD8JcX3DM@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 11 May 2021 14:32:24 -0700
Message-ID: <CAA5qM4BXfW-gyoUJ3FraZFqmG576Bx0g1Atm__a2oqzBwH=-Gg@mail.gmail.com>
Subject: Re: [PATCH] misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:57 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I suggest, again, steping back up and just not calling this function if
> you are on the root, as it does not make any sense to do so for a device
> that is not there.
>
Agreed.
I did a revision based on your suggestion and sent it as v2.
Thanks,
- Tong

> thanks,
>
> greg k-h
