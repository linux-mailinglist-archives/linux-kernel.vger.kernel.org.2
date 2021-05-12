Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972E637BF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhELOQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhELOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:15:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA27C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:14:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t4so35290545ejo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8+dsnVGPf7hsY+HQXduPDAnUEDSpNmU6uRk4M3oaqs=;
        b=c917zy549w9VdfbQA59q0ZGjmJzDalQGHwIAgrrORe6nhbyLpIm0hOhpfbR2lf56Do
         H4sq4JTjpYYzjFFtG0b3QjgOoRtfJPFdkjU9BzxOynd4sqh1WtoW8wGUXVi+Q6m6w22i
         kFeD/tXYufp88NZZwKtwHsIma/lW4Qxa4v5H11u4IUqDvj7C/BJPM/XGh4ma0/LydrAn
         utQySur7OvheW+UY9CJyqdC8EuH9SEGAQfSNUx682LoK/ZuEvSs5agLzdXj+D8v3A7OW
         mjja+ixSxQt/u0Qwy5OKTNtrwqxTXmk9tq3TKUOb1PkTmGMm2EiTX2wT/ZqpiDoRlZNg
         hYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8+dsnVGPf7hsY+HQXduPDAnUEDSpNmU6uRk4M3oaqs=;
        b=Kq7cLn7zcO4sxHV95THZhK7JkNAvrFb5lDGKPuOFXktuFo3U94vodr3RPp/VpRi+M8
         qJDiNKD7Gly8B/gBia7iEcCiIH9B+sbZyUeWPcGdVW2Zx+n9JwqwUZ5nomhkmM7KWISG
         kz9bImA5YJGyGZO1GPSlTQgXZynETXUjqkPor10Mfr4wsqvGIHrlOU4MWLwbQ+SHAGs/
         8+shScMEpKYpVhZkn28LkDNW+Mflx4XKWYQZF3LVEoltxh9bamDxIm/XBOjSxDxBs3Vi
         P0mfE/N9SHHV7v43AoK/MHbjd6H+UoJZrmrSzX/ReGO6ctnfa81Kj7Kx5dODjqlHNYci
         Eb9A==
X-Gm-Message-State: AOAM53129MQnLHSkHaKKz4fc4k0kPB+9hlTDCIg5EitksbiDdRYkLtMt
        /kMbQOWifCr+Z+niV5S/RVqR9Mhu+yBkFg==
X-Google-Smtp-Source: ABdhPJw8SlktX8dsixbWlXO7Non9hffmxokViC/0m0wWbQfshEDSr0xDEK+UxgmssiFbswmzvjm82Q==
X-Received: by 2002:a17:906:68c:: with SMTP id u12mr774733ejb.470.1620828852912;
        Wed, 12 May 2021 07:14:12 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id h11sm17812370eds.15.2021.05.12.07.14.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 07:14:11 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so3129543wmv.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:14:11 -0700 (PDT)
X-Received: by 2002:a1c:ba05:: with SMTP id k5mr7661497wmf.169.1620828850704;
 Wed, 12 May 2021 07:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210512074058epcas2p35536c27bdfafaa6431e164c142007f96@epcas2p3.samsung.com>
 <1620714998-120657-1-git-send-email-dseok.yi@samsung.com> <1620804453-57566-1-git-send-email-dseok.yi@samsung.com>
In-Reply-To: <1620804453-57566-1-git-send-email-dseok.yi@samsung.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 12 May 2021 10:13:32 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdOvfdeEPffem6ZDyMzu7yqWxBZrVi2S2wgwjBwqpqquA@mail.gmail.com>
Message-ID: <CA+FuTSdOvfdeEPffem6ZDyMzu7yqWxBZrVi2S2wgwjBwqpqquA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: check for BPF_F_ADJ_ROOM_FIXED_GSO when bpf_skb_change_proto
To:     Dongseok Yi <dseok.yi@samsung.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 3:41 AM Dongseok Yi <dseok.yi@samsung.com> wrote:
>
> In the forwarding path GRO -> BPF 6 to 4 -> GSO for TCP traffic, the
> coalesced packet payload can be > MSS, but < MSS + 20.
> bpf_skb_proto_6_to_4 will upgrade the MSS and it can be > the payload
> length. After then tcp_gso_segment checks for the payload length if it
> is <= MSS. The condition is causing the packet to be dropped.
>
> tcp_gso_segment():
>         [...]
>         mss = skb_shinfo(skb)->gso_size;
>         if (unlikely(skb->len <= mss))
>                 goto out;
>         [...]
>
> Allow to upgrade/downgrade MSS only when BPF_F_ADJ_ROOM_FIXED_GSO is
> not set.
>
> Signed-off-by: Dongseok Yi <dseok.yi@samsung.com>

Acked-by: Willem de Bruijn <willemb@google.com>
