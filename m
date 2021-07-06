Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234D43BC6E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGFGwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhGFGww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:52:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECA3C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 23:50:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h2so26563857edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 23:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qGYneynKf0la3vouTh63mUXWz9LxVM55ExbQtARcC50=;
        b=AworOtXvN5m5Vg+gUxwAyawktBSawkROq49Fi90KczfqzD22/N0APk8iy2yuWUxkgh
         6N2ae0o/bVK7i653+kstEu4s/FmEIxNaJTfqm0NYFTqihY8RknlvwEM4qjQM4B1C3PyD
         Uw6qJixDnaghrZnnRBg8QTKa0gVDB4pCwHQorhrtUkiG8Kmv7om0QOLlZybPrFV6TjcV
         pMAu83ZfA+13T0dlu9RiIw3gskJGJIidVuymdT2+mOGvO6DX8PWSlmjALoiODxRg1NNW
         I3hvRMC1wUqFWuqnrYTPf2lqDj3VAul36IY+p6GKLIQdxD/u+BJ9qKa3Ni7AC0j0r3/a
         LwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qGYneynKf0la3vouTh63mUXWz9LxVM55ExbQtARcC50=;
        b=jF4DbHM72/3jhsVANHeh0OXU/q2371Oj7b2LPOlPrHHbjafvDDQNksE2SB7tah7I/3
         6T0+sqf8nk4lb/aox+5v3qGLNL0/nBgVgCk3GaPmu0gtArSy/Wf0BO6dckJRjJMStfb2
         vk04Ak1EVI4+jbk+EiMmzlkUpFnEOGBgSxAsxGxM6zQMyu/h3+Wf7VH3lI7C2rOffmsx
         S0Np7Z4rJXiIoxhT3C/YBE8IuYDstvQ3yIy7rZCSZNcKwpK9VgHhHce67K8kUH3pltj6
         0yXKKLg0ShNWHPlcXlhsCA+WEMT3+66klxhSC56hY9bB/SvEOIxJU05OTjmncxf/Dg23
         8J0w==
X-Gm-Message-State: AOAM532FCJj535qoUzgXyk7tXtI/q/dexb8QfDHCYFyjKCd5PXLZGCUR
        kcifbwJhjxCwnbUATFhgRK5qV/A9mO3UPYTaSlFO5A==
X-Google-Smtp-Source: ABdhPJz/9/s6M2Fkei+XSVcT/chWEGemstEEOmidZAIJSD8mfx0LPd7++4wtTge1p3G1+CQbmwQbddTs15PRAXhleuw=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr8515984edx.30.1625554212145;
 Mon, 05 Jul 2021 23:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <1625553939-9109-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1625553939-9109-1-git-send-email-u0084500@gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 6 Jul 2021 14:49:36 +0800
Message-ID: <CAFRkauAteuRiwpu-GA6B1_Cmr4enzsdNAkUVUwE1pf35EN++HA@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: rt5033: Use linear ranges to map all
 voltage selection
To:     cy_huang <u0084500@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=886=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Instead of linear mapping, Use linear range to map all voltage selection.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
