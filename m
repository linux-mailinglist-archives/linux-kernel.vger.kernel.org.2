Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547BC3E9B67
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhHKXxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHKXxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:53:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18179C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:53:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso7775904pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yH5g66y79L9H25uzVilhEw52pa/PdLgYYJLVxPnNFwE=;
        b=Gu8C+0lvV/onCX19VoAQrGJVAwO0pe5rLgV2iJSRspNvJYs31k6U0P24DLkiASxBFo
         seTBfU16F214u7vJCow8uRfnhKZCDmqzni7wCHHJDRTmVCo2Q53N0DSPR9XEPR8srNb4
         +lGOlw23VCctvaxqjbkSCa4+0Lu+Ru1ybUmfl9sHqUw1894vvG+klkGeHksUV0GFWQkR
         87Rxs/5gu0AV5cdWR+/NbCkmX6awps9iFaCPwFxsbf6Dm+5avd6es/ZNbzbsvuTzdi45
         MBb70raS8VZcoFiz0rkz7WkvjEuZsjGh5OOXlCTMzTXzV3/0UHXnCkpTlfWWkY4kaV76
         xNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yH5g66y79L9H25uzVilhEw52pa/PdLgYYJLVxPnNFwE=;
        b=McS5iHCnQl10JnmW+qo9ryFl/WBqGdw8n5opbBV0LU1mTTXFci/PwpVEPyJIVysB/7
         OyZF92oX9gG/7UMhK3oKyV4fCBkcyoVgU6OisFjztS0m97hmYwl83CNNhfYk56hqQYLR
         tK5vOhhhvdhBgWimPzzPrSfTOY3Wy+2XoF0f+aQPRRiFo8EKb3Dwy1UdJKEqDCieJk9U
         8bUcAO0S+Yi7+uppgY3LR2Y1vAaE9Tqdw6cYP/EJImis8WDiZbIEEOvNf3njA6qR1//H
         hZnktmgQrzw2PIxOVMCyGced0wyrxa0NVSpAVJNUou0QacdnGqySYsIE1DHQfN3WIHXX
         EcJg==
X-Gm-Message-State: AOAM5304VnzCqUClUW3dsW0EPlP1V8X3p9CFqsjNcKW23h8INdMgAFzi
        uvxyu9LNB5C3RjfRyH+Brnfl0IsZ9P8MfVrfiul9O2c7uBI=
X-Google-Smtp-Source: ABdhPJyWBUWTR4y/5fMrTK3+S6BvM654Efr4KgJCYniLU5jnvNzUGHEt9kiGhurqZJyemkylUhU6vcGjF4u5FG6d6rk=
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr1199403pgu.82.1628726007667;
 Wed, 11 Aug 2021 16:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210811201450.31366-1-martin@kaiser.cx> <20210811201450.31366-3-martin@kaiser.cx>
In-Reply-To: <20210811201450.31366-3-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 00:53:16 +0100
Message-ID: <CAA=Fs0n0U62cZADeEGXD7HUYzCXpZuHXGZZruztNoTeShFw5aA@mail.gmail.com>
Subject: Re: [PATCH 3/5] staging: r8188eu: (trivial) remove a duplicate debug print
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:15, Martin Kaiser <martin@kaiser.cx> wrote:
>
> Keep the one that shows the wakeup capability.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index 4bf89b78a74a..6e4bf623f788 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -624,7 +624,6 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>                 dvobj->pusbdev->do_remote_wakeup = 1;
>                 pusb_intf->needs_remote_wakeup = 1;
>                 device_init_wakeup(&pusb_intf->dev, 1);
> -               DBG_88E("\n  padapter->pwrctrlpriv.bSupportRemoteWakeup~~~~~~\n");
>                 DBG_88E("\n  padapter->pwrctrlpriv.bSupportRemoteWakeup~~~[%d]~~~\n",
>                         device_may_wakeup(&pusb_intf->dev));
>         }
> --
> 2.20.1
>

Dear Martin,

Just my personal opinion, but I'd be inclined to strip out all DBG_88E
calls totally. If there are necessary functions being called such as
device_may_wakeup() we can always just keep this part and remove the
macro call (not checked this function out myself yet). Thanks.

Regards,
Phil
