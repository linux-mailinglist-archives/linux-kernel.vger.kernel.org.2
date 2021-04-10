Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C835AD25
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 14:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbhDJMCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 08:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhDJMCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:02:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EBAC061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 05:01:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id bx20so8361140edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Y+rFLdZxttQk+x+XDqZN+DXOyaagZNtXVw+dsN8Xs4=;
        b=JT5TMWYQc17RndU05frqUYMfr9OcULkN1aHQIhnHmyjL9iu/zVJFRL77ub+OMBnRYb
         y8YVsIMovNSgkBKCO4Z/J6TIkYtPjrPw5IXbE1WNhib84mAKamGSULHDb5VOSTF8Ao2I
         zD1zbUQ35s3Wcs2wxCVDX7wZFZiZBgNESCS7RvZwejTi5hFcIiYBxpesHTku3YyoBeXj
         Zqp0+f+wMekiiatD70J8nK1HWOhBYl63IWj/vOszfsVsqGOOLhn9qdTRN5scVUcKh00Y
         LeN6KT6rskVYNMEkqWriFmotZHyWRV8SDs2OrGXcrW7LKmDv9bT9YFtz8b4coQahrZh0
         KsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Y+rFLdZxttQk+x+XDqZN+DXOyaagZNtXVw+dsN8Xs4=;
        b=YU2+mAU1sJtX/VS80j/FnGo62KSvgEMSA/V4xzG9A9AqBG7X2vipsPoYmZlb1XOSzS
         EvpDTU1osnb8gy79h65B4ZOkf++08nG3+Jb1pKgJrLVeGGgMCXD6Tfh+zsS8Meg4jys+
         nxQuAKdxOEqAhhBpptE5b4oxQBG4JRAkfiXDw5Ot9eZ8hlHP4no9MfxeGvtRAvPZM8TO
         EwDjIkAwRHKrTLeLgQ8nurvM4202I1eV+DzdYzC9R9LDeKQa61OwUWRQQRjskzBinlpS
         9VNWecI+n6c+9de69uriPmDgQhVJtIye2fm4305NQuXGMm3DFv5bVsIEMliq3NkfHrq9
         z1jA==
X-Gm-Message-State: AOAM533gCwz1anOElCg1vxOP04SqQfSX8fx6HinLP9L8EU9idlTGeMQg
        bGuvDF52oNHaY9aInYkN89yAfUGWDJxkECeT
X-Google-Smtp-Source: ABdhPJzF9nLlltC6SajRODBWcL22JmGtRhIlV9ohq+aP0dVD2xp0NcvTjv2BZSAWYimwz+ycta9mEA==
X-Received: by 2002:a05:6402:408:: with SMTP id q8mr21046748edv.201.1618056107273;
        Sat, 10 Apr 2021 05:01:47 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id r19sm2582083ejr.55.2021.04.10.05.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 05:01:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the type and use of a variable
Date:   Sat, 10 Apr 2021 14:01:45 +0200
Message-ID: <2763630.ZYQqkGPH9U@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.22.394.2104101334190.2975@hadrien>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <10115279.QsZogQpAqX@localhost.localdomain> <alpine.DEB.2.22.394.2104101334190.2975@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 10, 2021 1:37:30 PM CEST Julia Lawall wrote:
> > That variable has global scope and is assigned at least in:
> What do you mean by global scope?  None of the following look like
> references to global variables.
> 
> julia
I just mean that fw_current_in_ps_mode is a field of a struct in a .h file 
included everywhere in this driver and that the functions whom the 
following assignments belong to have not the "static" type modifier.

Thanks,

Fabio
> 
> > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:368:
> > pwrpriv->fw_current_in_ps_mode = false;
> > 
> > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:380:
> > pwrpriv->fw_current_in_ps_mode = true;
> > 
> > drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:433:
> > adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
> > 
> > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:981:
> > pwrctrlpriv->fw_current_in_ps_mode = false;




