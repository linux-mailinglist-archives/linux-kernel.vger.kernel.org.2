Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8F3F1E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhHSQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhHSQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:58:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259FC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:57:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gt38so14150606ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4tGqtodxm8cq9s5nssrQK8UELCa81JVaJ+mdBHNrMA=;
        b=MFNDt8U3uf+R5KlZ32EtgNfNPP7b6zj1iTV2LzL0Y9SV+rkF+HQCrG+AI+wr7GaOlX
         1pGPelfy2gRTJHkJTMj1vQD/4eRKq0H9+ziqXzcaLYdt6UF5KWNYJOgq/FpUb+YCgeKr
         uwjJXo87PB9Tw8aljBbRBc3Ko1vLy89qNQoSXPlkAcxjso5FpvdGlrVxawCQFRE1/GiF
         PMuVBYEgsnO7jyIMU3QmK/mkM11JJ/RfaIV0XJ4PW/3bIXsnK1Cmk0HLSD7qmTv13guX
         CHjvT/I9G0FnpCr2mlk/fUGARp2RGs4dn/R3xuYXPpkeJWqfKUBqhz2b2T2fSKaAOvxi
         8RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4tGqtodxm8cq9s5nssrQK8UELCa81JVaJ+mdBHNrMA=;
        b=cqaJcS06lOb/viSJUS8v5zvxCS6YFEa4cw5PrUR7HQX5qWdeJqqxTK0eAM/KDsdylK
         CsH8SXcbNE4JrnMoab/vMPvyHnBIUh9M9P8k/yEJnEKNxu9J4yK+SyUlx8gr0HXhzv93
         fHUkHA88XcPzJn0ta7sIGwiVRZHwR0HMKhSptRWLYvQpLwpodlk/2DT4sLXDodsdhk0P
         3Y5zpWCPGhuGJA0DI6xShLmteq8CWdIbjKD1mJlvOialGTWRmlievSagNDu19raenaI0
         UewOCcnO7KPP4ZBVzODN/WpWjUZpQ2kwE8wqmb7RlWOI8xNAPiQm+FP8zmlQ+NQUpaqQ
         2ktQ==
X-Gm-Message-State: AOAM531A4vJ4S1SYpDS/eE+V8PZpCaO1ZXZvTnSKc9Qe1QkvP/K2P0sR
        q8y0CHntca723QxpSonzuN8chbYlW/s=
X-Google-Smtp-Source: ABdhPJyrpR5klD8IlbLbz43LNGM06O2CUoitITSGbSJm+M08ouGl7XOuSYu2tPgN95+l4fHU7YcYpA==
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr16685891ejf.117.1629392258310;
        Thu, 19 Aug 2021 09:57:38 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id r6sm2064300edq.20.2021.08.19.09.57.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 09:57:37 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id x10so10093024wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:57:37 -0700 (PDT)
X-Received: by 2002:a5d:494d:: with SMTP id r13mr5017809wrs.12.1629392256880;
 Thu, 19 Aug 2021 09:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210819143447.314539-1-chouhan.shreyansh630@gmail.com>
In-Reply-To: <20210819143447.314539-1-chouhan.shreyansh630@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 19 Aug 2021 12:56:59 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdsLzjMapC-OGugkSP-ML99xF5UC-FjDhFS1_BDDSJ2sg@mail.gmail.com>
Message-ID: <CA+FuTSdsLzjMapC-OGugkSP-ML99xF5UC-FjDhFS1_BDDSJ2sg@mail.gmail.com>
Subject: Re: [PATCH] ip_gre/ip6_gre: add check for invalid csum_start
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 10:35 AM Shreyansh Chouhan
<chouhan.shreyansh630@gmail.com> wrote:
>
> If we get a ip gre packet with TUNNEL_CSUM set, an invalid csum_start
> value causes skb->csum_start offset to be less than the offset for
> skb->data after we pull the ip header from the packet during the
> ipgre_xmit call.
>
> This patch adds a sanity check to gre_handle_offloads, which checks the
> validity of skb->csum_start after we have pulled the ip header from the
> packet in the ipgre_xmit call.
>
> Reported-by: syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>

For the ipv4 portion:

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")

For the ipv6 portion:

Fixes: b05229f44228 ("gre6: Cleanup GREv6 transmit path, call common
GRE functions")

It's possible that a similar bug exists before those, but the patch
wouldn't apply anyway.

Technically, for backporting purposes, the patch needs to be split
into two, each with their own Fixes tag. And target [PATCH net]
