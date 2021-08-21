Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8D3F3BB7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhHUR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 13:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhHUR2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 13:28:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC91C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:27:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x16so11529677pfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NImfKj+1u2UZdWcEsXkC/vWqZt0WpdSDDZujdOQQU4=;
        b=f/9u1of0w2xloeK65yR0rLas6BnGbLJEoVFQtnEtRoXjiUYo8WJdTPdcCay6afX+M5
         V8RDBn6I6A2tTAPE7hsQZ49NLdcgwspzXd8FeWsv3BdH7dGYCQtORswJn/T4wtlONKzl
         TWWLpU1oASE5kxPWOKNc/2HWEIe2XMeLLXVam7eT+w4pCH4Rf3pcTsVoTaDZx1e9Dr+l
         71NwPRpnMNniOHA+McKqv6mBoRwwNl33/4GzMgN1YnYsDzewNIjvPh5ERiExhVmykGqX
         UXmQ4aelrI4PyRsQ3qGf59LZhZEuV+UwCiN8DfTF8imcXha6FbgacheGb+BBETaLh1XY
         Q6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NImfKj+1u2UZdWcEsXkC/vWqZt0WpdSDDZujdOQQU4=;
        b=VC4kgbiwLliu9L9XySzGqP2UcK8lLsRThE8Ig6+YLgi1emWtGztomToX0WUc76nJ80
         14Kwit81fhI+dDFVuHGm4Urk3b1bJ/MS5r/4TR5a7rK6+9e0gWoPB06A4TBMDbv6dJNL
         m+LxXo9bv9WUXY387itx6gtDletSnrWod9GEW43w17uM5yDQIg+H7gGfYHDsqDF6qoef
         qEUIcYbDRKPyIEXHI8mzzUdiMvtBdOTXrYoLn8h3zaAOoJyJmPOR5K2pk1bH6T0xYLJE
         AVfbzzFs7LnnOGV2Ve4LudLyoWnsoQ8zwXzYpIBtVoUFMYBjAOaFOHdau5k0EXJyaNeF
         8BFA==
X-Gm-Message-State: AOAM533PRivcCzsQ0PstcHyiLMKY+36bfYsru/COGtbIFYVpN0sDOtHY
        SbM5HocfbrfIu4imB1Fh36HjnyAVnZ71el/l2H2bVQ==
X-Google-Smtp-Source: ABdhPJwNKKlNcmoftApiFlV0ypYj+vmHEDqxoXmfvGQIONgSHEPRBYmbiTcki8CiTVSCS5XNqks/io4enOGCDUdK4x8=
X-Received: by 2002:aa7:90d4:0:b029:3b3:2746:5449 with SMTP id
 k20-20020aa790d40000b02903b327465449mr25685318pfk.81.1629566877052; Sat, 21
 Aug 2021 10:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210821164859.4351-1-martin@kaiser.cx> <20210821164859.4351-2-martin@kaiser.cx>
In-Reply-To: <20210821164859.4351-2-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 21 Aug 2021 18:27:46 +0100
Message-ID: <CAA=Fs0mB_9Uy5xSr=pin+oDOCN+J07Yzw1CNchQLHmLVN6wT1g@mail.gmail.com>
Subject: Re: [PATCH 02/10] staging: r8188eu: remove unused define
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

On Sat, 21 Aug 2021 at 17:49, Martin Kaiser <martin@kaiser.cx> wrote:
>
> _HCI_OPS_OS_C_ is not used in the r8188eu driver. Remove it.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 953fa05dc30c..a11a0597e515 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2007 - 2011 Realtek Corporation. */
>
> -#define _HCI_OPS_OS_C_
> -
>  #include "../include/osdep_service.h"
>  #include "../include/drv_types.h"
>  #include "../include/osdep_intf.h"
> --
> 2.20.1
>

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
