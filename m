Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241603BF828
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhGHKPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhGHKPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:15:05 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 03:12:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h4so5428881pgp.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jE27VuYVlOpCcGE27gQsr7n24gIzFqBsKr/EtxzjirM=;
        b=G92dwu3sSHn0hpFfWmwVWhaEJSJl1fZGJKtLaF8K9SCsn9B+SxyuB+cdrHAa41EEoe
         bOPKELTY0ujAr1/uUjjxq+xIFE6F987CKLcGzuKYHjUYMp+UfKO1c/i/DWXP0ShUbMXu
         4eR9xAhqbcZUDGPmwY3PddJMgIsWU3LoVHfiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jE27VuYVlOpCcGE27gQsr7n24gIzFqBsKr/EtxzjirM=;
        b=PEM4CeAbO5TkvDTTcztFc7NZh9HBZT1vmtLkGbXLkNjWLXpL0NQ3QtFINu9L/xFzof
         lMlyLKZ4aa1Kg5FJCiaOt8qI0JVwfpqK5V1Dg6N1pOK1uAMId29qBBRn+YF++H7dUDF/
         Xe3JL9FguE8huW0X95Noi/Q0bSTdv/moP1Zx7yYLTtQd5LOlcxjThjjv/DND9RW5uRHZ
         uF9XCzLojIxqbKh0pgPm+fFqWUC2o2xqvxxzLjiHc+fgQAUkXKSa5lJv0UUxDxL2FRe7
         YFsSSZGa5OXyvyG/mKDgrOfTlfj0Xkj7WYl8U+EdXY6SswKCvuBqOE18D1c6OEKRuTBk
         idCA==
X-Gm-Message-State: AOAM532mbU3nOpDDyN9Vsiy6Ek5vfaTRZN2Bah+4520Pzke6rVD6VeiR
        pz84K4f41BzZ3MrR1wvw28mG5g==
X-Google-Smtp-Source: ABdhPJw7HnJbMSz3SImDF0XLYGQVXOiCHGIGnPFgK7xXG1hDpDv9iYrxuVajKmvbZrTOqqKljUkzgA==
X-Received: by 2002:a65:4903:: with SMTP id p3mr31418968pgs.402.1625739142574;
        Thu, 08 Jul 2021 03:12:22 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:9350:6a13:c03e:920f])
        by smtp.gmail.com with ESMTPSA id y7sm2026578pfi.204.2021.07.08.03.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 03:12:21 -0700 (PDT)
Date:   Thu, 8 Jul 2021 19:12:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
Message-ID: <YObPgQd9208Qmp2M@google.com>
References: <YKDYbaprE3K2QpCe@google.com>
 <s5hbl9b6mah.wl-tiwai@suse.de>
 <CAMo8BfKKMQkcsbOQaeEjq_FsJhdK=fn598dvh7YOcZshUSOH=g@mail.gmail.com>
 <s5ho8be8v3z.wl-tiwai@suse.de>
 <CAMo8Bf+FF8Ofq=FwoZZXp9vKiMaUZNAm+W=OJmu2j2XN6kLb-Q@mail.gmail.com>
 <s5hk0m26lfu.wl-tiwai@suse.de>
 <CAMo8BfLj+VLUbfUmHUSHOfc3PwbWd2w_xnaTZa9HyrcmvJCAkQ@mail.gmail.com>
 <s5hfswp6zx8.wl-tiwai@suse.de>
 <CAMo8Bf+bGujLN7H5yBqy-AkPCN7LgfmGSiWEGdjW6ZWeFoXs9A@mail.gmail.com>
 <s5h5yxl6uzo.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h5yxl6uzo.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/08 11:00), Takashi Iwai wrote:
> > > --- a/sound/pci/intel8x0.c
> > > +++ b/sound/pci/intel8x0.c
> > > @@ -694,7 +694,7 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
> > >         int status, civ, i, step;
> > >         int ack = 0;
> > >
> > > -       if (!ichdev->prepared || ichdev->suspended)
> > > +       if (!(ichdev->prepared || ichdev->in_measurement) || ichdev->suspended)
> > 
> > There's no ichdev::in_measurement, but if replaced with
> > chip->in_measurement it indeed fixes my issue.
> 
> One must compile the code before sending out :-<
> 
> > So with this change:
> > Tested-by: Max Filippov <jcmvbkbc@gmail.com>
> 
> Great, thanks for quick testing, I'll prepare the fix patch now.

Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
