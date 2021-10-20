Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC34354AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhJTUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJTUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:41:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515E4C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:38:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j190so16832315pgd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wnUfSvZ3oVkpbHK1Ie9Q/sSpEARC30mLV/QYy9Pp/jU=;
        b=VxYzTFw8jex52ZrlGrv0fmtzvKOm/iCOpozf9Y3HmmT4n9/iTRauv74pF5sJaW18dI
         usIERuOeUheey0z6RTmbf1M9jGBKmgvPzZ4FF0pcfiV0uymW4WRA1N8UDLsaHb6IMS36
         FFCIMAMjRS4J8qrzC9bgjnSMEQds8mv3HPbS/LamgLkDQKUPYx8vPkyMEBSgvgiXgGBU
         4RaoE0WZpk9ooOpaqICZZ7MN5e7rthTJ8rcGLJXNVu1IGZJ3Qx5RgH4eRQLUTcAGr8zA
         jZZEnuvAj8B1LgQZT7Af0aow5Gcbma2heV4Z9XyG/P4tFBr+dnGdXB29Sz464DwS0bcB
         eKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wnUfSvZ3oVkpbHK1Ie9Q/sSpEARC30mLV/QYy9Pp/jU=;
        b=TRzzHF92v3fM/04lWUDVwfomSXewZn9bCzlJ15NfjewCktCPWSs+xF4cf26YMVjikR
         kfyfWzCH3i7Wnvo3ohxIrkHBc18fZfZfbxGNdiKLHDI4+u1SlwreOlwQ4sOjm7egMW+I
         HJKl2PWLloDIjm2Pik4MJ4fHg2YQ9gXP1fEwPr4H4rW6+bN9doYBul0KL3iWwDhmXDzd
         clMPRPAZ4LFSiBVZfm6631WYh3rC2QQPuQqa3QSZD5a35izzSHuBAGoujrYO4AKtcJ2m
         DUmS/0omP9+C2dG8ro73TdfnMgTVp4Xd/Kr59D78e/VZi4481LAUGVWk4jOwWGFxZPTN
         CVFA==
X-Gm-Message-State: AOAM532TUe6b3YfdnKze3BjyQqeDyxerSK0b/Amt2/Ru/dXIOnlU9rQm
        WAUNbP8Qa2zftc+8Si0kFHgihRTYiCM=
X-Google-Smtp-Source: ABdhPJz8ss6lO9pzgQt3LxTQdWMJmqlSObYy8m9SuTjcu3PXj4f2IeMokF5haekxFyXr5CGRUaMB8A==
X-Received: by 2002:a63:cd09:: with SMTP id i9mr1148777pgg.129.1634762335746;
        Wed, 20 Oct 2021 13:38:55 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id t2sm6762003pjf.1.2021.10.20.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:38:54 -0700 (PDT)
Date:   Thu, 21 Oct 2021 05:38:53 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Denis Kirjanov <kda@linux-powerpc.org>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: signal: remove unused DEBUG_SIG macro
Message-ID: <YXB+XVb/mBlI5fWo@antec>
References: <20211020121637.6629-1-kda@linux-powerpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020121637.6629-1-kda@linux-powerpc.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 03:16:37PM +0300, Denis Kirjanov wrote:
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> ---
>  arch/openrisc/kernel/signal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> index 1ebcff271096..99516c9191c7 100644
> --- a/arch/openrisc/kernel/signal.c
> +++ b/arch/openrisc/kernel/signal.c
> @@ -28,8 +28,6 @@
>  #include <asm/ucontext.h>
>  #include <linux/uaccess.h>
>  
> -#define DEBUG_SIG 0
> -
>  struct rt_sigframe {
>  	struct siginfo info;
>  	struct ucontext uc;

This looks ok to me.  I will queue it.

Thanks.

-Stafford
