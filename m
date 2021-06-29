Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517443B6EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhF2Hkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:40:41 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36183 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232233AbhF2Hkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:40:39 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 305505802F1;
        Tue, 29 Jun 2021 03:38:12 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Tue, 29 Jun 2021 03:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=xPpV66HQWYVIE36VUh3s2k+KXaQN
        uzOi6HGwB2vvLlI=; b=AazxlZZVrmqm57X0pNXcZihlgEw8Rja3NTqf4rJAhrId
        sZzWqzxnLqo9mXUeGtBkomuHVceuBcpOlkThWQ8sOCGcUEAuGD7E84/1QgptxDxp
        VohUFHg1FgeZAkZM2TuUVE2+3LnW1tT6vvKOOsE5ulSvvJJYmwHOfxGqIKe4F8/V
        tewSxjjE5XOKAqhA6el1jejPmzn4RT05Sh1L3odwkPPLSZTZNhe5q3yGyLkLzgT5
        j+mhG6OzVYFkdnZS7X0UaF1NnkY/Iu+b2mupZW6OfpC70kQXkA+3gSuv7eEnsqu8
        75vU/K8OhArsVgjGt0825AP9cpRgKIGF0h2MQw+33w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xPpV66
        HQWYVIE36VUh3s2k+KXaQNuzOi6HGwB2vvLlI=; b=TVuybdMj+mIXjt/SMDwlbh
        sXV0LMaYWH58nxAH7/2fyt/n3U4cV6gQiBPI4xJYnAfdtof8Nadjo7h1zqcoMTRc
        wms/fAYBxqNKdFdeLMQuUdZA9wdSyBQpQ7izbbYNtShwZKI62QDMOgxnxqy/23BI
        lOJ1xx+YDU2E46iftghvIJLGtijpPE4z2vFrUfrANhOreffUS6hxqfY84+uGqCkD
        beAxPx8FwIZcpClmn+SrFwQESJ9v5O2t3dE5dvw/ZnHgTlyBp5+sZmd7Chm/mg0B
        OSwlldu12dqSG9D4HEWm0ibGdmUcvxU/fN/fVSx5ttYRTBeFIdHZFoWbWZWlpIyw
        ==
X-ME-Sender: <xms:4s3aYCw9WS5tkBhIVaEiwWmfJPFFLn1LHq14l3laXRWdD1wXOecRLA>
    <xme:4s3aYOSver13dt2IzApPeQtnAmFfKdnSi9E3IqwmT1HVPizgWmgX4UEHkjRjIijUg
    qZeuIwj8Q9T6AXB7tM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehhedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:4s3aYEUU1LxQqndKn8vTxCWrNEdOpMqbGFQbrzw1B8yG1edecv94EQ>
    <xmx:4s3aYIgLArskBRvcBRNz_paU13207fSaGy1M4-9hkrZA5MUjpRPqNg>
    <xmx:4s3aYEDd3kPwpjbysHG8_AAKYdSwen0ND6HnGlmS-C_FYcfb00uq1A>
    <xmx:5M3aYMaNWz_GSwOBNaTU7SxjDGMOZpvJXMTXg9BzOj_uaV5jLK3e4g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F1AB51C0060; Tue, 29 Jun 2021 03:38:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-530-gd0c265785f-fm-20210616.002-gd0c26578
Mime-Version: 1.0
Message-Id: <fedb8d5a-a0f1-4216-bb46-1af31b716309@www.fastmail.com>
In-Reply-To: <3a43b2de-6a71-2373-8695-5e96657c8fc2@amazon.com>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-2-sven@svenpeter.dev>
 <3a43b2de-6a71-2373-8695-5e96657c8fc2@amazon.com>
Date:   Tue, 29 Jun 2021 09:37:48 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alexander Graf" <graf@amazon.com>,
        "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, devicetree@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Petr Mladek via iommu" <iommu@lists.linux-foundation.org>,
        "Alyssa Rosenzweig" <alyssa.rosenzweig@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Rouven Czerwinski" <r.czerwinski@pengutronix.de>
Subject: Re: [PATCH v4 1/3] iommu: io-pgtable: add DART pagetable format
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jun 28, 2021, at 12:54, Alexander Graf wrote:
> 
> 
> On 27.06.21 16:34, Sven Peter wrote:
> > 
> > Apple's DART iommu uses a pagetable format that shares some
> > similarities with the ones already implemented by io-pgtable.c.
> > Add a new format variant to support the required differences
> > so that we don't have to duplicate the pagetable handling code.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 62 ++++++++++++++++++++++++++++++++++
> >   drivers/iommu/io-pgtable.c     |  1 +
> >   include/linux/io-pgtable.h     |  7 ++++
> >   3 files changed, 70 insertions(+)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 87def58e79b5..1dd5c45b4b5b 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -127,6 +127,9 @@
> >   #define ARM_MALI_LPAE_MEMATTR_IMP_DEF  0x88ULL
> >   #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
> > 
> > +#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
> > +#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
> > +
> >   /* IOPTE accessors */
> >   #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
> > 
> > @@ -381,6 +384,15 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> >   {
> >          arm_lpae_iopte pte;
> > 
> > +       if (data->iop.fmt == ARM_APPLE_DART) {
> > +               pte = 0;
> > +               if (!(prot & IOMMU_WRITE))
> > +                       pte |= APPLE_DART_PTE_PROT_NO_WRITE;
> > +               if (!(prot & IOMMU_READ))
> > +                       pte |= APPLE_DART_PTE_PROT_NO_READ;
> > +               return pte;
> 
> What about the other bits, such as sharability, XN, etc? Do they not 
> exist on DART? Or have they not been reverse engineered and 0s happen to 
> "just work"?

I'm fairly certain they don't exist (or are at least not used by XNU).

The co-processors that can run code also either use an entire separate iommu
(e.g. the GPU) or only use DART as a "second stage" and have their own
MMU which e.g. handles XN (e.g. the SEP or AOP).

> 
> > +       }
> > +
> >          if (data->iop.fmt == ARM_64_LPAE_S1 ||
> >              data->iop.fmt == ARM_32_LPAE_S1) {
> >                  pte = ARM_LPAE_PTE_nG;
> > @@ -1043,6 +1055,51 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> >          return NULL;
> >   }
> > 
> > +static struct io_pgtable *
> > +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > +{
> > +       struct arm_lpae_io_pgtable *data;
> > +       int i;
> > +
> > +       if (cfg->oas > 36)
> > +               return NULL;
> > +
> > +       data = arm_lpae_alloc_pgtable(cfg);
> > +       if (!data)
> > +               return NULL;
> > +
> > +       /*
> > +        * Apple's DART always requires three levels with the first level being
> > +        * stored in four MMIO registers. We always concatenate the first and
> > +        * second level so that we only have to setup the MMIO registers once.
> > +        * This results in an effective two level pagetable.
> > +        */
> > +       if (data->start_level < 1)
> > +               return NULL;
> > +       if (data->start_level == 1 && data->pgd_bits > 2)
> > +               return NULL;
> > +       if (data->start_level > 1)
> > +               data->pgd_bits = 0;
> > +       data->start_level = 2;
> > +       cfg->apple_dart_cfg.n_ttbrs = 1 << data->pgd_bits;
> 
> Maybe add a BUG_ON if n_ttbrs > ARRAY_SIZE(ttbr)? Or alternatively, do a 
> normal runtime check and bail out then.

n_ttbrs can't actually be larger than 4 at this point already due to the
previous checks.
I can add a BUG_ON though just to make it explicit and be safe in case those
checks or the array size ever change.


Sven


