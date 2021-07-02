Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19C3BA3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhGBSip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 14:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBSio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 14:38:44 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76DCC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 11:36:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m18so13577286wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qy2SuH3yLn9nvIah9N9cVsf8v+PHZeC5od/9bGW4LXw=;
        b=a3znGR55WEGHZ9rYByubK2VJp810L3abeZeLBp9RHvB9k8KawLIRdChMDideqmcpee
         hMprgf2aE/vE6qDNwzojHGKk1EVRFEshqo7KHuhNTJl1IUo/uZ828WTkGkbXQiq2w593
         lp7V+EbENMX/deeVUFN4ukLZRX/vaiYP4oKzJmChwYl4OCtCKHnAZ3tIBTCUCE97zihw
         wOtjQZ3/DZSLlnRyt0ZFI/OC6qeILauwxbA5ElSO4rwuzc1KxKd63sf7HDpJIqX4riqX
         82LjgEwZTrqq9d2gCMlggJdlZ5Z4ijP9G80h7AxpaWl5kDCLcUqIn7x2Cy6p5TZSR73Q
         MnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qy2SuH3yLn9nvIah9N9cVsf8v+PHZeC5od/9bGW4LXw=;
        b=WFm50ZKzARba2yO/uBi8OponIYHor3lIZBem0HcoD8s+Jl9HZCr3yfTMqsAelzCiXu
         NDFJOG5W8Q5UARxLcNYPaz8jF5SUGQVG4L+BIUvHczIT9G/1t0PVrgB1AhWr/OD2CaWT
         afnXZMRwZMopn+KlBgdfLRyhI72FghmPQLx3Hf5e5TTH0febg11kYkKoRmRbHjWUiv7p
         fTvroHeN5nuhJUwk7RFlEsa6sDlyg9hYPqqV2lW8rvQCu0qnycDubtXTnTyPKCRXivju
         JnDD5y2bQ2zQZQ5Go0tvUUAcZNa0cuiEksT5M/v5xgnsyqBANq7sDS2AiGhterhSqNHS
         bfvQ==
X-Gm-Message-State: AOAM533Vbp1BKkggEoO+6HGnZ58wm6O7wtLMjdmmGEKFcmpq0CRZi/EO
        3M4F3IVaf3k/6b5pxRhzm0TxUA==
X-Google-Smtp-Source: ABdhPJxEcdb0b54kE/uwKiajr9rj28zEzr82hGlqAQkQZZe1EmMWmbRm3Q/ZI9rJQjd0W8u2ttHo2A==
X-Received: by 2002:a05:6000:1a85:: with SMTP id f5mr1153882wry.210.1625250970071;
        Fri, 02 Jul 2021 11:36:10 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id m17sm4265380wrr.6.2021.07.02.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 11:36:09 -0700 (PDT)
Date:   Fri, 2 Jul 2021 19:36:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Yunus Bas <Y.Bas@phytec.de>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YN9cl1/7k/UlllSq@dell>
References: <YMm+VXRrRKIHGgmr@dell>
 <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
 <YMsHXEP36Vxr7lAb@dell>
 <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
 <YNsid9K4PdUJbKqs@dell>
 <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
 <20210630105557.eaktwdz5p6yzuron@maple.lan>
 <YNxktsFmlzLcn4+Y@dell>
 <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
 <20210702125920.fydyfhwqe7tyr7oi@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210702125920.fydyfhwqe7tyr7oi@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jul 2021, Daniel Thompson wrote:

> On Thu, Jul 01, 2021 at 03:34:43PM +0000, Yunus Bas wrote:
> > Am Mittwoch, dem 30.06.2021 um 13:33 +0100 schrieb Lee Jones:
> > > On Wed, 30 Jun 2021, Daniel Thompson wrote:
> > > 
> > > > On Wed, Jun 30, 2021 at 07:27:32AM +0000, Yunus Bas wrote:
> > > > > Am Dienstag, dem 29.06.2021 um 14:39 +0100 schrieb Lee Jones:
> > > > > Imagine only required parts of the MFD is connected to the
> > > > > designed
> > > > > system and unrequired parts are not. In that case, fully
> > > > > describing the
> > > > > MFD in the devicetree wouldn't represent the system at all.
> > > > 
> > > > To describe hardware that is present but unused we would normally
> > > > use
> > > > status = "disabled".
> > > > 
> > > > So if, for example, your board cannot use the RTC for some reason
> > > > (perhaps the board has no 32KHz oscillator?) then the DA9062 still
> > > > contains the hardware but it is useless. Such hardware could be
> > > > described as:
> > > > 
> > > > da9062_rtc: rtc {
> > > >     compatible = "dlg,da9062-rtc";
> > > >     status = "disabled";
> > > > }
> > > > 
> > > > Is this sufficient to suppress the warnings when the hardware is
> > > > not fully described?
> <snip>
> > > 
> > > Right.  This is a potential solution.
> > 
> > @Daniel, you hit the nail on the head :). Thank you for that.
> > 
> > This solution would indeed surpress the warnings, but what is the
> > benefit of this? We would define never used device nodes just to
> > satisfy the driver.
> 
> I would say that doing so resolves an awkward ambiguity of
> interpretation w.r.t. the bindings.
> 
> 1. The MFD device compatible "dlg,da9062" tells the OS that we
>    have an DA9062. An DA9062 contains six functions and this can be
>    inferred *entirely* from the MFD compatible string. We do not
>    need any subnodes to tell us that a DA9062 contains an RTC. The OS
>    can (and in this case, does) already know that there is an RTC
>    because we have a DA9062 (and a datasheet).
> 
> 2. The default behaviour when a node has no status field is to
>    assume that is is *enabled*.
> 
> Based on #1 and #2 above then assuming that a DT that omits the
> sub-nodes actually means "disable the RTC" is risky. #2 might
> actually make it more natural to assume that the device is present and
> functional because there is no status field to tell MFD *not* to
> initialize it.

Exactly.  Nicely put.

> That leaves us in a situation where there is no way to correctly guess
> the authors intent when sub-nodes are omitted from the DT.

> Given this is something of a corner case and the documentation is
> ambiguous then a warning of the author does not clearly resolve the
> ambiguity seems reasonable.

I'm having trouble parsing this part.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
