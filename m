Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AAE337404
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhCKNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbhCKNb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:31:29 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:31:28 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u16so1890595wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8fqycGuwMj3qUEx2mHcKX8YCe1sX+HnS0aurfvFRSrQ=;
        b=NvVlC7gsp9HeGKQfhn0jk48FchuwcestkTzi9kQhoPDhxTO0gHPL07xuHmOB1MjdT4
         WC/xMZunwaAvbwr1wD4WVJ5SEy0SzEoRROwXCHuyWu9iCzOYbxrL/50arqXljoLcmDrl
         R9sEt7NEs74tPONAU56ePaR26EWgqj0Aym6pbcm5BUbNvBrA8w+PU5XSNRDP3ryeqCen
         39Cq9Iz7xRbjwWjqEyeySAvArvcgpj1eS1qvUdRvXPEP5No/EyvRIMEDOci4yDnkBEqO
         u363NbmSoYTYEaVORSVxFE7NlCkv6MVzCfncsvl4CYvEsuD+utMqUgY8SxBuqRs9RFOH
         tUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8fqycGuwMj3qUEx2mHcKX8YCe1sX+HnS0aurfvFRSrQ=;
        b=RL/kxACDscLq66ERfpsCD8oQJy3C0hugblRmBJhErSKH1Q4wbqoeoqURvsl+92nvol
         atH6/j1e4QwAqBsQmfGEagllQQtYKmPPvRiZBid6T0AkbOypf5mRDRIogbqMvYqxhJhc
         Gonwo/b4HY1yC98MZZtByUKpVtX/BgAMliNt69DheP/wT39Ff9varq4jE2Za+5JscVyp
         XVsAVEE04a4F6XH8l0gC5Wyw32S+8OPDR6iSOLzm8yWRpgpcrgj91VxoSxcYsgo5zTrm
         k6lKj19ilE3gpQE2bDVDkGndyjunTBEVH7RfsfRgpwdD0eu1VJbW48nhNF4Uc62+BftI
         qACQ==
X-Gm-Message-State: AOAM5315FakjpYQe0Ee6Bvx2xZuLHRSiluZisBs7cXBS9Fg3lP9poeQB
        vo9WK+ysNTF+WyRK20W1FBU=
X-Google-Smtp-Source: ABdhPJyVw4w02f/ZDSsPRoxRDAJ8A2n21HYsLQojVHnpaBv/r5b8mjc+ZQ97VQ4axHukogpagPn1Gg==
X-Received: by 2002:a5d:5104:: with SMTP id s4mr9209630wrt.62.1615469487215;
        Thu, 11 Mar 2021 05:31:27 -0800 (PST)
Received: from agape.jhs ([151.44.221.127])
        by smtp.gmail.com with ESMTPSA id k12sm4053656wrx.7.2021.03.11.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 05:31:26 -0800 (PST)
Date:   Thu, 11 Mar 2021 14:31:24 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: align comments
Message-ID: <20210311133122.GA1701@agape.jhs>
References: <20210310153717.GA5741@agape.jhs>
 <YEjrEErDZTH47gto@kroah.com>
 <20210310160946.GA6421@agape.jhs>
 <CANiq72mEdHhJoCEmD0DD7QGP57soF3DGGoFNb89WF-4Oh_sscg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mEdHhJoCEmD0DD7QGP57soF3DGGoFNb89WF-4Oh_sscg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:03:57AM +0100, Miguel Ojeda wrote:
> On Wed, Mar 10, 2021 at 11:00 PM Fabio Aiuto <fabioaiuto83@gmail.com> wrote:
> >
> > I am sorry, I fear I don't understand, checkpatch.sh script says the patch is ok.
> > Where have I to add a ' ' (a blank?)?
> 
> Please take a look at Documentation/process/coding-style.rst (comments
> are also described there).
> 
> HTH,
> 
> Cheers,
> Miguel

Thank you Miguel,

fabio
