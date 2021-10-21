Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2844B435B33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJUG7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:59:21 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52686
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231158AbhJUG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:59:16 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9991A402CE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634799420;
        bh=Rd3TVdQEYYGJqY8LDfz2Z1r48P6bx1rBEWI+EufroyU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=umkzWiRY13oM/kghiElvyGLgnZKnuN83uL8ZIo3quyXGAO4OAbw+STWoFu2cMNWUp
         LkrXj/nIoPTk5SCPZ3m3uHPmDvf9kaLwc8egkxQ+U6S6o7y7vLJqSMVjPxk624udio
         fN8lfkG/S3gakU2qh0CJ/d2XCwEcZrH00Ih0eyfL6s6pQOi1Op3WBFjd395alv4C9k
         qUVH0i/JtBztIIh91A51SdU5CVXnFxgnwGpfRWyg9mkhylWdx+VBOXtUhgJmDDNtFj
         qj5BMgckef/Ui0eHflfr5thmFH+Io3ASNR7bWTQSmgXibLWYWk+M+cUJihGZQsnmcx
         bqQWKIMU9SVaQ==
Received: by mail-ot1-f72.google.com with SMTP id w16-20020a9d5a90000000b0055036b7abd9so5036742oth.22
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rd3TVdQEYYGJqY8LDfz2Z1r48P6bx1rBEWI+EufroyU=;
        b=UxThipl8PQ8O5NIpV45RaXO6Fk2C+QmJuIpDBUc42nn5vy+mfeAmuFu8eLYRM4oiMa
         rGqR/YKXfyIGsT99SDBsEAyXNYnp5opPOg82/VRq8zpz5S9B5JiUJuod7rdLHTgv9UOe
         NDa/FRk4pzll/RvpKbu11VkCi8K51EEGQu+Q7Ibbyem3WJNJeTTjsaw4mJHcgNUNFr7r
         RLr3KafF3sPndoiXGbrmtjTB6ZqBLxZrwBubR0dFalVq/1UazONV9hwDgd6flX8Wa9Yx
         0fUAXEV3CquPyMNSDAL3HMHpCHRNS+my8CD9kD9HTVQsS8MBrt18UiwMA1Wg2eoHvOYM
         R74w==
X-Gm-Message-State: AOAM532XJ5Veo2yHn7HKHgX8jWzbwmmo/k14KC7nLgAmlNNNPOtVbzVq
        xtSbGL+YLHyWQL7b8jtFmkWHC8fznZMcBIt+S9ZhtuOr2L2HidLVn5R7Fs0JRc88uOkbd2tZW0D
        ZrB8BqZtdkaSBKKq6Ajfw7MFf1fUKXC39tyE+RFmGb72jhpzdnWePMd162g==
X-Received: by 2002:a05:6830:1655:: with SMTP id h21mr3231140otr.269.1634799419090;
        Wed, 20 Oct 2021 23:56:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaYn3FbEBxku8Kok2yHwhmklId4ImFtFhqY4JjhPXK85xs7ZL633jFo032YpkEt8eGC9C94nu73DSS69nCpw0=
X-Received: by 2002:a05:6830:1655:: with SMTP id h21mr3231119otr.269.1634799418770;
 Wed, 20 Oct 2021 23:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210812153944.813949-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210812153944.813949-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Oct 2021 14:56:47 +0800
Message-ID: <CAAd53p7sPoH-MD9VMh1u+mf_E7Mc2xVfkHbhN4PCdxQM+v274g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Check PCIe upstream port for PME support
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 11:39 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Some platforms cannot detect ethernet hotplug once its upstream port is
> runtime suspended because PME isn't granted by BIOS _OSC. The issue can
> be workarounded by "pcie_ports=native".
>
> The vendor confirmed that the PME in _OSC is disabled intentionally for
> system stability issues on the other OS, so we should also honor the PME
> setting here.
>
> So before marking PME support status for the device, check
> PCI_EXP_RTCTL_PMEIE bit to ensure PME interrupt is either enabled by
> firmware or OS.
>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213873
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
> v2:
>  - Instead of prevent root port from runtime suspending, skip
>    initializing PME status for the downstream device.
>
>  drivers/pci/pci.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575c15cf..4344dc302edd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2294,6 +2294,32 @@ void pci_pme_wakeup_bus(struct pci_bus *bus)
>                 pci_walk_bus(bus, pci_pme_wakeup, (void *)true);
>  }
>
> +#ifdef CONFIG_PCIE_PME
> +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
> +{
> +       struct pci_dev *bridge = pci_upstream_bridge(dev);
> +       u16 val;
> +       int ret;
> +
> +       if (!bridge)
> +               return true;
> +
> +       if (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT &&
> +           pci_pcie_type(bridge) != PCI_EXP_TYPE_RC_EC)
> +               return true;
> +
> +       ret = pcie_capability_read_word(bridge, PCI_EXP_RTCTL, &val);
> +       if (ret)
> +               return false;
> +
> +       return val & PCI_EXP_RTCTL_PMEIE;
> +}
> +#else
> +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
> +{
> +       return true;
> +}
> +#endif
>
>  /**
>   * pci_pme_capable - check the capability of PCI device to generate PME#
> @@ -3095,7 +3121,7 @@ void pci_pm_init(struct pci_dev *dev)
>         }
>
>         pmc &= PCI_PM_CAP_PME_MASK;
> -       if (pmc) {
> +       if (pmc && pci_pcie_port_pme_enabled(dev)) {
>                 pci_info(dev, "PME# supported from%s%s%s%s%s\n",
>                          (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
>                          (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
> --
> 2.32.0
>
