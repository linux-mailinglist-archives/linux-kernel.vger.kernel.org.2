Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272B23C63F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhGLTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236481AbhGLTrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:47:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E80E61283;
        Mon, 12 Jul 2021 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626119104;
        bh=UilHVVz1yvU4lfibrXwUvgOhYORWOaWZDrPjLxRVRjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cuk/aVnbH+Cae5IUjOSNFzYjqyJNK4AytBZdTBlGhGpitZUudV5h+374WXIXf/uLt
         nTHvv+3JsKCMOrifpVYmCkVXOdcfWacLEKUxlTVMDs82RGHakWQ3iKWVh9sbMmvRZC
         CZwpnB43aQwuRcze/hl2u8drjHCHJVb7Dqm6eqAeoWBWuLZE/AXO7Hb3YIHJUbfeXK
         iqkW7NljaquicCojKHbwzSidPxyjs7O2mnD+8F742f6RKdicaL+npFDF9beg1AXj5X
         KwGaVIA8nR0clVw4UkGQ8hUda7TsEDGoLgiU071TSpqSFoquTq69uGBhZqOICsfTqA
         I8pvUj7SHeMQg==
Received: by mail-ed1-f42.google.com with SMTP id ee25so11548452edb.5;
        Mon, 12 Jul 2021 12:45:04 -0700 (PDT)
X-Gm-Message-State: AOAM531G+0SNGPg3UkAz9et7HxeHgCZLiOf2mCrqNJ1qBbYjaQkCzM1+
        FK4zzgQgx1XQO16JKdurwFV5alu4zUqLzD/pwA==
X-Google-Smtp-Source: ABdhPJw0WtwphGiFb69sagX3etDA/qgcvBX5D0zk15Icd1Y7k+IeY8IzoINH9466Qh+QwERjHfrFMEZCxft0fZRSlQI=
X-Received: by 2002:aa7:c89a:: with SMTP id p26mr574998eds.373.1626119102683;
 Mon, 12 Jul 2021 12:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210628093411.88805-1-gshan@redhat.com> <20210701172527.GA2567910@robh.at.kernel.org>
 <1c43cd39-7bf6-b99c-36ec-798b81b1aba1@redhat.com>
In-Reply-To: <1c43cd39-7bf6-b99c-36ec-798b81b1aba1@redhat.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 12 Jul 2021 13:44:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLF1pW-43BoH7bPkT+a3dk716LwCV6WO1Ygag_BZ-QO2Q@mail.gmail.com>
Message-ID: <CAL_JsqLF1pW-43BoH7bPkT+a3dk716LwCV6WO1Ygag_BZ-QO2Q@mail.gmail.com>
Subject: Re: [PATCH v5] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, drjones@redhat.com,
        shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 6:02 PM Gavin Shan <gshan@redhat.com> wrote:
>
> Hi Rob,
>
> On 7/2/21 3:25 AM, Rob Herring wrote:
> > On Mon, Jun 28, 2021 at 05:34:11PM +0800, Gavin Shan wrote:
> >> The empty memory nodes, where no memory resides in, are allowed.
> >> For these empty memory nodes, the 'len' of 'reg' property is zero.
> >> The NUMA node IDs are still valid and parsed, but memory may be
> >> added to them through hotplug afterwards. I finds difficulty to
> >> get where it's properly documented.
> >
> > This is already in use? If so, what platform(s)?
> >
>
> It's not used yet, but will be used by QEMU once this patch is merged.
> In QEMU, ARM64 could have multiple empty memory nodes. The corresponding
> NUMA ID and distance map are still valid because memory may be added into
> these empty memory nodes in future.
>
> For the QEMU case, the names of empty memory nodes are the biggest concern.
> According to device-tree specification, the name follows the format of
> 'memory@unit-address' and the 'unit-address' is equivalent to 'base-address'.
> However, the 'base-address' should be invalid one. In current QEMU implementation,
> the valid 'base-address' and 'unit-address' are provided to these empty
> memory nodes. Another issue in QEMU is trying to populate two empty memory
> nodes, which have same names. This leads to failure of device-tree population
> because of the duplicated memory node names, blocking VM from booting.

We accept patches to the DT spec, so why are you working around it?
However, a fake base doesn't seem like a good solution to me, so
premature for any DT spec change.

In any case, I think this needs a lot more context in terms of what
you are trying to accomplish and a wider audience. Some more Arm
folks, UEFI folks, etc. Maybe the boot-architecture list. Maybe that
all happened already, but I doubt it.

> >> So lets add a section for empty memory nodes in NUMA binding
> >> document. Also, the 'unit-address', equivalent to 'base-address'
> >> in the 'reg' property of these empty memory nodes is suggested to
> >> be the summation of highest memory address plus the NUMA node ID.
> >
> > What purpose does this serve? The kernel won't do anything with it other
> > than validate the numa-node-id range.
> >
>
> As mentioned above, the point is to have dummy, invalid and non-overlapped
> 'base-address' and 'unit-address' for these empty memory nodes, to avoid
> duplicated memory node names in devcie-tree.
>
> >>
> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >> v5: Separate section for empty memory node
> >> ---
> >>   Documentation/devicetree/bindings/numa.txt | 61 +++++++++++++++++++++-
> >>   1 file changed, 60 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> >> index 21b35053ca5a..230c734af948 100644
> >> --- a/Documentation/devicetree/bindings/numa.txt
> >> +++ b/Documentation/devicetree/bindings/numa.txt
> >> @@ -103,7 +103,66 @@ Example:
> >>              };
> >>
> >>   ==============================================================================
> >> -4 - Example dts
> >> +4 - Empty memory nodes
> >> +==============================================================================
> >> +
> >> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
> >> +field of the 'reg' property is zero, but the 'base-address' is a dummy
> >> +address and invalid. The 'base-address' could be the summation of highest
> >> +memory address plus the NUMA node ID. However, the NUMA node IDs and
> >> +distance maps are still valid and memory may be added into them through
> >> +hotplug afterwards.
> >> +
> >> +Example:
> >> +
> >> +    memory@0 {
> >> +            device_type = "memory";
> >> +            reg = <0x0 0x0 0x0 0x80000000>;
> >> +            numa-node-id = <0>;
> >> +    };
> >> +
> >> +    memory@0x80000000 {
> >
> > unit-address should not have '0x'.
> >
>
> Ok. Lets fix it in v6 after it's agreed to add the section into the
> NUMA binding document. Actually, the '0x' is copied from the existing
> example in same document. After this patch is finalized, I will post
> separate patch to fix all wrong formats in same document as well.

Fixes first, features second.

Or just don't copy bad examples.

Rob
