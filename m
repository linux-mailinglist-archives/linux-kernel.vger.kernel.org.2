Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC63AC7BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhFRJhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFRJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624008938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLL8PB172SRL8lGgz205HV0dC/eqDJtIYHSvhcZcv70=;
        b=cDBQRG0N8GwtVxIvpxGnbAboTX8SYfHoRa/ZVnQC0Hh+bz67EsmprrDlFl/sH0pEC5wOau
        icrgZA83ezcr5e5HFjUbTcZ9U3QFKG5OqaQhRFScDlmu2xp4M6FC13VoWcrLkIQIVc4Fyp
        6hAoORfU4JXokywn/cSLBXRas7gDrck=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-SSjP-BqeNTasiGnnLqqMBQ-1; Fri, 18 Jun 2021 05:35:35 -0400
X-MC-Unique: SSjP-BqeNTasiGnnLqqMBQ-1
Received: by mail-ed1-f71.google.com with SMTP id p24-20020aa7c8980000b0290393c37fdcb8so3221640eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rLL8PB172SRL8lGgz205HV0dC/eqDJtIYHSvhcZcv70=;
        b=F1NGQ/EvdU6Q2Tu3ve2TNYODcaFTQtnqsTNi67qAdSGnjv29LYoUs5a7OfC32vzIBc
         kNikZtMxwsPYWWAiKlddkXCql3F+8NsLyAk51dGUM8fS8QKh6E+MYZxS0XgYUoKuzz27
         9hr/wn0PJGTvj8+ZZNby2a4/jD/fR9dXNIirVFESRgiL15FJ+eJdC72LvDTT9yIE5Ofm
         h1W0O+6sxtaqYA4uTeq6KUaid4TOisvYDfBEHq2QAh/Dr1Ipcn+E4dGqgeRAS7G3UlzL
         197O5VmFgTWh05QlMNj3sj8WnQUf9I/VcZwvOzGEsLG0VnBP8SAU2dE9A36ltwBX1ve/
         nieg==
X-Gm-Message-State: AOAM531zmk3RWh1xieJKPLukPP2aKOrDEGpwQqWYM7ZMfLlmY+f3D8mS
        on1e5Gjeu0TQKw60UjB08lTemd+AZxsqko+W6XiECFzUvdALXVlSFO/0xOwS6gr0RsyOO+WJUnp
        S/ZR8QsC8sUsGE0l/D1c29AQC
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr3745070ede.94.1624008934360;
        Fri, 18 Jun 2021 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrTXbUUFRfwaNYCZ2CYmaoH3ldgRuFW7Ykg1x5qXMOhN3Q/A6Vhme8lxLfTWTSAbzIR/PDfg==
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr3745054ede.94.1624008934194;
        Fri, 18 Jun 2021 02:35:34 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.252])
        by smtp.gmail.com with ESMTPSA id ch17sm5993778edb.42.2021.06.18.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 02:35:33 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:35:29 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jiang Wang <jiang.wang@bytedance.com>
Cc:     virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        mst@redhat.com, arseny.krasnov@kaspersky.com,
        jhansen@vmware.comments, cong.wang@bytedance.com,
        duanxiongchun@bytedance.com, xieyongji@bytedance.com,
        chaiwen.cc@bytedance.com, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Lu Wei <luwei32@huawei.com>,
        Alexander Popov <alex.popov@linux.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
Message-ID: <20210618093529.bxsv4qnryccivdsd@steredhat.lan>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609232501.171257-1-jiang.wang@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:24:52PM +0000, Jiang Wang wrote:
>This patchset implements support of SOCK_DGRAM for virtio
>transport.
>
>Datagram sockets are connectionless and unreliable. To avoid unfair contention
>with stream and other sockets, add two more virtqueues and
>a new feature bit to indicate if those two new queues exist or not.
>
>Dgram does not use the existing credit update mechanism for
>stream sockets. When sending from the guest/driver, sending packets
>synchronously, so the sender will get an error when the virtqueue is full.
>When sending from the host/device, send packets asynchronously
>because the descriptor memory belongs to the corresponding QEMU
>process.
>
>The virtio spec patch is here:
>https://www.spinics.net/lists/linux-virtualization/msg50027.html
>
>For those who prefer git repo, here is the link for the linux kernel：
>https://github.com/Jiang1155/linux/tree/vsock-dgram-v1
>
>qemu patch link:
>https://github.com/Jiang1155/qemu/tree/vsock-dgram-v1
>
>
>To do:
>1. use skb when receiving packets
>2. support multiple transport
>3. support mergeable rx buffer

Jiang, I'll do a fast review, but I think is better to rebase on 
net-next since SEQPACKET support is now merged.

Please also run ./scripts/checkpatch.pl, there are a lot of issues.

I'll leave some simple comments in the patches, but I prefer to do a 
deep review after the rebase and the dynamic handling of DGRAM.

Thanks,
Stefano

