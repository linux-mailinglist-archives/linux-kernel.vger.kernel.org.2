Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAB32BBFA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382753AbhCCNbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379178AbhCCIUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:20:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E27C0617AB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:20:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u12so3856946pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=AwiOUOhuW6EnFueyj5x786yWZvf8VJgxR6bk+bVje3E=;
        b=kx71mWOK5eWW6fp8ZhJtKANfnVGfTfg0iIEdrNdepDNYMPlJZjwB0CNV0nPVukJiCA
         DuX6R2KPw1f6N4VZo6IPa2Dym+ZA7tGSA0ufAGP5lKilaoQh+Pl/f+Q/2lXuusIvlCHh
         ribXlaW5wW9MfBiA+ZGvRPl4Fb2p3Ouegrdhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=AwiOUOhuW6EnFueyj5x786yWZvf8VJgxR6bk+bVje3E=;
        b=KudCelR6EnUFYChw3rWuYE6xOyaNlGAjhZ1CuIeZxrE6jdk+7nk3Rizo74ep8JhIJ2
         aIGsr9HTVFPpq6tz1huR+Q53apwNA8SPird2NF7q7eAc45ZDz6dluPWnhSlKmvzfa9dS
         29iWkkLBcxoqSwiau4uchDoIvyaZp/VasvDG2SMxyITIoz0pJmd4kkOeBpw5K0wVYwXU
         1LuMncWc1x4LObD+Fy5S3BGG0ZPac1oAK4X+kXA8f6zFWilqzPJcSux1W9yZZK9MTvEf
         y0tUm/UxtmexWhlSIWbAFy2G5pYzGqyV6uupdqZxTqt9qge3lxNvlgQkuJXIMpyghX9d
         ydbg==
X-Gm-Message-State: AOAM531UdCLtmeHUubgPrSvQGFABGa+86QH0sk4JT1WF5eywU7lu8swt
        BRSgH+L2ktFb/m0kgEcMAVcYAw==
X-Google-Smtp-Source: ABdhPJyjAUMDV1wD5FKXN7q7V936rQC9rZcj2ZaH71aZcprTlyXEx2AOKVqi73/ddsFayGMzHLpeqQ==
X-Received: by 2002:a17:90a:ff05:: with SMTP id ce5mr8434898pjb.156.1614759606898;
        Wed, 03 Mar 2021 00:20:06 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id m12sm5751554pjk.47.2021.03.03.00.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:20:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301133318.v2.13.I3d1f5f8a3bf31e8014229df0d4cfdff20e9cc90f@changeid>
References: <20210301213437.4165775-1-dianders@chromium.org> <20210301133318.v2.13.I3d1f5f8a3bf31e8014229df0d4cfdff20e9cc90f@changeid>
Subject: Re: [PATCH v2 13/13] arm64: dts: qcom: Add sc7180-trogdor-coachz skus
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 03 Mar 2021 00:20:05 -0800
Message-ID: <161475960503.1478170.3435043996618334113@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-01 13:34:37)
> This is a trogdor variant.  This is mostly a grab from the downstream
> tree with notable exceptions:
> - I skip -rev0.  This was a super early build and there's no advantage
>   of long term support.
> - I remove sound node since sound hasn't landed upstream yet.
>=20
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@chromium.org>
> Cc: Judy Hsiao <judyhsiao@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
