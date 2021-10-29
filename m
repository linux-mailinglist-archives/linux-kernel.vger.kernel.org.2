Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E354402CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhJ2TGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhJ2TGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:06:35 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A3C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:04:05 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 71-20020a9d034d000000b00553e24ce2b8so10222338otv.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=msvWE2t5mYMtRDZ8I+17Fkh9yjZ5rWivjCZQNykv7fk=;
        b=h8ZNXZO6Y41SOBnORBN6mWRYXD8NiYviTASTihebDxoUBuG4reKkOwBjpj+PhwUfIR
         EV5RM3FzdALQPD4l4MUqP3QJRnMHFt/0jEojgCD2KmkD14HzRAd3+BkSsi/qrM3jG9+U
         JTXeDZrrA9GfjTCcPg4wlcAMDm50yudFoBXYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=msvWE2t5mYMtRDZ8I+17Fkh9yjZ5rWivjCZQNykv7fk=;
        b=XhRke0SNBEMDaX01dEnwF059NgmXx0t8vZdxUBR5XVCvezuNoPqmLgtJC//nd910SL
         G77L/JW+vr0/+SJSby94Rm6IxsGWQu8RkP+Bt5GXedsfBtpd8KRKvofmuj9o7Bfvtnmp
         7fP8au9VMoHuyW08Y6hzH/7D/VoWJPBT41WfCZrm4pyqLedTRFJLhJ0PMJ1NS7S8P/Rp
         X0wsdJSS4hUW+UjqjJgtA8M3uJpVP/6Ds0btDhanuxNZcZTnjQvrKZ2be2lFXSjDwW3l
         4/RaVpvulJ4Mma8svna3PQNNhYoxDwoP6CrM87Ueg4guqSnmrC4c4aEzR9CLvH0kCqwq
         sfmA==
X-Gm-Message-State: AOAM532SzsLM2vxE9m4q9mUOOj7lgiEmgoUEYykK9+gGOHHPc14gbX1I
        aF/pFJN+sy82ZIPtBwSspRBRF+M584hUN3GEjnF22fDq6+0=
X-Google-Smtp-Source: ABdhPJwejTge5mxVTo1xpsG7+GmYiYIEclbSkYga1ic0Puo/7kWiWy21jY9P4cFhgjzOxE55swj6TqN6+gG4s2vvMTY=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr9902382otl.126.1635534245276;
 Fri, 29 Oct 2021 12:04:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Oct 2021 14:04:04 -0500
MIME-Version: 1.0
In-Reply-To: <000201d7ccb2$300dba50$90292ef0$@codeaurora.org>
References: <1635408817-14426-1-git-send-email-pillair@codeaurora.org>
 <1635408817-14426-3-git-send-email-pillair@codeaurora.org>
 <CAE-0n50z=h-avn+K-weZnZFVN7nsR=fLAtge7jFZ0JLx2JvP2w@mail.gmail.com> <000201d7ccb2$300dba50$90292ef0$@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 29 Oct 2021 14:04:04 -0500
Message-ID: <CAE-0n5155J4vvvFES9V5=v+nX3BhZsBgZxkB=uLQOPij=-sf-Q@mail.gmail.com>
Subject: RE: [PATCH v7 2/3] dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, ohad@wizery.com,
        p.zabel@pengutronix.de, pillair@codeaurora.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibis@codeaurora.org, mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting pillair@codeaurora.org (2021-10-29 03:46:03)
>
> > > +
> > > +        glink-edge {
> > > +            interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
> > > +                                         IPCC_MPROC_SIGNAL_GLINK_QMP
> > > +                                         IRQ_TYPE_EDGE_RISING>;
> > > +            mboxes = <&ipcc IPCC_CLIENT_WPSS
> > > +                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
> > > +
> > > +            label = "wpss";
> > > +            qcom,remote-pid = <13>;
> >
> > There are a few properties here that don't seem to be required. Is that
> > intentional?
>
> Hi Stephen,
> All the properties in the example are listed as required (except for status, which will be removed in the subsequent patchset).
> Do you mean the glink-edge node properties ?

Yes I mean all the properties in the glink-edge node. Are they required?
If so then we need to list them in the schema.
