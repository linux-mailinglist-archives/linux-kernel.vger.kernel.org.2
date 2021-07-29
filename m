Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD9B3DA8E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhG2QYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG2QYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:24:44 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A4C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:24:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id z24so6515374qkz.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrbYP93L2tMwFoTHuD2bfzhhJvQFO01pQtZG8WiVqAk=;
        b=Sohrb55AH82uy9S0BXeyNZ+trj8sQwFMFTGrix422Z6JvroYXcGAMVMQf7fIlpvDAs
         eZruADDr/U7SRQI+eFcQ/AqKzwY8WC1A7fGTSbCrnns45gvM6Zp7rbHVWbq2N4Li0+mk
         r879Og8Y8m072gVYEPBs0guffl9ggBZ5X88x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrbYP93L2tMwFoTHuD2bfzhhJvQFO01pQtZG8WiVqAk=;
        b=RB6FUDsQa3jnRhbP3/pXjfjEUEBbmULbGjgRG6AGM0/71T7MCJknub5QdjEEPnBdkV
         nRqIdcDYxNRobbULHncMYin2cK93Xust6GX/3ZYMh6ZHugeLR6BvN+nYyKanl9KXJzDa
         FGwOoTCv2+tSAnD33Iicbrpkv28UwggwJaHhTeaOgtYku0quCUogVDTHG6x2kDt1Ozd6
         7wj8pNCy4MxOtOCEKytQ+E2JqaqjQseBOnHUHCteIGcxznQSTImH6k38ot7E/JWfMSLm
         mtXWD7+RtzHV4Ul1NgMiZsdw/PQsUKYFyRuiC7pSDbODWkIhTUXukNe59aeY2lBOnnXH
         wsKQ==
X-Gm-Message-State: AOAM531yKs+uD5ATkNGHT29LW2ZKFZV2Msiz6P7J0KZjiBpOFITsmRGU
        uS1WN74ccm/S690oky1++C9Kp0VaNkrH2Q==
X-Google-Smtp-Source: ABdhPJwIx7nFwgAQ1IDXmA42iH5+QcabHDYzct8rk3+Bptb3bvjDU4vjX4RqS8SOY2OgyKPoP7P3xg==
X-Received: by 2002:a05:620a:318e:: with SMTP id bi14mr6182489qkb.176.1627575879857;
        Thu, 29 Jul 2021 09:24:39 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id g26sm1937545qkm.122.2021.07.29.09.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:24:39 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id q15so11159143ybu.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:24:39 -0700 (PDT)
X-Received: by 2002:a25:2904:: with SMTP id p4mr7625518ybp.276.1627575878937;
 Thu, 29 Jul 2021 09:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <1627560036-1626-1-git-send-email-rnayak@codeaurora.org> <1627560036-1626-4-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1627560036-1626-4-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jul 2021 09:24:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UYsKNgZZUmAM22Mwxz7fJFN_3p0YRx6W3dnZHvd13_Zg@mail.gmail.com>
Message-ID: <CAD=FV=UYsKNgZZUmAM22Mwxz7fJFN_3p0YRx6W3dnZHvd13_Zg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7280: Add qfprom node
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 5:01 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Add the qfprom node and its properties for the sc7280 SoC.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Peachy! I guess a future patch will add things like USB2 trim and GPU
speed bin definitions?

Reviewed-by: Douglas Anderson <dianders@chromium.org>
