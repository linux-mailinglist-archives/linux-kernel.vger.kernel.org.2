Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1123923B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhE0AXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbhE0AXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:23:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2DAC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 17:21:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b26so5250360lfq.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRcwXTkXFqjHbLkGyM+Iivo9S+3vdfLIMeWV2k96/WM=;
        b=IcdHg9mtSIbKyQXE7To2tKBA5bjosTWl12QMBa/kT2sO6/0yLESdYBXhe/muIyLQvv
         SDfxb7HhzfyCzr9groZNH5cT/VyTZl+SFMrPNtiEYC80BuIcBHt/CM1kcnTlXc+I52cG
         jJ1rp51adY7ITDDDwKFKiWxeZT39YuNeKEVY4REpR8JJYwXY4P1GOdyACypnwShNTwEd
         UuhGQL0rwxBHlC7RyWiqRpIcoHfVpGk94e9HrlqlLBoXJCms4y/o4Q5FkRume2lEACxC
         Da4Wq0MKqA3qZYSDTd1OpR2yt47XE9w50Lzs/MgUpwmmqbDytgeEaYc9J96rcf114kvY
         /82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRcwXTkXFqjHbLkGyM+Iivo9S+3vdfLIMeWV2k96/WM=;
        b=KInx8xR7rhgau46f6n0qlSGqJDmpnOHCXEwcq7s96x3Ryt0pKqQ8+HcD9XhBWqpGRW
         bUoMgRhELqhhTJr/pKV4HpvNQPMM4lCGgXiaQRaa8ng1ZLHCSssfMjNMc1CaGam2HVNp
         Q9ivufqgl83u7/rStTNoeSrcvsZMCKNYyeRDqfMFFzbX2IM5bKV5WY6vboY1wstq8OnQ
         /1nxHr2fQSkjzRNBp1VcZ6QoSfoV2YwGn7GqoNtB4MfDuMOvLRsHf8TZLrPaorbVF3Pn
         7DzC7xMFuOOi9lOu6NTOkkuZI7edGbQCTk6BxwtoNrAUj8DOrrQ1FDY4o6xVW6A3ECfd
         6hQA==
X-Gm-Message-State: AOAM533lNC7XwA5/ATf2MWHdBFn3pscGTh0ShqJhz3VHXALeBpml11G8
        j7V3AdFCF25Bmo+nMxRV5+GDFyU5n4hGOM5Y1IOWev3I/zQ=
X-Google-Smtp-Source: ABdhPJwrZ46JCTawi7sfWZOjm1/sDDo4oQx316hZrft4mHIMt1cbwJe4Y1fVtf3CXaYRK3O8LpBxZyR4eEcnsnV+p28=
X-Received: by 2002:ac2:5145:: with SMTP id q5mr457753lfd.529.1622074889945;
 Wed, 26 May 2021 17:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210520190105.3772683-1-lee.jones@linaro.org> <20210520190105.3772683-2-lee.jones@linaro.org>
In-Reply-To: <20210520190105.3772683-2-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 02:21:18 +0200
Message-ID: <CACRpkdYj=kU6ix5GoTYc4bKcskoJM1mmmSbKMW4yEjRy4f3Zwg@mail.gmail.com>
Subject: Re: [PATCH 01/16] i2c: busses: i2c-nomadik: Fix formatting issue
 pertaining to 'timeout'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
        Sachin Verma <sachin.verma@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 9:01 PM Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
>
>  drivers/i2c/busses/i2c-nomadik.c:184: warning: Function parameter or member 'timeout' not described in 'nmk_i2c_dev'
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Sachin Verma <sachin.verma@st.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
