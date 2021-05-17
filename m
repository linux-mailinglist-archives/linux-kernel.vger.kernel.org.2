Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76408386DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbhEQXtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbhEQXtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:49:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD70C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:47:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w15so9297743ljo.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQw+B4Aaj5WKO3XnxnjoJnOilFMUwgNj2+eQXaBMmEQ=;
        b=J1ZYxPyZ8cjCExpqI3RxldvZfmnGnKipWwx+N7Lb7oRmwpbvIklJ9GutZMVJ7sMckT
         qpXB83zq3QwBmgq94TsbLcg0jeWcA2SY+O81rPPvAPM3yHQyofYG1tgVl/86von7i5tj
         J0ChEu9e8bbKtPN1nYQl8AT6g8O2tmQaWXtGjj5jWDsyS+8r7krQQtsxWrYb8SGx9fXQ
         jiCauF4QXccJyeuZ+sl/kefEa0MATjf28rRE9vI38NS9abJfTzffYW8h/LsnpmpK1jyt
         Lrysdcfv4lF6UWY4I72PwRXq5w8786Pg4VcJkDxwlB4vVFV/3xkN6o0cNpijbuZmE0D9
         KWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQw+B4Aaj5WKO3XnxnjoJnOilFMUwgNj2+eQXaBMmEQ=;
        b=JdiDHJSKcJrp13zLIp6aEPemN6TBe8dEjoCogDpnAo4jmRAQi/byHvMzC/m3PnN2ZC
         LyboCjwS3Kmtm25RS4mHKiIDN1zfyzQ6Eyhp4+qax2na2n1CymcQtMgC+LOpDUXTgpXo
         +GJ+snSz/bpH7hjjejY7YF3wwWl+MkDz9Vb1Wv7xwbcAU/LzUuOLMcl3NcRFFQdqCSCu
         p3HE7S+NPVsfYaWNrXtp8BpdriSvpHSlk0Gux53JVuwuJPjmEXOrNoCeYn7SirHAL3CK
         wXTGQr0DEM6BKHVRZ76N4hrj2a9zIIQCoE68BqUM4UW2YWvCuXG42+JAKxbN87zeQoek
         kiPA==
X-Gm-Message-State: AOAM531Uu9ZnVn7/13wvcwN/P2hkd62YICQ58kCaw6qCU0fs1b290uAU
        fZAWdGA+bunIuhRlR1TITctw+zBCVBC+BIKGyz1ZxtGz+Eo=
X-Google-Smtp-Source: ABdhPJxDXJyFBTKjv+mHs1r6TFAqKvhWB+ItK8dz6jjCTY8lwt/USQqO5WACAqPWuhy+6k0yqu4ISteDXDCbpU9JCdk=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr1591377lji.438.1621295271997;
 Mon, 17 May 2021 16:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210517193205.691147-1-clabbe@baylibre.com> <20210517193205.691147-6-clabbe@baylibre.com>
In-Reply-To: <20210517193205.691147-6-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 01:47:41 +0200
Message-ID: <CACRpkdZeeij7ZM5C7eTUeOiBzvX_PKH4XwthEggFyJn5_QqdAw@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: gemini: add device tree for ssi1328
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, SoC Team <soc@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On Mon, May 17, 2021 at 9:32 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> The SSI 1328 is a NAS box running a SL3516 SoC.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Same question with redboot FIS and the pin control for the
flash here, otherwise it looks good!

Yours,
Linus Walleij
