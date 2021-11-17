Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC9454102
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 07:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhKQGnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 01:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhKQGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 01:43:12 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A5C061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:40:14 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n66so4186838oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 22:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=sTIAMjYbIgPw9BtP6BK0EtEhZfFJG39339XpbTQz4q8=;
        b=A0tibesQgJVPgiCl6aeIuALbSS6lrs8f6fPC/c+D8Wf1ORiIDWJ+s1ln7Shzh1GpRD
         ro3/eplCp9UgHmCgISTLEFDSSv+2L/qNZBmCOztatF3fMnZQRQs/fCX/uDFgzO+5BbFn
         7jbYp3FaKRjgdElxiI9IpgGIo3racyC4WLSiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=sTIAMjYbIgPw9BtP6BK0EtEhZfFJG39339XpbTQz4q8=;
        b=kvlTeohkwHV3wW53bmQ8Pu0FST0GeP3hY52uDf6K9v2IAVy1CCr00yGp3L+tqKjVqp
         xbRgBV57lru1Gea6dTb6i9wWKmzog6KfMLxq/Um4aPqyc4lKDR1bBR+dTzw8jrrkEX5f
         m2ubjE5qofgAbZOEpGfhlFaXMXA3msVHS4SFbnn1KoKoUfeXqp5q7OmHaHX+1b7+q3D7
         NqvyjSWINA4JQzyUASBa13IGB5z/XYQJj/j/LCSkv2ROs9N1P1WDvzwsqUprJ2qNYPsz
         Je1/4nHT98AF1kuV94VLaVhZd1U0/hFTG6CvGOGUxZP1/QEnatuidRI31nzJShHErjwK
         r/Zg==
X-Gm-Message-State: AOAM530p/1QBmbssWYfivttLKXta98wHIwMtGjChw6E35/swAAtVmK7J
        uV3IwraiKbmCB5p7bGok+2ZduI5cy12jXAW3b09wuQ==
X-Google-Smtp-Source: ABdhPJwL9sejHW2saSeYc0Y8yMtZq0mvyD1HM5tD4KfGOegNHF0M+D7BAXpiycc0GG7yCK/vgooZobtV5T5yDPezdgU=
X-Received: by 2002:a54:4506:: with SMTP id l6mr58766242oil.32.1637131214191;
 Tue, 16 Nov 2021 22:40:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 22:40:13 -0800
MIME-Version: 1.0
In-Reply-To: <88a5219e-c82a-87fa-6af3-578238d6027b@quicinc.com>
References: <1635896673-5841-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53ArJSYEAtLbc5dFrPspKhi3Kv=hpu=wS1TMsOWcmz6pw@mail.gmail.com> <88a5219e-c82a-87fa-6af3-578238d6027b@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 22:40:13 -0800
Message-ID: <CAE-0n53cbEAXgE6+9b+pqxGFayhB-2evhnzQatfoCc2h1r5VmA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Add Display Port node
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        robdclark@gmail.com, robh+dt@kernel.org, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, quic_mkrishn@quicinc.com,
        quic_kalyant@quicinc.coml, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-11-16 08:43:38)
>
> On 11/15/2021 3:39 PM, Stephen Boyd wrote:
>
>     Quoting Kuogee Hsieh (2021-11-02 16:44:33)
>
>         From: Kuogee Hsieh <khsieh@codeaurora.org>
>
>         Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>         ---
>
>     What tree is this based on? I don't see edp_phy upstream for sc7280
>
> this patch is depend on=C2=A0 --> [PATCH v2 4/4] arm64: dts: qcom: sc7280=
: add edp
> display dt nodes
>
> it had completed reviewed.
>
> https://mail.codeaurora.org/?_task=3Dmail&_caps=3D
> pdf%3D1%2Cflash%3D0%2Ctiff%3D0%2Cwebp%3D1&_uid=3D1789&_mbox=3DINBOX&_acti=
on=3Dshow
>

That email link doesn't work for anyone besides you.
