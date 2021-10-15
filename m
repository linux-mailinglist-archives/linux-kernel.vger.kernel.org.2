Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E244B42FDBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbhJOWBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJOWBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:01:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D34C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:59:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w14so43077950edv.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9pKyE4uXQ4v77H67bVhfvYNdBYMVwhYoxHl8+ZSF6s=;
        b=Z9/Wnz3HV1RIE0kt/gUyL6rSKP114/irnOAKQdhKMk3C080mvTEDXcYWcTwBIq12xC
         /7O8zFykbmnCXIciX883dHr08y/jLLO5+ousxsFk+LUcq4OmlUZ7kKn9pFfge/q45HNp
         lgMljTVEuG3JtclgRxA/bXl6GIMyMn1dsmyJx6qIeA2lRizdywzbqhRnGbvdmp/pZA+0
         vHr8QP3/QnSmsnl/UbaVadqEZtqGC+aLOrCe/DK/e1nlpbvYjOZ4yrbbcvihmEFcjHfB
         aL8hVdd4Ocl+ZZJ3FXLVpUc9pWqaYzk8n/gRqc3Z992I7pbmcpTEgHipysTBhK3Y+GRh
         oSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9pKyE4uXQ4v77H67bVhfvYNdBYMVwhYoxHl8+ZSF6s=;
        b=SgyJXOoMEvldmho83dsxCmS5V0n2zw+xPF+A3x1M37AyhMm5BiaWQOZ5pEZD10LdZb
         j7K48XIMPag7hxenEKrVp/oddMX9f5aUcqff/ozqEGqWwWLhcaluvAK1WuYjfDUcIOlA
         8qXRP+A0jXuuhJfk2ssSm6VvfveX9vX45O/VR8nIow+9AlAVE9q2UGpEOgU0hrwIDX+F
         v8DkZOSBosrtM20vTwCVpzXIB6YAvxIDEuidgHei6QEy22wEP3neEWuHPxeZs7uAO2QA
         6HqdEG/OTUos7qjvKukWP+DuPPWbSwAIsHm8PzuG65XIGDtGihhpFBUb2fmqPqr2dwD3
         loxQ==
X-Gm-Message-State: AOAM531LyLJlfP1oAgoi9ZZ84F5HdkPCgtLhgc8PA3QG6Une9u72RESD
        JH4V7ElIt+XVV8ZpvHfsnDI+Gvdqvz/H7Jaa61U=
X-Google-Smtp-Source: ABdhPJzp86qa0FdWr7jP+PxpSeQNFXQFNcPFAbi0Fz3srgNClnpBQS/YnOhaT16RiuXhCdSG0FryUUUlxHCO8y+Cops=
X-Received: by 2002:a50:da0a:: with SMTP id z10mr20692743edj.298.1634335186003;
 Fri, 15 Oct 2021 14:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211015141107.2430800-1-narmstrong@baylibre.com> <20211015141107.2430800-3-narmstrong@baylibre.com>
In-Reply-To: <20211015141107.2430800-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Oct 2021 23:59:35 +0200
Message-ID: <CAFBinCDubtF=gSO=dpr==mMnBPeLGnWNMSi0X0_pqkFbtLCkQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/meson: remove useless recursive components matching
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        sam@ravnborg.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 4:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The initial design was recursive to cover all port/endpoints, but only the first layer
> of endpoints should be covered by the components list.
> This also breaks the MIPI-DSI init/bridge attach sequence, thus only parse the
> first endpoints instead of recursing.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
