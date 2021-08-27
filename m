Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4DF3FA187
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhH0WeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhH0WeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:34:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F6DC0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:33:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id l2so9285952lfp.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ywYhHM2zklC75nxCrBvwq7g6YJQFFGRNqncuhmwCEI=;
        b=dKrJ018IcTaQGPFXKX1augr8dB5GqpdOS5gKUA7c+ulUYCWpwqU0+rrfn6H3OxqD94
         OJ8QtQXJKZZQAO3+q5ydhL2luNjr3O+Iw/+vXgNlxagX/iijEYkb1MfVoQK9EFLUtZOc
         fo6sDBncrJR135w0GKfVo1Iw1S9QUmr1TxEAgYwUKrYqQ//ZN/MKhT1XW15pbf7tSO2p
         DXvf9mYFPwLjrmKAWJUNP9yA824mvY7rnCXXa+E25p7m6qEMhF0azl6D1RzqURcB5ISy
         KascdGYWQFht1pkgXTJ5JAQzBahatKzmO8TAwTT8y2mRnu54DUxeln5SKbJ/dQNVbHWF
         4XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ywYhHM2zklC75nxCrBvwq7g6YJQFFGRNqncuhmwCEI=;
        b=AzsaxH2PWmn36wHYLVSL63kIUJafIiMDzb0OQtqLi1uJQX7IuLYZ2oBddq1EUhLkPf
         9Jy8KnKKdBo82KQCrx8N9V/x/gcSLPMZWiEPyRZiVMbpwOmqmZiTIJLDRh8U450BpNz4
         XvKfY8VTdhpuQuAYPiKD1G+6LLWv6r/GCY/XFjQ9C9+kWzjgTB5xkTqAinyu42QAR3AF
         KrLX4n94NKu3s59MTdiF6w8tPZc0RwAkB86ex9zXXeiv6lKb+IBCPILRUKnOV2SriPL3
         bEaw8OHewjXI5T6dlpv8rBgzLMCjdNrrb50JxDMgheaEZUns/SUNd8K/ddP46us7tNXG
         OjGw==
X-Gm-Message-State: AOAM533/r63k1lgkGeUEQvPLINxQ/vWEaRhB3UwJ9p1zr62YDy1s5smE
        3bZSIQPMoN7rhRfeG3KUB5PQTAO7rlNOYbCXAdfbUQ==
X-Google-Smtp-Source: ABdhPJzNCHBqrGBEOijhOc/riEYonE9//wBepchueSEL4x65XMZ6mkXLAq3up4U255kyJ/jCLvrzKBsWFSaRCRECTU8=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr8186336lfu.291.1630103612695;
 Fri, 27 Aug 2021 15:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210823112204.243255-1-aardelean@deviqon.com> <20210823112204.243255-5-aardelean@deviqon.com>
In-Reply-To: <20210823112204.243255-5-aardelean@deviqon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Aug 2021 00:33:21 +0200
Message-ID: <CACRpkdZJ5vrmVvL3wjHPmdEyr2==SZ2+Ay37f961Y_TWjGaS7w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] iio: st_sensors: remove all driver remove functions
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 1:22 PM Alexandru Ardelean
<aardelean@deviqon.com> wrote:

> At this point all ST driver remove functions do iio_device_unregister().
> This change removes them from them and replaces all iio_device_register()
> with devm_iio_device_register().
>
> This can be done in a single change relatively easy, since all these remove
> functions are define in st_sensors.h.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
