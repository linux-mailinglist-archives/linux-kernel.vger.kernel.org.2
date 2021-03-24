Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE2347DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbhCXQ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbhCXQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:28:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B829C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:28:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t20so8211453plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4FDhjn8F4kjGyuKc/8jnoebjpeHUlznny+1iTWmt3ik=;
        b=TsY3yix9JYzH9w3GsTijlIfU1RaQvEgi29AWErS4Jf2CJ+LRh2RS5MRGum9KTPZeh5
         n8Rgd7/OQWrK3EUcsmZGsxYj6SPrutAl8757HR/y91vPaLdSIR9ucCTRCChPPaKt2D8T
         P1t8JOb8u8zBUa3QAgunbfIujMIWqdvvU5vzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4FDhjn8F4kjGyuKc/8jnoebjpeHUlznny+1iTWmt3ik=;
        b=no9gwZmM60MEwlNubGt7YeM8fJnU2ni7nrkfuxyjL8AZG9lZX+CUUrtdpjmBBnwNcm
         MXTZv3gM3ppb9MHhbhn4FYfvGVbEaFI667hRo9Wuua7tsZoKg4kjbLQTeSoshiakeJIb
         Qdr1XiimpRQ2JBG2GBGZmk0QWgQGG1XIt45H2aN0JIzl/nMu1P1LISy9g/8QU+zAYSTr
         VT8uwVihJL4KdPS9VseRZn7jXnjmt3kDMowaj+VuxslJpznEyV41NtsUd6hm3VR/rjI4
         sSYZyLhO3/3/kw3l9ipGuQD8rBgjczgC5Rzj/eVlCv3fkcidx9xUtLK0Br8zaUH176pf
         heyQ==
X-Gm-Message-State: AOAM5310rM4Z4M5vp8H9R0Dzb2YnKzUyurqeFeMucZmkk8J+pAr+Ereh
        IzWE55t+VmXK++cBwvpYQhtLfkz2iQ9Pfw==
X-Google-Smtp-Source: ABdhPJxx95a8sKxKKG8ygLhnz44Vegp79a4ZrQl5c7JYQE9fIBD844QAoFXVlnijFAUrY29+54rBLQ==
X-Received: by 2002:a17:902:d2c7:b029:e6:34e2:7a83 with SMTP id n7-20020a170902d2c7b02900e634e27a83mr4444859plc.60.1616603313667;
        Wed, 24 Mar 2021 09:28:33 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id c6sm2963022pfj.99.2021.03.24.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 09:28:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <161660145349.3012082.16210818967187877873@swboyd.mtv.corp.google.com>
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org> <161648289959.3012082.11356063123403968180@swboyd.mtv.corp.google.com> <363c5b7d9baca5a010552137f80a1cf4@codeaurora.org> <161660145349.3012082.16210818967187877873@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD card
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     adrian.hunter@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        rampraka@codeaurora.org, sayalil@codeaurora.org,
        sartgarg@codeaurora.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sibis@codeaurora.org,
        cang@codeaurora.org, pragalla@codeaurora.org,
        nitirawa@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
To:     sbhanu@codeaurora.org
Date:   Wed, 24 Mar 2021 09:28:31 -0700
Message-ID: <161660331135.3012082.15196616622122288364@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-03-24 08:57:33)
> Quoting sbhanu@codeaurora.org (2021-03-24 08:23:55)
> > On 2021-03-23 12:31, Stephen Boyd wrote:
> > > Quoting Shaik Sajida Bhanu (2021-03-20 11:17:00)
> > >> +
> > >> +                       bus-width =3D <8>;
> > >> +                       non-removable;
> > >> +                       supports-cqe;
> > >> +                       no-sd;
> > >> +                       no-sdio;
> > >> +
> > >> +                       max-frequency =3D <192000000>;
> > >=20
> > > Is this necessary?
> > yes, to avoid lower speed modes running with high clock rates.
>=20
> Is it part of the DT binding? I don't see any mention of it.

Nevermind, found it in mmc-controller.yaml. But I think this is to work
around some problem with the clk driver picking lower speeds than
requested? That has been fixed on the clk driver side (see commit like
148ddaa89d4a "clk: qcom: gcc-sc7180: Use floor ops for the correct sdcc1
clk") so ideally this property can be omitted.
