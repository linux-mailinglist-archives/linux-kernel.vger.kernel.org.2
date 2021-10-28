Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7522943D82F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 02:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhJ1AkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 20:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1AkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:40:23 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 17:37:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q16so7684348ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 17:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXqQCOpu8CLs50biqo5RLezrlhQ8rX/+z0HIytvSHFM=;
        b=UhWGxxDdtCvXQwuNGh/a6PTbTGzqmTdtJP2QgW3p1BbODTe01LeoGLpCVYRfMEvgfZ
         zf+1bv8i/zdKEYSO7QB5AgKWE23OD9M5NsvGwloOHT+TjpWrmj2UUWKha3UuaX8Ma7dj
         IsgaxLb+4N+Gzvyu8Ml9v7noz3vbKBQ/ZrK6iepE13fvp4fmeUTMITFZh7lWoz9wq/o7
         c6I7sOLWUr20sB9MA+ZvPidide7Pdu7VXZqvg8H/hw2lHHI9ZN6NKf7Nd78FW/UjMFfJ
         lgMzt2KZ3QU2kXkqaCxn+MHYhTr09+QMpk+uBSJfoJ/wTEnRomt2s3APDYlHM9za08Sj
         1QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXqQCOpu8CLs50biqo5RLezrlhQ8rX/+z0HIytvSHFM=;
        b=SFa0I8PEzFl1L1t/ZZOOflbdKoYMUrSFkTOlm6UkbjwUwHufBUjc9pTbzqPNgkQFC0
         wCbIXFLdXBuba8fJNwg77E0wfzE4LYUC+qz0i1ZMVJDuwXnnevqXJzHhaMX8JK1esZY8
         tMoU/eBy/2Rnjtz0hhDyfir5PGMN38zEjL9PQxUF9rRqm/a92X+XiexyfcSr99eH2z+J
         L5SiVizpwF7U9EgR7mCo4SOxwEhjVH1Yhy2x7P/AfAOjuiev0qkibIECncSSBAVe1cox
         +bk+ka2Sxr360TOVjOggw+drMxHu7VwuRwBDt6lZ8mzRHOmLLPPreEBS2FgVJ85aDRRG
         QLxw==
X-Gm-Message-State: AOAM530Vtu43wgENeMRnRlijxdgY4KSkzkCFKPNOkPmmYANv/Afx1Z8n
        giyuO3yWE0nlfPgfCg9bY6GrPwF/dh7Usg8/mr3esw==
X-Google-Smtp-Source: ABdhPJx/ZkBhi3dKE5KGYKnhgUSSycuYqcE4KP0Jbz2tVS2/1+povo5De6IlVJi8gu+smbo2PnhqZs781+xvQgBaJY0=
X-Received: by 2002:a2e:8ed9:: with SMTP id e25mr1240733ljl.358.1635381475650;
 Wed, 27 Oct 2021 17:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211027082155.206449-1-francesco.dolcini@toradex.com>
In-Reply-To: <20211027082155.206449-1-francesco.dolcini@toradex.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Oct 2021 02:37:43 +0200
Message-ID: <CACRpkdY95RSDbNm5rMtSZmbDW9=+KtY7dAfA8PGarmQ-CF6dnQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: stmpe: Support disabling sub-functions
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        marcel.ziswiler@toradex.com,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:23 AM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:

> From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>
> Add support of sub-functions disabling. It allows one to define
> an stmpe sub-function device in devicetree, but keep it disabled.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Looks helpful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
