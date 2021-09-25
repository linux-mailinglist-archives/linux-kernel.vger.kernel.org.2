Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AE418374
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhIYRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhIYRID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:08:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1AFC061570;
        Sat, 25 Sep 2021 10:06:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eg28so49515370edb.1;
        Sat, 25 Sep 2021 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kmui+08NXbFT0nLrvdY1BcuEpj6U8FJtaRHyjNLMkbA=;
        b=X1vU2O/fMuGWIQr8sO60x4m4WHXkW0GxW5txZsHtd/Zx4KqWWIefwro5FAX5CkHJYm
         7hdMkOC5kLrAlY1xk8W6Qo7v8w0rjyiq7WGw5Lijh/oM5AnWHsfhfXsBCkov91zV8fIz
         +MEqh1mqE3iINMKCl6SJwktVYwIh9CQZVRGXO603RrbLr0ygp5RSfgA61CQ1FdmPGNjc
         8sY6G/mJy/s6J2Dk4jAlsFExUc8cfGXQRnZmZ7rIXpr9L2Z6cTPz5i7z3Gfq1OgyQVH2
         sWRoGkf/BT7d8dz06/ygAK895NwboYDW02SkHm9b9JQSSSv+Ip+EMja4v8jqR0EVYQCo
         SBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kmui+08NXbFT0nLrvdY1BcuEpj6U8FJtaRHyjNLMkbA=;
        b=Dq5JqO4LnmDpETCd1Vsb4i8C0GW/HJiRvvMyH3OJMbePSgv5rgBDOrwcZQ3dagqj6f
         nMLKJV39Er2Bo78G8yccHVJDjfNzfAwi23BE6ZEazE31JRooC9Ga1dL/MlhWZxNv8i2L
         sIL89o4bNXPtQ7spoL8iCHwk0+VzPyh6F7NgTU53A6GrkDeBGE3C2D/eSKBMzDRL3F/l
         ZbYimL9bCd+3yySPnS1BvWwvRhJ6oSkk+thEETVJUqy9nSGavbn+hcKvcdoQoRrNRbUg
         H9htD029PFxVgcHgYPMN53UA7qB3FpEVRF4mYtcw5H6/qu6QJZUOAbyuUSfZ6Nn/l/3F
         Hdmw==
X-Gm-Message-State: AOAM530E+P7zvnKN4fAPZ1eG9KN+31ja23fwM8KXFs5pHm4UKp1kLYes
        NRqZ6DZXBIbnjUMXw90P5fYUROfBE0Xbm/uBKeA=
X-Google-Smtp-Source: ABdhPJzrY8tMFPHNGE75+mTiVvTPrwW84zeV3b5rRuTKD9rGRN+lbs2VxC0jPhBb0dkobrhLqii4p1oNJfeFWWGh+Ig=
X-Received: by 2002:a05:6402:493:: with SMTP id k19mr12301396edv.386.1632589587538;
 Sat, 25 Sep 2021 10:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210924231242.144692-1-colin.king@canonical.com>
In-Reply-To: <20210924231242.144692-1-colin.king@canonical.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 25 Sep 2021 19:06:16 +0200
Message-ID: <CAFBinCB0LOJvCuhtX7EFk55a7-gUJ_P43iuOLB8qeTkZGgEmBQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: meson: aiu: Fix spelling mistake "Unsupport" -> "Unsupported"
To:     Colin King <colin.king@canonical.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 1:12 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
