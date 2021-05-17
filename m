Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3D386DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbhEQXzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbhEQXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:55:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D34C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:54:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v9so9966652lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbhlmfPa5s+HmHF2AkgVRLQaiXQBSVARBK7bDpva6h0=;
        b=G0JFaE5M3Vu3bo7EXsLiB6MuKFBihbF0+5Gj0JkCdWDC/4eI8kflgVFBuq3ERfsVHX
         S6SzU/5NmSDGhKsT9ym/tPH2muXKg0aNbFYrP2zEw1/R1lToYN6mnKThDgo/PXQkLANS
         QH54ygk7MUqpL2PyCkwlcKhqaoybOav7MybC/jzLwiNM7lyO0zcgDR7Vf6TTtvNJQmHs
         9iZfsfCKqsQLN35lVJqjoZNwYs98xrZg+FFUF75Cu87wJXiRcfoV0I1YrZE+86SdRHpN
         fMEu/pUrHPx/GFyPSmjuJTAwloseNGXOhhwlV3+UnwUg/6GUOVoqUSUA6bCO5wcwNRkz
         PBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbhlmfPa5s+HmHF2AkgVRLQaiXQBSVARBK7bDpva6h0=;
        b=byeRQbtYzhsxYCKCs9S12WKF4cIGFBKA6ahw/ioNzxfLeJwiedi6vQkt41CWynUd3f
         9bQTLkV2QcMIjPXTI50bjEfaIz//x0EfmJwVAzzz+oiC2bLDmzd9KgpbDf4peFeFBmc3
         59TYbd5k2odDj9bzG6D3bQYsW5nQzKVv2ZS1xEN1RkzCYXXV1imDgnlwmgxQqrZVA9EL
         KzRCcWDiYTv4sfORs/nFYIV68vxMMPRqAgIOf+C1cMHF0w/hoq0gCPwnkBER5wTTaVlf
         7ApdWEZ/9jO5R0ZRhMUdvuv8IfZpQ87eO7MCkxpUUwQIx6Cg+k84lnBJwqiU2YzyYHbX
         DMrw==
X-Gm-Message-State: AOAM531mT96qp72/GtYc36w/sjfpYiznOlaxfe8XK6lumuzfQComrgHJ
        j9bwgj1PBh3f+vt1nZs2D4R8oax/frwq/uPGl2N3lg==
X-Google-Smtp-Source: ABdhPJz7J+GqpZt/lpIho+kd7mX00GTqQd481/bCTFXSF+rls5RoKbTDY/QIdG8vSFWmcfrAMHryQevnYCUDghbS/G0=
X-Received: by 2002:a19:a418:: with SMTP id q24mr1724759lfc.649.1621295648198;
 Mon, 17 May 2021 16:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210505202618.2663889-1-clabbe@baylibre.com>
In-Reply-To: <20210505202618.2663889-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 01:53:56 +0200
Message-ID: <CACRpkdbR9mt-X-Dt9uR9vGtg_EDJCk3H5Umuh2eUX-PGZ7VBfQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] crypto: start to fix ixp4xx
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     chohnstaedt@innominate.com,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 10:26 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Loading the ixp4xx crypto driver exhibits lots of error.
> All algorithm fail selftests with different reasons.
> This series start to fixes some of thoses problem.

Excellent! Thanks for taking over this Corentin!!
FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

If I merge my 3 additional patches through ARM SoC
will it work out or do I need to think about some clever
merging strategy?

Yours,
Linus Walleij
