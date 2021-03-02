Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FB32AA3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581727AbhCBTRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839715AbhCBQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:57 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48BBC061A28
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:25:05 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r23so24690950ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgzcgIB23RMi47QVqd3ju8TPfRDtVMdCk8UEZvI/KOk=;
        b=oCfgGQA0IMiav6FcMToDhsbb8L8fZl0A4rdm2RSIeKLmKD4v23sBbEtqXkGfisoYqP
         Z2WYGGTvNcVzs09UjGiVNCaSpp+l/27BGwk5hWlvB3DOvAZvWit9pT6LLahK9EAf6i9U
         3zilEKSFq4mPZzw5xhrTXu00mk7aII1gw+OoL/Thxo3OfHE0LP8UU6F0Getd/qgTeP6u
         Um9uxExjowErjUNRPmFK/iW4vO0ByRevv8FZ/KR60fQ+XODDZkZDoc8BRZLim1ax3osw
         VWKcyOvQ1ZNrgAcW4FCaeMZjmJLcorURE2UcRNY4ORS1vrfosgAe4Yqf/katbzWLzfSL
         QFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgzcgIB23RMi47QVqd3ju8TPfRDtVMdCk8UEZvI/KOk=;
        b=fYbdzawK4+R7sKb6SMVP94Di5sk2FbLVHM2ruDrK51N+OBVQSWxEy5+Q0MEAIUlLAn
         YQf7QJ+6GaEq2I5+4s2OAHiNCDOj0sxWv/nR1Ahyjue4qeossmA2kdKwUmgrtg9a3zwI
         fMbB+f8C/uUDKG2Rb39GXQco7Vq84/i6a08dG6zcPQhtqv4H6Gk55ivhSQcDehdV23Gh
         bcqyvyLZrphoq/iTyXRYqWcQodUnYxu1Rg/zNSDePDGPlIbgg9gaA4dFMiwD1uf0Eyg+
         eUCkdl6soacAJTG7uv92seZyCYrQe/ju863vthsfoEIVqxAV3tqmj6lERPZA1RE+wJ56
         +qdw==
X-Gm-Message-State: AOAM530D0sabc/OvRkXvXNfj2PiBNH1psNaYLDKGW35aC5/5YSFs0Vh0
        VtIVYheu1EKHoJ2/IoHngS8g9NbdFq0yBIcqMmFxgagfjhk0Gg==
X-Google-Smtp-Source: ABdhPJy+IkGD8KvWzg2c0gA6CgGZv+VLjkXbozOe70ttJzYLpjRi1N2NxIJmy80zw1y0cZQRV1GPl5piB9vX8lMCH78=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr4198706ljw.74.1614702304270;
 Tue, 02 Mar 2021 08:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20210301165932.62352-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210301165932.62352-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 17:24:53 +0100
Message-ID: <CACRpkdaF4acg2MyKS=nvzPk2gAroUZTiQBixtociqKioFCyPiw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] lib/cmdline: Export next_arg() for being used in modules
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 6:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> At least one module will benefit from using next_arg() helper.
> Let's export it for that module and others if they consider it
> helpful.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
