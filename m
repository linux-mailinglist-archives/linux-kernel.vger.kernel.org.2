Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D4D3479B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhCXNei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235239AbhCXNdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:33:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DD9C61A0B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616592827;
        bh=o9N4i7+3noUv0B6lJUnCsQ1a7vxB7qpfn9sOMth9bJM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QjzaBxVXzft4VWeTPw8A5sVm1pW/PtZkCRT8tUJv5DiUqJTMiIZH24/SYzSgH+49I
         RYAMumLPIjY2zQ+ESslZf5u4gCmhk50vC4lo5vjoExtxSBzYt+ta2WDiqNjxlQ3BxU
         zsi/Ue6pet0QxobkUplg9lKCmOPEa7MH4MpV2DHIi/iGErPQhP2mVhjGpVvGP4B51l
         9jiC88NSVAfsOFAw0UaFTU8JCAJhowbU5k+U8P/B4mXUV7d3vQ1u8NerwFk6IpZNoa
         sVLamh7L/6a5kgo7M0OaGFn2/lE5nnE3GCfPZ+8e7lQXaZsipwyLi/xKA7w3fRIhlA
         zHvtDWKLyjdKQ==
Received: by mail-oi1-f170.google.com with SMTP id z15so20786999oic.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:33:47 -0700 (PDT)
X-Gm-Message-State: AOAM533wwgyHl066VpmUiYubvA8CqATdyZBOvlnmqNOuMnlioyP9L3Bd
        eqht2xUsuBe44WEv3DnS2vMTOYgrO7cJAJ/rNYA=
X-Google-Smtp-Source: ABdhPJwLGMq5E9ddat76/h5D6iTzp4r4i2DAaKNqQgKerm3fo6JXWGsSPV4CM9kNFzrRvvQsedNSTb89dqaNsM7Iy0c=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr2358206oie.67.1616592826738;
 Wed, 24 Mar 2021 06:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210323130430.2250052-1-arnd@kernel.org> <f8cd5d0b-0c50-a2e9-a5a1-a2358419dd44@rasmusvillemoes.dk>
In-Reply-To: <f8cd5d0b-0c50-a2e9-a5a1-a2358419dd44@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Mar 2021 14:33:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a17=PdOqKrvemuP1OCzoxRZ0HLBje-tV4Ssc=kZeVbQRw@mail.gmail.com>
Message-ID: <CAK8P3a17=PdOqKrvemuP1OCzoxRZ0HLBje-tV4Ssc=kZeVbQRw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: fix gcc -Wrestrict warning
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 4:57 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 23/03/2021 14.04, Arnd Bergmann wrote:
> >                       if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
> > +                             int pos = 0;
> >                               memset(i2c_output,  0, sizeof(i2c_output));
> >                               for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
> > -                                     sprintf(i2c_output, "%s 0x%X", i2c_output,
> > +                                     pos += sprintf(i2c_output + pos, " 0x%X",
> >                                               securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
> >                               dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
>
> Eh, why not get rid of the 256 byte stack allocation and just replace
> all of this by
>
>   dev_info(adev->dev, ""SECUREDISPLAY: I2C buffer out put is: %*ph\n",
> TA_SECUREDISPLAY_I2C_BUFFER_SIZE,
> securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf);
>
> That's much less code (both in #LOC and .text), and avoids adding yet
> another place that will be audited over and over for "hm, yeah, that
> sprintf() is actually not gonna overflow".
>
> Yeah, it'll lose the 0x prefixes for each byte and use lowercase hex chars.

Ah, I didn't know the kernel's sprintf could do that, that's really nice.

I'll send a follow-up patch, as Alex has already applied the first one.

Alex, feel free to merge the two into one, or just keep as they are.

      Arnd
