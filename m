Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F12A33A175
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhCMVhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 16:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhCMVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 16:37:23 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5966C061763
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:37:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s7so13525612plg.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 13:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ootG2XrOkhMQLJHEpBH+pCeYeVaDGS0iuqljiy1oEb0=;
        b=A/0VnEWGHMYZAnW1lvGJC4Q4hCEQdFv71QUITCN2/3XxvAWdOSDWejWUWpa7lNpmDn
         il2nQR9kjLzsCBlcyGdHWrsgrbF6SnBKTlVyO6jFv8/Q/SSArQxM+vhvxOkGgWhoLEZh
         J6PwBHCJNyITXX6zxm6fXwzbl/jTyA5YitWMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ootG2XrOkhMQLJHEpBH+pCeYeVaDGS0iuqljiy1oEb0=;
        b=XcYe8GkfQBEFt8Fer3ahGn79LD5RinJGwTkNzrgGcEkv6lq+Cz3QMa8Ap2d7GlasEW
         ohx3oBM6EP9Rr3jN68UXz5+V9X03GT1Q+PHIef0g3UDkbZXuK0rj8i5z380/O1OuimRk
         Kj5NLcKtGrx1DCbK9oVlrL7Nnc1rt8y+pOzdcCjrGewW8iTYIxA4Db59VAGS59HC3UdC
         x1ZsyjNf1SRC9xlvVQ6skhk792vs3T46oPMKljp5Z1p33YUSxm79t8msmMNqlW9d3PzT
         Ke/XzwD4ZvtuLfeEnngPlYjRQbQgNLW1zBjzmbM5pbznIDNpu7jVqPAfh7xS4SuVgfwc
         fGiQ==
X-Gm-Message-State: AOAM530nGWp2ez4oZMdY1KvxmJ7DPcYtQ5B8H5FEEnD49O2J8m2R3k8i
        Zmuh2MIFuWp6RFzXbgMMmDS8Zw==
X-Google-Smtp-Source: ABdhPJwM9UUOMdwRLcwgdvW79ILsoIhMlIz8vXaekFKN5Gs5x30titgi8iXP8HdUs3xiaTbVwnYphQ==
X-Received: by 2002:a17:90a:5b0b:: with SMTP id o11mr5368406pji.18.1615671443334;
        Sat, 13 Mar 2021 13:37:23 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:e859:c7d5:7d7b:5ed8])
        by smtp.gmail.com with ESMTPSA id w18sm5908370pjh.19.2021.03.13.13.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 13:37:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1615269111-25559-4-git-send-email-sibis@codeaurora.org>
References: <1615269111-25559-1-git-send-email-sibis@codeaurora.org> <1615269111-25559-4-git-send-email-sibis@codeaurora.org>
Subject: Re: [PATCH 3/6] dt-bindings: reset: aoss: Add AOSS reset controller binding
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, mani@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org
Date:   Sat, 13 Mar 2021 13:37:21 -0800
Message-ID: <161567144139.1478170.5287677329522581215@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-03-08 21:51:48)
> Add AOSS reset controller bindings for SC7280 SoCs.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
