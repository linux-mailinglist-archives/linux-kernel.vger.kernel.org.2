Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304BD423891
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhJFHLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbhJFHLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:11:34 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ED0C061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:09:42 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so1970931otx.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=HfTHUhLPFuNYu+1s+5X0I1ftdKhtGk97U1HjbXbHe2o=;
        b=MFJcPHrnKWIcIkMutzo8P/bcT7APg9bV6rqSWArphXMQM8qVEv3/2CHyvz9IGsTCkk
         oR5muMjWB8iM1Twlo3tukBoIIcpK2u44tZmqMm/ve0gintVkb92yXeDz2se9QZSt/VX2
         xqeDp+xVcN2Mx83FyOYrr9Vgufc/ytalTD4O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=HfTHUhLPFuNYu+1s+5X0I1ftdKhtGk97U1HjbXbHe2o=;
        b=vnxN9/JZMjXm4s2JuFUqqht1xZ2COaTr/NmsimIn2ef73I8AC1YfI341qlC4TlEOWs
         gZwUCeLV2Dn8n2FZl2tdCmJs9NTClfZZ4T8fn1C3BkHkAm6otRe60QV8TsRcmF4X2Z0v
         OaMHXrdJyakM6xWficS10sjZ2tlRQ3G6leN8uJncHqIAWNOz4T7aVNLC3cbm+lz9CYLZ
         b8sPyVKEbOUWK7j+cZNT8OpHaZ4Strsou6Vg8WZ9Gg3OmRMgngKAN7rLxNjAQCVQ9U8Y
         zrkzd0Zs6+hkxNyuhNV8zlyZ8tvIDDPNl4V8mJKcFF5anMvWjV4WQg0z9H8zH76NdPRE
         sxjQ==
X-Gm-Message-State: AOAM531EisCH7AfH6esMBNWmghoZgtQg1XHhEiLM3tP87VeHtZEZDAc3
        9qoJmXWFz0ZW+HqQjM0MB7oXHs55yAvsU3tvDOhUpg==
X-Google-Smtp-Source: ABdhPJzivuyKoDsjOOPOWdoEgQDyWy6eq7Yz1Nv43Y/7dsaEcPdBJmpGtrjRzBtq40vOOSw1Ry91dEzksSzUwC1Qe7Y=
X-Received: by 2002:a05:6830:4116:: with SMTP id w22mr4893118ott.159.1633504181834;
 Wed, 06 Oct 2021 00:09:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Oct 2021 00:09:41 -0700
MIME-Version: 1.0
In-Reply-To: <006801d7ba70$54daae00$fe900a00$@codeaurora.org>
References: <1633330133-29617-1-git-send-email-pillair@codeaurora.org>
 <1633330133-29617-3-git-send-email-pillair@codeaurora.org>
 <1633350086.759437.1051509.nullmailer@robh.at.kernel.org> <006801d7ba70$54daae00$fe900a00$@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 6 Oct 2021 00:09:41 -0700
Message-ID: <CAE-0n51rsfFX_-Vxn2tumWiw9K-Tf244rhTedc76UKx5ADzKyg@mail.gmail.com>
Subject: RE: [PATCH v6 2/3] dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
To:     Rob Herring <robh@kernel.org>, pillair@codeaurora.org
Cc:     mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sibis@codeaurora.org, kuabhs@chromium.org, agross@kernel.org,
        ohad@wizery.com, linux-arm-msm@vger.kernel.org,
        mpubbise@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting pillair@codeaurora.org (2021-10-05 22:09:18)
>
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> error(s),
> > then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit.
>
>
> I have updated the dtschema (2021.7) and still not seeing these errors. I
> will fix the errors mentioned in this log though.
> Is there any other flag/setting, which is to be enabled ?
>

I have dtschema-2021.10 installed.
