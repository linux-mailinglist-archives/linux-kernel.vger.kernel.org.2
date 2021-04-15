Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995DF36014D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhDOFEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDOFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:04:03 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC35C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 22:03:39 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id s2so7142993uap.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 22:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6rXRCawg7a0JdGyqbR6u+JeuBa20F3vxBah9EplT/k=;
        b=Q36gpnEooF2/6e+IsIkHU9yRDPTDx7sR+y5K926rcioaIDtKOE/roeU4sUIGtoQF5j
         sH7HzmlXskxqAvLn8VOsMkZnaNdQV4USwYD0sMjmhjLrE1RyETTHa6OAyn9qzB3flBBk
         do44cvcUU7DFMNJvkAZlgb02eZixRELD4GpTNClzAKVZaZUCGNDMXm5U7iFht5LbVTxz
         MVX4mYHQseJfE8C2/GFM77Cn5Xpsz9HWqUkJJIGMGjsH5exZTQmN5p7UEnh0bwI84mF/
         ld7N7tJMFqC10bNl4RD3+QIKAIdIg9qNtTPz6HtdUIl0WDdnIYjhTRni/Pk3a7FWdstJ
         dX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6rXRCawg7a0JdGyqbR6u+JeuBa20F3vxBah9EplT/k=;
        b=USl/i93b4I/LyQLTPqzN5By0nPxQ+ADdqSksLCImmqzXEP90VsnFxTBwsLIEq6wW0u
         WYXwya0bsFW2IrYqn7c5tjOKzWOSWodP4kezB0z+YiaualatWEeXzeYoW775Gr2LIng4
         h3P67lP0CuuyiaoAWZRCHeGk7zrFxt8ghWa/NJ3ihQ0DCUhg7l7Dakt4+K04yipU0bou
         m1CsXfrOGNTvfDcwNGRkSlf5PnyuOxTh1UIq3+jY6pNMaHRkNraGci2onO5yaVOeb/zh
         y2nlMPfLjx4xSr3TLS4MY+FxUneEuYeuKgfMuH78//rzIKPb3lxaKPGACnapSsRSaVQF
         yQUA==
X-Gm-Message-State: AOAM531+d7zP1gWeaAO1mlfJV475PgGwIVveWQlvBZmRJt7NiXlkYGMW
        RhsOShdfLmLDDRqL47YE+bCiFLRY5gDOtyidrNOn3w==
X-Google-Smtp-Source: ABdhPJw6ScYkmKPwkrxQD7A6q15On1dQNv6EYeBh1rI89wj8xocbUlzQCTCt7+i6K6foXhy3/nEmiIOgNoSNdP89lrg=
X-Received: by 2002:ab0:2741:: with SMTP id c1mr653603uap.1.1618463017982;
 Wed, 14 Apr 2021 22:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210415050121.1928298-1-badhri@google.com>
In-Reply-To: <20210415050121.1928298-1-badhri@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 14 Apr 2021 22:03:01 -0700
Message-ID: <CAPTae5KsNsw79ozyHtN+8L=Si6Z2y-Qkc9=Xw-vFZerUwDM=pg@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Fix error while calculating PPS out values
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:01 PM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> "usb: typec: tcpm: Address incorrect values of tcpm psy for pps supply"
> introduced a regression for req_out_volt and req_op_curr calculation.
>
> req_out_volt should consider the newly calculated max voltage instead
> of previously accepted max voltage by the port partner. Likewise,
> req_op_curr should consider the newly calculated max current instead
> of previously accepted max current by the port partner.
>
> Fixes: e3a072022487 ("usb: typec: tcpm: Address incorrect values of tcpm psy for pps supply")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 1c32bdf62852..04652aa1f54e 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3132,10 +3132,10 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>                 port->pps_data.req_max_volt = min(pdo_pps_apdo_max_voltage(src),
>                                                   pdo_pps_apdo_max_voltage(snk));
>                 port->pps_data.req_max_curr = min_pps_apdo_current(src, snk);
> -               port->pps_data.req_out_volt = min(port->pps_data.max_volt,
> -                                                 max(port->pps_data.min_volt,
> +               port->pps_data.req_out_volt = min(port->pps_data.req_max_volt,
> +                                                 max(port->pps_data.req_min_volt,
>                                                       port->pps_data.req_out_volt));
> -               port->pps_data.req_op_curr = min(port->pps_data.max_curr,
> +               port->pps_data.req_op_curr = min(port->pps_data.req_max_curr,
>                                                  port->pps_data.req_op_curr);
>         }
>
> --
> 2.31.1.295.g9ea45b61b8-goog
>
