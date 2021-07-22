Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D53D2CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhGVS5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:57:39 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:34317 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhGVS5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:57:38 -0400
Received: by mail-qt1-f171.google.com with SMTP id a19so169253qtx.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrCcO1rl/jimbgMioNh66hv+GfxnblGwSC/dwoJZl/s=;
        b=OR/C64J/BNamjqzxHfBvIO2o3AHRiFnk2SHRnkrrc7nT+wLWnOdgvojugXh7DVLUv2
         A+bJ9g7NXYIt3Rgw13/ato+fl0tSj+F0vqDhs5A0UeEN8VlUBIb/CGmgibXuEZuhCS9M
         /KqQCsC5lV+ImU7YIe07/AAWxdVpO+rPem7Xj1T7QqRcKNsfG5J3vMvPif8m/xf2OuKI
         Fr56XY3bYLA8b39bTMdtEhmrfhvRGU8bZd3VTZRJ8X23LYu5+3XoImDXlg3SF7LmQJsV
         YOUiD7dXAoF4mztopz6Kdy2k8TaCgWuBD25+0GOAFsBv58Ykn79oRxPtE5i+d7mnTVvT
         nl6A==
X-Gm-Message-State: AOAM530sUleCP1QFskhcH3bj/zxkxIOV1lCaqj/Rrk9xlGUlmpYyCU5p
        bcpQTp3aPSOcS5i4Zu86TgvENciC3L8=
X-Google-Smtp-Source: ABdhPJx5qj+DaNvMQT8WrJ8PmQFXGK4/ppx84uxOpgh8MYadnF2KiYSIDvjN/Vzb+kWp+el37R+aFg==
X-Received: by 2002:ac8:45cf:: with SMTP id e15mr1110647qto.347.1626982692166;
        Thu, 22 Jul 2021 12:38:12 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id t14sm5741061qkm.7.2021.07.22.12.38.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 12:38:11 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id w10so154734qtj.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 12:38:10 -0700 (PDT)
X-Received: by 2002:ac8:7c44:: with SMTP id o4mr1090841qtv.191.1626982690807;
 Thu, 22 Jul 2021 12:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210705111250.1513634-1-fido_max@inbox.ru> <CADRPPNRYDBFHEppfpYLwsy7MMEdtsOLS764MJboL9ERW0-KK3Q@mail.gmail.com>
 <ec981260-fbe3-5cc4-1da3-dfb2f70f8f85@inbox.ru>
In-Reply-To: <ec981260-fbe3-5cc4-1da3-dfb2f70f8f85@inbox.ru>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 22 Jul 2021 14:37:59 -0500
X-Gmail-Original-Message-ID: <CADRPPNST8XRhO5yR7p8pSbbJCO7xwhF2W3WZ7R=63mTET+fAdA@mail.gmail.com>
Message-ID: <CADRPPNST8XRhO5yR7p8pSbbJCO7xwhF2W3WZ7R=63mTET+fAdA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: convert QE interrupt controller to platform_device
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     saravanak@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhao Qiang <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 1:57 AM Maxim Kochetkov <fido_max@inbox.ru> wrote:
>
> 15.07.2021 01:29, Li Yang wrote:
> >  From the original code, this should be type = "qeic".  It is not
> > defined in current binding but probably needed for backward
> > compatibility.
>
> I took these strings from this part:
>
>         np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
>
>         if (!np) {
>
>                 np = of_find_node_by_type(NULL, "qeic");
>
>                 if (!np)
>
>                         return -ENODEV;
>
>         }
>
> However I can't find usage of "qeic" in any dts, so I will drop this in V2

It is really a bit hard to find as it is pretty old.  But it was
really used up until this commit below in 2008.  So probably it will
be better to keep it just for backward compatibility?

commit a2dd70a11d4c9cb8a4e4bb41f53a9b430e08559b
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Thu Jan 24 18:39:59 2008 +0300

    [POWERPC] QE: get rid of most device_types and model

    Now we're searching for "fsl,qe", "fsl,qe-muram", "fsl,qe-muram-data"
    and "fsl,qe-ic".

    Unfortunately it's still impossible to remove device_type = "qe"
    from the existing device trees because older u-boots are looking for it.

    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Regards,
Leo
