Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DD325757
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhBYULM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbhBYULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:11:03 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D62C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:10:23 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so4344458pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=swyMy5/0Rp9qCosdNVcZdjaUALxgy3MHRytEm+vRwrQ=;
        b=VXOp7z900xqaqjf/pwL8dQdzm8m0TcozQ2K/c01FbS80t90yBrY/27ME8755vqgl72
         BbdEsBi6x5d8RJf+NUMIY8B7ipJsyj6DyqqN6/nZ3vJWkjo3DFsbTZRkaMR4BiRdDTDO
         tThdmBJec5ENzOg6Q4kiByjAP/BYre73vr/Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=swyMy5/0Rp9qCosdNVcZdjaUALxgy3MHRytEm+vRwrQ=;
        b=pmDNVjKfjmUeqi0C5izlneebZu3NaI2X+9C+eVxNYKtgwZe7Bwt3Q5+bVUnQK9MM6H
         AqrKoJGpoezkxBugLD8ADxlNAhFlYvzL5K1PhzbFjKk21bLG2W0JTtcA0hUfrcGbaiOL
         kYruFKiL5+WkCTnqW4ttNgwqzLiQ8LheY4xEJ4aY7tDWQf2ugSJTFz/5c4RrA7ICrtkC
         EJCPYyuT1JUz6MLU1bmV2lwb3ClxqKsz1F9svzEzLCQDiN19pQzvpkzx9+3FrlD6BWLI
         4Iu0+54PQn5Ss5G79savPyxQSCSi/OU46pfwn4UM78NvPK9N7bKJjEOQTpbBXKvRL5PA
         G3Uw==
X-Gm-Message-State: AOAM532m4HJ2lKTLLXLTsCsDGcveuqBqAxe4WHBSpUYRnwt+HfPbWy11
        gjLGJ1ZHMerBop1rJYOkksp1Jg==
X-Google-Smtp-Source: ABdhPJylGmX26FSNU4yW9cKMW6aPGHiyhtycnQKq1zZKMV4KrnbPf4L5DcnAptWYIhgQLhVIH6kXmw==
X-Received: by 2002:a63:d601:: with SMTP id q1mr4442742pgg.417.1614283822348;
        Thu, 25 Feb 2021 12:10:22 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:b942:93a8:e68d:5a90])
        by smtp.gmail.com with ESMTPSA id k11sm6629386pfc.22.2021.02.25.12.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 12:10:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210225103330.v2.2.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
References: <20210225103330.v2.1.I6a426324db3d98d6cfae8adf2598831bb30bba74@changeid> <20210225103330.v2.2.Ia4c1022191d09fe8c56a16486b77796b83ffcae4@changeid>
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sc7180: Disable charger thermal for lazor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Feb 2021 12:10:20 -0800
Message-ID: <161428382042.1254594.15382294447104869744@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-02-25 10:33:35)
> Lazor is stuffed with a 47k NTC as thermistor for the charger
> temperature which currently isn't supported by the PM6150 ADC
> driver. Disable the charger thermal zone to avoid the use of
> bogus temperature values.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
