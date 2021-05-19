Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7CC3899E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhESXbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhESXba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:31:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3735DC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:30:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j10so21579531lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMwUCc4SgPJG97Rkm0aBtlB2yukAmA0ZCOYZxIe8Tck=;
        b=COFRVP/pO0baQb+7qWHLDz2WLUT5dypjNrj5zUFuYXzUtg6fpKRLlKYbiZzPTITPZc
         /uUhhjfIhsoNsAMrop863YnjD+LgJVtDBP1KYoIu4ksGcJgGWz+s4WWn3kmvO/XAv0BK
         OjUUa9da0YUMEgSfNJvNy+ql5y+6om6KV5Dn8le+pTDLe6BKSPKUmTwLt2eqm7lESk3B
         QnO3uLAlBSJnplIxsPfmtdAsiUJVFs3wuquyVQJXmSJaQ2CdHSUXq2Mye2jrpNtdysXk
         O4duXcZeyAtbDkRMCeOnacVwo36wilffm5IBrr8bDvT2UfALp70Ae/bNbZX+hYLGS5rx
         LiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMwUCc4SgPJG97Rkm0aBtlB2yukAmA0ZCOYZxIe8Tck=;
        b=E8A49rz8Ewe0FzQI8Oehq+m0Hp6GwOFy9vwTOlEKzuZSnIKXU9AptJqOKufA0IrFuu
         ufTOIUqrcHd9vi0hpZ7ufP0Z6z3NGlU4EjWEHQqC+5gLCxvA7s5lH6bv5pU3tG5Oiers
         T7camS69QYPLNxUfr2K9Mq+jlK3gBRDftMTfUxoRijioG7jY+oeYITRBKaXZbJtX3Mao
         OsDA0vji6zbo+gyVM+1oR5LL7fbhC7K8tuj6Xmx3QiWww6blmGiKNRi2rlc3+GKxSgeS
         tZht4dg0yJJD8a3pgy7Wvl6ebBBsk7rUbKuV60YKcfzIxrDDGJUWmTPyRr6yQxUcaUHb
         WVkw==
X-Gm-Message-State: AOAM533PYZ+yRPpMhDlMYcYAIJ15CeDvaik7MYHn1jX87u1XyVpVTB93
        DfSZgaD75g1IY5DGweKCmeDyUji6X5hIFBKr5BR3vm2vUSQ=
X-Google-Smtp-Source: ABdhPJzJNxbjDTEBFvL1ZTsKRGzbh5UGwMfvAMRXs41Xp0OeG3kf02/POIFVqkoTMyWq2ondcCw8vTGrfxB/0AvMAqE=
X-Received: by 2002:a19:ef10:: with SMTP id n16mr1030061lfh.649.1621467004538;
 Wed, 19 May 2021 16:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210510194633.11943-1-andriy.shevchenko@linux.intel.com> <20210510194633.11943-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210510194633.11943-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:29:53 +0200
Message-ID: <CACRpkdbox-QS-2TG0U_PMRHT60dxt9HaV-k7cTReDn+uM6-fZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] bitmap: Make bitmap_remap() and bitmap_bitremap()
 available to users
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Neeli Srinivas <sneeli@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 9:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Currently the bitmap_remap() and bitmap_bitremap() are available
> only for CONFIG_NUMA=y case, while some users may benefit out of it
> and being independent to NUMA code. Make them available to users
> by moving out of ifdeffery and exporting for modules.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Neeli Srinivas <sneeli@xilinx.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
