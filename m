Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1EC3E3E69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 05:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhHIDlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 23:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhHIDlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:41:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80375C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 20:40:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id oz16so10362581ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 20:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cLY9sgUFeqLVG8RY76RwvNnVEYKobl7puuBKIKFwgw=;
        b=gM0E3hXuGckUHWxXj0uv4NdJxUHs6kvfmlWLO0jkmq2JJVdzob2k8qNuiXLKJoUTn9
         X5/IGAKRLGZt3/NXNGg0MbMH+tSuiFVvK6wj8ZNnKyZCjJIDkX2PnvLBCoHejGhzzp2Y
         uibRcJz//L4hH9I6j+Px7DxETExDxEUA9dAvuyzY6cRAMXHKnCJPrFGw2q1t2YQgqHwW
         duoJO8Xbf+wKat5lMKbv7gbbWr0Jw80K3PGNdBR6/vhjoxfdR56W2rUQKbhTlG9AxxF6
         tKFYWCCHlZ2Clhcex4I8zDwzqNUBhbBU0zvfs2mpH5LkYGb7ULu1utQ/Qg/Gkax0Skqo
         mVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cLY9sgUFeqLVG8RY76RwvNnVEYKobl7puuBKIKFwgw=;
        b=dYOfCaV0faCyIujd3t23gaHUn+TquYyGIqRvOTH76o8VbVDZiPEgLe1XOQozV9QyQ2
         JIy6vJaEFAkPiFQys8TZrahEU97hbp7STquZziuhTbaSNCwvJV2sb0I1z+eyDpwhzbYC
         HZ9Zrseunk5x9V0o6VVPrTvsnU8q9ZMQKEyVNXb/Ev6SDMXcMVdPImUVLorudYRa5bre
         650uo3ElXvumJ2QII609HDh00nnodLj83x9dlB3SzrRBL1Wi5Pke5S0B4beYL9ml48rR
         GrtKDWCf9JMqRkepQ610VWDXH33vkF+wQxAxMDIrLx316zEVK5uUy+8g7+UbjHsle9ap
         Xfkg==
X-Gm-Message-State: AOAM531viSJgDDZKxUSi/tyc1oiMnSlb6iHrHpcIC6Z2oeaEzicpzxX6
        Tr09mF4diF3avtzL6HR6tdl9IAWpfFxt96/zquQ=
X-Google-Smtp-Source: ABdhPJzKuSfup2sRDZ7kB9/1qqRB425HNqbVtcHB1daSWJ09aNadRvOCLRdh1Ocv6p+y9lqa8GbDcp3xUbPvL5MNU7w=
X-Received: by 2002:a17:906:a890:: with SMTP id ha16mr21342380ejb.73.1628480440037;
 Sun, 08 Aug 2021 20:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210721111137.1523229-1-mudongliangabcd@gmail.com>
 <20210721111137.1523229-2-mudongliangabcd@gmail.com> <YQvXfQ4A04cy5MEA@kroah.com>
In-Reply-To: <YQvXfQ4A04cy5MEA@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 9 Aug 2021 11:40:13 +0800
Message-ID: <CAD-N9QX7A=Z4=bpjw63zCZ=KTTJTYP=n9g29Kp1d39DxgK2_Eg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ipack: tpci200: fix many double free issues in tpci200_pci_probe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 8:20 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 21, 2021 at 07:11:31PM +0800, Dongliang Mu wrote:
> > The function tpci200_register called by tpci200_install and
> > tpci200_unregister called by tpci200_uninstall are in pair. However,
> > tpci200_unregister has some cleanup operations not in the
> > tpci200_register. So the error handling code of tpci200_pci_probe has
> > many different double free issues.
> >
> > Fix this problem by moving those cleanup operations out of
> > tpci200_unregister, into tpci200_pci_remove and reverting
> > the previous commit 9272e5d0028d
> >
> > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/ipack/carriers/tpci200.c | 35 ++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 18 deletions(-)
>
> This needs to be applied to the tree now, and should not depend on your
> patch 1/3 here as it is a bugfix.  Please redo this series and send 2,
> one to be merged for 5.14-final and to go to the stable kernels, and a
> separate "clean up things" series that can wait until 5.15-rc1.

No problem. I will send a separate fix.

BTW, how about the PATCH 3/3 in this series [1]? It does not depend on
PATCH 1/3, however, it does not include the fix to memleak, but also
moves the unregister function. Shall I send it separately?

[1] https://lkml.org/lkml/2021/7/21/370

>
> thanks,
>
> greg k-h
