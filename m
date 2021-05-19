Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7081388B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbhESKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346420AbhESKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:03:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55313C061763
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 03:02:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so3222924pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7etUJcy4Y/9kkJXKM1wnyfHQolxKQ1AcioEGekKUcRQ=;
        b=EWqCOmbCjo6LwdSgsf5Zi53/+iBmUhLvLcVcXVf9DLyTKj2dQNCudvOA9ijXzBJZag
         foSwnFiU0epUQXNm50yaQJai/dahSJGCCMjBWR4dY9ZDbTF1GW56UxtY6W7IuWhzlTgS
         KmlYV4twUxy1oHAddLZ1dg7Qvg52z8NIJPqyb2j1Y3lm4qOpP1Sz1hSkX2mZbkN9tTxl
         GjdI+GIWBIiKoY8/SF3maNxphM0xrAVVbpmka8ahE7eGCdKy3zdp8w8TJjU9jQqIvbBG
         I6NF571XJrj4cOaOiqyzO9+UlvKTWyvdVe7l05m4WTv/I2j+SOY19ao7oYJ9ewmkpz2v
         7j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7etUJcy4Y/9kkJXKM1wnyfHQolxKQ1AcioEGekKUcRQ=;
        b=V4yX/AeV24yfKFPJklDn4UVZbPNlQEZG8FVRErqdFhDpPp4L3tUiwKbsdhKwb9wmen
         Aco1tGmPe3Qb7+zqD4re+3SnIRogSaBLHFTq0wVqxJhMHRtFTcobuA3KPDcUPJmIqvK1
         HJ7IFbXwqYaj/Kvq2VlmcP3D7H/2khOEhAoymrHNK2FWK1q2yCqdDZe7geyaqUCQ24Xr
         phmcS93pg5XCRUzwME5o9TmtpOFyv09mSJq5hJuz0acRll+eXik1kgOVWCJ/em0YWK66
         vILppKRH381cGtLfHqH5QuNh6ip6THnaEL5TiAeJtHN6zAeS7PUXA/Ar/XIYoeStCmcL
         rL1w==
X-Gm-Message-State: AOAM533WdM09Z5Wp0ITa7Th5V2gwnAL1zGyBeU1r8R8aLSrVWWebakmP
        cu3tV04b1cph1ZHrIqnRVBwSQw==
X-Google-Smtp-Source: ABdhPJzU2v6WLyXV3Auv4qGF892obiscIiBdeZGaieH6kNnsCItvnioyiaXRYUE9BtHcS4F+6pmRNA==
X-Received: by 2002:a17:90a:e2ca:: with SMTP id fr10mr10731258pjb.6.1621418557740;
        Wed, 19 May 2021 03:02:37 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:9384:8c4b:dc2b:c4d0])
        by smtp.gmail.com with ESMTPSA id d12sm13692185pfv.190.2021.05.19.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 03:02:37 -0700 (PDT)
Date:   Wed, 19 May 2021 03:02:35 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dario Binacchi <dariobin@libero.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 1/2] pinctrl: core: configure pinmux from pins debug file
Message-ID: <20210519100235.GA3063522@x1>
References: <20210516135531.2203-1-dariobin@libero.it>
 <20210516135531.2203-2-dariobin@libero.it>
 <CAHp75Vd8875hRNk1JK6gkmfxjqxBSu4cRNE1zJt9TyEW7TvsMg@mail.gmail.com>
 <1735504854.166374.1621346262270@mail1.libero.it>
 <CAHp75VeADiRKdfnsXQ=y3z1WAJBbtZ+P=8tdyYtVQpJrSrQ63Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeADiRKdfnsXQ=y3z1WAJBbtZ+P=8tdyYtVQpJrSrQ63Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 05:01:30PM +0300, Andy Shevchenko wrote:
> On Tue, May 18, 2021 at 4:57 PM Dario Binacchi <dariobin@libero.it> wrote:
> > > Il 17/05/2021 22:02 Andy Shevchenko <andy.shevchenko@gmail.com> ha scritto:
> > > On Sun, May 16, 2021 at 7:43 PM Dario Binacchi <dariobin@libero.it> wrote:
> 
> ...
> 
> > > Can't you use strncpy_from_user() ?
> >
> > Ok, I'll use strncpy_from_user() in the next version of the patch
> 
> Don't be in a hurry.
> 
> We need to settle down the interface first. We still haven't heard
> from the maintainer (Linus?) about it. Neither we have a clear view if
> we need to revert that patch that dropped pinconf-config (Drew, what
> do you think?).

Vladimir Zapolskiy wrote in e73339037f6b ("pinctrl: remove unused
'pinconf-config' debugfs interface"):
    
    Of course it might be possible to increase MAX_NAME_LEN, and then add
    .pin_config_dbg_parse_modify callbacks to the drivers, but the whole
    idea of such a limited debug option looks inviable. A more flexible
    way to functionally substitute the original approach is to implicitly
    or explicitly use pinctrl_select_state() function whenever needed.

This makes me think it is not a good idea to bring back pinconf-config.
The pinmux-select debugfs file that I add added in commit 6199f6becc86
("pinctrl: pinmux: Add pinmux-select debugfs file") provides a method to
activate a pin function and pin group which I think provides the same
capability as long as the possible pin functions are described in dts.

thanks,
drew

