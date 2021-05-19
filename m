Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE33891C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354576AbhESOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354634AbhESOq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:46:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D463DC061342
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:45:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so3480581wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vtQyTkNhjUkCjH/8sVD8bneWIwlm/Dxj8QR567u8xdI=;
        b=gh/GjuQiO3Ct13Q3lfxUckPHZU6hoJY9mROUyHfSDmceVHuSeI5Tlrt63n5QqogDZA
         ljDf644jhGvNoGiVmfl1iRz1nKaASN3vp/ek9LCdGp1Nc++J0cNP4xTOvW6yRztpo56s
         6WNFL60VdcNaQUDYaKTVxfRpw412dRX4vFgVfcsB5Kbyn43Rv/Yq4hlLuKfcOkALi5Js
         3hGddvjnFrObPxXA0BQ8KuRWy/nGMXvPCybNhLO6WUsbR9HaHbXdQ3u9EtMazgpBenu1
         YJnoVoFmnpZhYecFNg3N8sdGZ3xIw4/9jDcbahvZyt3Rf33/pRCfllPTF8Z4t9tYQJGE
         TcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vtQyTkNhjUkCjH/8sVD8bneWIwlm/Dxj8QR567u8xdI=;
        b=WwopMW3uwFe1GVqqMJzvdLDoMosVC4UnKQxYimkabJP+Ez3D9oiuuDFy5VJomQgCPS
         syBnfwMfO4V82uDOscJO2r/Q/Gi+bJYGrIBvUG5UV1WOcpeG0th3ws5ev8SeDudyeCME
         0AAvViUk3VBBvkTC5jv+zobzjXY1wnGCVgEQDQUCAEdrzUr55YTqX8M/lcNdeAgYWRyG
         PXE0FXlDE6KzI8q9N0IcqSQ7T2b2OL9Vg7WffsMc56uU7U8SwlnHq1n1xD5yvb/a8i06
         dFM6vrQni6rZFngzxqHgKC7ierbJ/tmjTVS9AFI/4mN3iwKuWIR1oDtDi3yJDh4n6piU
         H7+A==
X-Gm-Message-State: AOAM533SY8B4MHt5sIEKLSneCGABMEJDrhqxyCFg7bSkDVFI/Ji+tQ18
        Zb4ddKwhjZLTB4IsLdhabDvDf8G9SP11GA==
X-Google-Smtp-Source: ABdhPJzYq25oll4hRr0EFJCoTCJmTNCn/MNZxukuJNewswtzTns1rhELUL61fzBVsBTwbdR/ii0vPg==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr11984131wmi.36.1621435536499;
        Wed, 19 May 2021 07:45:36 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id h9sm20927137wmb.35.2021.05.19.07.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:45:36 -0700 (PDT)
Date:   Wed, 19 May 2021 15:45:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH RESEND] mfd: rn5t618: fix IRQ trigger by changing it to
 level mode
Message-ID: <20210519144534.GB2549456@dell>
References: <20210515205519.5884-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210515205519.5884-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2021, Andreas Kemnade wrote:

> During more massive generation of interrupts, the IRQ got stuck,
> and the subdevices did not see any new interrupts. That happens
> especially at wonky USB supply in combination with ADC reads.
> To fix that trigger the IRQ at level low instead of falling edge.
> 
> Fixes: 0c81604516af ("mfd: rn5t618: Add IRQ support")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
