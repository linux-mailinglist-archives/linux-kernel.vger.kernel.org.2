Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC35B41A12E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhI0VLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbhI0VLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:11:14 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443EEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:09:36 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id y16-20020a4ade10000000b002b5dd6f4c8dso80168oot.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Dq29TxJ5zpM4XHFteYmjRFf+8vB0LPfL9SydtuPUex4=;
        b=QXoqixS9dSwgotQCR4tPOH2boVVWjkQ9G/7fRvVPwOODbCs72HTY16UDes5QZRApcH
         KpzoIV+7PFON62nO10VhOP3msaqlF2KOpIyzg8TyhBSU5ysGfhzrSAtrTmwwNlYPKVP7
         SXcSfXUWpQz0lHdH1A4JuyE2FlzoL4tlEyHcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Dq29TxJ5zpM4XHFteYmjRFf+8vB0LPfL9SydtuPUex4=;
        b=fKzh3LFulLGc41+yKxK5fFfNaFUQ7MN0FACe2WOt8qyRL3ulssa8n1Gx73wTu+25xD
         pEylubwrM4lS6+a3pIq38pChHvmULVVzj2YN3QuK4Aen7v8kJAJHwVB5Dw+qNZjANl4P
         mpZqCZ9EOIFXngXxuqqK64B3+YX7DwrTe3JaaS+uiu0DN+niALVgoLy0GtJmHZeX4Ndd
         Yj0twbO+veUHx4JT0lPQm3T0iZxcmicU7jyl13orceJ06az6HPeIsueb8u8X9NNHJtLS
         /TNW57mC5pBIbA8k+JOjnctAywmb2idVf3rYG+FvhsR/fpfq5YcMh4gKdNYt2rcSN9en
         ciKw==
X-Gm-Message-State: AOAM532GlGQ8WjdDqEcGg5FYGkUoWvxGY/IhEiBqJi4ZoUMkYh7io3to
        cx6EhS1PZZaG/OeTHnOMEBYpfJu8+BxyUk4k1mhl+Q==
X-Google-Smtp-Source: ABdhPJwsE/D0A4gu7LK9Uo5aq776hYHg6zVFtNMjoHs4nXxtn9C+5PEy6DETLnx3RKhAzWNHPiAUZenoQ4MczmEq2U8=
X-Received: by 2002:a4a:c3c2:: with SMTP id e2mr1747622ooq.8.1632776975637;
 Mon, 27 Sep 2021 14:09:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Sep 2021 14:09:35 -0700
MIME-Version: 1.0
In-Reply-To: <20210927113632.3849987-1-arnd@kernel.org>
References: <20210927113632.3849987-1-arnd@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 27 Sep 2021 14:09:35 -0700
Message-ID: <CAE-0n52=yYW6SuMUPwGiv374K7D6DDpOZdJUudHdhMa7x2p1CA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/submit: fix overflow check on 64-bit architectures
To:     Arnd Bergmann <arnd@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2021-09-27 04:36:23)
> From: Arnd Bergmann <arnd@arndb.de>
>
> The overflow check does causes a warning from clang-14 when 'sz' is a type
> that is smaller than size_t:
>
> drivers/gpu/drm/msm/msm_gem_submit.c:217:10: error: result of comparison of constant 18446744073709551615 with expression of type 'unsigned int' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
>                 if (sz == SIZE_MAX) {
>
> Change the type accordingly.
>
> Fixes: 20224d715a88 ("drm/msm/submit: Move copy_from_user ahead of locking bos")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
