Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB753E4FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 01:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhHIXJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 19:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbhHIXJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:09:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CCC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 16:09:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e19so31813134ejs.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 16:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bdar2Q57ofXvO2DJTkrAdy3Bmtw3CeKG7qPdudkZRAM=;
        b=SSYRwXnV4LF/UXsrDDjaIiZX+2JxoEFnuHOna68sVDPBcs2PZZabmjTHoSvmvSCPsa
         SpGhLcDXxfQsmMgvTN63lIDPabx85VTiwmSFhEzB8U6KBBkwTjMhxvSh0cAckxpiZXSN
         dG6LjI4jCgLtOrAFaThFf9QOZdXriI5mmX6DZmJcIdPyfenSHFjUIEa3U4Ner0O8PuHi
         KqXpKXDuGhqmU4qoheQXFCDMY7WTZi083syd/AlVvQclpSZ+4DcEZyUWOXEGXu0k2tS2
         QTxxUmvHVK9aWr6/VjPHn9ViAO6Na8JKb8o7NF6WZr3pn6NfB6bye36slt9AV8hBVAED
         ediQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bdar2Q57ofXvO2DJTkrAdy3Bmtw3CeKG7qPdudkZRAM=;
        b=VOlAnRxYnXK/UitIDBq0paBN9fdulJSx7NJXapf1FaTLED0XKwQvcZg1FGm+ncmTXr
         1vtJ3arR9EikxKgQwmkBxy8dmmy5ebcZbhmfycdkXEGV4BfZNLyoMpS2ZPJklS97Fhsh
         PxfygJzaOM6zEPfek9quk62vUgVni3AJ6eXPsEyzle6ZtPj0i9I7axWhQdHCce7GP8Ig
         A4Hn7o6z/WszJVzwDatCqFtb6mTdeJOYrMZGauAoqMNrtJ6XqDi3JzmPBOTexbYsL+Dt
         MChxBTThdWQjWylPQFWrST0fMLIts4xLipd/Uo00PeSzLhx+NTfEG2dl2DHL4drjlvwj
         PuOg==
X-Gm-Message-State: AOAM531+F3nGIE365MPG4DF7uVgju5fFTWbLCuwPW8lBpwvy/m+8+sq6
        etyehOtYtEl3DjvSeX0jsAq2pTCQqfdBCicBxzY=
X-Google-Smtp-Source: ABdhPJwVqW/NcTYgPpaHsjo4bSpu1VkSxs7JX/IgQM4rBW2xBSXEu3650B+wAQskkEU+80O5cqOjqE3/+FX5Xo5Ko6U=
X-Received: by 2002:a17:906:7f16:: with SMTP id d22mr24843079ejr.135.1628550549136;
 Mon, 09 Aug 2021 16:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com> <YRFKlOvXKKQX9vr6@kroah.com>
In-Reply-To: <YRFKlOvXKKQX9vr6@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 10 Aug 2021 07:08:42 +0800
Message-ID: <CAD-N9QXFWr2APy294T6v+16d8SXtUuLEoPvZTw1ZDwfQ+D4kFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ipack: tpci200: fix many double free issues in tpci200_pci_probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 11:32 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 09, 2021 at 10:30:26PM +0800, Dongliang Mu wrote:
> > The function tpci200_register called by tpci200_install and
> > tpci200_unregister called by tpci200_uninstall are in pair. However,
> > tpci200_unregister has some cleanup operations not in the
> > tpci200_register. So the error handling code of tpci200_pci_probe has
> > many different double free issues.
> >
> > Fix this problem by moving those cleanup operations out of
> > tpci200_unregister, into tpci200_pci_remove and reverting
> > the previous commit 9272e5d0028d ("ipack/carriers/tpci200:
> > Fix a double free in tpci200_pci_probe").
> >
> > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> > v1->v2: revise PATCH 2/3, 3/3, not depending on PATCH 1/3; move the
> > location change of tpci_unregister into one separate patch;
>
> Also needs to go to the stable trees, right?

Yes, this needs to go to the stable trees.

>
