Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9132BBDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358782AbhCCNDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhCCIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:15:07 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E0C061797
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:14:25 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id a23so5976361pga.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=P1dtltEjETKu3sTEniyo9zPnCTLC+x4yGC+jPDmiEdE=;
        b=DFjBbYW4i7nCNY+8nO3JLdXqK6DlITs2S/fUluYL7jQmvOks/+LOnBODIJkfkcbrr3
         WQ/a9PQ72NTSPxepkYLKTr7fwq61U1oCn9Gq9Dd/KfASm/mJc9Rmw2JQzDL234Q9TQP1
         tmUSLG/OQQXqYjZ58xZTB9603sXSqWsQy0rqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=P1dtltEjETKu3sTEniyo9zPnCTLC+x4yGC+jPDmiEdE=;
        b=toBlEAClY4aiVg9GnjljleBawOJFBxxPE1PcqXAE840ZJseFq+A4amAvmMR9d6ibV7
         Q7G/l9dWthvTmvhpaJUDowWqJEtNG9kL/xtWZ0ccVFsJc+kJK7/wDRyU3jNjBQuo8R9N
         tm8vHinEMEr/FAMBHHtLbqNtlVdHaVq5G/iXNQ4c4wPx9eDgl3hzO0MbaRQatsZM2kWX
         ZdQ9oYXJEM1e1/C9tI8Zh4EZ4SSLQ+TCWjoFBaEW6jQ/X4i5NQqOxBFTFr2O2sF16X33
         MzhdKw9nhzofXyQJ15j9hv+eFCw46ReeDYd8VzVIr/Wb9QuDQgFItPAOVPG6Sl7hQ74K
         GPCw==
X-Gm-Message-State: AOAM533G40EOF8fmlgEnGjHj/uVJM95UMe+62ZB28z53wtmYzPR+ijuz
        kDNxXSgaJpQmSK39iAXvdHvosw==
X-Google-Smtp-Source: ABdhPJxNhzZMc6gB6O8kxv/u+g9OfQs7Cdr1qTVz0+CIRmAneXjymSzwnIP3u80l2INlse/RgyrUJg==
X-Received: by 2002:aa7:87d5:0:b029:1ed:b85b:1420 with SMTP id i21-20020aa787d50000b02901edb85b1420mr2004823pfo.17.1614759265611;
        Wed, 03 Mar 2021 00:14:25 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id r31sm16414439pgm.11.2021.03.03.00.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:14:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301133318.v2.3.Iddf6dc8102aa4fbc3847936226fc7bf2e2cd315c@changeid>
References: <20210301213437.4165775-1-dianders@chromium.org> <20210301133318.v2.3.Iddf6dc8102aa4fbc3847936226fc7bf2e2cd315c@changeid>
Subject: Re: [PATCH v2 03/13] arm64: dts: qcom: Prep sc7180-trogdor trackpad IRQ for new boards
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 03 Mar 2021 00:14:23 -0800
Message-ID: <161475926359.1478170.7064077548869689969@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-01 13:34:27)
> The trackpad interrupt got renamed and also moved to a new GPIO on
> newer boards.  Let's do the move in the "trogdor.dtsi" file and then
> undo it in the two old boards.
>=20
> NOTE: since none of the new boards have device trees yet, this change
> looks silly on its own but it will make sense after more boards are
> supported.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
