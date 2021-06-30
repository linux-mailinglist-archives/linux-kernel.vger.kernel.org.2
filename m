Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69153B8100
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhF3K6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3K6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:58:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE57C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:56:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so4126764wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LuOiP/oVaXqoovnUjw3xthvWWpKANM5v9sU1LvOTO60=;
        b=jIwHZ0HTG0eE7kpfmVjoIAIPdTVboXiTXnU64uL4wmwlkg5YMaSXi0r1zIUkiTKu/J
         J2In377aSyhtd3yKCHEkEcsPgHDhh05N1e3TKmHpucQFKxJGGDK8p++X4Bz58aGqmulq
         a3g44qDcTrh3hUGCXFu9rGms4ijFXug2/f8LdNNj52/uPIV0cZkTKjs6pIobEZe8fjZ0
         zhoG/ZpS0rRo3Kw5ZV07rnZqQZAJXSYjrwuAeeoM4VYPkgoabkhU8RbUYDg2E9bz3Qmu
         vM68GfHjRWdt9AhH75mthDmvR5fNoosBxNG15L+8Q1p1zg0eapw8syIVRLCE2kXmT9M+
         wEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LuOiP/oVaXqoovnUjw3xthvWWpKANM5v9sU1LvOTO60=;
        b=doNzvR33rkKXeSDODwMg857bMRsCIVyx68GEWl0k47Ivm8kGkUKqwxTQ2JpnDCw1rS
         hJ413Xpxr6oxdF37qa6D2CgxuO0IjzGgGwITqZPr3vYJ4/2hB1UTUoMquEy3VUhF7ppd
         ARSXmMqAsOBxsblMQj3olkJmghfaTlgs2ayd3hnpOQ+FVE7QLGO9oTXiHzqn25JNRtVB
         w6/Ze5Q5DGSRl5wwEJqQ8QebEYJTkzCNHNFoGRsYTvHjMdXiWGp90p2CQE3U6xhvFJP2
         dfDYO/1sy7nZ8ad3vLF8sWap/We3WJeVNMmErF47moO51D61uomJtMwTI8vV6w3BrvoS
         7PuA==
X-Gm-Message-State: AOAM531BQiu4Gd2kSPrXjx0VNN2xcsc4Q83Wb8ThmYeK1SF9bsEZFgKB
        q4xf/mKRUVccpScR1AMqW+q/3Q==
X-Google-Smtp-Source: ABdhPJyRVu6tyoOcSztd3HO8Iz/dO2ACLgvtUMzNpqzNFqgzVpom4vFpvSHgeGy+TQcnC1vBEkiryw==
X-Received: by 2002:a05:600c:350c:: with SMTP id h12mr33111243wmq.157.1625050561630;
        Wed, 30 Jun 2021 03:56:01 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c9sm11026194wro.5.2021.06.30.03.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 03:56:00 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:55:57 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yunus Bas <Y.Bas@phytec.de>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <20210630105557.eaktwdz5p6yzuron@maple.lan>
References: <20210616081949.26618-1-y.bas@phytec.de>
 <YMm+VXRrRKIHGgmr@dell>
 <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
 <YMsHXEP36Vxr7lAb@dell>
 <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
 <YNsid9K4PdUJbKqs@dell>
 <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 07:27:32AM +0000, Yunus Bas wrote:
> Am Dienstag, dem 29.06.2021 um 14:39 +0100 schrieb Lee Jones:
> > On Tue, 29 Jun 2021, Yunus Bas wrote:
> > > Interestingly, all subdevices defined in the driver are registered
> > > as platform devices from the MFD framework, regardless of a
> > > devicetree entry or not. The preceding code checks the subdevice
> > > cells with an additional compatible. In case a device has no
> > > devicetree entry, an irritating failed-message is printed on the
> > > display. I'm not sure if this was the intention but the framework
> > > somehow forces the users to describe all subdevices of an MFD. I
> > > think the info print is not needed. It makes more sense to set it
> > > as a debug print.
> > 
> > Actually, this has served to highlight that your DTS is not correct.
> > 
> > Why are some devices represented in DT and some aren't?
> > 
> > If anything, I'm tempted to upgrade the info() print to warn().
> 
> Imagine only required parts of the MFD is connected to the designed
> system and unrequired parts are not. In that case, fully describing the
> MFD in the devicetree wouldn't represent the system at all.

To describe hardware that is present but unused we would normally use
status = "disabled".

So if, for example, your board cannot use the RTC for some reason
(perhaps the board has no 32KHz oscillator?) then the DA9062 still
contains the hardware but it is useless. Such hardware could be
described as:

da9062_rtc: rtc {
    compatible = "dlg,da9062-rtc";
    status = "disabled";
}

Is this sufficient to suppress the warnings when the hardware is not
fully described?

There is almost certainly a problem here since there is a mismatch
between mfd-core and the DA9062 DT bindings. mfd-core warns when the
hardware description is incomplete and the DA9062 (and generic mfd) DT
bindings are ambiguous about whether sub-nodes are mandatory and include
an example that contains missing compatibles rather than disabled nodes
like the above.

However it is not entirely clear to me at this point whether this should
be fixed in mfd-core or by improving the bindings documentation.


Daniel.
