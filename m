Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C897A32BBF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359000AbhCCNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357084AbhCCIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:17:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A776C06121F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:16:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t9so3665427pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=uYZRbhyL7KzOykj1NhE7gDh+zvcD7jkPKMo7lrnS5FY=;
        b=DYE2bMSIlQ6KS2zIrO0Q7S+dyA8pER+2xZ78O6sYhhkOx38htgA/UHJLaN6bULTLIT
         0ERT69auhkZfMq+LDdFH5/1v797hVRbQOzxZt5gTRooYRvfBBxIyKaN9j1+83J9Kj0io
         lwGNNbvB9vJTd2L6AGFjUSXKcJF9UIxlWamAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=uYZRbhyL7KzOykj1NhE7gDh+zvcD7jkPKMo7lrnS5FY=;
        b=mIMGeGzpq1M5B/XRH2SysKAB0Ik2dWr8l67dHD2X4fF3Zsnp96FIn5uSaiwfdy6Hn7
         U3WCzZjObnlP2Tgn0hwdfgeBUN+rMQtLLQHcdlQJFkA1fBtwBgYbXEVnNxawUUcL1h7H
         evmQE2k3jatOib7INimC8vLs8XsF3fbWEOSjbas02d9XltdvLsQPBvPUXilMIWsJ1fQH
         kk1ZDkBa0bbYkdLpSxFvckYzaNgqmjZoIvCPQSG6C9XtmkksQyy2gqRXtCsagi4E/Spu
         DpdgFznxiYgFYI/H07FR+bm3vkbm91UDp5hJojxiMfwsnXSUCSK7UQZhQjp6PLBkq2xP
         k24A==
X-Gm-Message-State: AOAM530cvH437HU43gRU2kROM+kPprRJR9clvHJ0ev3VfgCgk6mQIQqZ
        /GPiVWny7bPURei3FJuDEMROqw==
X-Google-Smtp-Source: ABdhPJxqtxECnSTfpeKTmKz9fSj8mPi+jxPuZBz5/OJXo7Tljxz5xj7N+IftqSn/RqtW+kDKkpkpRg==
X-Received: by 2002:a17:90a:f98e:: with SMTP id cq14mr8281992pjb.60.1614759367165;
        Wed, 03 Mar 2021 00:16:07 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id y63sm16317131pfy.68.2021.03.03.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:16:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210301133318.v2.9.I4a38fe64dd79c54af80d7e4ef5940f8cf4f86e75@changeid>
References: <20210301213437.4165775-1-dianders@chromium.org> <20210301133318.v2.9.I4a38fe64dd79c54af80d7e4ef5940f8cf4f86e75@changeid>
Subject: Re: [PATCH v2 09/13] arm64: dts: qcom: sc7180: add GO_LAZOR variant property for lazor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Philip Chen <philipchen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 03 Mar 2021 00:16:05 -0800
Message-ID: <161475936528.1478170.9732052355754437435@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-03-01 13:34:33)
> From: Abhishek Kumar <kuabhs@chromium.org>
>=20
> For trogdor, in the latest board-2.bin file, new BDF with variant
> name GO_LAZOR has been introduced, so we need this property set, for
> GO_LAZOR BDF to be picked.
>=20
> Cc: Philip Chen <philipchen@chromium.org>
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> [dianders: adjusted subject line and sort order]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
