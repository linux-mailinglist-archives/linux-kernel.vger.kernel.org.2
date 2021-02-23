Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080E3322696
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhBWHqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhBWHqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:46:09 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9FAC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:45:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id a4so11848982pgc.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=xHrDmRSScVv/177HLfEC9DblROvubef4C117H27kpDI=;
        b=oPCBxW23NUDIdjCFaQUuwktRYz6if1/UG0Bd4QQQoENA4iQ9Sq0s2veVLjfogsgiuY
         E8g1i/sJHC2G2ioapcVR25xuJZ98FHL2VrRc/Fy0AoXoD3GapKaNWq0jeomhFnSxRzxu
         yANI81bhDIWet+zIWwaeHUrgyyu+jNKU1UAU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=xHrDmRSScVv/177HLfEC9DblROvubef4C117H27kpDI=;
        b=lc4+J+dhcmn0P75GJvK1IfUyNTCvfQJ5MKFVMQtkQ6ujuZf/slPHLg6aToncgSGK8R
         xYqlMH+F3dSJHY/BKTq+c7zfdBTsdlU6cSAEDTg5hHDjxlKeaVJ5PWSKz8gLqnZYFxae
         WUSECIfktSEY6EHpJ7N8We6eYVBufdgPWWsOELeMC+a8UDXZhKCPrWrxSqoorY4Dbbie
         a7BehAiO/KCP5tG4SRLJ9OvzjGOkcb0gmjXh1JJ8w3Oc0+hU9Do8tsmbRydVVXgEs+rJ
         PmtyMTY2jfTJfoodndgQYAPDiW0SVz8IWUCbFUtFcSKPh5CDudvjh19nTAQ0tSb8L9hv
         qd1Q==
X-Gm-Message-State: AOAM530kcnd3rD0ckx9vNXx3P+8NBujnoXWvxIPDJIsH1re44huv6SgE
        UczKklcyN5z6PVvoxmsqGI5xQg==
X-Google-Smtp-Source: ABdhPJzYx5TP/q8zGXS26TWITLWDzpjXEWZY0tomTEbDfKUx04wHbvmiHWAod8evnhYZdNOPiPcAzA==
X-Received: by 2002:a63:4709:: with SMTP id u9mr22936404pga.250.1614066328754;
        Mon, 22 Feb 2021 23:45:28 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id c22sm20998364pfo.136.2021.02.22.23.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:45:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613114930-1661-11-git-send-email-rnayak@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org> <1613114930-1661-11-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH 10/13] dt-bindings: watchdog: Add compatible for SC7280 SoC
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Mon, 22 Feb 2021 23:45:27 -0800
Message-ID: <161406632702.1254594.5789445963319310338@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-02-11 23:28:47)
> From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>=20
> Add compatible for watchdog timer on SC7280 SoC.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
