Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D943908DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhEYSYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhEYSYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:24:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D6C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:23:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso10826414wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hSZqZuABEzIvON8ojKdkELp1gOSuX/1cHHTTz9t4Xgw=;
        b=BXGwq6vDLk02vGw0975Wfa6RDPf6ZeJxD19pr+uk0NXQfD4E7T94BDGcujZo1/AdUX
         W7wbYbWIKX4Y6yki71HDjZEmre932CVI7D01kOwX+KJI2PS6hgaixTiOMLt4OVniz4EN
         JBvpFgB8rUPiQGC5+7WF+HoSc0hruFJG98/rbDsncHr5UtPg/sbYmiGc5quq0MukEmRZ
         Z9r/CpozbSCvK5Vq5ZjixVZzAcN8R+GnpL7w2bhBzI6WMZuRIwuIlpnyxpVywtk8EdAs
         O3YmGHQlZBaB9hv8Y2MrNcb1/k0Evl8muNs5UsajOx2fdwzkCXFmBnQzllrluuEkytEr
         qJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hSZqZuABEzIvON8ojKdkELp1gOSuX/1cHHTTz9t4Xgw=;
        b=l48GJtjW0olEsJn+TpymeELxDh+DMbDMKsckSBDf7F+wwGnr28NbHT4ODpFNAxG7nX
         SEC28/K7tBUsA6XG+WsEZstMEkEwAkpWqagmXBC2N/n16QXa+iwM7IvUAr71q1vsdXC+
         UWxXJTd4CZilB8UfW9Bf8zlN07DPQChZ/gJDpSKJdC/UzdYcvOehClBggcwG6dklIO+e
         tHjdSI44GU1tN51ROPLCzGm0PxHG+RzsvHTeu34tpOi0wM/CiM2/DnVyhIX1kZLcGgnl
         byVIFoyqQUnsCyRXq+gcpckewE5a4l1vmd/Ixs6JMu3kkqEz0K3KApRKLg3ut+Fspvh9
         i3iA==
X-Gm-Message-State: AOAM531VkEUA6QGrzGOvtwNUWS6BbCIBmwd7w9YldUE0RXE84cWcGYaO
        yHSy1DM+PTkG/F/86s07TRJUMw==
X-Google-Smtp-Source: ABdhPJzFzDFyTevYMtBDV0/rex1lDMsYaD5IAdYaJw4DgVU/+RI82ttETzAiyCDf+z03EVE5SawnPw==
X-Received: by 2002:a1c:b384:: with SMTP id c126mr25214598wmf.110.1621966993714;
        Tue, 25 May 2021 11:23:13 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id i5sm17414871wrw.29.2021.05.25.11.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 11:23:13 -0700 (PDT)
Date:   Tue, 25 May 2021 19:23:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Message-ID: <20210525182311.GE4005783@dell>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
 <OS3PR01MB6593170DE2814540F6C3F900BA259@OS3PR01MB6593.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB6593170DE2814540F6C3F900BA259@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Min Li wrote:

> > 
> > > +/* Current mfd device index */
> > > +static atomic_t rsmu_ndevs = ATOMIC_INIT(0);
> > 
> > Counting/indexing this way is generally not good/required.
> > 
> 
> Hi Lee
> 
> Since there could be more than one devices attached to the system, I am using this counter to track the index of each device.
> How would you suggest to do it? Thanks

Why do you need to track how many there are?

We don't usually do that at all.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
