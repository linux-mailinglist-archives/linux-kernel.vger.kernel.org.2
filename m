Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F132A3EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577782AbhCBJw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:52:58 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:57169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbhCBJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:36:20 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZSJa-1lJswr442A-00WXqO; Tue, 02 Mar 2021 10:32:24 +0100
Received: by mail-oi1-f175.google.com with SMTP id 21so11704221oiq.7;
        Tue, 02 Mar 2021 01:32:23 -0800 (PST)
X-Gm-Message-State: AOAM531hF36/sThj2owRkXrHWycqP6E58oQ72Gtd09/crl6sgULoNidy
        xbqaI+a6gfGt6u3woA6Wy30SzN8uOAzTUeF4/IM=
X-Google-Smtp-Source: ABdhPJx5XWp8Ki1644NUPJ6YSXBsqLQpbCENNWA/2WM/vGVPVyb7m95NYVRO672W5xEbCNFsN9VAYmGWDNBc6nbj8WI=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr2418133oib.11.1614677542554;
 Tue, 02 Mar 2021 01:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20210226140305.26356-1-nsaenzjulienne@suse.de> <20210226140305.26356-10-nsaenzjulienne@suse.de>
In-Reply-To: <20210226140305.26356-10-nsaenzjulienne@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Mar 2021 10:32:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1t3yCD4vXF803nL=n3Y3hD1MOPOAEZwZA+782N64PXTA@mail.gmail.com>
Message-ID: <CAK8P3a1t3yCD4vXF803nL=n3Y3hD1MOPOAEZwZA+782N64PXTA@mail.gmail.com>
Subject: Re: [RFC 09/13] iommu/arm-smmu: Make use of dev_64bit_mmio_supported()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:legnmUJMED7xyeS16jB9arlUrQNnIgwgh0Z/SL2rsGfiqTRbTOf
 NtLEy8RNEn3XAqm45/VVsbBmfEhlqKHUNMatEBQRFkw+fk/l4iQTqfr/y/pY660ApdUonl1
 u5t9+H1J39ZVaEgGEudbaI6UPC19yGDsriGVsyDm7Jv2e8Raqqn+gjb4N3Y41W2xyPOVgZR
 jUN3F9jgyIQY2/SHGhpBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0C2k/V7y7uE=:fNubMXZuJeLDiEayPIlmPO
 T9mI1e+Jz0jaPmEc7aGXw1MNZbKVyXPCcVgIgdlodX4XiHJQsstiDKmhfoeJhgEGpqtiMEB0H
 TEcW9tKynn5Bo3J6DUx+DqtEZyAA3o3KqkRxnC90+eCsZlgMuW9Q6/576B2gmtfPliJZ1LKhF
 N5odR4H0+kEqMatbPIuOVMHO2pkigboCgPcjOe9b0J1J1R09+EYW/cQuFYGUrVkYxk4GUi7eR
 xP4NycU9z8xkNpqw7mW5/9wEC/sbq89xg5KiG9sgsJlSg0qv+xiiGUypQ1bAah2JYf/m3/Obs
 UTuDlVEWk2tq+Mltn1BIE8vgvBsGoYK2R2Wbs1kL08KSaw1nflMqLF/Vg4pSNeY1gPXBFNrCB
 7TYXVVMVYBNehSzpl7KJatUDVYtlxvZ7eRGZiV8v0Y0U77tLjNUWhayAY4n8WUZG5LrBXAY0v
 DSr8r/vYhuWlpajUAqeL+86aMoqIr2Fx8i69ovGUcRR8bzs2UZTkf884XjzHPu1pQAZtoQRWD
 bby7RVVLkA3/KzImJCypKlV5wsNhXNG7TxZSHRyMdMqPxHVeBLLaoNdMJgvXg6UkojOGZGows
 ncSjhSEEcarsD+Vi6q82Y11V9578RYmeeQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 3:03 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:

>         if (smmu->impl && unlikely(smmu->impl->write_reg))
>                 smmu->impl->write_reg(smmu, page, offset, val);
> -       else
> +       else if (dev_64bit_mmio_supported(smmu->dev))
>                 writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
> +       else
> +               hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>  }

This is a writel_relaxed(), not a writeq_relaxed(), so I suppose you don't
have to change it at all.

> +       else if (dev_64bit_mmio_supported(smmu->dev))
> +               return readq_relaxed(arm_smmu_page(smmu, page) + offset);
> +       else
> +               return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + offset);
> }


I see this pattern repeat across multiple drivers. I think Christoph
had originally
suggested folding the if/else logic into the writel_relaxed() that is defined in
include/linux/io-64-nonatomic-hi-lo.h, but of course that doesn't work if you
need to pass a device pointer.

It might still make sense to have another wrapper in that same file though,
something like

static inline hi_lo_writeq_relaxed_if_possible(struct device *dev, __u64 val,
                    volatile void __iomem *addr)
{
       if (dev_64bit_mmio_supported(smmu->dev)) {
              readq_relaxed(arm_smmu_page(smmu, page) + offset);
       } else {
               writel_relaxed(val >> 32, addr + 4);
               writel_relaxed(val, addr);
       }
}

         Arnd
