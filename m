Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A136BE48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhD0EX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:23:27 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:34479 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhD0EX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:23:26 -0400
Received: by mail-lf1-f44.google.com with SMTP id z13so10640519lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=+3nCZbNLiqMqhR6U6pOoZhEuTzuJzc2jZTBWAxxwNNw=;
        b=PJyHlIHk9csc75Md7//o4kCY0wLWa1kPStE8FEZYEY1gEMjwGIhlYF4gLVllyCLZYg
         Tf7ot1hjoYBPRSGim+Fi5HQ+k9F7tl+TNw/va7g06/E9w1CmjixzHtOotCEFQDxIDnpn
         W5MEjiQjSLL+zT9Xojog51NpSbgiFRIFVnJN3tqa/8EmsaIPZ7wjmBoYXu2sbPsYp+3X
         b8HjA0s2uHo9VL5IeuLSgX+aC8LUcpY0Xsy2fmbg0XRwJY9X0iPI5LMvmExUxyr7eJ3D
         wHoDLEVKnL4Zs82wBp9GeeKlxm/BfDvpIf35Osw2dSz5GIvlWiDVTC+M8Dh0UTPRADJG
         UMPA==
X-Gm-Message-State: AOAM530GpbBlMjoLyyS0/nJs2cyzE+Zmw60iGBtzOu2vA/i/vKIshmtY
        BBAmsfcoR/RuGCHMnDG+VPOWbmh8R5etvg==
X-Google-Smtp-Source: ABdhPJwLrr+w3z6xLa2w3iLIK7nDdyplVm9jf4tFO03xGCKQmuNPrr+oz95HuyG9+pjNTbSZrsRxbg==
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr16081405lfg.655.1619497361813;
        Mon, 26 Apr 2021 21:22:41 -0700 (PDT)
Received: from dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id j18sm207541ljc.132.2021.04.26.21.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 21:22:41 -0700 (PDT)
Message-ID: <c57e008aa165ef2bed8a3d8747b8bd6b3838445b.camel@fi.rohmeurope.com>
Subject: Re: [PATCH -next RESEND] regulator: BD71815: select REGULATOR_ROHM
 to fix link errors
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20210426183752.19089-1-rdunlap@infradead.org>
References: <20210426183752.19089-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 27 Apr 2021 07:22:23 +0300
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Morning Randy,

On Mon, 2021-04-26 at 11:37 -0700, Randy Dunlap wrote:
> With REGULATOR_ROHM there are linker errors:
> 
> ld: drivers/regulator/bd71815-regulator.o: in function
> `set_hw_dvs_levels':
> bd71815-regulator.c:(.text+0xbb): undefined reference to
> `rohm_regulator_set_dvs_levels'
> ld: drivers/regulator/bd71815-regulator.o: in function
> `buck12_set_hw_dvs_levels':
> bd71815-regulator.c:(.text+0x33e): undefined reference to
> `rohm_regulator_set_dvs_levels'
> 
> Fixes: 1aad39001e851 ("regulator: Support ROHM BD71815 regulators")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
> Sorry about the Resend. I'm having some email problems.

Thanks for fixing this. I just wanted to let you know Arnd sent same
fix (and couple of other fixes to BD71815) few days ago. Mark couldn't
take the patches as the original series is only in Lee's tree. Sorry
for causing the problems.

Best Regards
	Matti Vaittinen

