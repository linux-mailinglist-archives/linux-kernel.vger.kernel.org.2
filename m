Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E393608BA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhDOMDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhDOMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:03:39 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADCBC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:03:15 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id b18so6854618vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkwjroPlHbqcNmJWRDqs861V15DKJFOnOt0FvUZN0wc=;
        b=U0byq/pvP64Pqt3eY0jYvQBkaMTMgBSMupiajU8dPcQc1So5sbX+Pb5PpszOHrnB6a
         FpDQEQxa+9amemH3bnvooAj6atRVX4rZytzxD9V6pp20rdvNTVTyULNgl21JsfKcsN4b
         TOHx4i3UsOaOj4xROEzIUpcNDSUuFNjeosU1OcUiHkdI2Kiachpb69NFSMSHSr61L7RH
         EVPaKnymfjNVGKityRj7FOSWcm4mTNfM9vqXqBbv/RnmM2F65NIPNX2Cd0WzQuvQMTU7
         WJmDBVy0ppt/lMMzN+FupoDywfpkY62hCCIPq0u/Ji1KWiwc6XVH4FZ7JgxgWNKWmmYX
         1DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkwjroPlHbqcNmJWRDqs861V15DKJFOnOt0FvUZN0wc=;
        b=dYJZ8Q20e1pTRo1NbL/fHJ0WFptAC1A3bjztA2cfJVegfNNY7CQL6dKS6jLXYiIToD
         IONNB+VwxGfLo51KpavAN39b4cJsHsDkZNm9Hlfi5J1YAe0BZJ+bgphLliMwj8+WvNvP
         NE3j6e/NVyVpKk3KIeIklGxMVlNTDiKt7cEtjfJJRuPPhR7EydN6H/pVRFRzaKDvVaW5
         Ci7v2C0gA+aLlZA9p0M5lO6P6uSg64uhlEGbvfMzRfRp2iY9JvwZbh6/+iTzFswsHZ38
         91q5OqNgHIJpCkp+sx6UOjUf7guxJuI2NYfr+3xC5X3PZaic83VB4aSFqwJ3ccHzom6C
         i7uQ==
X-Gm-Message-State: AOAM5328TJk/qEksJ5cEPgKuGvRUzlO6STf6tlsBz5p4Gu9mbDw4LhsI
        unh71m2ApxhAuzyyTifrTcQGDjkUGLb8sCwxL0Xd2g==
X-Google-Smtp-Source: ABdhPJwiiPVdVZQgBlAWNpX73X2uQob6NdxDRuQSUywpkfNNJzX805N8Lqi4CF4gIaCgqpMAB2z934KH8DoUDzCfML4=
X-Received: by 2002:a67:cf41:: with SMTP id f1mr1713476vsm.42.1618488194599;
 Thu, 15 Apr 2021 05:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210414212236.346813-1-huobean@gmail.com>
In-Reply-To: <20210414212236.346813-1-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:37 +0200
Message-ID: <CAPDyKFqeCW9NOO1sqhOAUoLwS12AL_NAWeE5ukDenJLG2Dec3A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Let sanitize not retry in case of timeout/failure
To:     Bean Huo <huobean@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 at 23:22, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
>
> Bean Huo (2):
>   mmc: core: Add a retries parameter to __mmc_switch function
>   mmc: core: Let sanitize not retry in case of timeout/failure
>
>  drivers/mmc/core/mmc.c     | 22 +++++++++++-----------
>  drivers/mmc/core/mmc_ops.c | 11 ++++++-----
>  drivers/mmc/core/mmc_ops.h |  2 +-
>  3 files changed, 18 insertions(+), 17 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
