Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4474045B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbhIIGhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:37:53 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50520
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230433AbhIIGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:37:51 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A99B53F320
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 06:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631169395;
        bh=akLaMR2Qq8amUpvssgxVNr2WG7Nl5vSl23ypQFllRfM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QlU56PXYiwED1TkFBvvem8n0nH/6c1M5r9bsHCB1gPMvaS6ZLfJxH7rQzCg5nom0p
         cCh8FAOHwKZgE0Di4XZeucjGOhfqvOos8dR3UnG2EgVXfmMh6ygyIc0d4Kxl/570K/
         3ij0ZXYzETsQ8AKcbKPxOXwmSwoB8BbsAjQ8iwJH/UokzEY1tOn+oGUQolCAsNYUC5
         HkibcGicglR7pHUN13dzbwgb9fIWEEj1yiWUY1pPfRjztGAlGXmljPHFyvaz1j+rVQ
         eWQ7M1y0YfrqqieNAP7YU+lWH/mZN/XvYuqgtqq0V1dlzz5p6byM8MWlQH/N2+2evw
         vdGF6PIO3T5nA==
Received: by mail-ot1-f69.google.com with SMTP id b25-20020a9d60d9000000b00519be3bdc04so552599otk.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 23:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akLaMR2Qq8amUpvssgxVNr2WG7Nl5vSl23ypQFllRfM=;
        b=w3/q0BnVEapznBzUtxLVoplas5gAgUpoBCqff310BFSNx3Odc0aPhdb9iy6EvH2wuA
         WGcEhtNFUEFXPA9F+LfXJZHTI0NWUPjOd5L9i/UVidzTwJFUjLYKvyaJe5sABn09uULk
         1Rm5aph7IdnBDfDfFJHrAF8s07k2WSduI01Dy1ogUrQ4Q7EdFRP9EA1sRm2HWsiRt07F
         s3Mzaa0pGWPXyJWtds6a9deuCcr+mkbn+vl9l5OdTUQUfwBy5L3Bvef69ATEnjAVm8Aq
         u/gcHu+xUWueBtQ3DJKFqtDLohEXUSfAeIzEKNRqrg5OetN8yS8u4OOxbHCphLvRSLN9
         78vA==
X-Gm-Message-State: AOAM53007Xu7UdkFWomV/iQdMgbxfMKLX0EmD5fmqXn/G2cmSO1n7F2Z
        gydggZzaAqO2eIaQNHcJq9WUsTL2yGi5WrlhkmPlROgXLNRcnRbi622fN/Arw1LovnEL31wf3nE
        brSUCLSF8ZDTaMHR/nNBXrBVYeLy4+N4yy2WhCjaI8vP4zrs3HzRDXuFCWw==
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr1140775otq.11.1631169187448;
        Wed, 08 Sep 2021 23:33:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydNUWa4iWIrH1MSc4yRb3P5wiZt7TtCAWb93Z2ahXjOMnItwMOcoXnTS7/j/i2x/EH0tmNaHVVy938jYvOcUc=
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr1140764otq.11.1631169187145;
 Wed, 08 Sep 2021 23:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org> <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
 <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com> <YO4odF0EwqxfNLFq@fedora> <YO67m/jaBvco+I36@8bytes.org>
In-Reply-To: <YO67m/jaBvco+I36@8bytes.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 9 Sep 2021 14:32:55 +0800
Message-ID: <CAAd53p4138BB_5-++0P9k91B1dCuKzuv1yGjiG77ewhd1MRSbQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu v2
 and uses identity mapping
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 6:25 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Jul 13, 2021 at 07:57:40PM -0400, Konrad Rzeszutek Wilk wrote:
> > The SWIOTLB does have support to do late initialization (xen-pcifront
> > does that for example - so if you add devices that can't do 64-bit it
> > will allocate something like 4MB).
>
> That sounds like a way to evaluate. I suggest to allocate the SWIOTLB
> memory at boot and when the IOMMUs are initialized we re-evaluate what
> we ended up with and free the SWIOTLB memory if its not needed.
>
> If that turns out to be wrong during runtime (e.g. because a device is
> switched to a passthrough default domain at runtime), we allocate a
> small aperture for this device like the above mentioned 4MB.

I am currently working on this but I found that 4MB is not enough,
16MB is the minimal size to make the device work.
How do I know the right SWIOTLB size for each device?

>
> (A boot option to always keep the aperture around might also be helpful
>  for some setups)

OK, will also implement this in next iteration.

Kai-Heng

>
> Regards,
>
>         Joerg
