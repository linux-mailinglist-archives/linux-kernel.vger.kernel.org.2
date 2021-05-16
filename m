Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD7381E77
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 13:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhEPLYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 07:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhEPLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 07:24:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D180C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 04:23:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k15so2727093pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 04:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lJG0zQvDeXMVv53Ck1aIxdEZ/keO24SJzKO0xIhMZeE=;
        b=DXnVL0pkjr1uBBJuNdlGYAMQdS05d4l6kYyV8u5Hx0ooeevWDgkeiKeQt3pSAGIvdt
         UIO2PQF4t4LhFGgyH/tW+sHN5I1iJv1VKtbw5wSOz8WjF1nDAzW0mkGCE6iBZBB2U11O
         YklXXQMHpnh+vcEhmmG8fLKpV6gy4EA9xxFHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lJG0zQvDeXMVv53Ck1aIxdEZ/keO24SJzKO0xIhMZeE=;
        b=VpdUqi/VyDkdYLyW7vYX5L8Q623Vh8yGKeAitmVbudnuRnW64jR0XT1pEAySWxVnqw
         saRco2dYlUR5dNeg8v2M6yRVCR1Ee8qW+yy8JSvqx8IkGJUB/e/SL+/btWzDkMUAmXLY
         KTYruIcoY/4mowZqfdo8e+uhFiQ+Hf+GiX3pcmt5ukEQ77nE9ma8WHoQWGXC7Z/o6q2I
         OdKS2UcWK4SysL2TI9GzPQ1piCIDXPbx1qFkWMSS7PIq0rabBI3Gm9i9WKnxBjv/ZnQq
         eB/kuNhqlELmeAzmlDgGlbYLaQ97f4Y+9ckLMTLboe1Mmuz6DElJMjPrYwv/BG0+ElJf
         zw6w==
X-Gm-Message-State: AOAM530TEt8vD7S+VKcVszglqBU62AyMLXC0oONiPjuaEqqslB5tCtI7
        p+C6M4ccvjwnYoLE0mJRI20d1g==
X-Google-Smtp-Source: ABdhPJwxNb8d5ZlbARnU54AQKtx2pJJ/iterhcqiCFNnfTaHDGAeBoL/sepmaDiofgcZLc5RmD6tAA==
X-Received: by 2002:a62:4c3:0:b029:27c:892f:8e22 with SMTP id 186-20020a6204c30000b029027c892f8e22mr54576846pfe.6.1621164207073;
        Sun, 16 May 2021 04:23:27 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4596:acad:c782:2f52])
        by smtp.gmail.com with ESMTPSA id x20sm8137652pjp.12.2021.05.16.04.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 04:23:26 -0700 (PDT)
Date:   Sun, 16 May 2021 20:23:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
Message-ID: <YKEAqdIAZ5K5FS+1@google.com>
References: <YJ4yBmIV6RJCo42U@google.com>
 <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com>
 <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com>
 <s5hbl9b6mah.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hbl9b6mah.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/16 11:49), Takashi Iwai wrote:
> Subject: [PATCH] ALSA: intel8x0: Don't update period unless prepared
> 
> The interrupt handler of intel8x0 calls snd_intel8x0_update() whenever
> the hardware sets the corresponding status bit for each stream.  This
> works fine for most cases as long as the hardware behaves properly.
> But when the hardware gives a wrong bit set, this leads to a NULL
> dereference Oops, and reportedly, this seems what happened on a VM.

VM, yes. I didn't see NULL derefs, my VMs crash because of div by
zero in `% size`.

> For fixing the crash, this patch adds a internal flag indicating that
> the stream is ready to be updated, and check it (as well as the flag
> being in suspended) to ignore such spurious update.

I reproduced the "spurious IRQ" case, and the patch handled it correctly
(VM did not crash).

> Cc: <stable@vger.kernel.org>
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

I'll keep running test, but seems that it works as intended

Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
