Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6773B94D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhGAQsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhGAQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:48:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF31C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 09:45:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o13-20020a1c4d0d0000b02901fc90de999bso544410wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L3pFdPu57kS1jFJZyYV4aOUa4gKWfmg2DMJUYi33zTo=;
        b=uJhqgcnoMmJC1G+0kUlZcDqN4QBMN21by84HV8Xez3OoBM1i1cDcln5Dhn1z/2cPBn
         ZjqUgmWs7NLKVhscsWmP+sHAVV0dDdbUg8VEWQywcp1vO62gDYVsll6FX8wN/ZwhsTei
         2qJ9L7DLhMCaLtEKzhgXD3REZiPtA70DT4wfGMLHAJ5nOUNYYx9xtsAbOgLiM8adzZTC
         QFpRK6Dwd5xBYGHDfJYLQ51jjrrcYgDuS0CrPKsJaWiDtSaPP2CW3m9lf0IS+mVRZxGj
         LfjpgRSF7RS8Bff2MaXESHy0iBI1kFiVTTRSRHPcYRwGim1PqPOc+P4mvc3qo8G62WPx
         CdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L3pFdPu57kS1jFJZyYV4aOUa4gKWfmg2DMJUYi33zTo=;
        b=tnjyad8d0V3m+mLiNzgW0dQda1DsOIhUse44UTojXP/FKdZRckUNJ5iZ+7syOjTCTi
         tXF/SNECV3nWAT21dlIE8KLnoe/eROMBljcFXp7Wu6SlsBaIV5YgRHL8xerKs259eCnT
         Q8ZB6DUqoCzRqIZZOYCUHYty6bfPPscVIAEMPt1W+muaEi9vGfJlHYFht6aqevmXFuRY
         noR/Yi6kfYUbYzJbnd5+Pf2SNTC3aCu35ppA8nP6A4QNAVlrNecJ81s2FuSATO6ot35m
         1SZShupC4FbQLt0/OyyC6/fbiw24mGe4vtYNJ/V9EL/pEn57E4473htMdfa0WxC5j6dy
         5gbw==
X-Gm-Message-State: AOAM532noXiF/v4WMzUmsdIvxaT+BWuL2YcHo1Ip84+vvu66V+x6zYaS
        xYfzb4TyWTbmC7FyyqaBrfAsAA==
X-Google-Smtp-Source: ABdhPJyOs2S4uDvDxwR/E1L7FY/r8zU1vG5sJy7mA2TtuoPMkavAQHUnGMRSzQn4ELu/tAs8wRCEMA==
X-Received: by 2002:a05:600c:3542:: with SMTP id i2mr680272wmq.100.1625157935042;
        Thu, 01 Jul 2021 09:45:35 -0700 (PDT)
Received: from dell ([109.180.115.217])
        by smtp.gmail.com with ESMTPSA id 25sm164362wmf.21.2021.07.01.09.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:45:34 -0700 (PDT)
Date:   Thu, 1 Jul 2021 17:45:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yunus Bas <Y.Bas@phytec.de>
Cc:     "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YN3xLEQ45cjCz3wW@dell>
References: <20210616081949.26618-1-y.bas@phytec.de>
 <YMm+VXRrRKIHGgmr@dell>
 <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
 <YMsHXEP36Vxr7lAb@dell>
 <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
 <YNsid9K4PdUJbKqs@dell>
 <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
 <20210630105557.eaktwdz5p6yzuron@maple.lan>
 <YNxktsFmlzLcn4+Y@dell>
 <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b5d0003cce92cad57e7712d1e46c78c10f1a0ab.camel@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jul 2021, Yunus Bas wrote:

> Am Mittwoch, dem 30.06.2021 um 13:33 +0100 schrieb Lee Jones:
> > On Wed, 30 Jun 2021, Daniel Thompson wrote:
> > 
> > > On Wed, Jun 30, 2021 at 07:27:32AM +0000, Yunus Bas wrote:
> > > > Am Dienstag, dem 29.06.2021 um 14:39 +0100 schrieb Lee Jones:
> > > > > On Tue, 29 Jun 2021, Yunus Bas wrote:
> > > > > > Interestingly, all subdevices defined in the driver are
> > > > > > registered
> > > > > > as platform devices from the MFD framework, regardless of a
> > > > > > devicetree entry or not. The preceding code checks the
> > > > > > subdevice
> > > > > > cells with an additional compatible. In case a device has no
> > > > > > devicetree entry, an irritating failed-message is printed on
> > > > > > the
> > > > > > display. I'm not sure if this was the intention but the
> > > > > > framework
> > > > > > somehow forces the users to describe all subdevices of an
> > > > > > MFD. I
> > > > > > think the info print is not needed. It makes more sense to
> > > > > > set it
> > > > > > as a debug print.
> > > > > 
> > > > > Actually, this has served to highlight that your DTS is not
> > > > > correct.
> > > > > 
> > > > > Why are some devices represented in DT and some aren't?
> > > > > 
> > > > > If anything, I'm tempted to upgrade the info() print to warn().
> > > > 
> > > > Imagine only required parts of the MFD is connected to the
> > > > designed
> > > > system and unrequired parts are not. In that case, fully
> > > > describing the
> > > > MFD in the devicetree wouldn't represent the system at all.
> > > 
> > > To describe hardware that is present but unused we would normally
> > > use
> > > status = "disabled".
> > > 
> > > So if, for example, your board cannot use the RTC for some reason
> > > (perhaps the board has no 32KHz oscillator?) then the DA9062 still
> > > contains the hardware but it is useless. Such hardware could be
> > > described as:
> > > 
> > > da9062_rtc: rtc {
> > >     compatible = "dlg,da9062-rtc";
> > >     status = "disabled";
> > > }
> > > 
> > > Is this sufficient to suppress the warnings when the hardware is
> > > not
> > > fully described?
> > > 
> > > There is almost certainly a problem here since there is a mismatch
> > > between mfd-core and the DA9062 DT bindings. mfd-core warns when
> > > the
> > > hardware description is incomplete and the DA9062 (and generic mfd)
> > > DT
> > > bindings are ambiguous about whether sub-nodes are mandatory and
> > > include
> > > an example that contains missing compatibles rather than disabled
> > > nodes
> > > like the above.
> > > 
> > > However it is not entirely clear to me at this point whether this
> > > should
> > > be fixed in mfd-core or by improving the bindings documentation.
> > 
> > Right.  This is a potential solution.
> 
> @Daniel, you hit the nail on the head :). Thank you for that.
> 
> This solution would indeed surpress the warnings, but what is the
> benefit of this? We would define never used device nodes just to
> satisfy the driver.
> 
> Also, this could lead potential users of the DTS to falsly assume that
> the defined subfunction is actually supported and only needs a change
> of status for that.
> 
> Actually I accept the fact, that changing the info() to debug() is not
> a good idea, since the driver should naturally warn in case of a
> compatible mismatch. But this should only apply for devices defined in
> the devicetree.
> 
> But regardless, if defining all the MFD subnodes in the devicetree is
> the way to go on with, it needs at least to be documented in the MFD-
> bindings.
> > 
> > However before I provide any further assistance, I really want to get
> > an idea of the H/W you're working with.  Is this a reduced function
> > DA9062?  Or is the functionality actually present, you just don't
> > want
> > to make use of it?
> > 
> No it's not a reduced version. Some functions have been deliberately
> omitted. Internally, MFD's normally have a common control register-
> sets, but the functions have separate controllers and therefor separate
> connections to the controllers. When a MFD has e.g. seven sub-functions
> and five of them are needed, then the two unneeded functions can or
> will be left out on purpose. This is common usage and can also be seen
> on other devicetrees using MFD's.

I think what you describe here is a reduced function device, no?

> > NB: The suggestion above is usually the default for devices (at least
> > this was the case back when I was neck deep in DT).  You usually have
> > the a device specified in a DTSI file with the generic properties
> > defined from within a top-level node which is usually disabled.  Then
> > you link back to that node (usually with a &) from within your DTS
> > file where you provide platform specific properties and override the
> > status to 'okay' or what have you.
> 
> Yes, that's the common way which we also use. Normally, there is a
> generic DTSI file representing a set of possible settings which is then
> specified in the DTS-file it is included.

Right, so no problem then.

Describe the full device in the DTSI file and disable all of the
functions by default.  Then, in the DTS file for your particular
platform, only provide nodes for the functionality that is present.

Explanation:

Essentially, by populating the mfd_cell, you have told MFD what to
expect from a fully functional device.  If any nodes are omitted
without explanation, it (rightfully) complains that something is
missing.

In order to describe the device properly in Device Tree, you need to
firstly describe the entire device, then only enable what is actually
present or what you wish to actually use on your H/W.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
