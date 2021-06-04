Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3709B39C331
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFDWG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:06:58 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44835 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFDWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:06:57 -0400
Received: by mail-lf1-f48.google.com with SMTP id r198so12852082lff.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQZbuWUG03lQ2rSsW03oJWLnLVkei/e7oxh8vFKy7HM=;
        b=nWeoqrwgWO9J+GywK0+9MkhsUybMt4qICY9XGVkIHqhglHGFgf1gsU6s0vwiblTgKC
         EJ2yjEw7gmTSbvLVaWKTrTGLAzw32OApT5lGPAxEzeqkw7ff9fwT0QF8W0x7bVBwr6OI
         IDBq2rqdoRFZOyQbTUunBPM3/qkKhATM5edS+3bVkAgEckv2uwTiSnR27+p3Zp8ecxYQ
         j+NIQBSSgc/oHPPrJ2+YwxswY4zMVnQXwtpakhxXGGy69pNEe7HJiqxfQizni8azumPa
         bUkAg0yy4EI72OZMDRf7S9so3g5JB68AjUgiFTPzIecay/6ac+JVlgW9ieJGdeKdjwX1
         FHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQZbuWUG03lQ2rSsW03oJWLnLVkei/e7oxh8vFKy7HM=;
        b=dxFiW9W0BFOGI1iivs9tw5ERpq1UsLRqsjWj5yxPBfAd4WOszSJYsYi8d/Qdco3+g1
         icMXkWnMfe4xviB0D4VAPrpihPcZI7Mw10YbvMG6rxrHCXmDU2jzm6xgN1OKltlvzc4b
         iuNuGwiLBWlbSUlWGB4vAoJ4g05M0P06QB0rxsa5kygLNRI+PwAWPP4axWNrAiIoESbm
         ikxcWgz0m0SSj5YI9S/CIl6VWJrUBxwNMS7HiYQ6/KrA0w6gA1w1WJt3vV9JV0hChgGQ
         2VU/y2ydHxsM2QP4+/RDOi8tvy84nLs5lmReQsBDG8ncpLx0GpSma12ZR6EbKUQo6m1H
         LPEQ==
X-Gm-Message-State: AOAM530cHKf0ezGp+AjshlsIxSX5fhiLZ3WzzA9hAnfDdYjnVaiNHpJ9
        yds5cMmSxVbZB3/do8zxmiU0VPNEDIV3qdapA612yg==
X-Google-Smtp-Source: ABdhPJxrXNHigb02NXg6KvBA1hhlWVQqvBzap419QCgz9FmREBg8ONmXhdrIziS9rug3ASrPUTOzuNFzPRSRw8rrQ90=
X-Received: by 2002:a19:8157:: with SMTP id c84mr4135763lfd.529.1622844249725;
 Fri, 04 Jun 2021 15:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210514123309.134048-1-tsbogend@alpha.franken.de> <20210604122223.GA8940@alpha.franken.de>
In-Reply-To: <20210604122223.GA8940@alpha.franken.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Jun 2021 00:03:58 +0200
Message-ID: <CACRpkdafaMUjai4VCxePX2kWFkh4=Ks5qQvHTtYvVtkeHPhKKA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] gpio: Add support for IDT 79RC3243x GPIO controller
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 2:22 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:

> is there anything a still need to do to get this integrated for v5.14 ?

IMO not really:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Bartosz is collecting the patches for v5.14.

Yours,
Linus Walleij
