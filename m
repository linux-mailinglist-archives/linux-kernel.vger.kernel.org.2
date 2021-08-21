Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344523F3C04
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 20:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhHUSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhHUSSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:18:15 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08002C061756
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 11:17:36 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x10-20020a056830408a00b004f26cead745so23175397ott.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=2MKqqfHMC9DXCZ5xc/Z5j/sgvGFltKULDdY+rzqw+xI=;
        b=fB2gtJr+5qSucpbo/Htu+gWHsd5m6BQLDuOP2RIzcFVcA4UNf6kYwNfvBWnFOCsiXV
         sAKHY4MVkMqsls1si64SP/MHHeSH9hMsqBLhYDHVBrqP5qGxS83E5QYhoxDJnm3/fZTw
         F2PREdmGa2lzOs8Rlg5fl2hsZp7zu0CLnNyJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=2MKqqfHMC9DXCZ5xc/Z5j/sgvGFltKULDdY+rzqw+xI=;
        b=Xv4XgHBeET84U0JRiHV1ZO5o4XeEDQdsVDbsN02kmn/hq5OG5+30ENLqG3+jC03Gat
         nmwVWWZM9seHDgkSh12izL0Hu8X+Af67ave9Q91Kp0eRoEYFjP8TiGv3T3bBvH+q2OCu
         1yhoiwJPZ4dEVeXZnQ/pfv6DVSanToB4FTedCTNv0sggwEw/Dd8WmF1DXHBEuuwaCdOu
         eUTWmACMnJJ9VVZMFYYYmByuHhqgelnkX4kdcuLfSFixXuwJc+eOSkTBKB8e5ROITdWQ
         RA5TREkTZRIpFrI3UWZQ6Am8Wq1DhHhbEJlQhU+tg2e5M1fWiSXmcStoS3PGSdvux9gf
         dwLQ==
X-Gm-Message-State: AOAM5306EgdoT+HMRwSvKx0+mB2vQUXszJtyNrNVe0OzTb2h3lko+sW5
        BlCEUt6Uf5QHcQpmQ3gzu5kKfkfPJP9dtZVxI6gnpw==
X-Google-Smtp-Source: ABdhPJyrMLTV+CWdNDmUPr7eiJ450LgaPMm/6QyCI2ugSBUfQT/aHAxPyhwPwc5pCP7HOzreW/pBZhds3Uo30GK/ALc=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr7110085oiu.19.1629569855413;
 Sat, 21 Aug 2021 11:17:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 21 Aug 2021 11:17:34 -0700
MIME-Version: 1.0
In-Reply-To: <d733d47bc6a86fe28302943e50d02bd5@codeaurora.org>
References: <1629342136-3667-1-git-send-email-sibis@codeaurora.org>
 <1629342136-3667-3-git-send-email-sibis@codeaurora.org> <CAE-0n531EgLx-gGJswmmNAFmy-P9z=Hh1N=fkLw_uemoeQnYVg@mail.gmail.com>
 <d733d47bc6a86fe28302943e50d02bd5@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Sat, 21 Aug 2021 11:17:34 -0700
Message-ID: <CAE-0n50z=MaEZhXRSQpN6Jo8m7nyQSS6MqikAgT5cfkH1ZvL_g@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] dt-bindings: remoteproc: qcom: pas: Add QMP property
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, mka@chromium.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-08-20 07:24:02)
> On 2021-08-20 00:25, Stephen Boyd wrote:
> > Quoting Sibi Sankar (2021-08-18 20:02:05)
> >> The load state power-domain, used by the co-processors to notify the
> >> Always on Subsystem (AOSS) that a particular co-processor is up/down,
> >> suffers from the side-effect of changing states during suspend/resume.
> >> However the co-processors enter low-power modes independent to that of
> >> the application processor and their states are expected to remain
> >> unaltered across system suspend/resume cycles. To achieve this
> >> behavior
> >> let's drop the load state power-domain and replace them with the qmp
> >> property for all SoCs supporting low power mode signalling.
> >>
> >
> > How do we drop the load state property without breaking existing DTBs?
> > Maybe we need to leave it there and then somehow make it optional? Or
> > do
> > we not care about this problem as the driver will start ignoring it?
>
> We can afford to break the bindings
> because of the following reason:
>
> * Load state in mainline is currently
>    broken i.e. it doesn't serve its
>    main purpose of signalling AOP of
>    the correct state of Q6 during
>    system suspend/resume. Thus we
>    can maintain current functionality
>    even without the load state votes
>    i.e. when a new kernel with load
>    state removed is used with an older
>    dtb the remoteproc functionality
>    will remain the same.
>

Alright. Is that reflected somewhere in the commit text? I must have
missed it. Can you please add it?
