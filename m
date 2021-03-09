Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DD03328A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhCIOao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhCIOaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:30:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22A7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 06:30:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x9so20477209edd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXQaz6o4atEJRYBV31RTFfL6gXZMWZsubP8sDmVgbZQ=;
        b=au56fHLLqSDZ32svP/xUg7xLMNSde2/I3pHgvCvdQj4Hg4vCaCD6OmBVREF29YOaNk
         vJjCUz/23fLp5igggCvoWzZdbDJKzB3HCWTEMeQSF+dQw56rXDiY7UROn9tanPEwm/4O
         aVWGqQXGLpsfaXVuJj8POuaglPiq43KbYP3+rzOIm2NztRnr92M8Z2gQnuodZb9iy66p
         ylSyGZcZgRAHM72qPOKI9D+x9UcxbWivnI4svzrZraIVaEbebcQOjcD59L3w+NIq7FVS
         eboqFRffwc7ovjPZ0xWW6ogtUiYUwM95YkLDrK4TJyeot+r2cLyCDd5GegD5FEvUVfsk
         mUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXQaz6o4atEJRYBV31RTFfL6gXZMWZsubP8sDmVgbZQ=;
        b=DnXVptNUmp/Sf3DS+rVbP6f8r0KXGMkYAA/3rEniVtH31+K3HnENm4BTr/24LpaFA8
         szZxcmOyHwEALXl2gGk1BLQSEJKctDb6dBjU4kCBHsVjpP+fGTA6SIyDUJzSfV0eCLmi
         cZJlBbEGv8EhWIWTpk2ZfK++rLji2P3HjQ3/2zKs35n9B+JBRw6KXIqDnPPn2//w+/i7
         SBKNrk33Lrg5j7dr44jjcYngk3jvzxJ39WtEdcwQnPXTIdOrteHy6UNTH/m7Z77sKXQ7
         yEotvX5A62EfZT/JyWAoQiBqJ6fY2S2CVjDz7t3kjbwbonP/dYUETcS5O4n9XjdaLeRv
         loFQ==
X-Gm-Message-State: AOAM5309qx9dgj0TfvqzLTPwKWvpllYFDgVuM/Q4rWjiaXLDPkjom3t2
        LymQNZ6GYijHEbvtNYIE0ZESLNQmzH4=
X-Google-Smtp-Source: ABdhPJykji2UIRW1reLZYh3hKgA7TnhakC26laVZksw/q+zFxpnZS88fCg6Oikpe2S6NzYVGILDRYA==
X-Received: by 2002:a50:ed90:: with SMTP id h16mr4420101edr.101.1615300212028;
        Tue, 09 Mar 2021 06:30:12 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id gj13sm8064140ejb.118.2021.03.09.06.30.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 06:30:11 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id 7so16040232wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 06:30:11 -0800 (PST)
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr28646938wra.419.1615300210948;
 Tue, 09 Mar 2021 06:30:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615288658.git.bnemeth@redhat.com> <9b79f43d2dfec8b2cb8e896b5591e7b1c3cc1f6c.1615288658.git.bnemeth@redhat.com>
In-Reply-To: <9b79f43d2dfec8b2cb8e896b5591e7b1c3cc1f6c.1615288658.git.bnemeth@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 9 Mar 2021 09:29:31 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfd=47GLDui1mmg_+OgG+OYf80XYKqMEvKUhbzJFM=dQw@mail.gmail.com>
Message-ID: <CA+FuTSfd=47GLDui1mmg_+OgG+OYf80XYKqMEvKUhbzJFM=dQw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net: avoid infinite loop in mpls_gso_segment
 when mpls_hlen == 0
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
> A packet with skb_inner_network_header(skb) == skb_network_header(skb)
> and ETH_P_MPLS_UC will prevent mpls_gso_segment from pulling any headers
> from the packet. Subsequently, the call to skb_mac_gso_segment will
> again call mpls_gso_segment with the same packet leading to an infinite
> loop. In addition, ensure that the header length is a multiple of four,
> which should hold irrespective of the number of stacked labels.
>
> Signed-off-by: Balazs Nemeth <bnemeth@redhat.com>

Acked-by: Willem de Bruijn <willemb@google.com>

The compiler will convert that modulo into a cheap & (ETH_HLEN - 1)
test for this constant.
