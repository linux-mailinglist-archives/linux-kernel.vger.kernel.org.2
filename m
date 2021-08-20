Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482DE3F3172
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhHTQ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhHTQ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:26:15 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F9BC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:25:37 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r38-20020a05683044a600b0051a2c6dd421so14972302otv.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxLtPnFOuMANvSxjDCMLHiIliU+/Z440kM6ruecl38k=;
        b=Z783oB+nDDQyM0f1HJ/G0ZPDPQooXJ9p3r+9iH/5O1IgKBo1rZSFWiGyTFei0a4kJ/
         5aIU4NzBsHcT8oiKJr6wu4p4PYGFJ3hvFlG4qQKwiAO1Y2dO9rLjRTgpnOjTJCk4IE7U
         P8YBrvTrRTAJX6pttSyng90U6LKtiRfvTBmrTV7FU1d+smc8daUMVYJJ8Em5U0pMgN3D
         FlKkUPuPaoXPY7HMhDaLzAKl5m4JSLIt1L83ra8j0c/2Xl5QcE1HXPAEwbxdVXlBVQ58
         9UxsqCsv+XDujL41vV/32fYz3xH4i0ePSlnNJhxoJ27XDPvNUewjTVul0clL3XEN2+Ip
         vTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxLtPnFOuMANvSxjDCMLHiIliU+/Z440kM6ruecl38k=;
        b=djkOa7N5XNakFGAS51E0pPdgloOa8BxoTjVEYh+hvVDVGEtHDEZATeTa40czGPiWr+
         GBEpr3x8jP1aIaAIrYfRW5VH9XMwS4mKd26a2MzN6ksbqYuulqbapUPAeHk31Y5acPSq
         ilcuv6aY2bftAcfKuNGI3qt7oPY8mcxBMcgLsBMNSr+snBhcAZJcODZ7GV4dDP1MyAMY
         pq0OwoCr7AxXyje6742CfpdDhndF0VejiiQb7ILnQNrRrZvPJ/IFUgZoyXHpDW6rjvBf
         Lmsl72IrAXwt+R9bwrktBTHG2Cz36xEYlYweWs90KerkNML/wd28XPdZ0UTC9HQKkGHn
         JoaA==
X-Gm-Message-State: AOAM532BLAeu0qSFYy5PuF4it3MyGfv5Uqc6WwyY0LUp0yTfWis7vPbx
        Rp/LA0Uv2JT01O12KdCVZOkQWm4QWEcJy/afJeU=
X-Google-Smtp-Source: ABdhPJynj0LbtZZT9BmBLirtHoVCZCS1abv6Ww0W+ePB/ENcm6OI+phRBmzIZn/Z+t5Cahb/1FWoayo+eJt0d6Iehlc=
X-Received: by 2002:aca:918:: with SMTP id 24mr3689929oij.58.1629476736847;
 Fri, 20 Aug 2021 09:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210701065735.159336-1-joyce.ooi@intel.com> <CABb+yY0MAkZc8qgZ09VxiiDWhMJBzzws32njJG0k4XY19nuHwQ@mail.gmail.com>
In-Reply-To: <CABb+yY0MAkZc8qgZ09VxiiDWhMJBzzws32njJG0k4XY19nuHwQ@mail.gmail.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Sat, 21 Aug 2021 00:25:25 +0800
Message-ID: <CAFiDJ5-eYjEZGMrQeqUHhXX2n1M0CLdZ6nH-KewmfVVkNf8y9g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Replace Ley Foon Tan as Altera Mailbox maintainer
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Joyce Ooi <joyce.ooi@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 11:32 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Thu, Jul 1, 2021 at 1:58 AM Joyce Ooi <joyce.ooi@intel.com> wrote:
> >
> > This patch replaces Ley Foon Tan as Altera Mailbox maintainer as she has
> > moved to a different role.
> >
> > Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
> > ---
> I am sure it's all legit, but there hasn't been an Ack yet from Lee Foon Tan.
> Ideally this patch should come from the original maintainer asking
> them to be replaced by the new maintainer, followed by ack from the
> nominated maintainer.
> In this case, at least an ack from Lee Foon Tan is required.
>
> cheers.

Acked-by: Ley Foon Tan <lftan.linux@gmail.com>

Regards
Ley Foon
