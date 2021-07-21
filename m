Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB4B3D06C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 04:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGUB5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhGUB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:57:04 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B251C061574;
        Tue, 20 Jul 2021 19:37:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z9so818879qkg.5;
        Tue, 20 Jul 2021 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aN+hI/hvLP5nbqQDgGUl5r57KPkS+zV77YzWwgrtMGA=;
        b=SgIYVi+JsAqUv7JTRn1AA6w9zwtlDsIuFHsCFdjICju832y91ruaa9KPgcb20/XLyK
         Dj8y+e9UNSSCVhl6dm5BaZvPzuL8lpebR/ohiLC64ctrt18pUkldDHdo3bAAiIrlvdtG
         7hijleTo+fyBhyHNa9R23dcHKaP3xJjFIh5Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aN+hI/hvLP5nbqQDgGUl5r57KPkS+zV77YzWwgrtMGA=;
        b=MXEPay76lMpOxrgN3Agvrc4YnW35DdbzJPvamC3OrPDtLJKiG7R9Hy13rktq2g1A+H
         5zjI+2W3EGMyh7N7GjdIrOZQ3j6va3M8+fc89V3f5UjinFq+DcWAg14oGbr6IMoGUEi8
         AilSFLiXiU2pNLHtDjeYkDMl6cUM75P2wg3ZeEGoHGgxSuVXj1ON6qutnaIssnvWsz+1
         h7zBHPG4pu+CrsMmHh0oQRRjkvFYXPV2ql/ECdVtOdjBdWQL6KBYJC+9gFyUW/vhlHyR
         oUbiQJAPxrsnpwTjRuA4kUQfU+rn63koDAme8J23J6XTouinZglLGnumjjnb0HPDa8sH
         orPw==
X-Gm-Message-State: AOAM533F3I+F0TkJXMWODQMDyZDYQ03KLA+NB6+tY/59Q0PQp9K17hKX
        wl0EX8LoBNQ1O/L1+Fp9xH/FCnxOybA5vHlzRfk=
X-Google-Smtp-Source: ABdhPJymZQk1TW40WE4GyQwwOME1VOFW1Mi6pvXnbAQmyjoLmM/INX1gpTHax9I8mFo9Yn1FcM/nitv5Wjd+J07Z+7M=
X-Received: by 2002:a37:5c84:: with SMTP id q126mr21243926qkb.465.1626835059980;
 Tue, 20 Jul 2021 19:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210716151850.28973-1-eajames@linux.ibm.com> <20210716151850.28973-2-eajames@linux.ibm.com>
In-Reply-To: <20210716151850.28973-2-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 21 Jul 2021 02:37:28 +0000
Message-ID: <CACPK8XcBHGsFu0VoNPutC8HYbLcf0WV-KWNixCdGXxWsf1PDVg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fsi: occ: Force sequence numbering per OCC
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 at 15:19, Eddie James <eajames@linux.ibm.com> wrote:
>
> Set and increment the sequence number during the submit operation.
> This prevents sequence number conflicts between different users of
> the interface. A sequence number conflict may result in a user
> getting an OCC response meant for a different command. Since the
> sequence number is now modified, the checksum must be calculated and
> set before submitting the command.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> @@ -479,11 +483,26 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>                 return -EINVAL;
>         }
>
> +       /* Checksum the request, ignoring first byte (sequence number). */
> +       for (i = 1; i < req_len - 2; ++i)
> +               checksum += byte_request[i];
> +

This could go below, after you've got the sequence number, so the
checksumming all happens in the same spot?

The driver has become a bit of a maze, I can't tell how you're
deciding what goes in fsi_occ_submit vs occ_write vs occ_putsram. If
oyu have some ideas on how to simplify it then I would welcome those
changes.



>         mutex_lock(&occ->occ_lock);
>
> -       /* Extract the seq_no from the command (first byte) */
> -       seq_no = *(const u8 *)request;
> -       rc = occ_putsram(occ, request, req_len);
> +       /*
> +        * Get a sequence number and update the counter. Avoid a sequence
> +        * number of 0 which would pass the response check below even if the
> +        * OCC response is uninitialized. Any sequence number the user is
> +        * trying to send is overwritten since this function is the only common
> +        * interface to the OCC and therefore the only place we can guarantee
> +        * unique sequence numbers.
> +        */
> +       seq_no = occ->sequence_number++;
> +       if (!occ->sequence_number)
> +               occ->sequence_number = 1;
> +       checksum += seq_no;
> +
> +       rc = occ_putsram(occ, request, req_len, seq_no, checksum);
>         if (rc)
>                 goto done;
