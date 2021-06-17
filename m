Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5D3ABEEA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhFQWcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFQWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:32:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32299C061574;
        Thu, 17 Jun 2021 15:30:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u24so5844923edy.11;
        Thu, 17 Jun 2021 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wITVgltgJl5r151IxWILEHl3H0k8xMn+nPMIK1yBTco=;
        b=A6KpSp9l167+m1JZaayN154StG1sIipUwxo4nt19Ogvbo5r8fOTD648WBix5qzfqB2
         rRfHK83RMO2yQj+sD9D/INjL4zRpZ8vlhhrreqBmubzJHpnlbL2+81QTesPEiS5s8RiC
         Ry4mSUdXdhD5g/9oA3H9jIJgy95lOwBY1tP2xSkv01gFeyScHy1ZA2EEDqglOzFpncx/
         o6bYt+Q4lDgNcUvCQqukMLYFfLMJiJubiDOYYD31VMPiIcDTw9lYdEo7I9DeXKuiXfKr
         Je7E0yYO6qIcQFGgpOa6VUZKRgzipbjmyso3dm0abHgaTHuGgAQ6v5HWbym10Wp9lIm/
         Ui7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wITVgltgJl5r151IxWILEHl3H0k8xMn+nPMIK1yBTco=;
        b=jqjMzdYrQCqXvGI6LkxkaIEpco1LtaLdSTADuKbkrsbNSWxQVfshr17jIqHPyOamWM
         5OpP8rnEJsF5g2VuuNM4zXmSpriUoXcK/hPWqvE0oC22OcTDvDb1tfDUyeVaewg9HE+b
         lqRAPX108hI0KkmpbigakrSRK+0kFbNlfsdgykTmn6MhBjUUpTRnm0R1U9E/9dTGFtCt
         i7rV3lDEFbaIUnbgIziRr6mCCUyvToF/+mDLqMbNJiDgL8ysr5Ju7FFEkpDZGWd7Mow3
         0/eyrfKfnLe1JeOm2eRPGlbQjVSzJJhHeaVXWqV5Nbi0JohStXm+qURniLcRp9Euic6w
         16rQ==
X-Gm-Message-State: AOAM530ue+23ybgTd/B2afvi0NSgRBaqrwlUWctYQ++533bdhmeQkyC4
        1PzZsZZp1WOkAutU1IMbnp99UYktqF9jrs/KjxMNmAZI
X-Google-Smtp-Source: ABdhPJxXu8wu2qt5mjrLbCpviDnEsgxqXyFVOpxp/qXDwJT4DGreJi/OxhCYS9+dnwJGKW06LqKY6P9GMHuhEfHq85g=
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr741248edw.179.1623969013637;
 Thu, 17 Jun 2021 15:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
 <20210604190338.2248295-2-martin.blumenstingl@googlemail.com> <20210616233109.GA285667@robh.at.kernel.org>
In-Reply-To: <20210616233109.GA285667@robh.at.kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 00:30:02 +0200
Message-ID: <CAFBinCCE8vmMJE-Y0dvGpT+1QFKVN0U9yKinF_2w+644GaXxYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kishon@ti.com, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Jun 17, 2021 at 1:31 AM Rob Herring <robh@kernel.org> wrote:
[...]
> > +description: |+
> > +  The HDMI TX PHY node should be the child of a syscon node with the
> > +  required property:
> > +
> > +  compatible = "amlogic,meson-hhi-sysctrl", "simple-mfd", "syscon"
>
> Is there a sub range of registers for this functionality in
> "amlogic,meson-hhi-sysctrl"? If so, please add a 'reg' property.
yes, for this part of the HHI registers there's a dedicated sub range.
I'll add a reg property with register offset and size

one question about .dts validation: at least the clock controller
(which is also a sub-node of this) does not have a dedicated sub
range.
Is it still OK in this case to set #size-cells = <1> and
#address-cells = <1> in the HHI node?


Best regards,
Martin
