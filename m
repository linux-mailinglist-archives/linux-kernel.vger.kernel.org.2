Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB59035D5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbhDMDaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245500AbhDMDaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:30:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE762C061756
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:29:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so3438096pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=DynDyWvccRYWPixdZN4H8oJ4zvAUSDNQf2dmUS2wW00=;
        b=Ql2Y2Kg3KxgNqF3Zg8yz0YIMGEicTbn1eIgNdhf4EPE2qyysjk8AssDl42K3Div+5T
         /4xnHeJVzx4DG9EHMdtng46958IMwdL0u1FlfgKzZapuBL42VnweL9/i3pYSquPq/GCE
         y16hpkz/ha8LsmU7OZiz0FcfjDQCJvz2sCi5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=DynDyWvccRYWPixdZN4H8oJ4zvAUSDNQf2dmUS2wW00=;
        b=gfjzmQBx9Z/D8ZqjN0cwCMHa36F+0nmyJoGZS9OUfGwy3YzLX+MCH+XT9+hvbralZH
         P1etyCH+ByveUCf6ysRq1/Q2lDFLXE8409xdCzRPkNw243IfPVVg2PyUoLKXk9nB0VQU
         EFn6jTw1Oubx9h+gs/gVOYs5suRRRUn7t6I3bbxhaYK5Kb7DAUcRKcMc4Z3iI+YU1K4j
         528PIGS16eVj4GXYJrqRuGS+t8SlxBVDdwC7EqwW3EbIHQej6TdkbRG0PnLFxhLyKLkP
         pvlnofyJCT7QAPBvZDKkXvqrB99xBjlmb6EUvG5ot0KzMs1r/1b8/oGujE1HCiQYkp9Z
         XZag==
X-Gm-Message-State: AOAM533xXusSI0N6vEyiarb3yEuMZ7tOkj1Z7dnLJBIeLKKAGjOfkEdB
        /iqfpBdhKLT6gjwenWaim/Ma1A==
X-Google-Smtp-Source: ABdhPJw9dbnsMYGsSa9Am46g8wAw3a8D88wOwThNmlb1jIzTMyJnO6BG+AI6KgAd6QyZgQVycVY1Vg==
X-Received: by 2002:a17:90a:e28b:: with SMTP id d11mr2583048pjz.53.1618284597380;
        Mon, 12 Apr 2021 20:29:57 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:1d18:a339:7993:e548])
        by smtp.gmail.com with ESMTPSA id r1sm11724978pfh.153.2021.04.12.20.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 20:29:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1618246971-28754-1-git-send-email-khsieh@codeaurora.org>
References: <1618246971-28754-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH 1/2] drm/msm/dp: check sink_count before update is_connected status
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Mon, 12 Apr 2021 20:29:55 -0700
Message-ID: <161828459569.3764895.16686521998891540267@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-04-12 10:02:51)
> At pm_resume check link sisnk_count before update is_connected status
> base on HPD real time link status. Also print out error message only
> when either EV_CONNECT_PENDING_TIMEOUT or EV_DISCONNECT_PENDING_TIMEOUT
> happen.
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Also please include

Reported-by: Stephen Boyd <swboyd@chromium.org>

in the next post.
