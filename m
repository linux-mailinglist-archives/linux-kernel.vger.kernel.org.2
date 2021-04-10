Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4F35AD68
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhDJNDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDJNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:02:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13B9C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:02:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w18so9700126edc.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Do6TOYC7++a6IT3LFrIbNRxGi7wBbVzvSmX3FLO0FdM=;
        b=HU+wWxvizyxRF+Ep5QdHxWya1Iq41OOSwWEAJ3CM/e50CLK5mj0KZzaidwqcU4gjK9
         Y2ipiTZ7bLwqlshB9tPJRoxlrCeaS/kyi2vuNjhnLNYtlro+v4fPFIy8sIapQ/hjSxgh
         aGQ1N0ZgVqXQ1YBJPHsoerNgrFIzvlhGZ0+4gGt+UDBfZnN9hUE37O+Qx23GbeLGjotU
         s14JGPwH2fO4KHJNPV/lOfuD8hgPYjQN1JnsEjuBKVVKHRp7K3QZARoPI7c2JSH8stPU
         EGmqx3RnE3HpWTN85ZzS7wGjuOeYiQ/nV2DV3GBRGbdqyMOgVzqCmhWJL9/ikThAXw08
         OO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Do6TOYC7++a6IT3LFrIbNRxGi7wBbVzvSmX3FLO0FdM=;
        b=f74ANQYWolttLxEIeeWMluFvT5r9UEj56GAYbNV6F0GP7iFHcKkEhZ2xFU0I77+skc
         7Oik8vDlO42QIw5t5tC27hMKI5SZe+3DyqmWjxv4NPQgdfDKwBQ7B6MBLyMEuwIiNw5D
         yCGHp/FGYBaKWpc9YBudO1azHX3NmP/5Zioo22wcpRPd3QBE1+j3OgUJu8hi0UsRnO2J
         gNf6u13XWaDY1/04GHfJoNUrqhu/pc6kCWS1BSIZ0ohHj1T+iJyU7kAR3EJbonvKFKwu
         fBFTcEezptTak7PURIRqEyVNcdAMYy0nzO2Wom5q5nzGpz/yrMB4muZXblkagsbM8Dfs
         +dzA==
X-Gm-Message-State: AOAM531/mseRFvpOshRwUUBABLHDj3UnwJB8CdnDpwswM/rjQSs0X6lD
        b2VxBX1iygcs5lGvi+5/OpU=
X-Google-Smtp-Source: ABdhPJx407YkiJEJt9B4XApmbe8vLTQuoNjU8hFa7bzAs8IAztyiNUNFbJeEGn10/Zb9a14sxT44DQ==
X-Received: by 2002:a05:6402:614:: with SMTP id n20mr21433069edv.58.1618059761100;
        Sat, 10 Apr 2021 06:02:41 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id bf14sm3081490edb.67.2021.04.10.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 06:02:40 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the type and use of a variable
Date:   Sat, 10 Apr 2021 15:02:39 +0200
Message-ID: <2186059.xkuF2sVEJi@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104101410350.2975@hadrien>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <2763630.ZYQqkGPH9U@localhost.localdomain> <alpine.DEB.2.22.394.2104101410350.2975@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 10, 2021 2:12:28 PM CEST Julia Lawall wrote:
> On Sat, 10 Apr 2021, Fabio M. De Francesco wrote:
> > On Saturday, April 10, 2021 1:37:30 PM CEST Julia Lawall wrote:
> > > > That variable has global scope and is assigned at least in:
> > > What do you mean by global scope?  None of the following look like
> > > references to global variables.
> > > 
> > > julia
> > 
> > I just mean that fw_current_in_ps_mode is a field of a struct in a .h
> > file included everywhere in this driver and that the functions whom
> > the following assignments belong to have not the "static" type
> > modifier.
> OK, but a field in a structure is not a variable, and this is not what
> scope means.
>
You're right, a field in a structure is not a variable.
> 
> int x;
> 
> outside of anything is a global variable (global scope).
> 
> int foo() {
>   int x;
>   ...
> }
> 
> Here x is a local variable.  Its scope is the body of the function.
> 
> int foo() {
>   if (abc) {
>     int x;
>     ...
>   }
> }
> 
> Here x is a local variable, but its scope is only in the if branch.
>
And you're right again: I needed a little refresh of my knowledge of C.

I've searched again in the code for the purpose of finding out if that 
struct is initialized with global scope but I didn't find anything. I 
didn't even find any dynamic allocation within functions that returns 
pointers to that struct.

Therefore, according to Greg's request, I'll delete that stupid 'if' 
statement in the patch series v2 that I'm about to submit.

I've really appreciated your help.

Thanks,

Fabio
> 
> julia
> 
> > Thanks,
> > 
> > Fabio
> > 
> > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:368:
> > > > pwrpriv->fw_current_in_ps_mode = false;
> > > > 
> > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:380:
> > > > pwrpriv->fw_current_in_ps_mode = true;
> > > > 
> > > > drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:433:
> > > > adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
> > > > 
> > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:981:
> > > > pwrctrlpriv->fw_current_in_ps_mode = false;




