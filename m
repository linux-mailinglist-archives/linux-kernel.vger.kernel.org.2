Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1346843F74D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhJ2Gi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhJ2GiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:38:24 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D30C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:35:56 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v19-20020a9d69d3000000b00555a7318f31so135681oto.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 23:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dkdO3Icgb7DUlOmsuPxDkO8TG7olzzHWl3o3c3JSly0=;
        b=iQ+FZtH/C+L5mW9JwCuoepEJ6FvgYOvKGFKTS52GdNtfBqat4FsD3mDJTB92gScY+x
         llHNiUtTABHa4tQCnLB7x4HsRW5rNK5m18bWSG1Vx0qAyGSilkSNPHZqhpnKpJhCkfrn
         5D5K1OpL2JmUWqL89+JqfAihCj4QZjrKMEe0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dkdO3Icgb7DUlOmsuPxDkO8TG7olzzHWl3o3c3JSly0=;
        b=DjySe9MVb1ZyXaNT9p+dWTKbx+z+G9LbRhlC3DdT3lH+AkifUOkZIno/0sPWK+ovGu
         jUv4HKbRjVWUl8ffni0dEMdXK8z/jqineBEowsP5TucmoNlI7Mpz05yJLOoPj51grVBw
         8d1JOPgadVuCNLC0kGLaKH6pQCkLfmUghmplJgAfXC8E9Ltzie52XVdO35Q/yQDAab5g
         hTlHvl8JgQyKaTS+9pa2Bm1A9Z4+/dK182s5Pvw/V4SvSP1K24d6dHwPClGVKn4SgOZT
         AF3Skt3Kejn7XseSQ/9TQxX8mcT/ah2xpNjMBtua8WDxf8QlTdpVv+Vrb2aNDRSYl/Tl
         tgHg==
X-Gm-Message-State: AOAM531PpV24Z1rb7czbn5YOpS0lrdWwq1q75lFhhFA1bXD+E7u+yxGR
        ZQjUPWsCSBhWGdAhPpLcrIo4TcYu89mqMdwCOov/g02criw=
X-Google-Smtp-Source: ABdhPJwspusB4f+oAyCp/cycI/Hh2DqX/KyThqqZdJTHZPzfWH2gfegrDIP57d1k9LEBFhCBJe3cUlTKHKtanKNWTpU=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr7102048otl.126.1635489355350;
 Thu, 28 Oct 2021 23:35:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 23:35:55 -0700
MIME-Version: 1.0
In-Reply-To: <20211028174015.v2.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
References: <20211028174015.v2.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 23:35:54 -0700
Message-ID: <CAE-0n51jMivTJ+o6W1wKH-Z8T6qOCX6bYEi1n1tNs2APJqGDGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: sc7180: Include gpio.h in edp bridge dts
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-10-28 17:41:15)
> The edp bridge dts fragment files use the macros defined in
> 'dt-bindings/gpio/gpio.h'.
>
> To help us more flexibly order the #include lines of dts files in a
> board-revision-specific dts file, let's include the gpio header in the
> bridge dts fragment files themselves.
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
