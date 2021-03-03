Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678E732BBDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358801AbhCCNDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344790AbhCCIPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:15:38 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF6C061793
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:14:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d11so13599939plo.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Ys6kuPDFRi31EkQfNoVQbkWvHohfbwNBXe8ToIgFzPc=;
        b=AsuVtpWFV2Q636LgKkKnxXazaMOiw8680f1n5HPgHPAiaog2JDJYl9Yp6Va5KkXf4L
         RvS0e7mTZLko9V88kZO3b0pBVwHK2FZgpcI0b1k29oLc4fiKxd/68Nmlcfn87qXDFFBO
         4Vfy077i2rw0PoP0SP+eLMNUJe8/rp/tzDyPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Ys6kuPDFRi31EkQfNoVQbkWvHohfbwNBXe8ToIgFzPc=;
        b=Qq/sU6wHFpFxCxrXcF8UrXtzAFW1DRp9NnRAByuDVERgTh8+8gzdGNsxqjnzfPEXD0
         +yJ0ruNL9Rwjpk51pzl4vCR1hlNBSOXjOpLFHcPwq++1NBn9t0gqV/at8KfOGxdCAGWb
         uAelA40oS5cL6W85O/OPvPDSCI4FoScSICKBo3ELuMt5kHuMIXiI/U2lvwZkzaYAWRJo
         0bq5ICYir97m4j0ZVMCwv6lCq/qGVv2C7AN8BDKiqTXRZWU3VQlOEFTnAhhtstb8BgZp
         IvzJOCJiCMjpdsR7Mr7DVNTHmr43WZjR+TlMrNOrG93Prc29mnYppiPLffDAclqzcS/q
         7S6g==
X-Gm-Message-State: AOAM5332eGcXU76Kvx2oeByPdQirYIjQSIW3ZVZyTmnB+IYNBGKgCRY0
        nVOvSr4Gr2slq3U8iE9BEDWoyg==
X-Google-Smtp-Source: ABdhPJzFxT/t8kc9vVl/6aILPA0eun40kYLrV/D9zGBSCRUNhtEpDCAO7Wmx5gnU/F8yIsTkPqwcIg==
X-Received: by 2002:a17:90a:1463:: with SMTP id j90mr7788262pja.205.1614759296696;
        Wed, 03 Mar 2021 00:14:56 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id s10sm23329080pgl.90.2021.03.03.00.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:14:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301133318.v2.4.I1483fac4c5ae4b2d7660290ff85d69945292618f@changeid>
References: <20210301213437.4165775-1-dianders@chromium.org> <20210301133318.v2.4.I1483fac4c5ae4b2d7660290ff85d69945292618f@changeid>
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: Unify the sc7180-trogdor panel nodes
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
Date:   Wed, 03 Mar 2021 00:14:54 -0800
Message-ID: <161475929481.1478170.891014466656181696@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-01 13:34:28)
> Let's avoid a bit of duplication by pushing this up to the trogdor.dtsi
> file.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
