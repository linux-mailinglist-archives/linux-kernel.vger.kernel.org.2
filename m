Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4515C35993A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhDIJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhDIJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:30:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C1C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 02:30:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so2606290wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gwj+s9/MPNGp8MyMcCfWHYTaJSXA15w26uCI/hDpxBM=;
        b=mCgAQow5OJ0Sz5LtItrljl/dRuo0GhxDgW8vOV20Cns3k7Je7i7ezOpUuhKhis0AWa
         7h6b/tTSjVNsgfj2H+YfLGrL6aMLqqHa1rWbhUGUTmCgjgIwfbwrHlMJ1bruahwDta94
         0y5rZheWJkn2BkdZpX40R2fLjNqjexiA61O9LHdmy5/LFcVR2NB8uWRCOki9ZrNzZwld
         boN8RsPkEgJKkjIrBhhgZ8EvN30mAGvS5P2DeK33HvhpdC6pVbK4xIor5r4Djs+IcaEy
         79LQ/mbvcpFI7kzLaLUUjq7NiYBd6M9qWOEsJUZMPmQ1zZ5EU49xHjCkJJ5doXa7hUVT
         Rq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gwj+s9/MPNGp8MyMcCfWHYTaJSXA15w26uCI/hDpxBM=;
        b=lnyrPRXuYFMdaWLy3Z3GtUSKDqF9h51jr3yB9xmH1gDT2M39SrMHYJv9ioLom4zRg6
         Tpzh51kRJGezXTYAP6YDo30ib4bpCUVLyWwT65hR7Obnl2O+lbXcH3JW6hrmp5C0cMbQ
         1254Ts4IHKXUqofaIqmha6Ryu28Git4wYTLze2jm271xrPo8B0eWn/gsCQFS3srB33tL
         BE+qxojwMpr/qIJm54BKJ7tMuVJiejqZAW9oy4Q1HawKruSSLERyRc6G288Z4ABi6YLN
         R/OXTRjX5wb124oGkhCpZhT92UmEXuvGRooIQ/AdK0MORgJOcS5sZqRrgPmTHUFINPi/
         Jg9Q==
X-Gm-Message-State: AOAM531QWhqvuDO07lDhUL/RlykpX0pNQ9HkypmsylVYpdc1raoU1PXk
        R4GC5BDJ0Ckhv+ra+vIBbdw5XvVZWJGNAjxAf85uGg==
X-Google-Smtp-Source: ABdhPJxY/dbUau5gJK6sjVl79ezv4EXih8jmN1JP2io5GiR4irv6U1mhos/W8Q5QZ8IeGUfVz8paN0/3nF50HsgvJ44=
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr12990048wmb.22.1617960625778;
 Fri, 09 Apr 2021 02:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210408155334.12919-1-barneygoette@gmail.com>
In-Reply-To: <20210408155334.12919-1-barneygoette@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 9 Apr 2021 11:30:14 +0200
Message-ID: <CAMpxmJVHJt4p7KVwqQHoWu+WbS8pUm8VDuj0NeWzzzwubRwGhg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: gpio-104-dio-48e: Fixed coding style issues (revised)
To:     Barney Goette <barneygoette@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 5:54 PM Barney Goette <barneygoette@gmail.com> wrote:
>
> Fixed multiple bare uses of 'unsigned' without 'int'.
> Fixed space around "*" operator.
> Fixed function parameter alignment to opening parenthesis.
> Reported by checkpatch.
>
> Signed-off-by: Barney Goette <barneygoette@gmail.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Changed the commit message to `gpio: 104-dio-48e: Fix coding style
issues` and applied, thanks!

Bartosz
