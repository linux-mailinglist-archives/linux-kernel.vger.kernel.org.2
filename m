Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0D30C9AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbhBBSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhBBSWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:22:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C116C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:22:02 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i7so15417437pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=H3Ktduf2QxtISjs8SRv/RgHUJLdczDldyTBeCd9r9t0=;
        b=JZKF6L+xZ0ixNqQkugWKwkTH8BX4f7XZ4EnCXuycwHUkO/STif4yShPRGkSWv3WnE+
         TwlGVsIE8o5elNHxDk0dHruDHycMm1uiXsGRWUc0OFaLyRiAts55Zaz1i15DK9kVzLlu
         lHiC7/zQ3USfSRYNLs3uhIfeK5ibwcw69YygY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=H3Ktduf2QxtISjs8SRv/RgHUJLdczDldyTBeCd9r9t0=;
        b=mvIlRNOdkLPCqMkdfvaCIpAy6Ufmc6Xspxt4pBgNO+148H4OvqATURKOqYRNI//AFC
         3slxyLZVETaCM7I0Ret5vVaphtyQ9OqajpJeS+sr3lNMG4hBbFiqDMUcNp/zygBZGaKZ
         1bBiUM1GWDxRpD0zOO0DA/1kCy3ARnSc99LGyBKT0RnLqJX12lOI1lxXkcAjWykPRaS5
         rf/UcEFQcXbkMhg/1vCVbOT40TL1Hsi4rNf/BEwaIlIdEy4wRb787qcOzym0WtX9Z7D+
         5SgD5OlTiaFG5C4Zybbi49/YVQhvmLXcaZhIAajQYJewOVjCca8+jPuIHVZbXpqTZq5k
         /YPw==
X-Gm-Message-State: AOAM5332zI4w25aJO2+1BT/+KE3VJVyDuUwmdY9+yvDW0ipLyGkhWzFM
        tZG3K/SZYm7BIIQQh3QoLaUDyw==
X-Google-Smtp-Source: ABdhPJzmldyf2y2Wk1vWOl94CphO+LqXsIC7rCCdsLOlh0sJJeqoonhUJhmjgpgtFexAJ0nzN/uNuw==
X-Received: by 2002:a65:4101:: with SMTP id w1mr11472979pgp.323.1612290121838;
        Tue, 02 Feb 2021 10:22:01 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3571:bd6e:ee19:b59f])
        by smtp.gmail.com with ESMTPSA id q2sm20238115pfj.32.2021.02.02.10.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:22:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210202123214.15787-1-bernard@vivo.com>
References: <20210202123214.15787-1-bernard@vivo.com>
Subject: Re: [PATCH] drm/msm: remove unneeded variable: "rc"
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     opensource.kernel@vivo.com
To:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Bernard Zhao <bernard@vivo.com>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <groeck@chromium.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Feb 2021 10:21:59 -0800
Message-ID: <161229011920.76967.17860389589804358045@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bernard Zhao (2021-02-02 04:32:03)
> remove unneeded variable: "rc".
>=20
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
