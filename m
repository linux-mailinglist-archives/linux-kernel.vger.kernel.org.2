Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392D832BBD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352159AbhCCMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842752AbhCCIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:12:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A68DC061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:11:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l18so3839380pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=DMQiSblKmDEtFz8Bw7dmgo7l8LMebNEzg/kjl/liqLE=;
        b=CT2YnraIqGDeegc9kIxrFgu83h+aOyX8MHYWE5TkKVrlsewCS8M2DBC74Ikk6wS7Ih
         FHYyVjx/IpBm/jxbb3BQJm7wCXmouSMC2bupCDVxi6hSF9yeRItrbkj/hGx4M1nubiPX
         pprCZCuVKh3K2Ou/uJXQH/hhlgm4kAdGCSf6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=DMQiSblKmDEtFz8Bw7dmgo7l8LMebNEzg/kjl/liqLE=;
        b=p8lWdXWcPf/CIbVwlAl7bmd+1ezd+PAGA8AfwKdJtej8GxhlvSqisnQi1dj6kwhe0d
         8i9+xGrkKirNGeyYwDcyf46TkRfV8AGzJ8O1bpabP9JdnyWS44t1/w3gNlqKqCkYvBnH
         0XxtjBSzQbwQO9In+nl0T6nfH8yNE/y5Tac3n9LXBfTbZZ5nYCqoHZkw3SIMsvm4ZerC
         9v1EOMJEbznVF64ggPs0NVnDtEDNC2Vg6cURfU456RClJMWBm80hC7Cfb8v6O37lc5Ll
         YrA6ZXPog4OD3BJRpZ7P+gBdW7wZu8m2cqFvV+lALT/AAGy7e4310XkUuk0v4xGh3vdq
         DQ9Q==
X-Gm-Message-State: AOAM530MNJeunYob7wGleGrXr+lblW+AXKp4B/jN4+5e6VhlmG1oqHEA
        OfYRhuE47GJiWJp1APJnMMudTQ==
X-Google-Smtp-Source: ABdhPJxG/tKzWxUKe7+dddHY2Jcl8eQsDrsMzm3AcEg1Vm6JEscnTVVEqx9/efCzaa8Uw3lummw/PA==
X-Received: by 2002:a17:90b:909:: with SMTP id bo9mr8451689pjb.107.1614759108852;
        Wed, 03 Mar 2021 00:11:48 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id u15sm22547301pfk.128.2021.03.03.00.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:11:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e96d665d1e98b46a189a57e39575ae0debf37172.1614669585.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1614669585.git.saiprakash.ranjan@codeaurora.org> <e96d665d1e98b46a189a57e39575ae0debf37172.1614669585.git.saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: Rename the qmp node to power-controller
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Date:   Wed, 03 Mar 2021 00:11:46 -0800
Message-ID: <161475910634.1478170.13268307384255747031@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2021-03-01 23:28:01)
> Use the generic DT node name "power-controller" for AOSS message ram
> instead of the protocol name QMP(Qualcomm Messaging Protocol) since
> it is used for power management requests.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
