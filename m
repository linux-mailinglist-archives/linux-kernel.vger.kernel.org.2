Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270713A9490
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhFPIAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhFPIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:00:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C34C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:58:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l9so708381wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ffX+rO4NU79OrIv37Fic6T6B6n82nghu+Qcor+9aKQ=;
        b=khEMvz/xpNC7eciELINDeN7LKTuzFSUcTHzlZHA7x8Or4GgRSU9TX6jMGAgtM6NyHI
         8Uxt0uqgbdzb68N7iq3qm0d5LEJrEWMwxkt0lfdjCx2Ehj9IN6fqLvcK7zgoIc6vYZEk
         dSkCjga5oRMigy2mGyOKFiNbmBZcSWdza6xyrTJ2lAaaqaTcgBboNTttxZLb8TXqV6qq
         YsQT7tSPgMVKaEaSKx2DUaQY2S1KQBGIGE1YEjBuuvWPyp/kX5hupMpHkIPSkAHF0kap
         keiSMCiZys2NF4mfDKKYlem9SxGvc9VJxQ675dR6Cs2KAkfb+igAJLJPVbOIpcLIo5Tk
         ecIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ffX+rO4NU79OrIv37Fic6T6B6n82nghu+Qcor+9aKQ=;
        b=lukt73dP7V1yNpeknu2dbwaDTRDBWdMwTyy25aIVURXBauyDdFaASy1dOfkcBpJkWg
         qy8botdaK5nHfDQ3Bq4eQmWV/osSQOSaTEUt68k+JgU7oMCTyHoDqjtR91RTzmTXf8pH
         21DvwTxY8LkUGHImuQvWW7jI0SFNQovW8j/J32JG6UUGE2QMt2BDOzC+NNsC/VYszLmf
         Ll4H10f0UYalwX76L/0rKYji7Y3pzcVVOBcyrmmHdY8N6EUQsXSmMCZK6KAx4Myqvxss
         C/SP8Xhtb4KxDxLBJG5wPJww6HBTtMbTfQ6HYRj4Qm0QotKYCsgxdbPZ+OBRxu6Eemb/
         iH7Q==
X-Gm-Message-State: AOAM5321Qtc81oOnuGccO1fUldVGlIZ+I5TZ6b1GbkmBALBw0lAjtumN
        jNO0e09OcJdiShaahfXrhrewYQ==
X-Google-Smtp-Source: ABdhPJyh7SCmM/AkMVqOKuJVpTeverxMXB77brs8CerM8SErrcYCOWXGFs/nKybnXJblsyPyVwkXDA==
X-Received: by 2002:a1c:de8a:: with SMTP id v132mr2511044wmg.27.1623830320831;
        Wed, 16 Jun 2021 00:58:40 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r3sm1059528wmq.8.2021.06.16.00.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:58:39 -0700 (PDT)
Date:   Wed, 16 Jun 2021 08:58:37 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/7] Fixup unused variables and warnings
Message-ID: <YMmvLfJmoso0xWdJ@equinox>
References: <20210615223607.13863-1-phil@philpotter.co.uk>
 <YMmnKSWJNIk/XJR7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMmnKSWJNIk/XJR7@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:24:25AM +0200, Greg KH wrote:
> On Tue, Jun 15, 2021 at 11:36:00PM +0100, Phillip Potter wrote:
> > This series fixes an empty goto label by removing it and converting its
> > associated goto to a return. It also changes a decrement operator to
> > prefix to make it clearer, and provide expected behaviour. Finally, it
> > removes a lot of unused variables warned about by the kernel test robot,
> > which are a result of my previous DBG_88E removal series, and removes an
> > entire function as well which is surplus to requirements.
> > 
> > Phillip Potter (7):
> >   staging: rtl8188eu: remove empty label from
> >     mlmeext_joinbss_event_callback
> >   staging: rtl8188eu: use prefix decrement operator on trycnt variable
> >   staging: rtl8188eu: remove unused variables from core/rtw_efuse.c
> >   staging: rtl8188eu: remove unused variables from core/rtw_mlme_ext.c
> >   staging: rtl8188eu: remove unused variable from os_dep/ioctl_linux.c
> >   staging: rtl8188eu: remove unused variables from hal/rtl8188e_cmd.c
> >   staging: rtl8188eu: remove _dbg_dump_tx_info function
> 
> In the future, can you use "staging: rtl8188eu:" on the prefix of your
> 0/X email so these can be caught easier by those of us who filter on
> stuff like this?
> 
> And thanks for fixing these so quickly, I'll go apply them now.
> 
> thanks,
> 
> greg k-h

Dear Greg,

Yes, absolutely, my apologies. I don't know why I wasn't doing this
already, seems obvious in hindsight - I put it down to my brain
malfunctioning :-) Many thanks for taking the patches.

Regards,
Phil
