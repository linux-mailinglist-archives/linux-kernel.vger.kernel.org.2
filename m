Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99C13DEDCD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhHCMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhHCMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:23:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831AEC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 05:23:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hw6so22178665ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtlBN5e/EVpe5xwv2aVry/eQDKWqwL83Vio3Gr+T1UA=;
        b=MDI+Ew8CkVlcfRk09T7+lidlFk5Se+Ws6iehNSQhtwW5KrOnmtn/0m8QeRTLIFO3GY
         H2Twro7MvsBZLrgje+WVN3RVG/w0CC1kaG2DsUUDDpOZblATI+PicPhly91dTSNjVCj0
         2IBf1jaM8MHnTlfnqqVjxJmU3EZKvI9HN1GAZ5IlXEHODyYq/xMa7TL7LSMZO8M98Lzr
         FqIFeu86o3y5duVTTzCWIl5eSmiYDHHvAEsrtBk33JQ8qL4S81NvKGIw34RlA4bjEhke
         Wx1xKOSrh9b0MtsUWjN8o+9LqUnwZAlquEYqCl/egdFNn0lvT1w9QXieL04GrVCMW1wX
         YT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtlBN5e/EVpe5xwv2aVry/eQDKWqwL83Vio3Gr+T1UA=;
        b=byGvx6Qe425cN0m0aU50+L6xhorS+5oN9be3Jv1nUaOu6bICaM/8h0HIuPX3oO8gBV
         wup3gatXqt4GLxZTUVO5gkG2kO5YZsk8Slybapf0bOPl3kGUFaVQ864bAfQMeCmDU2PU
         e6tGxw5ChomZAWHvykvNbvywYxYps4389ZW9o24yxxn3U+7KM+AfkRGh4gHemfUoznO1
         wZxQLyMm91kEWQFoznTN/T3b1gTGOUlfgoK3qsShYzkPVeZ3b/D10EGCrGYxiP39nKJx
         tCKFqdIDfg82/vBarp+OEEe16AIXKdl1V9HMz31SX4Vo3JwfH0//kKMZVD6sk0IlBCpz
         5ewg==
X-Gm-Message-State: AOAM532ItXcFE3+ql9LFL5nHFw8Eic+pCJc/uBePlxQPScz1/vw43N2L
        BAHZedeSWo5WVs0un9tREI0=
X-Google-Smtp-Source: ABdhPJxfr66p7gLYa1C8qI9woDWHJhCUQ3mR5zxfUTBCPiRHyN5cpvTx6WuKWVF1hOIHLOe95qZDtw==
X-Received: by 2002:a17:906:9c84:: with SMTP id fj4mr19921594ejc.180.1627993407065;
        Tue, 03 Aug 2021 05:23:27 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id s12sm6142403ejz.36.2021.08.03.05.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:23:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: commit c7e88ecbe328 ("staging: r8188eu: remove rtw_buf_free() function")
Date:   Tue, 03 Aug 2021 14:23:25 +0200
Message-ID: <26260563.P9vmH3Ooqy@localhost.localdomain>
In-Reply-To: <20210803072129.GA1422@agape.jhs>
References: <20210803072129.GA1422@agape.jhs>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 3, 2021 9:21:30 AM CEST Fabio Aiuto wrote:
> 
> Do you have any idea of what happened? This
> topic could give us all deeper understanding
> of kernel memory management.
> 
Hi Fabio,

I've just briefly looked at that c7e88ecbe328. I have no time to dig it deeper 
but at a first look it seems that the following line is the culprit:

kfree(&pmlmepriv->assoc_req);

It should be:

kfree(pmlmepriv->assoc_req);

The second line frees the memory location whose address is saved in assoc_rec; 
the first line instead frees assoc_req itself.

Regards,

Fabio 



