Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB93B50E9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 05:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhF0DKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 23:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhF0DKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 23:10:39 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D5C061766
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 20:08:15 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id l16so4423931qkp.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=va7DUf7TkXKN4fGyuUyT1CmYtjFdZYEFkc1gybWvP9A=;
        b=ppJ0df1a19HDyhHqUN5M17coWm4A57ArzQBCgyDxiasYI0xaQXnt6tnd9LtaI6Lj0P
         2EOv1I8I65YQ4LItGEj5PKTQMJ4nwGnTJjVkUY3HgNdLuuFc+rszBENYw8/zipJWnZWg
         409qDuu4bYe33lOMdiX0+1xYMgDlJAnOQ68CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=va7DUf7TkXKN4fGyuUyT1CmYtjFdZYEFkc1gybWvP9A=;
        b=Wt2vz/TyWSjm24Izp0o7M3hKBXsubWVkPLajBN6a/Iplsch9ZLmZavpY3EEsPBfBSV
         V5SOgPSbzxfCb/ZrlErOhy7J0dk9d+26D2RfVZSTvLcy9nEAWir1QeytWiDMy8OK+TyW
         lcZ0EGyhVfEfkhx/U9l1v2Lf1B03h6FNVMstLHxgAaqWbLuHndcxYGMSAN6N0bEEydP3
         1IyAmQN+iKLgO3VhQyHhjoj4ocA81xgWf5t9oww37rwNykfSmwvR/2e0KkAgxP9Ca+oy
         JmRGLnsuUvwgFuETS/l9sVo67klZ46SdYFcmlv2fgueRvZkqZpRskTbgbnOHEJ86VlU2
         dkKw==
X-Gm-Message-State: AOAM532h3un/adFFPphqr1H1HULLjXKTxjxhGiiMFTOCbjU3XCX0jgi3
        VDU0cD0eO4GPuVCg/SB9QX/AUb2lHp/MWde/x4izsg==
X-Google-Smtp-Source: ABdhPJxwixlFZPCwI9ScZryjo8y3l9Oo1pN2NyhH9TZFK0lqEnxLiMeO4M5fIdxyb8Nh6BAn2llfbxBuYyCEmYzucTs=
X-Received: by 2002:a05:620a:a57:: with SMTP id j23mr14653961qka.443.1624763294748;
 Sat, 26 Jun 2021 20:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210623133205.GA28589@lst.de>
In-Reply-To: <20210623133205.GA28589@lst.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 27 Jun 2021 12:08:04 +0900
Message-ID: <CAFr9PXk84aejj186UNizftwK_w5G1RXLMsSvAEVEYsXi8=yCoA@mail.gmail.com>
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 at 22:32, Christoph Hellwig <hch@lst.de> wrote
> I have a vague recollection that you were planning on dropping support
> for non-devicetree platforms, is that still the case?

Are there any SH4 boards that actually support DT?
I'm still using an ecovec24 board(SH7724). I'd love to use DT if
that's possible.

Cheers,

Daniel
