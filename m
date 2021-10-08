Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C563342736A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 00:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbhJHWKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 18:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbhJHWKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:10:42 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F03AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 15:08:46 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l7-20020a0568302b0700b0054e40740571so7627132otv.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=eRM/GW7Nz2OFw2k17twQGnIo0wF+tOa2AlGFVMS86EM=;
        b=F0dXedi0IAD47x8czJsAGMXrivcfwYxv4pkmpOdt840ykD/TvJNwmnRHgY3tYnVuAV
         9rK2pF290E+2PCT6YQz0gOaYFRhycaDZZi3lAmei0A1L+wMl7EC9I9SmUT7P9iA1oLcA
         sRYqEVqquRbwepfOiBt6WkbATF8yFjWaMxQ1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=eRM/GW7Nz2OFw2k17twQGnIo0wF+tOa2AlGFVMS86EM=;
        b=LKQy9my+nBB4xBKwq1mrkHU5x1lK476xiKmtj2tOuqSz5vufxdelmy7DlEV1e8L/LL
         MVe8N8+sgV7/sEvwtEDCnIixa1HNlQjBCHs/MIqyfkp8vtNM+iElga3h0I/0DOYEZDwR
         KIR9iNqowD7lThLsaGTVqEjhnndhr/Rv3N1Q5KUDPzR730p3vlKF2j4BHLDGw0MD9R6H
         CA1Tn0KHfmeIuOPITfeZOtmXgsMPmHEKmF2uYGlkb+RxDMwnnFHZn5I5h6lp4fp83jW5
         M9qhkKsC8dweYLN2fp1Z9JSzSflVzy3KzZGg6r1dEV+b56YFqgcikite14AWcrA2017+
         YWKg==
X-Gm-Message-State: AOAM530aU52icz35/C4lWaQkLNSkc9M4B1qRxjlyHULROxPhCz6Z5XcS
        XWiPqdoc/qE1L84an+MKcuwJNZbMJ80DGtkjqUliVpPioP4=
X-Google-Smtp-Source: ABdhPJz+XzsxfBUPNSFtRuDtmegWrFGX/Yeg7TOOT9hLgVYsP64+/r5mtnoQas58CTF5G3R7gSZlZ6JOVqs0ba2v9aE=
X-Received: by 2002:a9d:12f4:: with SMTP id g107mr6848914otg.77.1633730925558;
 Fri, 08 Oct 2021 15:08:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Oct 2021 18:08:44 -0400
MIME-Version: 1.0
In-Reply-To: <20211008113839.v3.2.I187502fa747bc01a1c624ccf20d985fdffe9c320@changeid>
References: <20211008113839.v3.1.Ibada67e75d2982157e64164f1d11715d46cdc42c@changeid>
 <20211008113839.v3.2.I187502fa747bc01a1c624ccf20d985fdffe9c320@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 8 Oct 2021 18:08:44 -0400
Message-ID: <CAE-0n50UhQ75iDcdVDu6V6jv9tXLsyaW5NRJ6i=caf0uMNcueA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: sc7180: Support Parade ps8640 edp bridge
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-10-08 11:39:35)
> Add a dts fragment file to support the sc7180 boards with the second
> source edp bridge, Parade ps8640.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
