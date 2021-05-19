Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB573897CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhESUV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhESUV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:21:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BE2C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:20:36 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d25so2522321ioe.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRiHXEJ3H9xvlgre0fnNmGDnpCPSQ/8wsaWe4BZwIkU=;
        b=ATTxoaeLiqMwpqzcG+ixVG8Geo1RKukgNaDI8luZT21z0TwGMSxzLV3kxcyuEoGaAz
         68codWrq3VTMRKJB6HXEZl0SEhxHBJJe2qobGvg2iPK+sKZrjGEjY/69IGPZIgm8fYTd
         Q589vbmvfFRGBNaOGErSPQJ616Z/1f3dFRNjmfjQRz8OAdDvG18llfvwdhEzwRHVAqXR
         vfy2G9CY88Qc2SePxU1ug3GYn1o+Q7e/GSnYPakg6dB9GdW0LG22azN/ftn00bdLISEh
         8s8HGTQ5hYfDfOLCaIpeK/4ifx2P7wJ79lwiDoI+IkGvPzY9NFqhA8AGXfNQAaGzXSar
         LLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRiHXEJ3H9xvlgre0fnNmGDnpCPSQ/8wsaWe4BZwIkU=;
        b=mwhKvSOw+4HnhLFY8XvyB7GzrwUhihGOeKoupWF3zFwJOOGEy4SCY58NdEacqzYKZ7
         ayXFxBfEz/2zhtNW/H1cKFkOoilKj6PVyVNB/seugbUSRcnmJIa4BklKwPdVVZj26WBY
         EOxM4R71gbRAkvDo6FROtZIFnc+1zbgc6yEzSSOWTE0zHpF3g9f38lVIQVfrdPG/RljA
         rpB0aiDn86NBqSVSZvWZNnkGtR9zqiyYddw4/X/w+9WJq/tmNu9dAcrORxmo3MiA9ENG
         AsqEjgYKaopz1X5xSwXDjMj0GNbxphXTtVYe/8jLkWzMls5mVIGNNwEWiUZo/ftNnOOM
         IeMQ==
X-Gm-Message-State: AOAM530uJrf3dr/0NlNcw433g2lrLXMK0qUsmWL6sREKxrLVM17HVwpd
        gOZYBJolnTy0II5xWQo+fLhhm42dOSJ4GHVU4tQHsKR1VAJQroJU
X-Google-Smtp-Source: ABdhPJxIcjxv+sGZayKxpmTvGtHLiVLKhmxuPCo5n6v6b4b6EX+dQ2dzI73XYC/LXgrdnv/cq6NcxXjnwN8cmTPXTrU=
X-Received: by 2002:a05:6638:287:: with SMTP id c7mr981041jaq.137.1621455635267;
 Wed, 19 May 2021 13:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210513040732.1310159-1-ztong0001@gmail.com> <YKTO+xuM/Ly+8Vwf@mwanda>
In-Reply-To: <YKTO+xuM/Ly+8Vwf@mwanda>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 19 May 2021 13:20:24 -0700
Message-ID: <CAA5qM4C05nKGC0=FK2CntcX8SodotypVvCeAkMeVekX65o4+0A@mail.gmail.com>
Subject: Re: [PATCH v3] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 1:40 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Tong Zhang,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 3ce3e45cc333: "misc: alcor_pci: fix null-ptr-deref when
> there is no PCI bridge" from May 13, 2021, leads to the following
> Smatch complaint:
>
>     drivers/misc/cardreader/alcor_pci.c:149 alcor_pci_init_check_aspm()
>     error: we previously assumed 'priv->parent_pdev' could be null (see line 147)
>
> drivers/misc/cardreader/alcor_pci.c
>    142          /*
>    143           * A device might be attached to root complex directly and
>    144           * priv->parent_pdev will be NULL. In this case we don't check its
>    145           * capability and disable ASPM completely.
>    146           */
>    147          if (!priv->parent_pdev)
>                     ^^^^^^^^^^^^^^^^^^
>
>    148                  priv->parent_cap_off = alcor_pci_find_cap_offset(priv,
>    149                                                           priv->parent_pdev);
>                                                                  ^^^^^^^^^^^^^^^^^^
> It will just crash inside the function call.  Is the if statement
> reversed?
>
>    150
>    151          if ((priv->pdev_cap_off == 0) || (priv->parent_cap_off == 0)) {
>
> regards,
> dan carpenter


Thanks Dan.
I already corrected this in v4
https://lkml.org/lkml/2021/5/18/1040
Please check if the issue persists.
- Tong
