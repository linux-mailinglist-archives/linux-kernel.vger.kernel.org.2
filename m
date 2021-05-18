Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510C738793B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbhERMyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbhERMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:54:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:53:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso1481429pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NbTixXgWYXsxanz6aB594uSCEv+grsVBAHiaopDOL4=;
        b=cvlTJ1nijKUYCimS6Hf14ayIjwyPTQI7rc56syE/s07Kd//XjuVoF8DUfvLVL++PC4
         v4agY9I+h8lftxjM8vcMPteZIzoAcB6Xx70MPU2ji+LMgHW9y6211WWNS1cE5ePfsRZV
         pZ6uKxc/jjOSe7tjrR+b06V+NClqhpGOFwlHo41W7K2WFexk5ZS7mdWYlqIRzy2lEm1X
         BpQS2zHFx1sRaDOdQnaFq8vXvuX06lkEom4nX8oJNxP4GTZ1t8sGeBfwXdExDtN13TpB
         9ILJhNAZjYKfl99VnidcBO+XZPtGL2k06oPZW4RKGXokN+kENyo27kYp9A+SgcSDbn19
         bjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NbTixXgWYXsxanz6aB594uSCEv+grsVBAHiaopDOL4=;
        b=SD6LX1CjOXGcZWME7HlN/YDgOrqeTKc8Ozrn3Iiglyrl3lYTHueQDoREeE+SWu+uv7
         nxlCHHPeIDd9IOPlG4ZP6mjDeiEPePJMfQ6sLChnqrw6lx1NCvC0qjIive79eJ6SvF+T
         cyo1ALYeIV2PWfw/OPZS/fHnkzm7NUDljdmfYFCj7fuAHmCePFRBmpBfg/vrxTG41VmL
         6OJEcaQNd15WTWhrwj9oq7QtdO2d4FksheZfVhxMlQocaLF95M3HAwxXUBOLpp6DfYQr
         yrrei/0A39U24shgqmKSy+QzqhZ5xYglHmygdSvhvDDHpw5jYATQmnCLN4qzpZkFm8cM
         WobA==
X-Gm-Message-State: AOAM530zlVY4DHpfbYigSnk5RxMSM5884pTnZkbYKQZbMgiJpVG4ma8H
        HvNnmYPf+XFkAB5++IMZd3PON/kDxO0nbklfrCO6/STcmBG5r8xL
X-Google-Smtp-Source: ABdhPJwuoavz5RUOgtiz8itk0VusVn3Gd/3D/VTxFq4CRODFlK+jE18X7mtNYNh953/3f0whDZLlZXv8Lt547lVupnQ=
X-Received: by 2002:a17:90a:b38d:: with SMTP id e13mr4830251pjr.222.1621342392033;
 Tue, 18 May 2021 05:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210517063553.554955-1-pihsun@chromium.org>
In-Reply-To: <20210517063553.554955-1-pihsun@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 18 May 2021 14:53:00 +0200
Message-ID: <CAG3jFyu60U7oLSTBZN_X848kfnzuzRpbsnDJSsvmUZ=u2dv2Hw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] drm/bridge: anx7625: refactor power control to use
 runtime PM framework
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series applied to drm-misc-next

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=60487584a79abd763570b54d59e6aad586d64c7b
