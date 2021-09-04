Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2C2400961
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 04:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhIDC7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 22:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhIDC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 22:59:43 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584AC061575;
        Fri,  3 Sep 2021 19:58:42 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ew6so801614qvb.5;
        Fri, 03 Sep 2021 19:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aT7fAjhBnMScunMdGoTyQJ33IupYZGm7kjNq4WANd6s=;
        b=FK61RgghBQFOJhuduTOz63OD8TelkAw4kYshKwxWr/JJ/+4VFqNW6RzPdV+BzWraJY
         KtcXS435uG1OnNUofzTa99WNpXTzqLE1iiECvPnKrQ9EirEfC9eOOKCa6Gjmyk2FQ2Di
         1CaeS7bolX1le302tnyB2AYHNNTdhTL2uYon+mvTKc57thWAd744XovDnq+hB3M9Psgw
         gXShJi6WXGGejGMGw0XKicKTqLyCfo5hCN1NcFk8GvmZn5na/CDiBs1uQed+00Ha7d1P
         QKLMzuu5WZ3rs37gp5Zy5kkm9jKZYelOhaCv1HebwCXIAFAybsNAGP443St4J9bWQU3z
         fO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aT7fAjhBnMScunMdGoTyQJ33IupYZGm7kjNq4WANd6s=;
        b=Dq8dBu0f8DpmvuHApiOOSn6lVsQ/xVHR0/E4UAxUUt1GncS2AteT+64tS5RhPlnNlz
         fA58bn4SVAUAQRUR5O3NyOrXeZ75qqOLCIHwAzN2sHXecPbkyeAK6oLCWL8P4u0lTLh4
         JMR27MH1wwF+BKUAvXS4IYiUKBTBjjfECisDxUsPecW0uFKKBkXrs63868OfyxH6iGLG
         jR+e4NxW29xzWCwhaFjF70/B3W6Uj0nMX+qMuAPfuQGoo7xXSrvGoizTgghekmBjcQMz
         CR7U+yP7dAVl4Fqf3Sv4HMxb3LsViOn+MBwdEipeO3CeFFhi+JDbDfSksM6aMPSx2xhO
         FRGQ==
X-Gm-Message-State: AOAM5324fK6A5SURWf6nBLITRFyYbSX0XdKFvnGyA1rnEfm94xqQZ7BI
        xh+520sh0tCXLVeMj+sdws0zmMKVdbIew59PsvQ=
X-Google-Smtp-Source: ABdhPJwVK96P+Skpxb+nksrGIb1NbFe0ar9Y+PD32hZ2w9uoRH9k8OQXfDoEY28NEelHIVl7ZeKIHM//nZ8mHOkqmsw=
X-Received: by 2002:a0c:aac5:: with SMTP id g5mr2176290qvb.23.1630724321945;
 Fri, 03 Sep 2021 19:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <1630661377-31244-1-git-send-email-shengjiu.wang@nxp.com>
 <1630661377-31244-4-git-send-email-shengjiu.wang@nxp.com> <YTJQcIOU1mMxoIpF@robh.at.kernel.org>
 <CAL_JsqL_5U0QB5d5VmgX3PMa9LNkyFa+RHWSAzeeTzq6xR=_nA@mail.gmail.com>
In-Reply-To: <CAL_JsqL_5U0QB5d5VmgX3PMa9LNkyFa+RHWSAzeeTzq6xR=_nA@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sat, 4 Sep 2021 10:58:31 +0800
Message-ID: <CAA+D8ANSR49juFDvPxHECKv7-uSowjdxruqnb=z6vu_CEkujjg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: remoteproc: Add fsl,imx-dsp-rproc
 binding document
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On Sat, Sep 4, 2021 at 12:50 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Sep 3, 2021 at 11:42 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, 03 Sep 2021 17:29:36 +0800, Shengjiu Wang wrote:
> > > Define the compatible string and properties needed by imx_dsp_rproc
> > > driver.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  .../remoteproc/fsl,imx-dsp-rproc.yaml         | 131 ++++++++++++++++++
> > >  1 file changed, 131 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/remoteproc/fsl,imx-dsp-rproc.yaml
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> I take that back. What's the difference with this binding and
> Documentation/devicetree/bindings/dsp/fsl,dsp.yaml?

Some devices, but two kinds of driver. one for remoteproc
framework,  another one is for ALSA.
So should I merge fsl,imx-dsp-rproc.yaml to fsl,dsp.yaml?

Best regards
Wang shengjiu
