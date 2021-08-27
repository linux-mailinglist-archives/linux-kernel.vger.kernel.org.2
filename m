Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA43F9D30
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhH0REk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhH0REi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:04:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8759FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:03:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id i28so12583407ljm.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMCxP1q+YWk0B2oK/6zzu3g1wQAnYnc83Q7t9pMG8V4=;
        b=dcdbQ/RtiU7GznMTjJwU3jzPaaCUUG5bRRWP6Gzw2JWdDMqBJwKw2YyQ1XbxOdoYPA
         +mi2ySeon5SwiDtYL6d70TlnoKwIjs1J/Ysnh3rG/ZoNCUWU/5i8Ap6Vj2KmFgtIx/XY
         UaV9VNipYhf0f7oAT8gAeV4ukpGrJmlv6M+3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMCxP1q+YWk0B2oK/6zzu3g1wQAnYnc83Q7t9pMG8V4=;
        b=Z/0GpFF6yAnQ8Ta2Vf52yBaUJ1IxtwsqYVNwnv2foMKLwKpF/FhBX7HqV31u5ANvu2
         AEoT686ZU/O/+zx6UkwGx6/jdZ95/nEVLhiYs88hkfcfUCaOVflZm5/G5BE71C5p0psg
         3S8Q+Zc1itGDunzHc07nLR8RHR84lBoSEx2Icz83W/euvrIM0sXQLvEMOzE1H8zChqjG
         KC0LRXbEMTJGPNg0OYylx8rJfaGUxYBgEYLnSWYmTyjHJEubzGb4Yb4qKhxj7YoGrRoE
         t13liUleAJd+3K42yWv5rEa+/1R2OeXNn29fA5v5erw4Cu3vyUv137qfy5LN5iBt2TFi
         2I+w==
X-Gm-Message-State: AOAM533YjVS7b34b4SsDDAVAN9CiJI8oPwh+Sw7vozBswj96EjHdt7pd
        ex9ff4z1kxS3whrUOTcMv2TQuCP7pQL+nTH9
X-Google-Smtp-Source: ABdhPJzP0/4b5/UBR8XCFOYvB7CqmhO99dQGCa0u2/dSC2uThIsN6LPaDqWcQhSS0x+EwwKhy/pN0g==
X-Received: by 2002:a2e:bc1d:: with SMTP id b29mr9023386ljf.2.1630083827590;
        Fri, 27 Aug 2021 10:03:47 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id bq7sm640449lfb.136.2021.08.27.10.03.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 10:03:47 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j4so15705783lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 10:03:46 -0700 (PDT)
X-Received: by 2002:a05:6512:2091:: with SMTP id t17mr7463548lfr.253.1630083825642;
 Fri, 27 Aug 2021 10:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210826131747.GE26318@willie-the-truck> <CAHk-=wi8Wxazuq+E4_V0GG4eda0rNpZi76AYWQe7xfPZAAexAQ@mail.gmail.com>
 <20210827074041.GA24309@lst.de>
In-Reply-To: <20210827074041.GA24309@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 10:03:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjd28sN9khO=1j6zmBk+2n4_e+SY1URjW9hzsHSAZU+7Q@mail.gmail.com>
Message-ID: <CAHk-=wjd28sN9khO=1j6zmBk+2n4_e+SY1URjW9hzsHSAZU+7Q@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fix for 5.14
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > In a PC world that would be (for example) the legacy PCI space at
> > 0xa0000-0xfffff, but I could easily imagine other platforms having
> > other situations.
>
> So what would be the correct check for "this is not actually page backed
> normal RAM"?

It would probably be interesting to have the arm people explain the
call chain for the warning that caused that revert, so we'd have a
very concrete example of the situation that goes wrong, but taking a
wild stab at it, the code might be something like

            /* Don't allow RAM to be mapped */
            if (WARN_ON_ONCE(phys_addr_is_ram(phys_addr)))
                    return DMA_MAPPING_ERROR;

and then having something like

  static inline bool phys_addr_is_ram(phys_addr_t phys_addr)
  {
        unsigned long pfn = PHYS_PFN(phys_addr);

        if (!pfn_valid(pfn))
                return false;
        return is_zero_pfn(pfn) || !PageReserved(pfn_to_page(pfn));
  }

might be close to right.

The ARM code actually uses that complex pfn_to_section_nr() and
memblock_is_memory() etc. That seems a bit of an overkill, since the
memblock code should have translated all that into being reserved.

But again, I don't actually know exactly what triggered the issue on
ARM, so the above is just my "this seems to be a more proper check"
suggestion.

Will?

                   Linus
