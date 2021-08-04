Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2DE3E0A83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 00:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhHDWqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 18:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhHDWqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 18:46:21 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F5FC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 15:46:08 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id s21-20020a4ae5550000b02902667598672bso842602oot.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvjJXIAyDtPL/Ndk/Btj800bsnjEboaOCHdw/tjENlE=;
        b=NvgNV1BmOyqa+ONMf/ndrJq3FcJ7c5LtBMHtnvF0HO93XBKfRK4RrR34Cc/uKakySh
         m7ZcUjTOAWSAAigDKMZlCvF7srO4sHeRrHLUrLoJxffYgyd+VQBKS40QzRAd432FN48J
         RSWCYqHIZn95SJUMdLqpkiUnfZs96ZUZQ7ggQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvjJXIAyDtPL/Ndk/Btj800bsnjEboaOCHdw/tjENlE=;
        b=poY7LvVXd1mFXIRE1WoXzVqP836qDD+9ska/ItOVhDiKE2tS/xsgVyHhEvf3sTgmnx
         zWiBWJKUnYAo7oxEqBBnPeLAJ8yKqflGv4PXXDaYYS1ww9TbWL2IUAqeRfX8ct84Rf9G
         C6plEk9sydM097YWf99Cr9Zt1dg+q+EfQqgwYpnTGtIttdZEvfQfB2G6U0Rl3hUuQMn4
         osd5auCNBZtxfkPBWqvHXycyScHTmRlPmmgHlY5HB4tJ7MkCjDrLo303/R9mGhf8Qng8
         X0Ihv2dflEzFdArH6E7t4ExSOxxkPc+T+0tBNaYfz+izWEL2sCZO/ngMyBqZaseo+U2T
         7ztw==
X-Gm-Message-State: AOAM5332dP0UYEDSzoTwAsbfGfUe9cBMdt/MmL3H9Aj2Zn93vybV57pB
        aYNa+Z4Rhf8bSjFV11vcvQm5pMuW/y7L4A==
X-Google-Smtp-Source: ABdhPJzI3pBFPCo4fmYWkFuXbU3r+mY6WCNRzDwd+Hf6CwkBWIYotxS3mViUJ5ZHfJYMhS737R603Q==
X-Received: by 2002:a4a:e907:: with SMTP id z7mr1098471ood.20.1628117167321;
        Wed, 04 Aug 2021 15:46:07 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id x38sm646367ott.42.2021.08.04.15.46.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 15:46:06 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id a19so4789105oiw.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 15:46:06 -0700 (PDT)
X-Received: by 2002:aca:110d:: with SMTP id 13mr7258895oir.77.1628117166068;
 Wed, 04 Aug 2021 15:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210804020305.29812-1-islituo@gmail.com>
In-Reply-To: <20210804020305.29812-1-islituo@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 4 Aug 2021 15:45:54 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPxMBeVwb+708Z5ZwKsNmBhcAE1AwbbRvsQMDiNaGJXQQ@mail.gmail.com>
Message-ID: <CA+ASDXPxMBeVwb+708Z5ZwKsNmBhcAE1AwbbRvsQMDiNaGJXQQ@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: drop redundant null-pointer check in mwifiex_dnld_cmd_to_fw()
To:     Tuo Li <islituo@gmail.com>
Cc:     amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 7:03 PM Tuo Li <islituo@gmail.com> wrote:
>
> There is no case in which the variable cmd_node->cmd_skb has no ->data,
> and thus the variable host_cmd is guaranteed to be not NULL. Therefore,
> the null-pointer check is redundant and can be dropped.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>

Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
