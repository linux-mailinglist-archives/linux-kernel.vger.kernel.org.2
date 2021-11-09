Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3244B8F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhKIWu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbhKIWuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:50:06 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD89C00EAA9
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:21:24 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so855477otv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLsRex488etMkJyCCFaXLtgPzZ6BB/J9dKWw8UO3KF8=;
        b=HiVLib1yZobRnuW7sMIDMYgEiV7yhcNYV53azWFi6aSYW4Hu++8xN0MqgT9ZBTBPe1
         tHfuZJW+x3zpArXVhEztoQURqBgNNAqvkhrpdok2c1CYScgbTEkk3toWbsXGaEsMPhBc
         pobpQ2rMClAZp0i0TvDBo0SZAGTrza1mdUUSgjugkU2oA7tzpHVZSIZWY2OOOlvRabpj
         xPBPjmrQZd9Z6fxEVq7BWnagN67ohxQ3kkVDeE0cZHQkykxoJzisjtym0erskVnhIOYl
         BxQABSwHk0vmOC8j2uq7gypLmELd9QUegVybgm3hF2dKB/JaBQMP0LD29ohzDV3YG8Wz
         hM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLsRex488etMkJyCCFaXLtgPzZ6BB/J9dKWw8UO3KF8=;
        b=NIMtYQsmYSRexA0ZzTHW/g/paGoyImljwXvQFuyAoXSI/2mRI3TE5UKy0DHRVtKNZ5
         fqoFwOW/as3Z+TGRKJObzEnMMb1IZibedMLAIEFzT8jGPoicAWWjr/EbDVJMoF28I0ie
         ukN5VcuGgumFiw4ck/oDYEhqZJYfXxIFHjHsdn7caYqpgEP2ih9iectU76C3OJpXgPdt
         hLw8lXZnE5kiebLPzXVsNm5bXNsEaSR53v68/IKTpVeVpzuDHKofjhYxT7KVtiWsFIeQ
         5TSPs+BsT8COa4fgn/noX9cC38oA4MQR1Z8y+J9bYNgSj7e8KZERQW2Wce0NKZ664zoh
         nVlA==
X-Gm-Message-State: AOAM530GBw4otwUTulu0UblyUY4TkSNHQP7YY8qfXovMtooAUUZ5PIIt
        RD6ZpFSwlY9h/fLOiyohwTiRA070TrmTWUZsFv1UJA==
X-Google-Smtp-Source: ABdhPJxnGCMwPBzOn0vDnUGZChUhsq9PbhUnrHTyTVpdBpkdT5/1fxR/EpRTVr/sEUcMpLzruQlZhgh3IK5H9XIVdOU=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr8689832otj.35.1636496484311;
 Tue, 09 Nov 2021 14:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20211109164650.2233507-1-robh@kernel.org> <20211109164650.2233507-3-robh@kernel.org>
In-Reply-To: <20211109164650.2233507-3-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 23:21:12 +0100
Message-ID: <CACRpkdaY9VQcUCNe4ZFKFyRd7HSFh1FX8yOT-AFqjJ6wc56Ehw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: versatile: clk-icst: Ensure clock names are unique
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 5:46 PM Rob Herring <robh@kernel.org> wrote:

> Commit 2d3de197a818 ("ARM: dts: arm: Update ICST clock nodes 'reg' and
> node names") moved to using generic node names. That results in trying
> to register multiple clocks with the same name. Fix this by including
> the unit-address in the clock name.
>
> Fixes: 2d3de197a818 ("ARM: dts: arm: Update ICST clock nodes 'reg' and node names")
> Cc: stable@vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
