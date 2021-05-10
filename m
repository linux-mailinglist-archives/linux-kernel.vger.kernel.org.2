Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A0D3797CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEJTkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhEJTkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:40:31 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF35C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:39:26 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so5340580otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yhUDh0e/b1anVljhcDa1wrhOJB/6Woz50CPB1HWEqNY=;
        b=iqUDDZdxsLd4gJtcv46uxXc7l+exDvo44LnhOseIIeRVeyzDH70gnu3P0u32q4CltC
         cB8mSs8aSrvVEKc0YGZ+MJFuD4YvNjL66gfitw+3GprIT1kgmf98TUDglHMyyiqoLLDf
         zBbzdt2eZxVI8GjeMHWqx3FlSd/7mbYxt9GZqZ4Cv2FXs6q3zc/sS4NI8bUJPxpBxhmo
         fQb7P6xKjENsSqr+1NK42vVV0P4f2/gHX59Db6NMmrSlx8ERx+qDUoUfwctqHw1oHzh4
         l5A+H9p53VMz7HkrmO9aLEKuULb4cpTxzIwaYGuP16/YD6eP5+0VocrcqJThZ8EHOZZF
         KSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yhUDh0e/b1anVljhcDa1wrhOJB/6Woz50CPB1HWEqNY=;
        b=JHUs4+9sChk0GM9a+tDu3AO7CyuBFKZG/VstQjWSmJ+sKM58014HV2kXTDuNSh51s1
         DQLkr3suEjFa/e4hebTZFhkq21ljjK9+BIOHcgdf5YbmHauXp4QCI0yzWLWVzhY5KxJZ
         +qE41fJ4O013WWxcUDS4Zv3mZS+Dwb1P4+I2U46AdITki0WGUCt/EAIINUYkyXiLqc6V
         IIIhGn4qVxic7HYiaAbSLK8IfgPpPSLsw6JpgqbjjgL3qEAFayz9OscO112dqxjMwEY7
         poZlpacCYW8+4fxRx1W+5yVeF/XnqbiXYmHkW9fX7JPs9H5a2kAY2TkegRvVSvgJYre/
         6EUg==
X-Gm-Message-State: AOAM5319+TCTWFjruQJaLlAwnICcrYNkLmDcC9UaVTLrgfYMHPOrgp1x
        0WcaPd9x3P28Y9MzJWagVLd+rOpmrqg=
X-Google-Smtp-Source: ABdhPJxyDthWghhbwT622y8PXKBsHrntpRrVnKxGY3Da0kcUi0sPPtnCX2Lv5pNr5aGZ3dFeQJWedQ==
X-Received: by 2002:a9d:73d7:: with SMTP id m23mr22948588otk.325.1620675565857;
        Mon, 10 May 2021 12:39:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15sm286807otp.20.2021.05.10.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 12:39:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 May 2021 12:39:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13-rc1
Message-ID: <20210510193924.GA3929105@roeck-us.net>
References: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
 <20210510025414.GA2041281@roeck-us.net>
 <CAHk-=wjsQz-RJzXPu6eeZE+R9m2SH6JoreV6e_mwguitZ5_=zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjsQz-RJzXPu6eeZE+R9m2SH6JoreV6e_mwguitZ5_=zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 12:01:00PM -0700, Linus Torvalds wrote:
> On Sun, May 9, 2021 at 7:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Qemu test results:
> >         total: 462 pass: 460 fail: 2
> > Failed tests:
> >         arm:raspi2:multi_v7_defconfig:net,usb:bcm2836-rpi-2-b:initrd
> >         arm:raspi2:multi_v7_defconfig:sd:net,usb:bcm2836-rpi-2-b:rootfs
> >
> > The raspi2 problem (a crash in of_clk_add_hw_provider) is well known.
> > It was introduced with commit 6579c8d97ad7 ("clk: Mark fwnodes when
> > their clock provider is added"). Unfortunately it appears that there
> > is still no agreement on how to fix it.
> 
> Hmm. I see
> 
>     https://lore.kernel.org/linux-acpi/20210426065618.588144-1-tudor.ambarus@microchip.com/
> 
> and don't see any objections to that version.
> 
> Does that fix it for you too?
> 

Yes, it does. It was submitted ~2 weeks ago, so I have no idea what its
status might be (it is not in the most recent -next). I just sent a
Tested-by:, figuring that it can't hurt.

Guenter
