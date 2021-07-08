Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B53BF81A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhGHKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhGHKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:12:43 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64736C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 03:10:01 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id j8so3316657vsd.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XkfH9+fTTan24v4bvoti+pLXgKwMSUgTJQx2o0Bllo=;
        b=gVmQ9nGXksd1SX9wHOHv2tLAo7F7JUgz0O1xj5BfEkwI9cnxv4Ts62oSThPZ6D6wCO
         ZgUTmFBeNQYsuF2cVN6u9NWRyNeouHi1kaXG2xoT3wrXl9C/j6PC3badxUTUigGqAw0J
         VC02TiDBaRv8k0IBH9yBV4KG9UUI/w25RN5OEZ3po6WJuAkuqyF23eLJwn9mqmWmO6np
         RFcpWgayy7jKRBATf1fAY8oh4tpxVDdEFf3o+om1R1a7WhscmFLKNykB6rKxAuCXpVr9
         hskxkSIgU2PxMaoL0dg07cHH8uymm3r2i2X7pEhreyex/UIqliMN5ob/EVG6kzz0xzNj
         e1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XkfH9+fTTan24v4bvoti+pLXgKwMSUgTJQx2o0Bllo=;
        b=VxmlForJsikPCsCjQ1v+UPohhlvk4+K3eWBUw6r7JBUhCw9sY+FlHoKwG6OCvJdnt+
         gC2UHmWCpAf25m2vzMhS9Szkmj6ubJtdIvkNPEGRM4qbPYoBw/YSsYZjqqHZakE1YHPt
         OH/nhQ4rUQr4kOOyC09RWo1pUNxpYcah+NchVqB1c1VOg5LJ75lNTIBTZdX7kaiPQoaL
         MM6JCk9Q9h93I8OT0vUpeBoJ37RkI22JQHyB7WmkGXlB14TEp2NIW5y7n0QzCUGF2YPs
         S6l7M3NIymi5cmWoAwCsXsAREbOPlpfVuGdThdWmIOEUILRV4eFVRoRMHeWRm17Kg4tm
         awlA==
X-Gm-Message-State: AOAM531b6g1weKWm06+0sSntXHj4QcxVwHGjxTyUjMyNflP3KeVPs40k
        TuB7u8NY3Ez35IeW403qAlrpZQz495uyk0pXhM6LFw==
X-Google-Smtp-Source: ABdhPJwHgh40ete+mWshNgBzlFotTAKewBYMMJyK7LdPKgcW1MKGOya9/zroMMERxNBQ9ffFUG/OviGrGS35sgyMGLQ=
X-Received: by 2002:a05:6102:2324:: with SMTP id b4mr3247152vsa.48.1625739000496;
 Thu, 08 Jul 2021 03:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
 <20210621223141.1638189-3-dmitry.baryshkov@linaro.org> <CAPDyKFo6dmjw0TnaK7=35dq5Si_6YYpeeSa=gU++1od7WkQZ7A@mail.gmail.com>
 <20210706115517.GB4529@sirena.org.uk>
In-Reply-To: <20210706115517.GB4529@sirena.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jul 2021 12:09:24 +0200
Message-ID: <CAPDyKFr=8spZBD+bTe3SjS=nATL-ByFu_epnT2Z4chSuQNke2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] regulator: qca6390: add support for QCA639x
 powerup sequence
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Peter (the email was bouncing)

On Tue, 6 Jul 2021 at 13:55, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 06, 2021 at 09:54:03AM +0200, Ulf Hansson wrote:
> > On Tue, 22 Jun 2021 at 00:32, Dmitry Baryshkov
>
> > > Qualcomm QCA6390/1 is a family of WiFi + Bluetooth SoCs, with BT part
> > > being controlled through the UART and WiFi being present on PCIe
> > > bus. Both blocks share common power sources. Add device driver handling
> > > power sequencing of QCA6390/1.
>
> > Power sequencing of discoverable buses have been discussed several
> > times before at LKML. The last attempt [1] I am aware of, was in 2017
> > from Peter Chen. I don't think there is a common solution, yet.
>
> This feels a bit different to the power sequencing problem - it's not
> exposing the individual inputs to the device but rather is a block that
> manages everything but needs a bit of a kick to get things going (I'd
> guess that with ACPI it'd be triggered via AML).  It's in the same space
> but it's not quite the same issue I think, something that can handle
> control of the individual resources might still struggle with this.

Well, to me it looks very similar to those resouses we could manage
with the mmc pwrseq, for SDIO. It's also typically the same kind of
combo-chips that moved from supporting SDIO to PCIe, for improved
performance I guess. More importantly, the same constraint to
pre-power on the device is needed to allow it to be discovered/probed.

Therefore, I think it would be worth having a common solution for
this, rather than a solution per subsystem or even worse, per device.

Unfortunately, it looks like Peter's email is bouncing so we can't get
an update from him.

Kind regards
Uffe
