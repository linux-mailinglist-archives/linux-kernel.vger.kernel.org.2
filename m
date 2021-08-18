Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116CE3EFFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhHRJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhHRJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:03:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE75C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:03:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w6so1369851plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wi6GiW3siAeArZqvWLcz46sruMCMOkQL9Tx1MHP2F9M=;
        b=O6b9QEJX2A+BMP2t/Jopnb3uLzfw7MkxdgYGDPd8kXg7lj6i5rW4b1KQUD7duBp0NW
         ARZb6rSvwK8yUjjDtTmZ/No5b/N6TJNMpFMfjHQcB66xfWC5jxVfZdmVgg/rw4tb9D9m
         KTQ5SvRW25g7NfqelO4dYcMxQcfvJG7CIhrVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wi6GiW3siAeArZqvWLcz46sruMCMOkQL9Tx1MHP2F9M=;
        b=cyycmAbUyP+MEhea6Q0qbMU1HkQu4kFkZr05PJMO75XyP5FwEaxoaGmB4/QbS5Yj4/
         kQ2IQdr6BYm/8yGLMpLODAfyUr2UI0hja/01HEwIu891oVVh21ONeVC9bW7iMZtZ8Jlz
         2usvP9AtGK5Kpx7CckQiWVQ7CRi0H4DKE20xq+dukLWcvCTN2clVFwXDoGvUpRM2qryY
         1s6A/x/w+dv8cB8QzVa73/JchrSsnOFnU1/+3FJcASSUpOsABoPBclzycG9InxzaGnJi
         CUKyxN5RfhbK4IDM4YP1VYILDggKdEMuHC8yzSLRMUk+fOdEqGA56kpOMOSBA5GIs/PT
         4JCQ==
X-Gm-Message-State: AOAM530IErtFd6qR0SIEBaoJteHLOP/45YX8h/j1SiWxKp8KoUUyaTrF
        Vy4C5peRufnpGlAxWd1DCJk6yg==
X-Google-Smtp-Source: ABdhPJwBy4P3b9ZHL/uuEc5QK3+QU7JmWq9RZXhEv09uSY9Rwkh8duMfsoih0ejFVq5RU4iOGkX0cA==
X-Received: by 2002:a17:903:22cd:b0:12d:8876:eea7 with SMTP id y13-20020a17090322cd00b0012d8876eea7mr6462580plg.75.1629277398247;
        Wed, 18 Aug 2021 02:03:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y13sm5730422pfq.147.2021.08.18.02.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 02:03:17 -0700 (PDT)
Date:   Wed, 18 Aug 2021 02:03:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        linux-can <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] can: etas_es58x: Replace 0-element raw_msg array
Message-ID: <202108180159.5C1CEE70F@keescook>
References: <20210818034010.800652-1-keescook@chromium.org>
 <CAMZ6RqK4Rn4d-1CZsg9vJiAMHhxN6fgcqukdHpGwXoGTyNVr_Q@mail.gmail.com>
 <202108172320.1540EC10C@keescook>
 <CAMZ6RqLecbytJFQDC35n7YiqBbrB3--POofnXFeH77Zi2xzqWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLecbytJFQDC35n7YiqBbrB3--POofnXFeH77Zi2xzqWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 04:55:20PM +0900, Vincent MAILHOL wrote:
> At the end, the only goal of raw_msg[] is to have a tag pointing
> to the beginning of the union. It would be virtually identical to
> something like:
> |    u8 raw_msg[];
> |    union {
> |        /* ... */
> |    } __packed ;
> 
> I had a look at your work and especially at your struct_group() macro.
> Do you think it would make sense to introduce a union_group()?
> 
> Result would look like:
> 
> |    union_group_attr(urb_msg, __packed, /* raw_msg renamed to urb_msg */
> |        struct es58x_fd_tx_conf_msg tx_conf_msg;
> |        u8 tx_can_msg_buf[ES58X_FD_TX_BULK_MAX * ES58X_FD_CANFD_TX_LEN];
> |        u8 rx_can_msg_buf[ES58X_FD_RX_BULK_MAX * ES58X_FD_CANFD_RX_LEN];
> |        struct es58x_fd_echo_msg echo_msg[ES58X_FD_ECHO_BULK_MAX];
> |        struct es58x_fd_rx_event_msg rx_event_msg;
> |        struct es58x_fd_tx_ack_msg tx_ack_msg;
> |        __le64 timestamp;
> |        __le32 rx_cmd_ret_le32;
> |    );
> 
> And I can then use urb_msg in place of the old raw_msg (might
> need a bit of rework here and there but I can take care of it).
> 
> This is the most pretty way I can think of to remove this zero length array.
> Keeping the raw_msg[] but with another size seems odd to me.
> 
> Or maybe I would be the only one using this feature in the full
> tree? In that case, maybe it would make sense to keep the
> union_group_attr() macro local to the etas_es58x driver?

I actually ended up with something close to this idea, but more
generalized for other cases in the kernel. There was a sane way to
include a "real" flexible array in a union (or alone in a struct), so
I've proposed this flex_array() helper:
https://lore.kernel.org/lkml/20210818081118.1667663-2-keescook@chromium.org/

and then it's just a drop-in replacement for all the places that need
this fixed, including etas_es58x:
https://lore.kernel.org/lkml/20210818081118.1667663-3-keescook@chromium.org/#Z30drivers:net:can:usb:etas_es58x:es581_4.h

Hopefully this will work out; I think it's as clean as we can get for
now. :)

-- 
Kees Cook
