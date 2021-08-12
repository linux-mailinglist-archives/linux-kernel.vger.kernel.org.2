Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7DB3EAD7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 01:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhHLXLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHLXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:11:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7736C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 16:11:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u3so14809216ejz.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 16:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pldq4BQLhbXUiMQyVqnQvEJ+WijB05dp31Np55Rm74=;
        b=f64+GA1QNqvr9ZaICAQIwgSvc+KRG2fqIRRmJkb8fW1M4yjXUm6st4fHgqUmbApkKp
         HzTpdNFMbsAg2E3jxTjNVro271Idcyfk0PTaN/Kj2gyPza57rWgQc4lYirT71xvWB0q+
         l6jkQhmtMo4iKu1qKbno54lUSW9g6oilznkoVMwN+0mIbS2noQdAxemddKneSZ8i7JuU
         EltmVlBPirypbVocSRRtecaQx5YlqEBlJW8FAwJWqaj3BZJXrhLS63DBKDxvyk1Fpi8T
         6YM6QvPndO0UfI/M5o7iAWKA+jqogihE9NAjjG39/8tp054wY6feUNCWOZz/Trg+l1B7
         ywxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pldq4BQLhbXUiMQyVqnQvEJ+WijB05dp31Np55Rm74=;
        b=C7hxaABL+2EI4+Q7mdXTyYZgUMx/57elIED2EjD7NKWfBRDBROpHVUyuH+7a+KfZLt
         eAItXS9dv0nJAzG2ABBfV1jPkvM0tQz+jQDJHluYKKgEXbGnc7PKQAMEonqkaOeTNkEf
         /plIjX7F85Nd2Yu0A9ib34k+fzRynvX3h6VLgAYbQ50X8PRyFFTKNl0cvIy2EvQo5exl
         uGjiKz4GsOYcb4v8ADQTx3NV2IiPCwbU6NxwMBnDBhUgIc1ZDIPQjRjypxrwIXwZQ3MU
         cymldK2Gx9twPIjtaBaZz25ZDUvAfxKURVvsbkIAUyvF9s5Odn70wKhpSRSTgDqrc50f
         Mq9Q==
X-Gm-Message-State: AOAM530XMNEEKZRKbDWXugD5iP3J+RHtebub8j5hln2oDUsCJ7Cj4vGw
        FEKNWFAYz5ntmOL3BxW66Wg=
X-Google-Smtp-Source: ABdhPJxB3YLm/NLdB9V53s3dwtW1iOZmqRS6c1VTd2TMck3BODrOwzz2+Zv2KBMetylSl6y2ZZbT1w==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr6054053ejw.92.1628809881282;
        Thu, 12 Aug 2021 16:11:21 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id v24sm1789314edt.41.2021.08.12.16.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 16:11:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 3/3] staging: r8188eu: Reorganize error handling in rtw_drv_init()
Date:   Fri, 13 Aug 2021 01:11:19 +0200
Message-ID: <1651213.ETx7SW4KbR@localhost.localdomain>
In-Reply-To: <20210812204027.338872-4-nathan@kernel.org>
References: <20210812204027.338872-1-nathan@kernel.org> <20210812204027.338872-4-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 12, 2021 10:40:27 PM CEST Nathan Chancellor wrote:
> [...]
> Looking at the error function as a whole, the error handling is odd
> compared to the rest of the kernel, which prefers to set error codes on
> goto paths, rather than a global "status" variable which determines the
> error code at the end of the function and function calls in the case of
> error.
>
"status" is not a global variable, instead it is a local variable with only 
in-function visibility and it has an automatic storage duration (i.e., it is 
allocated on the stack frame of the function and is destroyed when the stack 
is unwound at the return from the function). 

According to the above definition there's no difference in storage classes  
between the old "status" and the new "ret" (the latter being a merely rename 
of the former). However, "ret" is a more appropriate name for that variable.
Furthermore, your handling of errors and return value is more consistent with 
best practices. 

Therefore, apart that minor misuse of the "global" class in your commit 
message, it's a nice work and so...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Regards,

Fabio
>
> [...]
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> [...]
>



