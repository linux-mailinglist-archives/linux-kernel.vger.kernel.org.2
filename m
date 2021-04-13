Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4708E35E87C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 23:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhDMVpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 17:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhDMVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 17:45:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB60C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:45:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ba6so21186806edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtrQUYaQ1DNhvexbHv80y5K6lB9AUwatNXLoT+S6QRQ=;
        b=l6L0IRxR8mNsE8rknbUzNijupzedPU2v4qLqSEqJ48RMJgFdDRjzy34uiA5zh3lfLL
         RsMyAYg+6rXFTzguI0d14YpGlsYiiXTAZ7kY4r+YimEfmd209ZvzgdI90KuwLTKDSZfn
         0PKySFgZoTo9y7dGJOrzVVF/ruk0qTvPqfzR2Ny45nHnTCRmdmHHGOSbO3F9UraMUdZ7
         zuwL7JMSq/L8E5kTAztS/D75inJd9msvh1j4/yoI07U3FfYyQeNHX0UBlE8m0K2PtqE7
         LnkxcKJPNp4RV/KT2YN9JyaK2TqDppeAOihjhrG9wxsFyr5Unb2DFnynqPPbxL9vk//v
         54Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtrQUYaQ1DNhvexbHv80y5K6lB9AUwatNXLoT+S6QRQ=;
        b=jSxXuGLVg6Ocs4T1bq4Cf8FVCCGO5juCnpQ11+gxuHPxZ+dcfSTdVsrKyjav3fRgH8
         2WYouwRXXQtAZlo7O+Z3qx6l4+6DOzanb2LCEz2juCGPG4Vduq44Ofin2+D43L5e8dcc
         /uG2bYLChRDM69W5+YIi7CTwLc56pnOMLfAgtBRoL0x/j5TExLgNo2BHeZA1DTkPZo11
         0MT9qJAHRjT2mqMcKgaKlEC9qK6Gf3w3G8XQv1nRRoDxcAJG7sfYVMo5k2q50y8m5lfy
         o7HJoVlN/T8uNL0sp8tq85KvRKAPKohS5g/cEZU2TjLvp16uSWvXNvzMXoox5/Jsrc0T
         KdsQ==
X-Gm-Message-State: AOAM533SQZw47GdKqhVBvRP68b7I76+Uvvz7+7IeddKc2Jx8oolnrMCK
        SV92cMNnAsl/QqkzcKW3QdIQRkRpAMxFhQ==
X-Google-Smtp-Source: ABdhPJx/V9Ts6vPEsSz1LqgQhCc6f5kD1axmAIy2i98U+q+Qzv7b3cp6nuWU/Ufo/Z6dcyNFLWg+fA==
X-Received: by 2002:a05:6402:31ad:: with SMTP id dj13mr36405989edb.167.1618350322393;
        Tue, 13 Apr 2021 14:45:22 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id nd36sm8352582ejc.21.2021.04.13.14.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 14:45:21 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so9006335wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 14:45:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc8:: with SMTP id o8mr1832923wmq.87.1618350321080;
 Tue, 13 Apr 2021 14:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210413054733.36363-1-mst@redhat.com> <20210413054733.36363-2-mst@redhat.com>
 <CA+FuTSe_SjUY4JxR6G9b8a0nx-MfQOkLdHJSzmjpuRG4BvsVPw@mail.gmail.com> <20210413153951-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210413153951-mutt-send-email-mst@kernel.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 13 Apr 2021 17:44:42 -0400
X-Gmail-Original-Message-ID: <CA+FuTSd7qagJAN0wpvudvi2Rvxn-SvQaBZ1SU9rwdb1x0j1s3g@mail.gmail.com>
Message-ID: <CA+FuTSd7qagJAN0wpvudvi2Rvxn-SvQaBZ1SU9rwdb1x0j1s3g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] virtio: fix up virtio_disable_cb
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>, Wei Wang <weiwan@google.com>,
        David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 3:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 13, 2021 at 10:01:11AM -0400, Willem de Bruijn wrote:
> > On Tue, Apr 13, 2021 at 1:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > virtio_disable_cb is currently a nop for split ring with event index.
> > > This is because it used to be always called from a callback when we know
> > > device won't trigger more events until we update the index.  However,
> > > now that we run with interrupts enabled a lot we also poll without a
> > > callback so that is different: disabling callbacks will help reduce the
> > > number of spurious interrupts.
> >
> > The device may poll for transmit completions as a result of an interrupt
> > from virtnet_poll_tx.
> >
> > As well as asynchronously to this transmit interrupt, from start_xmit or
> > from virtnet_poll_cleantx as a result of a receive interrupt.
> >
> > As of napi-tx, transmit interrupts are left enabled to operate in standard
> > napi mode. While previously they would be left disabled for most of the
> > time, enabling only when the queue as low on descriptors.
> >
> > (in practice, for the at the time common case of split ring with event index,
> > little changed, as that mode does not actually enable/disable the interrupt,
> > but looks at the consumer index in the ring to decide whether to interrupt)
> >
> > Combined, this may cause the following:
> >
> > 1. device sends a packet and fires transmit interrupt
> > 2. driver cleans interrupts using virtnet_poll_cleantx
> > 3. driver handles transmit interrupt using vring_interrupt,
> >     detects that the vring is empty: !more_used(vq),
> >     and records a spurious interrupt.
> >
> > I don't quite follow how suppressing interrupt suppression, i.e.,
> > skipping disable_cb, helps avoid this.
> > I'm probably missing something. Is this solving a subtly different
> > problem from the one as I understand it?
>
> I was thinking of this one:
>
>  1. device is sending packets
>  2. driver cleans them at the same time using virtnet_poll_cleantx
>  3. device fires transmit interrupts
>  4. driver handles transmit interrupts using vring_interrupt,
>      detects that the vring is empty: !more_used(vq),
>      and records spurious interrupts.

I think that's the same scenario

>
>
> but even yours is also fixed I think.
>
> The common point is that a single spurious interrupt is not a problem.
> The problem only exists if there are tons of spurious interrupts with no
> real ones. For this to trigger, we keep polling the ring and while we do
> device keeps firing interrupts. So just disable interrupts while we
> poll.

But the main change in this patch is to turn some virtqueue_disable_cb
calls into no-ops. I don't understand how that helps reduce spurious
interrupts, as if anything, it keeps interrupts enabled for longer.

Another patch in the series disable callbacks* before starting to
clean the descriptors from the rx interrupt. That I do understand will
suppress additional tx interrupts that might see no work to be done. I
just don't entire follow this patch on its own.

*(I use interrupt and callback as a synonym in this context, correct
me if I'm glancing over something essential)
