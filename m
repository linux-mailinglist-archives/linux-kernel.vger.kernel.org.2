Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF647363E16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbhDSJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhDSJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:00:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F553C061760
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:59:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so7645412wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=imdYfxadLvf66UqJrLdP+jNRWPDriPV49gKMKRgDf9U=;
        b=MhWOZlAaGQbgumc0RLcBI7Eo6tUscm2hdCcY72xvUiKO6T5U7wVeKkh+1VrFaG66Pu
         XmIMRiH8YDXvTwJ7cqv6scfSJxAP1+EycEKK6U2FgJK8C7ALnWzIhxFLZ31ZJEEtUauL
         gHldm3ykUlafuzkHXAvxV2Z4+78hwLKhnpRmjL79+goWXLKedkVsTDcglmA2muBUl5Xe
         +iRC1LUJXhe/2sXhuGTJhmjvmzaEcdW08XppkbCcY4foF1o6HPMLpM8b+IQdXkofjnUV
         8JCqEWNmLCB3PeN+XsjQSc+iagQxE46gMFLBse2cQOj57d39VmZ9xVkCDzi6j74Mwsyb
         +5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imdYfxadLvf66UqJrLdP+jNRWPDriPV49gKMKRgDf9U=;
        b=glGJA46JfcwN8XwmjZQk36NmScXAk4T7m15Lz7FokP75TyocUYIk1dodHkXjSEEZDy
         6eoHKOjlifJ6qcDXHctmUErRnjpztCJM41EOIX8JzHm+ocHqEO3gB3SYuHlIUv6cktKF
         JGQar43kR/TcgvaqqV6uESY4JMxPup3F+0DH7Vz9SlC2+hyfEqMvhXmQ5m1xFzQeo94v
         sPekuw/XclzNyKADmAi1tViZWe00RhgdMRQR6TFVyafHoE5hqzYPiOhgK05GcyOZ6xtL
         MXbTkTPIRFzHG97YV8/8YnWVblKx555coWOmKhkYOS6Ght7+Awt0EyYY7LozXEyKa2g5
         vvbg==
X-Gm-Message-State: AOAM532989DfAe+eYUeuHv3xQ/yZ+dxllgezk0yZB7c4lv6IzlDkPfBP
        gbVdXqa5eZvlhRyDJhQHFEKZfg==
X-Google-Smtp-Source: ABdhPJyttmIhyOWwAZzKx3fqzhhoCfyRE7e8EHnxzE2txBcfL2G/wBuyLWNkAiW9JdSzXZ9BeBSyDA==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr18551745wmj.111.1618822788077;
        Mon, 19 Apr 2021 01:59:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id o1sm22902869wrw.95.2021.04.19.01.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 01:59:47 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:59:30 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Subject: Re: [tip: x86/urgent] x86/dma: Tear down DMA ops on driver unbind
Message-ID: <YH1GctvMa2filsNg@myrica>
References: <20210414082633.877461-1-jean-philippe@linaro.org>
 <161847725788.29796.15623166781765421094.tip-bot2@tip-bot2>
 <20210417120644.GA5235@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417120644.GA5235@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 02:06:44PM +0200, Borislav Petkov wrote:
> Nope, sorry, no joy. Zapping it from tip.
> 
> With that patch, it fails booting on my test box with messages like
> (typing up from video I took):
> 
> ...
> ata: softreset failed (1st FIS failed)
> ahci 0000:03:00:1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=...]
> ahci 0000:03:00:1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=...]

Sorry about that, I only tested under QEMU. I'll try to reproduce this on
an AMD laptop.

Thanks,
Jean
