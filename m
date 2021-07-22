Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B88E3D2D85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 22:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhGVTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGVTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:36:12 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC2C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:16:46 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t143so7914592oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lGBGDn+lOFNngvvH3L1P75ECn+Xc69iUtWDhuizhmRk=;
        b=WBVq6pEiIdZU+GzhLnjTWPaJtocMzNL82BgTggr5nUPLGGS8R8sX+BOMVEApmfkRw9
         8Y56V3g4r4I8SqKRkOSNP4326oh1kzb+1PuACxmp6HoAfAsgtrdlAJ556GV92PT7exzL
         McADJKZB9Lb+pcbQrmy4bQpGWLhDQQptnnwPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lGBGDn+lOFNngvvH3L1P75ECn+Xc69iUtWDhuizhmRk=;
        b=i/qOVCTtYRyb3aIn8Hk5f8VRgDfOZ1uGwiEbGImEjeDAplwMawAdWRgqkETx2X/LTE
         XUtaEkd0rKWG4NsxrKUYH+U04HkwTQlSDw+9I+ZoUvRMa7BzMqIKzIcx7EQvxlUsnzVL
         agjsr1159VT5t/KBPe+QEF81BEipMro3mMgS+8LTm+9RCAbSxiLHLhFX8/sTViffLznI
         JOlUKC4ip5DMHpAn+K15+XsBYRNJIm5ZfLW6RfBYnMrifzJTO2KGmvWdY1TMsU82fwYO
         oysMpG0OPae1gf5YWqKXm41660uavNmWT5h9my+Mdcrstc7xrxeSZdK0yrm43ehN+tnR
         igfA==
X-Gm-Message-State: AOAM530gJ9DGfTJgyVI2e2gvrD8ptX4CZdOR38PB1FJWoJtmUiJdFH24
        HzaIb7Nf49aoM/Y6nkWvz1W3CXbXhDPKlaWqhIRPcA==
X-Google-Smtp-Source: ABdhPJxjTaEbkRrBN/FqiRS6clBxB0FcklPeiI3sKW/kjDjrRLw/EbOnNhQjT9Uf5BJl9SFEVjqPUChYPfrbRGjQLhI=
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr1175746oiu.19.1626985005662;
 Thu, 22 Jul 2021 13:16:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jul 2021 20:16:45 +0000
MIME-Version: 1.0
In-Reply-To: <20210722024434.3313167-1-bjorn.andersson@linaro.org>
References: <20210722024434.3313167-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 22 Jul 2021 20:16:45 +0000
Message-ID: <CAE-0n50iOP5K8Q79ShmLowWErxMFRdYZRg=hDszYn8O4OJaz6A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: Initialize the INTF_CONFIG register
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Abhinav Kumar <abhinavk@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>,
        Vara Reddy <varar@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-07-21 19:44:34)
> Some bootloaders set the widebus enable bit in the INTF_CONFIG register,
> but configuration of widebus isn't yet supported ensure that the
> register has a known value, with widebus disabled.
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
