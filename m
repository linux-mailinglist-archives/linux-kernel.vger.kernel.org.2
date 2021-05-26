Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1203911BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhEZIDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhEZIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:03:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB121C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:01:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so396304wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+OokPh00UHNMEVv0qejiACa3XrrZve409QsuoHPQEnI=;
        b=cp7YMOUMsGBd4BUjWctRmLdA1x65K2vceANEGb4hxYaZ/hP+dWB3NhaN5ZQeKJzL/m
         Xc+ikkrfBnRtSpyvaKCnAdgHqi8veYfVSBilxTkM2rh4W2Y+sRdY5sy09CRhLUf23IKJ
         dU3VPyZcI0at/2pKPVxn4+h/m+sxiql7zzf4ercgkTMcJ9rM5ryWcMb2VmmhkF7H1WNi
         vW11SC4gAJ9og1Fx10anXZTOMq3CccHgdcmWUf7Dxh6x/HGLvaVcPjipS2ju9qIp/pOX
         /7sdS4Znd3g3T6jjCnrsvUPfBGhJGwj9QwctuIc6l1r/BppbzGvSwgi/aIoTNyMskkr6
         XB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+OokPh00UHNMEVv0qejiACa3XrrZve409QsuoHPQEnI=;
        b=gTR7qpAcZzu94Aja/a5hGHT4NrumwjqFC5XriqZQ0z/Rg+dQRrAap7C3wRlaRKjhpC
         7xvW7IWmF89mmuUYmD0nM/IRDLhjmeTahQSc7g6XKNc1a0MNX3NZwwEButaB21cBmxVG
         2z1dmTs3lQLMQ2MMA9RoWRCUa3Y4N2Y8yydkjXC6go8uYgYqEa99Xi5YyHaheMVEfQ/l
         +tXrTbB3jOJ9DrzmWsFdaBvc6M6GPwLC3BuvU503uX8ZjYT6FwRtfzFsxdOMv8Px44vi
         K7o/K5n5qoAiOMR6n44EcwQ8jpX086JcTq3eLqqIDVckdOoKItb6UtU68rm3dZyDPdpO
         WGJA==
X-Gm-Message-State: AOAM533AGQVFiAc9kdKRoqgHbCc+lE94MqgPu7RZwbEfYVdU+ffwKj0S
        5N82saONVTEix2HqVIP7oLEiS5LevxbU9g==
X-Google-Smtp-Source: ABdhPJyO2V6OIPuzluNbVZmtuvdUumAwztn8IbGm9HmrtQ+2FsQjbilszw8nI19K6dzuDfvkEkJrBw==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr2194706wmq.46.1622016086487;
        Wed, 26 May 2021 01:01:26 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id f188sm5255392wmf.24.2021.05.26.01.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:01:25 -0700 (PDT)
Date:   Wed, 26 May 2021 09:01:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <20210526080124.GH4005783@dell>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
 <OS3PR01MB6593170DE2814540F6C3F900BA259@OS3PR01MB6593.jpnprd01.prod.outlook.com>
 <20210525182311.GE4005783@dell>
 <OS3PR01MB65931F0244E7D2CE6FCB4080BA259@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB65931F0244E7D2CE6FCB4080BA259@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 May 2021, Min Li wrote:
> > Why do you need to track how many there are?
> > 
> > We don't usually do that at all.

You've cut away all of the context.

Please keep all the context so that we and others know what we're
referencing.

> It is used to index the mfd_cell array, rsmu_cdev[RSMU_MAX_MFD_DEV]

Why do you need to index the array?

The devices look identical to me.

Just have one entry for each type and register them in a for() loop.

> The index is also used to enumerate the rsmu character device, say /dev/rsmu[0/1/2/3]

You should be able to use platform_id or a similar built-in counting
mechanism.  There shouldn't be any requirement for you to hand-roll
your own device counting solution.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
