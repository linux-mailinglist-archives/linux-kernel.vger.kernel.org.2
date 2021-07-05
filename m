Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93D83BB897
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhGEIIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGEIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:08:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CB3C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 01:05:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so20945779wri.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t1Dn1dbFANDxTjKru21fZeQlfANFxxDAnXeii2gE0pY=;
        b=LZua4B2MfHjBcWLnDB1A4UVlgc6HH6nE7V+cq6l/d1Lw00g7qdmvicSb1psX32gu75
         AhW+YCu8XABprqUth0XD/uApHJ/ULHUwxciTi9TDiCF/jSJp4LUqBJlyCcztNMoQiMhT
         RV21RMTZ2MjaBSpJ4vEXWtYuUxqq9K6fPWBCKzvDkk5l41iI2JbvoM5P3gyogG/VbZzd
         OsVAPntD1xFOf3NvXhVG3YPaeRWPCEQIQiFfdzJM0u68ghdWPr6wi/niGrMck5kv2aJQ
         Moh2P0gAlVmo6p3creyVO/0jNrG3Iob+tWx+rMFAcxqVHxT3kp3Bico11UnSuxz9t3FP
         DjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t1Dn1dbFANDxTjKru21fZeQlfANFxxDAnXeii2gE0pY=;
        b=H0Gbh01hqASaRUKhAHtMexyqNZGJNZ1jDNXkjugbbmeJwNuaByyN3MYoSQQYh9uHUN
         y/JUPiiS4A667oUjH3ETdVPLVf/Vgm1sNGnuZ6T+hIlDmLnK/NehHV8a0AHD3RYTobsd
         Ny9E8Pv+GrAMXpMiMouk01dA18sQAinB4J6toMuAmcWckVkAVD9rmBoLIswCbuSOFcYX
         N4jeDZre4KWrOEUIZSqyiF4DlUSJ/Qjd9Zp32112VmDdXERdZg+2TLRTpiKK+2gOk9aE
         dQBSW1dZj1jcSfDMSoRUKXm+UibMRgSWDm6cURRF/yj7Z4O8mhr5lE0Ayhjyp2C4OJN6
         hMIw==
X-Gm-Message-State: AOAM532cnNbDlNCRWKYguTkg83WX7qeftUggDL5TFAQbkTq/dJKlsHHV
        DknpQsBrDFP42ZiXSDNo1jwHEQ==
X-Google-Smtp-Source: ABdhPJwxJsOmbKlnKq2EyBpZK0JRYzr/QEAiu/iHEWJKCQVPy3QuewjAHeP4YqCDhPa88jRzDAecjQ==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr14967674wri.66.1625472357675;
        Mon, 05 Jul 2021 01:05:57 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id m17sm12678696wrr.6.2021.07.05.01.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:05:57 -0700 (PDT)
Date:   Mon, 5 Jul 2021 09:05:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yunus Bas <Y.Bas@phytec.de>
Cc:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YOK9Yyc31lKr6BzA@dell>
References: <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
 <20210630105557.eaktwdz5p6yzuron@maple.lan>
 <YNxktsFmlzLcn4+Y@dell>
 <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
 <20210702125920.fydyfhwqe7tyr7oi@maple.lan>
 <YN9cl1/7k/UlllSq@dell>
 <20210702191012.mecgw577ggkabxr6@maple.lan>
 <c2ca83c4d67a47a8e104e5c54a4920cac56312b1.camel@phytec.de>
 <YOK1RvQI1rHvaXEy@dell>
 <614d720b0f468334e74a4e29b626d498f25a7c31.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <614d720b0f468334e74a4e29b626d498f25a7c31.camel@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jul 2021, Yunus Bas wrote:

> Am Montag, dem 05.07.2021 um 08:31 +0100 schrieb Lee Jones:
> > On Mon, 05 Jul 2021, Yunus Bas wrote:
> > 
> > > Thank you for the clarification. I'm now aware on how to handle
> > > MFD's
> > > in the devicetree. But given this, the default behavior of MFD's
> > > should
> > > definitely be documented since i could see many other devicetree
> > > examples handling this also not in the proper manner.
> > 
> > In the 8 years I've been working with DT and MFD, this is the first
> > time this particular issue has arisen, but if you'd like to submit
> > such a document, it will be considered for inclusion.
> 
> This is because on older kernel versions (or at least on the last LTS)
> there was no warning in the first place. The warning was added with the
> following patch of yours:
> 
> Commit 466a62d7642f ("mfd: core: Make a best effort attempt to match
> devices with the correct of_nodes")

Right.  The implementation was decidedly more broken before this and
many sins were lying dormant.  Fortunately, we now have an early
warning system which should catch these kinds of misdemeanours during
initial implementation.

You make a good point about LTS' though.

I'll be sure to keep this in mind as more people update.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
