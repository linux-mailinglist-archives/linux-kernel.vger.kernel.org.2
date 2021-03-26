Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1882A34ACAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCZQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhCZQil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:38:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DE1B61A2D;
        Fri, 26 Mar 2021 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616776720;
        bh=QEA0T21Fu4VzIaJtHMWn2IoyfAGGCrYbK9GWeEI8BYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wg5KoBZs/6f2D0h2Dh/5ZHL5+SEix0B49zJBcunx/+8Tkcj7ftRuOsnzONNwrVHuD
         t1OcDSiLgQxylemBtNA+h3rw3myeYmECCmks6buFyMtRjCGDQTwwGx/Xo08LSLt0li
         01AGwaWYu7t21Vc6RQvIqlHC/U3Zb72DqROlhSQS3Lp9dHXJGVfN5AO3QB9hhL1p4c
         yXyFPHE2TeFvyn+6nqczhaCghEypVMw+k2p6M8TTDAkes3ASZTaF8LHdnavJIwvaBx
         Py1seawcU5wMi/8npS14DFzm00sjpN1m67g27pIymtu0Se4S4AQoDkn5HNDeJ3aG0R
         gO03dMfXoQ3vA==
Received: by mail-ot1-f50.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so5751527otb.7;
        Fri, 26 Mar 2021 09:38:40 -0700 (PDT)
X-Gm-Message-State: AOAM530c4DDBYbyiOE7xkCQumM8SJIuL53rcuz8l5DGuNBzVgxvVFFWi
        2VNOCdKu9e65Ek7uSwilq8QRJQyu00qX7vCsasI=
X-Google-Smtp-Source: ABdhPJzB0TrCzzwZmjbPbQIHOQOCMqU527iREXAspw4fnjjWwkJXz9Bi65g7VAAKjEts74t5pCxDXA+PaoPyZwzwQds=
X-Received: by 2002:a9d:316:: with SMTP id 22mr12446233otv.210.1616776719555;
 Fri, 26 Mar 2021 09:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210320151903.60759-1-sven@svenpeter.dev> <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org> <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
 <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl> <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
In-Reply-To: <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Mar 2021 17:38:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
Message-ID: <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        Rob Herring <robh@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 5:10 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Fri, Mar 26, 2021, at 16:59, Mark Kettenis wrote:
> > Some of the DARTs provide a bypass facility.  That code make using the
> > standard "dma-ranges" property tricky.  That property would need to
> > contain the bypass address range.  But that would mean that if the
> > DART driver needs to look at that property to figure out the address
> > range that supports translation it will need to be able to distinguish
> > between the translatable address range and the bypass address range.
>
> Do we understand if and why we even need to bypass certain streams?

My guess is that this is a performance optimization.

There are generally three reasons to want an iommu in the first place:
 - Pass a device down to a guest or user process without giving
   access to all of memory
 - Avoid problems with limitations in the device, typically when it
only supports
   32-bit bus addressing, but the installed memory is larger than 4GB
 - Protect kernel memory from broken drivers

If you care about none of the above, but you do care about data transfer
speed, you are better off just leaving the IOMMU in bypass mode.
I don't think we have to support it if the IOMMU works reliably, but it's
something that users might want.

        Arnd
