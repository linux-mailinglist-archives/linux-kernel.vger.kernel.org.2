Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68013EB305
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhHMIz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbhHMIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:55:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C2C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:55:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h17so14606208ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRJ2425isHE00uMB5hvHaCbM2rZD365pwhUWk5w/BXc=;
        b=O9Ic7VzFR8Dxy+IG/c1pNtqijWlKbBK7f6mns/c0w8a+Hv1MlD/c2azRHt2h8eCHki
         2ykgSXbimIgKjVTUKejS8RpeDqvQ7vJlJZ0PRDWjHC0q94Um+P0d6NNafrXc/DzIwd3j
         DhlLUlLslIPq/qoiISxGwmuDuY3QQ7LIDf3ZBhmBXqEOaShyV1XhbZcW1zvf5qfKKbkZ
         EDUXyj+x+a88Gnnx0gecrVUjmfkT2Fa9xwaErfFN0GZn3Pb7eCsBlgmObCfHAkTYD5RZ
         SXOdajB+Ancj1czXHJkbrJsD+rcoIvbMYKBO+two5/S8TNvsGa9rtHXI96SRtI/0Gj6i
         aiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRJ2425isHE00uMB5hvHaCbM2rZD365pwhUWk5w/BXc=;
        b=Y4way1seY2mB1SJJWIHe/UIp+Y9WHaLR/UUFxVJTywu2rll8x3EY5aM8abFZj/wegk
         IXQuCaOolSYUeZa6wTLDhsb5AK2f1rIgqjTK5KDDjhjRcUbpNqHoYHVq4QPj1LBNe48t
         uWH+JdFduYzK4MaG6IP42fL3rgdCDxcgxamCk5+PhxBO6arbBTkMutvJgD7Wk/G5W1V5
         twBXJ/uZmMtPhzaN9qGUpCjhQJOnIYXV7u6Oz7CdBVCwxuIv7YAWQiJgggep0daz5DK/
         aeHAMtWxOXJK9zq/g6kVkoTC/Uy1WEUBAhvNOkN3BvjeYP14NJ87MnTZZNgfr05sAOtm
         lFFw==
X-Gm-Message-State: AOAM532B8saXqaw/Txkqh7fsglvQSyZVEAb/AdDqyYCrqje0QuSddUYc
        JDyZ/nH91PbqelGYoKxFKzVbmft5Xv+vs7Unw4GM4w==
X-Google-Smtp-Source: ABdhPJxSOmQyZLGDAfWS7wB1WYvUYNHu0jF1ziU0U66IHngmPPPTVdHMrjUAzXEsLsm9wp1PpzXbRbTevw4fjF17lhA=
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr1100690ljp.74.1628844929180;
 Fri, 13 Aug 2021 01:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210812170300.1047330-1-trix@redhat.com>
In-Reply-To: <20210812170300.1047330-1-trix@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Aug 2021 10:55:17 +0200
Message-ID: <CACRpkdYTsEFPBhByKCoA71D-LiJ4iptQcRkzB96HFUPJKxyBkg@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Fix fallback logic to use firmware's canonical path
To:     trix@redhat.com
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 7:03 PM <trix@redhat.com> wrote:

> From: Tom Rix <trix@redhat.com>
>
> Static analysis reports this problem
> firmware.c:709:6: warning: Branch condition evaluates to a garbage value
>         if (ret) {
>             ^~~
>
> In brcmf_fw_get_firmwares(), ret is only set if the alt_path control
> flow is taken.  Initialize ret to -1, so the canonical path is taken
> if alt_path is not.
>
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks!

But we are working on a more generic solution to this and other
problems in a patch that Dmitry has asked Kalle to merge.
https://lore.kernel.org/linux-wireless/20210808180510.8753-1-digetx@gmail.com/

Yours,
Linus Walleij
