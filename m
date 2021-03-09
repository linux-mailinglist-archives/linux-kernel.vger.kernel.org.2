Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5829E3328B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCIOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCIOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:36:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF0FC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:36:26 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id dm26so20487729edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkrImNhNpTZbyH50e8J9HL5+BNOIlHrCZBcyIPHvdns=;
        b=it1he6lFFcNQQOZEWQXRhe/IQSNeucdGGvbtokOSAmr4bBlJkfu+kpji98BR0/GsGV
         +AaWi1JPDbGLv8yzjYXF0BEZFEPWXHO+tRoydoYdlfq4OiRfjRazY6/0cX5LwDqnxyb1
         52430PMmUh1QDQ5kEmtyaFUChfVSFLzAghdgi15N7bXgXmnU0Df0iJPe2B27zg8+KaSl
         au9sjdS60+iMcJEQVcx4fqIuaGdn9LGT4Ff49QkovaprjQoZcH6ViqVbSbhMVjA64ARh
         S/Y4vriSZjZNir9OFVoGpHvP3Tsvg+9pOdxPZEwfoXV6wbNG7iHDbb47feA7dZq0Bfev
         sSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkrImNhNpTZbyH50e8J9HL5+BNOIlHrCZBcyIPHvdns=;
        b=qaNXFf3QftM2m4iplbCLkirjmuvJ+bgLpdc+Yj4IwXKRWlCxY0fVfWmtszRouC9uod
         1z3sxltbuZMguISaDXqnsFz+9CyKoGUBzNJbTukCY1VXddSeUKlWqJTK/dunTOqBLLDb
         utRNGB+Eth4znfKk50ySa10cb/59vXgAMk8OsgJ++zQaAsNFXBT5KgYvfpXHWLj5fAe0
         Lr16HUNv/6bMQh0h1RD/c8kYqkI5hnwyPGjMWXyV0z0EdYNSetX7CmQyf/uzd9I+rku7
         cESxzthzIyNhKoh5a3xywASo3/hbXGPCnaaRle5guBH3yyiRSrR2K3vzFWESF+tH+/FN
         yaOw==
X-Gm-Message-State: AOAM532pzIvC/gAWojMMPKP7EUqzzVPWcbFw2qIkK2RxVUNowIwNNEHo
        1FjmS2iwTlMFm0bnSsmq7e1vSmc7wzM=
X-Google-Smtp-Source: ABdhPJwcJKvM22h1t6hpa3964/gu65DtTlF5aomOAXX/vCv8eF7djiXiei0KLtaVKgqC9/2qCM1J0A==
X-Received: by 2002:aa7:cb4d:: with SMTP id w13mr4473497edt.249.1615300584635;
        Tue, 09 Mar 2021 06:36:24 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id e22sm9193325edu.61.2021.03.09.06.36.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:36:24 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id d15so16065334wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:36:24 -0800 (PST)
X-Received: by 2002:a5d:640b:: with SMTP id z11mr27886602wru.327.1615300583787;
 Tue, 09 Mar 2021 06:36:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615288658.git.bnemeth@redhat.com> <b07e88b0d023fd7c6f5bbee27ae1cb33e52b9546.1615288658.git.bnemeth@redhat.com>
In-Reply-To: <b07e88b0d023fd7c6f5bbee27ae1cb33e52b9546.1615288658.git.bnemeth@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 9 Mar 2021 09:35:44 -0500
X-Gmail-Original-Message-ID: <CA+FuTSf1RVx4HSyT7PvWfNpz2nYY5qWSf_RtYiejLbSccemQCA@mail.gmail.com>
Message-ID: <CA+FuTSf1RVx4HSyT7PvWfNpz2nYY5qWSf_RtYiejLbSccemQCA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To:     Balazs Nemeth <bnemeth@redhat.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        David Miller <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 6:32 AM Balazs Nemeth <bnemeth@redhat.com> wrote:
>
> For gso packets, virtio_net_hdr_set_proto sets the protocol (if it isn't
> set) based on the type in the virtio net hdr, but the skb could contain
> anything since it could come from packet_snd through a raw socket. If
> there is a mismatch between what virtio_net_hdr_set_proto sets and
> the actual protocol, then the skb could be handled incorrectly later
> on.
>
> An example where this poses an issue is with the subsequent call to
> skb_flow_dissect_flow_keys_basic which relies on skb->protocol being set
> correctly. A specially crafted packet could fool
> skb_flow_dissect_flow_keys_basic preventing EINVAL to be returned.
>
> Avoid blindly trusting the information provided by the virtio net header
> by checking that the protocol in the packet actually matches the
> protocol set by virtio_net_hdr_set_proto. Note that since the protocol
> is only checked if skb->dev implements header_ops->parse_protocol,
> packets from devices without the implementation are not checked at this
> stage.
>
> Fixes: 9274124f023b ("net: stricter validation of untrusted gso packets")
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>

Acked-by: Willem de Bruijn <willemb@google.com>

This still relies entirely on data from the untrusted process. But it
adds the constraint that the otherwise untrusted data at least has to
be consistent, closing one loophole.

As responded in v2, we may want to look at the (few) callers and make
sure that they initialize skb->protocol before the call to
virtio_net_hdr_to_skb where possible. That will avoid this entire
branch.
