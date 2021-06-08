Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97F839EB9D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFHBrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:47:10 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:35450 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFHBrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:47:09 -0400
Received: by mail-wm1-f42.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so880446wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r14pfJQSH7mNzFy625fHX1prI2TQpdUTeO+CV7kQrlQ=;
        b=h5AWFb1PH17B0ztbZ3qrdDlPVcuvS+A3yNj0XJMzGDFxugYS5GfoZaRRlS9g1vGuoA
         krxRGIZa838eYpBUg2Kn5LejoMEuF0PLT4gqGk8EivKIF4cpgd8hi6MthR7y3LRErr0L
         51moMQSxHY3awwli+ySEJgZM2sa3XSeGN08TFirFTFxmdDJmroj/KfJSf0JIU1yjLchQ
         QBNxqZYodCe0PtsMz4ejo1AtluoBVWaRtRLygDMVowEti4vv97I6v5Bdc8DsK3BMspvU
         zXWnTVWS43RY5rLeRSMM3YAgHI4Ah7apR40WI/TkYqSJPTkdwx/cmpmJ4Hd/m9VSJOeI
         SsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r14pfJQSH7mNzFy625fHX1prI2TQpdUTeO+CV7kQrlQ=;
        b=GOAiwgAUlotlKb2xVJgnOGkVvi1tCIlbt0ONM6ZUsYuiriW+6MfPLv3+HAByP3YSLN
         xO5VXL8PR+iDwb4pUaF76ULrae6IzxEQVviZOeGpd1reeUDGjYaC8NDwD2Eo2VR/J5ra
         vdg7VOrI0nnS2R4YN0W0/NiJWKjIoY2zVfmtC6gywUw8iavHmcR8K+S7pAPMV3aaIzS4
         jIRzkRlvXmGwogqW9jyrPqcd65nEw7oLALKvjWuOfAn5eATDWx7BgBHOfZw/b4OUWlU3
         9tCf6Fg5FhbBX/UQM4CBkeMZMhs0rI363Z4g3HWP4yYDcvgJIztb48idECiXxCgxDkFi
         Q3ww==
X-Gm-Message-State: AOAM531qX4FIL9h7HBAWLh2ZupPmEQoZwoYO2Eau6KWHLJlaVxvV6hSw
        OwE35rhtdjKhuSt+2v3eWUkz3dGgX+3K/idAXnMqpQ==
X-Google-Smtp-Source: ABdhPJz6dNQLRZw9PpZxa6mgOEZCXfp+dKPoBk40t9/2ew4OXb7W9GKxXAw9ko5dqXMqffkva3chctSABJ+hvOTOFnI=
X-Received: by 2002:a7b:c013:: with SMTP id c19mr1595252wmb.158.1623116653952;
 Mon, 07 Jun 2021 18:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210608005344.3762668-1-zenczykowski@gmail.com>
In-Reply-To: <20210608005344.3762668-1-zenczykowski@gmail.com>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Tue, 8 Jun 2021 10:44:02 +0900
Message-ID: <CAKD1Yr2xnWpbsDY=pyv+Sq53FV4Bmc2es33p70eyTvm3GnQ3JQ@mail.gmail.com>
Subject: Re: [PATCH] f_ncm: ncm_bitrate (speed) is unsigned
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brooke Basile <brookebasile@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yauheni Kaliuta <yauheni.kaliuta@nokia.com>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 9:53 AM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -583,7 +583,7 @@ static void ncm_do_notify(struct f_ncm *ncm)
>                 data[0] =3D cpu_to_le32(ncm_bitrate(cdev->gadget));
>                 data[1] =3D data[0];
>
> -               DBG(cdev, "notify speed %d\n", ncm_bitrate(cdev->gadget))=
;
> +               DBG(cdev, "notify speed %u\n", ncm_bitrate(cdev->gadget))=
;
>                 ncm->notify_state =3D NCM_NOTIFY_CONNECT;
>                 break;
>         }

Acked-By: Lorenzo Colitti <lorenzo@google.com>
