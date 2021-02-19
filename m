Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B231FB09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhBSOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhBSOhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:37:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D4BC061574;
        Fri, 19 Feb 2021 06:36:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cl8so3810109pjb.0;
        Fri, 19 Feb 2021 06:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7ionRp1ZXY9IYkwj7KvTSuR30BkQ1bSGX68omoJKK0=;
        b=dsczfc2hrIrRhMQivoGf1eEDCs+l0usQ197IIlpx8FruhL3GtfZF1U99hQjXs866+c
         s5MyrfANo5j/yY/179tALVh8p2q+MuCBnEhvMj6+6Bt/r3URTDtFrSEbayK4LcYPGa5F
         mEBGEBjCBykmVTmZ13jj2xVWz78DwbIY7AaDvL+8WHBGALS/w8SVDfMYKyltAnF6hcWq
         oq5xbVkROKrfH6l+kM8BYtTLOIppaSFFhuGtzaowr0xyqtNSin+vkIx7VX+QKssx5yJt
         Zbru3FdJ/qT8LPMv5cJFkyu6Cl8kp+5nzhmK9FqqoEnAZVloaDofnnb+pxxYg+Dkxfj+
         CJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7ionRp1ZXY9IYkwj7KvTSuR30BkQ1bSGX68omoJKK0=;
        b=NzQB5Tm5GmRBnEmYY4AzHCqpq4gW38SgLm0MJlhaQIdgC9f3iwPm6kf2AMaTXvTK6d
         cN791xldXlfE+mMjDJJcqqFk/Kt954C2KxbETUgHZyR7nNBcW/4fIkklTbaglTkeLDNW
         MDCZMZuJzoXE/K44ycUGmAoQseSCFPDM2dLlcyjY98vHcm7XNvw+bMpUmw0gU0FzNsO2
         LDczkrGdGZ/MnsWbvrhDtMePNf4QnNYbwzde1iUNaRoQpiUqLEq4bqTFSkzdJHjcHERN
         oS59U/eRZaeAPsQcJiAfcN085yKt4XGWQbwS0+6x6NZeIyu6q126u+VmlRYGOxGyisRt
         sNcQ==
X-Gm-Message-State: AOAM533jKKtTPNd792pNK1wopUYelQthAtao2af9Crdr3HhScqMMbdEq
        eGincJZz4Qw5TXvu5dg346I/ol6zlIX0TfMVolC8yVCp5yyImQ==
X-Google-Smtp-Source: ABdhPJxrTA0lztIb7xlyyu35/+p99yEb7EYJ9tqucNlAPtN+to9iDaASOxnOSTGROXOkZgIa43SRRXPo5vBSUF60D1Y=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr9737822pja.228.1613745394346;
 Fri, 19 Feb 2021 06:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
 <20210216160525.5028-2-maciej.kwapulinski@linux.intel.com>
 <CAHp75Vep0Fm1k_7gJcozk4t316QmUgt5Qe3PauwDg=py5VnHfQ@mail.gmail.com> <85blcgw5v6.fsf@linux.intel.com>
In-Reply-To: <85blcgw5v6.fsf@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Feb 2021 16:36:18 +0200
Message-ID: <CAHp75VfvHGPC8bvDUDt0ge9dh-YEnH8ob5xV6iPQwODjWETqPg@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] gna: add driver module
To:     Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 3:21 PM Maciej Kwapulinski
<maciej.kwapulinski@linux.intel.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Tue, Feb 16, 2021 at 6:11 PM Maciej Kwapulinski
> > <maciej.kwapulinski@linux.intel.com> wrote:
> >>
> ....
> >> +err_clear_master:
> >> +       pci_clear_master(pcidev);
> >> +err_release_regions:
> >> +       pci_release_regions(pcidev);
> >> +end:
> >> +       dev_err(&pcidev->dev, "gna probe failed with %d\n", ret);
> >> +       return ret;
> >
> > These are all completely redundant.
> >
>
> following is refactor of gna_probe(), but without pci_release_regions(),
> smatch (v7fcfe259) produces warning:
>   drivers/misc/gna/gna_device.c:78 gna_probe() warn: 'pcidev' not
>   released on lines: 56,65.

Then the tool is mistaken.

> here's the code refactored:
>
> int gna_probe(struct pci_dev *pcidev, const struct pci_device_id *pci_id)
> {
>         struct gna_private *gna_priv;
>         int ret;
>
>         ret = pcim_enable_device(pcidev);
>         if (ret) {
>                 dev_err(&pcidev->dev, "pci device can't be enabled\n");
>                 return ret;
>         }
>
>         ret = pci_request_regions(pcidev, GNA_DRV_NAME);
>         if (ret)
>                 return ret;
>
>         ret = pci_set_dma_mask(pcidev, DMA_BIT_MASK(64));
>         if (ret) {
>                 dev_err(&pcidev->dev, "pci_set_dma_mask returned error %d\n", ret);
>                 return ret;
>         }
>
>         pci_set_master(pcidev);
>
>         /* init gna device */
>         gna_priv = devm_kzalloc(&pcidev->dev, sizeof(*gna_priv), GFP_KERNEL);
>         if (!gna_priv) {
>                 //pci_release_regions(pcidev);
>                 return -ENOMEM;                 // line 56
>         }
>         /* Map BAR0 */
>         gna_priv->bar0.iostart = pci_resource_start(pcidev, 0);
>         gna_priv->bar0.iosize = pci_resource_len(pcidev, 0);
>         gna_priv->bar0.mem_addr = pcim_iomap(pcidev, 0, 0);
>         if (!gna_priv->bar0.mem_addr) {
>                 //pci_release_regions(pcidev);
>                 dev_err(&pcidev->dev, "could not map BAR 0\n");
>                 return -EINVAL;               // line 65
>         }
>
>         dev_dbg(&pcidev->dev, "bar0 io start: 0x%llx\n", (unsigned long long)gna_priv->bar0.iostart);
>         dev_dbg(&pcidev->dev, "bar0 io size: %llu\n", (unsigned long long)gna_priv->bar0.iosize);
>         dev_dbg(&pcidev->dev, "bar0 memory address: %p\n", gna_priv->bar0.mem_addr);
>
>         ret = gna_dev_init(gna_priv, pcidev, pci_id);
>         if (ret) {
>                 dev_err(&pcidev->dev, "could not initialize gna private structure\n");
>                 return ret;
>         }
>
>         return 0;
> }
>
> I've also added 'noinline' directive to pci_release_regions(), to see if
> it is called by the core code on "rmmod gna", but can't see the call.
>
> Is the smatch tool that causes problems here?
> Do You suggest other way to handle the problem?

File a bug against that tool.

Before you are doing v2, I would suggest you to go thru all comments
and address them. Above "refactored" code doesn't even have a half of
the comments I gave being addressed. If you have concerns, please,
reply to the review email with a specific excerpt as a context.

-- 
With Best Regards,
Andy Shevchenko
