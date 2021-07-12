Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBA3C5178
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbhGLHlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbhGLHJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:09:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F9C0604DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 23:59:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y42so41354566lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 23:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uL4qOFQDnqgQ2aF2ahpw+LAZlHDuE//p49FyeqzSj44=;
        b=gYccxzvPvlG2CcKSgoZmZQNAI1Cd7bWaGHRirLbAwi7R0HIflJLo39Hhv4QzF1lkhH
         f+DKUfMwZXfPveOzOgEcvxYK5CwGoOGgOmZTs9dRP0WBJMnq/Ar6IWpPvRznLewwEcc6
         6BAFfW0eJijjHkgV5bZIzZiK6FxE08DvZJxzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uL4qOFQDnqgQ2aF2ahpw+LAZlHDuE//p49FyeqzSj44=;
        b=RkkyCCQWNTFrQdlsyIQ59q+4oma0j8S9oIaElIOEKf6aDgW+uwLxtWZ1qaBgnxPCop
         nUlCwdCazHPMf079nGGCf6z89Li3TG7F8WkQ/tGQbfG2Xpy/B2nuk2bBQsXozgb0TpXe
         O+wYFsLfrZ4qCbywE5QE0uxSk2o1YMaloCS3xo8FKZDmnkCm/sDeFYbf+z5IZPtyvYFK
         3CmiEzPqpm4/SeJE9AkSDrX0lq/ajppbfDEOKACJIjBKnr88Y6OFcP9aM2IQf1btmy7B
         B4E84M/fjCLojbAP/sW3kVKHgcpOn47OtHalhkLCHpRkVwohIZe45aJud4YEtKzrNXgA
         63QQ==
X-Gm-Message-State: AOAM533dMP2mL3vAuCnr4iAt3y0zgdmW0+mZLJiVVLIwKudUhTe0eim3
        Aee8j2a6CkeMoRjyTNH3t2yy0fl54CRe3NjA+pn/Uw==
X-Google-Smtp-Source: ABdhPJxazF88IljSmFv7FTAnayUrL7XqJfcJPRRd4QyYr86AwfXQRElRMa5x7WctR+GIj9aB7/S2K9xgx3ANmjzXbCA=
X-Received: by 2002:ac2:53a3:: with SMTP id j3mr812475lfh.479.1626073151325;
 Sun, 11 Jul 2021 23:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210710122446.5439-1-tinghan.shen@mediatek.com> <CA+Px+wUVsY6CYwEdfSeK+KQGmvb224hvchgnTwX0rgBzMvXfqw@mail.gmail.com>
In-Reply-To: <CA+Px+wUVsY6CYwEdfSeK+KQGmvb224hvchgnTwX0rgBzMvXfqw@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jul 2021 14:59:00 +0800
Message-ID: <CAGXv+5EtUqe=HECJFkZXdDX9cV_wMp0OykHDOBJVWPF3MwA4ZQ@mail.gmail.com>
Subject: Re: [v2 1/2] dt-bindings: remoteproc: mediatek: Add binding for
 mt8195 scp
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 2:06 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Sat, Jul 10, 2021 at 8:25 PM Tinghan Shen <tinghan.shen@mediatek.com> wrote:
> > @@ -5,13 +5,15 @@ This binding provides support for ARM Cortex M4 Co-processor found on some
> >  Mediatek SoCs.
> >
> >  Required properties:
> > -- compatible           Should be "mediatek,mt8183-scp"
> > +- compatible           Should be one of:
> > +                               "mediatek,mt8183-scp"
> > +                               "mediatek,mt8195-scp"
> Just realized we forgot to add DT bindings for mediatek,mt8192-scp[1].
> Could you send another patch for adding the missing property?
>
> [1]: https://elixir.bootlin.com/linux/v5.13.1/source/drivers/remoteproc/mtk_scp.c#L879
>
> > -- clocks               Clock for co-processor (See: ../clock/clock-bindings.txt)
> > -- clock-names          Contains the corresponding name for the clock. This
> > +- clocks               Required by mt8183. Clock for co-processor (See: ../clock/clock-bindings.txt)
> > +- clock-names          Required by mt8183. Contains the corresponding name for the clock. This
> >                         should be named "main".
> Let's move clocks and clock-names to "Optional properties".  See [2]
> for your reference.  I guess it doesn't need to mention which chip
> needs the properties.  For those chips that need the clock properties,
> they won't work correctly without correct clock properties.

I would suggest still adding them. We will need to describe the requirements
anyway then the binding is converted to DT schema.

ChenYu

> [2]: https://elixir.bootlin.com/linux/v5.13.1/source/Documentation/devicetree/bindings/remoteproc/ti,keystone-rproc.txt#L87
>
>
> Suggested to provide a cover letter for the series next time.
>
> nit: other patches usually use "[PATCH v2 1/2]" in the email title
> instead of the one used in the mail.
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
