Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C55A3B8233
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhF3Mgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbhF3Mgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:36:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1054C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:34:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l1so1921986wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0I7x4z50ZBcplP+tJCE0y7F/DAh3KOim3T2tgat6mws=;
        b=DV/haovwQcid/QNeu+tBvgIi6elWoHSnFdvTzVvzHvodkx6v/oUjI++8voDbk9Dz8S
         Qe/7s+vEZ07gnGgBCDxQLZx6YFSdthC6PiLUckzUutC5hBGI/nBIEQbqRPkkvuyBfxP2
         H2RAO+9O4YpVf+Vi4YboZY1i0Z4umexTJTYlPB36BUq3IecbKmQb9JNnTTODaPtaSh71
         O1sCgaPvApGItvIUflg4IY+72rvp2Ro43zUNgVTHZGEJ7JlRNP2Nlx4t1XlcrIt1G/wU
         tQAUrGPx/7MBA7Upwr+wnJ6DiVy5V9KlcMCEuP0TGq3t/4VTAVqwdc1h4pdPNczR0I1H
         N5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0I7x4z50ZBcplP+tJCE0y7F/DAh3KOim3T2tgat6mws=;
        b=dTo8L8J9LDinrSNU8nVHUSOpDkW/3y5DesLpAd0iP9ZoWsFxjoMpbufk0CY7yuH3bY
         UbSjfWZwFgSg60+NArh7DV3AU+0iC5x71/YyfGi6HguWteV1dQwsVEU+XrRkiHGxtZiO
         4dvJqk/JzcREWSWrVBe9NiWjBO7c+sOWh7MXF4hX+kHPnGB2gwrX3cSSdv5moodj2xvh
         wMEgRMhNC4hY/lyX0xy/0aDT8CayGaviYB6qhZ9rKk9aMUAAgG6agvh2Lpwjaw3QmH1U
         2Dxazp2WooZFVeAzM4AAY0uJuo86ZrBn9hdo4ja6t5pq/h+VxLhDCrf4KBEHMsu2yMci
         ChEA==
X-Gm-Message-State: AOAM530a+PApg7U1QUOWNzxFeVwCGCoZdlKOIdCYXF6B6aNR6gj0/gq0
        jQ9z26OgJvWKkGvgf5XP1NpfDw==
X-Google-Smtp-Source: ABdhPJyI8hVel/wKk+D6gPqCAXuihnJmo/Z/jKlNJWsAAFgsnQBPa3qdL5LMZLMqXn820d9Gj3FO5w==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr4318414wmc.73.1625056440471;
        Wed, 30 Jun 2021 05:34:00 -0700 (PDT)
Received: from dell ([109.180.115.217])
        by smtp.gmail.com with ESMTPSA id c12sm25566586wrr.90.2021.06.30.05.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:33:59 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:33:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Yunus Bas <Y.Bas@phytec.de>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YNxktsFmlzLcn4+Y@dell>
References: <20210616081949.26618-1-y.bas@phytec.de>
 <YMm+VXRrRKIHGgmr@dell>
 <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
 <YMsHXEP36Vxr7lAb@dell>
 <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
 <YNsid9K4PdUJbKqs@dell>
 <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
 <20210630105557.eaktwdz5p6yzuron@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210630105557.eaktwdz5p6yzuron@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021, Daniel Thompson wrote:

> On Wed, Jun 30, 2021 at 07:27:32AM +0000, Yunus Bas wrote:
> > Am Dienstag, dem 29.06.2021 um 14:39 +0100 schrieb Lee Jones:
> > > On Tue, 29 Jun 2021, Yunus Bas wrote:
> > > > Interestingly, all subdevices defined in the driver are registered
> > > > as platform devices from the MFD framework, regardless of a
> > > > devicetree entry or not. The preceding code checks the subdevice
> > > > cells with an additional compatible. In case a device has no
> > > > devicetree entry, an irritating failed-message is printed on the
> > > > display. I'm not sure if this was the intention but the framework
> > > > somehow forces the users to describe all subdevices of an MFD. I
> > > > think the info print is not needed. It makes more sense to set it
> > > > as a debug print.
> > > 
> > > Actually, this has served to highlight that your DTS is not correct.
> > > 
> > > Why are some devices represented in DT and some aren't?
> > > 
> > > If anything, I'm tempted to upgrade the info() print to warn().
> > 
> > Imagine only required parts of the MFD is connected to the designed
> > system and unrequired parts are not. In that case, fully describing the
> > MFD in the devicetree wouldn't represent the system at all.
> 
> To describe hardware that is present but unused we would normally use
> status = "disabled".
> 
> So if, for example, your board cannot use the RTC for some reason
> (perhaps the board has no 32KHz oscillator?) then the DA9062 still
> contains the hardware but it is useless. Such hardware could be
> described as:
> 
> da9062_rtc: rtc {
>     compatible = "dlg,da9062-rtc";
>     status = "disabled";
> }
> 
> Is this sufficient to suppress the warnings when the hardware is not
> fully described?
> 
> There is almost certainly a problem here since there is a mismatch
> between mfd-core and the DA9062 DT bindings. mfd-core warns when the
> hardware description is incomplete and the DA9062 (and generic mfd) DT
> bindings are ambiguous about whether sub-nodes are mandatory and include
> an example that contains missing compatibles rather than disabled nodes
> like the above.
> 
> However it is not entirely clear to me at this point whether this should
> be fixed in mfd-core or by improving the bindings documentation.

Right.  This is a potential solution.

NB: The suggestion above is usually the default for devices (at least
this was the case back when I was neck deep in DT).  You usually have
the a device specified in a DTSI file with the generic properties
defined from within a top-level node which is usually disabled.  Then
you link back to that node (usually with a &) from within your DTS
file where you provide platform specific properties and override the
status to 'okay' or what have you.

However before I provide any further assistance, I really want to get
an idea of the H/W you're working with.  Is this a reduced function
DA9062?  Or is the functionality actually present, you just don't want
to make use of it?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
