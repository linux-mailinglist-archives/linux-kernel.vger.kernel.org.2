Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D830E7C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhBCXns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhBCXnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:43:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741FEC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 15:42:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o16so855710pgg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 15:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=yHURpLyu/TquLwx0y6eDJwaaKqJ+uw0cFvyf4JRgnoA=;
        b=Xbu8iTy1ZRPuaYXRVmxobKDV5EKGQvnequV/L0RekgYt4FzgK9lp0xnGDN73+uQyoI
         ytcu36a54c33UIBrX2kuE3aKpL+gwWCeMAsiadVMATEvvyhykfzqXLIj75BPw6+eCBgM
         +vD8KVcdswPshqB4gWnt5M3kUDKl0LXXsgLx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=yHURpLyu/TquLwx0y6eDJwaaKqJ+uw0cFvyf4JRgnoA=;
        b=goC2JxIJFuhEyzwhnRPow6bFRQ1v+WAwjCnwZqT1vWBCFuHw1KH35qxAOOmQ7vQ+4f
         7nTgajtlhOwmaJEVCgLRuEPAFeK/GNtuYYs4ZtNEC1OlpygsuDVL+wrsOzbdOxWLjZam
         NpKsyhcDgUbGoPz9rhRyuckL8+yJT/LLEzOtcYDI/l5sC2d4MCJqcgN03+Hsg+zekkxw
         18bbOvFWM01TiiF6Lx9sJ0REU7ZF2WGrWZkJ1t5OGKK15i9OzqlR/IS8zQfVvbIFkDF9
         aF4byUUf0cAXeaBFcoUnZv5iFDHJdDTbDu8SSMM76J4xBU/g12gmG++rFDwUIZD0y0B0
         gglg==
X-Gm-Message-State: AOAM533umsnEFrbT83C+cXK9p6L090HL8rt5Jx7roXhO4clI222Utvtr
        jaQAOoVjxfqthXvgJVvE7WaQpg==
X-Google-Smtp-Source: ABdhPJwhsJh7E/fIDVP54k0kiykGJypLBRTzhIYCPpD8yyPHqosMKVlqghMEgmQEviD79/BVAuLORQ==
X-Received: by 2002:a63:454e:: with SMTP id u14mr5968407pgk.113.1612395757069;
        Wed, 03 Feb 2021 15:42:37 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:59f3:e03b:c082:48d])
        by smtp.gmail.com with ESMTPSA id r189sm4026820pgr.10.2021.02.03.15.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 15:42:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210129094416.53601-1-vulab@iscas.ac.cn>
References: <20210129094416.53601-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] drm/msm/dp/dp_ctrl: Remove unneeded semicolon
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Xu Wang <vulab@iscas.ac.cn>, airlied@linux.ie,
        chandanu@codeaurora.org, daniel@ffwll.ch, khsieh@codeaurora.org,
        lee.jones@linaro.org, robdclark@gmail.com, sean@poorly.run,
        tanmay@codeaurora.org
Date:   Wed, 03 Feb 2021 15:42:34 -0800
Message-ID: <161239575441.76967.11776777354164899550@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xu Wang (2021-01-29 01:44:16)
> fix semicolon.cocci warnings:
> drivers/gpu/drm/msm/dp/dp_ctrl.c:1161:2-3: Unneeded semicolon
>=20
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
