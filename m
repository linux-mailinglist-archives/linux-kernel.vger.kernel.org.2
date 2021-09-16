Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2981B40ECFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbhIPV7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIPV73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:59:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D746C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:58:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i7so24142319lfr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqdMg3sYEVDu/L73yV5RUtE7bsLAqIyfCVaqqnuicqU=;
        b=r7ZzsngYT50eiYn3C0NVDAmH53vzgUe7T+5Pa172kLSk6H8xrLOD0KxZqHVVQdznmv
         MVTkGfS1VXPMi5hmACiMgQvFG3yHGenMpXZHchcw0wQnJEtZmR7jKNUPP4zSwH3Qnygb
         YabyJiYhWLd+i2VCjOt2rHQFsL1RctZ3ZTM2zFzeJfH0MbnGDkxEXAhVlLNrTL0MrxlE
         UPoS2N5HynoWyetlnKGUQBwPsL4TDxOxEmkLOXoD1QU3bdTnAkS+2S3ANPJwjh0zgdNA
         Ac1LcNe187YnuNTSWPh7oFKS5kfaRiwij4MIyuyqlm9xewEsigjtHtdpY3yhqdqtJV/a
         QuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqdMg3sYEVDu/L73yV5RUtE7bsLAqIyfCVaqqnuicqU=;
        b=IDgVOvOadztg0zu1avD+NuKyztLBMhqwf0dGczmEcZc5+1nqb/wICdgUxRin9fqyLz
         2ocknoi8/X2lZm1XnwoxFVamU+p8gXec7bkMu73cw3UpbINJgJMGlM8tr6KZDT6DaltQ
         TyxdkwlmKj9g/MOdbfPddP46roOuwycw3UWtXlDlxgHUl9+gK5o11Er+tYL6WWoMuY5u
         KCj0OtzPXZNWWDiXCGPXVQPp/bCZQ1ojS+N3+vFKhrxbecNoVnp90D2fZ9gf9elyr8+x
         MwGZp2MURhldAifHX68KC3BYUcD0RG8SAEQoTtcwlt6LV289AjlffOniZa9omsPWdz6v
         BENQ==
X-Gm-Message-State: AOAM533IxzWQ8I7z3hbBRnliFjPkfivxnJu5/+gxnvuzp9xORETUpigc
        z5OX5V8MTpRP3nou34wujMWuJOzwEdPqCr5cflCHq3FALzE=
X-Google-Smtp-Source: ABdhPJxm8Qz83s6bxer43QL0FEVGqhTBAM+KokIKmE42yqVfE5lpc5cycJCulEMnYIUcpvnn7JW2aHUv6RY1sp0mrhw=
X-Received: by 2002:a05:6512:e89:: with SMTP id bi9mr5504267lfb.95.1631829487007;
 Thu, 16 Sep 2021 14:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210824164801.28896-1-lakshmi.sowjanya.d@intel.com> <20210824164801.28896-14-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210824164801.28896-14-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Sep 2021 23:57:56 +0200
Message-ID: <CACRpkdZnWC1qCTqrJvu3H86S9F+jdh0DzR6xwbp=zDCSa2xR_A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 13/20] tools: gpio: Add event count capability to
 event monitor application
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 6:48 PM <lakshmi.sowjanya.d@intel.com> wrote:

> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> Add -t command line flag requesting event count to the gpio-event-mon
> application. If event count is unsupported an invalid argument error is
> returned by GPIOlib and the application exits with an error. The event
> count is printed with the event type and timestamp.
>
> Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Tamal Saha <tamal.saha@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>

This looks wrong.

If this hardware can report timestamped events, which I believe
it does, each event should be reported to userspace uniquely,
ideally using the native timestamp, and using the in-progress HTE
subsystem.

Yours,
Linus Walleij
