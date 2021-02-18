Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33EA31F2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBRXDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBRXDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:03:13 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:02:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id j12so2429538pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vapw8v9gd6gzUZfgZWeHcnI7BY6UOi1UlhquxFwuYA8=;
        b=myyxUgL8UCCIqyF9TebzT62kDycJr1y+iVGqSe8euO0ZH6L0wL44ljB1lRBO2DwHFa
         pvcC4/CkIpCKc+n23ZHRreytCuqUSGCi268XsZZ6pRIUauZYc4IdG4pv6tWXXocLUIaW
         H918ZYZifVJj+zdvqTI+5BJzJUa91CWz8qH3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vapw8v9gd6gzUZfgZWeHcnI7BY6UOi1UlhquxFwuYA8=;
        b=AkjnIlDYXbma1ngKa301INGWtQsLVpuBg9dQtrygzrN0W9MtBoBT3Ug+xgGTzCif77
         qzVCCCxx8gxoJ9QbkHeRGvIWKez4dLDlLdau4qGNHjXvTWrJE36hpR0ZX6WZvM76M5vy
         AJjMS+iXo++2wucvR+mqlGKepkcYxt8s0fbZzq/t+7B8JE79PVpTKMDAVBY0qdOe7lML
         dgNBFftEeBYb/ObTX6VQKHzCkPi42dDfDFHFzU5pt0BdO6mUr7uoc1HoPEohj7Sp1nXw
         r0DxmEWt+pO/KjXXeUSPfEKMaOqdHrK2A0wRYH18KXTmUmvLAOlhjhRtxSs1NQd0NVPX
         MEeA==
X-Gm-Message-State: AOAM531uai68fTsdiq6qzlUHXNdtT6Tx1C2aSKOiPzhSx82gM/p9OPbi
        onqUTvR65x012+NCrHWPKWaW+w==
X-Google-Smtp-Source: ABdhPJy9l/n+BZwpzPMU732tYNzMsXY8ijKjjyCt211yBXiRCWRp4d87GdOMQSntjHwy7ERugFHcDg==
X-Received: by 2002:a63:1409:: with SMTP id u9mr5796112pgl.312.1613689352388;
        Thu, 18 Feb 2021 15:02:32 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:e561:d87c:c8df:56e2])
        by smtp.gmail.com with ESMTPSA id c18sm6566737pgm.88.2021.02.18.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 15:02:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613681704-12539-1-git-send-email-khsieh@codeaurora.org>
References: <1613681704-12539-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH v2 2/2] drm/msm/dp: add supported max link rate specified from dtsi
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Thu, 18 Feb 2021 15:02:30 -0800
Message-ID: <161368935031.1254594.14384765673800900954@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-02-18 12:55:04)
> Allow supported link rate to be limited to the value specified at
> dtsi. If it is not specified, then link rate is derived from dpcd
> directly. Below are examples,
> link-rate =3D <162000> for max link rate limited at 1.62G
> link-rate =3D <270000> for max link rate limited at 2.7G
> link-rate =3D <540000> for max link rate limited at 5.4G
> link-rate =3D <810000> for max link rate limited at 8.1G
>=20
> Changes in V2:
> -- allow supported max link rate specified from dtsi

Please don't roll this into the patch that removes the limit. The
previous version of this patch was fine. The part that lowers the limit
back down should be another patch.

We rejected link-rate in DT before and we should reject it upstream
again. As far as I can tell, the maximum link rate should be determined
based on the panel or the type-c port on the board. The dp controller
can always achieve HBR3, so limiting it at the dp controller is
incorrect. The driver should query the endpoints to figure out if they
want to limit the link rate. Is that done automatically sometimes by
intercepting the DPCD?
