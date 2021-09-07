Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD0402931
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbhIGMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:51:25 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:37847 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhIGMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:51:24 -0400
Received: by mail-vs1-f43.google.com with SMTP id i23so8168542vsj.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqzG0edJSf2zwWdbDpmcnFDoPo2y6a0/m9oDx9ZHMOE=;
        b=eOW/oVyrF22A6j67UftqILlVb070Qqm3W4ckWAm/TJupIVUIlHv+l/FA6+yLOx+bik
         sTFmbEXnCp2CZtwsLiwQ50pWn1NBpJSntKCgyJ4ZBn6LIpgytTqFYbiIBJ/rAyb0Z2sW
         gxVDPeTQjruqG3JjBae7Xpwi43lbT1PKpHn9uf7lVt8eFFRv4Aa8h79Yd8HYeiw7tRFv
         k+7DC8z2mP1D5WPSGpZvaUVjOZ/Rfkll+vEQNhU0xdM78/IPMMimlS7XnFAWPhj+PVhT
         xm0Faf2ALu7hAMufuM8nCiUqxmRukH0aTnCQrCWlwuG568vVy638DGRqHfLDzmjlTEJh
         m8lw==
X-Gm-Message-State: AOAM530t9QKOrAgDn11G2hOEuS6diP9bvEolMXKn4lr3OCoTmfF4faoi
        syEW7nhIMvEkEFygxi0ooLtZlOvXUjYEn1bByJ9ItSEO
X-Google-Smtp-Source: ABdhPJxPryL8aTPbGDHY35cMqmQRv/1khmLpGMz1CZxejsOJTmiAIVYrDdEFqOST7n2BhwCskVWCgMtwvi6EEzgxLZQ=
X-Received: by 2002:a05:6102:b10:: with SMTP id b16mr4947451vst.41.1631019017646;
 Tue, 07 Sep 2021 05:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210907060729.2391992-1-linux@roeck-us.net>
In-Reply-To: <20210907060729.2391992-1-linux@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Sep 2021 14:50:06 +0200
Message-ID: <CAMuHMdVjAdC7bqFcxtfquHxpHJELe=UxWW53DcO-wNYZ-1Sy=w@mail.gmail.com>
Subject: Re: [PATCH] m68k: Double cast io functions to unsigned long
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 8:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
> m68k builds fail widely with errors such as
>
> arch/m68k/include/asm/raw_io.h:20:19: error:
>         cast to pointer from integer of different size
> arch/m68k/include/asm/raw_io.h:30:32: error:
>         cast to pointer from integer of different size [-Werror=int-to-p
>
> On m68k, io functions are defined as macros. The problem is seen if the
> macro parameter variable size differs from the size of a pointer. Cast
> the parameter of all io macros to unsigned long before casting it to
> a pointer to fix the problem.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k fixes branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
