Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B23FDD84
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbhIAN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:56:03 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:42917 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhIAN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:56:02 -0400
Received: by mail-lf1-f45.google.com with SMTP id j4so6540460lfg.9;
        Wed, 01 Sep 2021 06:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=1qbLir7t00tIXtsSOowis8wzBunbda5Sb7xAud87L5k=;
        b=QJHFdFwOKDQb5JBqkff1XErqaxiXi7zRXZttRrX/7OAvy0XYZ2LAucXOd5lgdLY/w1
         8rBqS6EVcmCe6bZaKZHoB5EoGydpr/IRejrfovqIb5KfBYJOtnV2YrpJd+mkif2HoE/t
         2fV9su+Qgl4t3PxYYzKEHszG7SIvHxLU/utUkrRnaadWjzzXjcnqCmO4di1TCxtYHg7E
         PwRo5bGKiqg6xISmLGtL9i1/37QCET1YuMbLd2h8WqKDjDyx8kthTYJn6UCjTR4oVPyh
         3gYLzRVBgO8pjt1prsEaanaDfwcVcOKql4EbqWrK3VVON3NktYJvCuOF3DsNnT07CrXT
         sHng==
X-Gm-Message-State: AOAM531WtYQ/BSB9lQHz3FruOvJ4upSE0/tpCvQT5aS7+8zyS9Fk7nYX
        bKR/il+SYdJrYDiLNgtwmwbDb0YtFbTOBA==
X-Google-Smtp-Source: ABdhPJxnqaiKpaUsD1/Wf7HVOpnXIwDiz/oQkQPofTMkFyItLkXYwvqnNuFAr7cr4G3mnvYqWtGMmQ==
X-Received: by 2002:a19:f015:: with SMTP id p21mr25478146lfc.32.1630504504031;
        Wed, 01 Sep 2021 06:55:04 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g21sm192581lfu.94.2021.09.01.06.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 06:55:03 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id l10so6587597lfg.4;
        Wed, 01 Sep 2021 06:55:03 -0700 (PDT)
X-Received: by 2002:a05:6512:3f89:: with SMTP id x9mr26306205lfa.233.1630504503566;
 Wed, 01 Sep 2021 06:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210901050526.45673-1-samuel@sholland.org> <20210901050526.45673-6-samuel@sholland.org>
In-Reply-To: <20210901050526.45673-6-samuel@sholland.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 1 Sep 2021 21:54:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v668_prQ8zw9rX3=Xi9L73cqqo+KhUN_4m8OUzF0qhCH1A@mail.gmail.com>
Message-ID: <CAGb2v668_prQ8zw9rX3=Xi9L73cqqo+KhUN_4m8OUzF0qhCH1A@mail.gmail.com>
Subject: Re: [PATCH 5/8] clk: sunxi-ng: Export symbols used by CCU drivers
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 1:05 PM Samuel Holland <samuel@sholland.org> wrote:
>
> For the individual drivers to be built as modules, the ops structs and
> callback registration functions must be exported. None of the helper
> functions are exported, because they are only referenced from the
> corresponding ops structs. of_sunxi_ccu_probe is not exported, because
> it is only used for built-in early OF clock providers.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/clk/sunxi-ng/ccu_common.c | 2 ++
>  drivers/clk/sunxi-ng/ccu_div.c    | 1 +
>  drivers/clk/sunxi-ng/ccu_gate.c   | 1 +
>  drivers/clk/sunxi-ng/ccu_mp.c     | 2 ++
>  drivers/clk/sunxi-ng/ccu_mult.c   | 1 +
>  drivers/clk/sunxi-ng/ccu_mux.c    | 2 ++
>  drivers/clk/sunxi-ng/ccu_nk.c     | 1 +
>  drivers/clk/sunxi-ng/ccu_nkm.c    | 1 +
>  drivers/clk/sunxi-ng/ccu_nkmp.c   | 1 +
>  drivers/clk/sunxi-ng/ccu_nm.c     | 1 +
>  drivers/clk/sunxi-ng/ccu_phase.c  | 1 +
>  drivers/clk/sunxi-ng/ccu_reset.c  | 1 +
>  12 files changed, 15 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
> index 31af8b6b5286..3ab109582646 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.c
> +++ b/drivers/clk/sunxi-ng/ccu_common.c
> @@ -83,6 +83,7 @@ int ccu_pll_notifier_register(struct ccu_pll_nb *pll_nb)
>         return clk_notifier_register(pll_nb->common->hw.clk,
>                                      &pll_nb->clk_nb);
>  }
> +EXPORT_SYMBOL_GPL(ccu_pll_notifier_register);

These symbol names aren't exactly specific to sunxi. Maybe we could apply
symbol namespaces?

ChenYu
