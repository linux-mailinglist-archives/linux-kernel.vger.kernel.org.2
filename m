Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4108F3E1CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhHETog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhHETob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:44:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA0EC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:44:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a8so11450520pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftm3zfKV6cpZYHKiwh7RI7XBwvcEz4eEvPAk+OMRUDA=;
        b=AiI5oLhAaXyaR3SelPewteL4mJEYEc8AT+m39Z5oK666U2KmUalH0V/Q3PVNYdxyh+
         pT/htNE/pG8f0RblYqtzbq0cjvqhKOstqn1U6oKns3zmNiF0uI/1fVova6+HCtP3yYZh
         FZ8OFiwBLhcoeWS8uluHq88j4d7258KHrdcakZJ3wLOQ0mcBNNKyBAekqdIuE2OtH4gp
         8V3DmcVxt/jcSCirJIblDWlGhCsvHLoO7raBntgN3UPtSxBMDdRmzhoaQ3D8pC/qH1Cv
         XY+44eeRqWsmnHXoMwYzl3m9zlROKHrmNWBtYhH7leiujgsjOwCaEiXOoMvWTZEuheZd
         cwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftm3zfKV6cpZYHKiwh7RI7XBwvcEz4eEvPAk+OMRUDA=;
        b=XtZx+2xZsHLMgccYfNVndiXKMj7/PEls2Qp6MXQX7wsIDNdNA9X4xtJFhGgq9lrF+S
         ocUUqjtd62yLS64WTm9jqbD2cMYyReY/fxN4ISBLFomuKHMZm9pNSBodZw4UL57OvJLH
         LN0Cx1ald2YjEXUurDo+hj46wWPPZUqOnmjjIECg1RoRl3d+4IVfx15ON4d3tp3z49XW
         Kfak/WRyJ8h5p6uc+kINDACUiGQeeu8uvBCUI3WVP1zcBnTTdDRi5zovFWJ5j8UhzTA9
         1ds3bGY/hiyEl0Nag1JyMaZd3A+qjYEsGysfVjg/0jzI6piV6L0mtsEShivhpTaoHSGM
         i1dw==
X-Gm-Message-State: AOAM530tzqYJ0YT7XmI/GeN4eODtp6gbjOWZLLzYYdUGIJJpcajY/HGp
        8rwrr7TCW0oM+1cEugl+IGyObT9MO5NlHx/KChqXuA==
X-Google-Smtp-Source: ABdhPJy33KaTp4XtlbKdMxRSehhUd59CykvfbtbM5r61VDZ0N+etwKCXbdTEw65Chwe10nsN/sSiu5v0t/KGL99tTmA=
X-Received: by 2002:a62:6304:0:b029:3c7:be8b:ae6 with SMTP id
 x4-20020a6263040000b02903c7be8b0ae6mr419609pfb.55.1628192655927; Thu, 05 Aug
 2021 12:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210805183100.49071-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210805183100.49071-1-andriy.shevchenko@linux.intel.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 5 Aug 2021 21:53:57 +0200
Message-ID: <CAMZdPi_+GpG8h2tJ1AxOj6HaPiXXDh6aC2RvO=+zXRy_AQpWkg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] wwan: core: Avoid returning error pointer from wwan_create_dev()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 at 20:38, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> wwan_create_dev() is expected to return either valid pointer or NULL,
> In some cases it might return the error pointer. Prevent this by converting
> it to NULL after wwan_dev_get_by_parent().

wwan_create_dev is called both from wwan_register_ops() and
wwan_create_port(), one using IS_ERR and the other using NULL testing,
they should be aligned as well.

Regards,
Loic
