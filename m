Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFEB39F3E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhFHKqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:46:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57594 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhFHKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:46:03 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <koba.ko@canonical.com>)
        id 1lqZDN-0005Er-TE
        for linux-kernel@vger.kernel.org; Tue, 08 Jun 2021 10:44:09 +0000
Received: by mail-oi1-f198.google.com with SMTP id p5-20020acabf050000b02901eed1481b82so8045214oif.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCY5WNTu+UDTiFQqiIKFFkypfQ54bdSFH3ROo1PqtWY=;
        b=Egg03UtmXuMhUfjUiuhP8xmvadnTasuBukIIvj5F5Sez9tbHgbESlJcofbRNPuq6mj
         w9ZNvtqwUieNlDcl47/k1pB4bZJnq/Tr1wVu3LPRL9PzmgbV228h30Q0QhHehefBgUr9
         dayuFbrNTeX105II14ENCEeApgDCO+HWSNWwteKopIYeN6i2X+tgCUTWKOGdPe24klrn
         tt0KwRqJUifluIOkVk221DRJOWwdcmk6A+mcnGW8OTYD8ghEm7vGebsc5UnQKuJH8tph
         wo7alvB8PWVzwueBQxap5H9JMlAorVM+EIZgTLKpiUDtIlTk+H4l03FAsKBw39MEcUzx
         tcOA==
X-Gm-Message-State: AOAM532LTx/5bjJmX9YkfXdACzo/q+Tv7QRge8sbS74oLC0GGSiU2KI1
        LRL/41PzPnyX+DSuydxLq0AWZwv3Fs6tmMLbQa/enpuufJhULEfrWTHkxDQUadrCC0Wv5PNrBWE
        9bYcZ/6TYQFPbiN6mcplShFW3N+5mjxEmX+k8Z8TFEZCi15RXt2hZsu17aw==
X-Received: by 2002:a9d:6291:: with SMTP id x17mr17571290otk.326.1623149048768;
        Tue, 08 Jun 2021 03:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOX1PcXLsYQDy2BKePJwDT8Z337BIIIgYOi7paLnFxX1vuyhE2far3cvKk31GjQ74pISXBS2WgnunjUVT+58Q=
X-Received: by 2002:a9d:6291:: with SMTP id x17mr17571272otk.326.1623149048432;
 Tue, 08 Jun 2021 03:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210608032207.2923574-1-koba.ko@canonical.com> <84eb168e-58ff-0350-74e2-c55249eb258c@gmail.com>
In-Reply-To: <84eb168e-58ff-0350-74e2-c55249eb258c@gmail.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 8 Jun 2021 18:43:57 +0800
Message-ID: <CAJB-X+XFYa1cZgtJEL1KCNWviL3Y4X6EbN--rE8CD_9oD9EFyA@mail.gmail.com>
Subject: Re: [PATCH] [v2] r8169: Use PHY_POLL when RTL8106E enable ASPM
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 4:00 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 08.06.2021 05:22, Koba Ko wrote:
> > For RTL8106E, it's a Fast-ethernet chip.
> > If ASPM is enabled, the link chang interrupt wouldn't be triggered
> > immediately and must wait a very long time to get link change interrupt.
> > Even the link change interrupt isn't triggered, the phy link is already
> > established.
> >
> > Use PHY_POLL to watch the status of phy link and disable
> > the link change interrupt when ASPM is enabled on RTL8106E.
> >
> > v2: Instead use PHY_POLL and identify 8106E by RTL_GIGA_MAC_VER_39.
> >
>
> Still the issue description doesn't convince me that it's a hw bug
> with the respective chip version. What has been stated so far:
>
> 1. (and most important) Issue doesn't occur in mainline because ASPM
>    is disabled in mainline for r8169. Issue occurs only with a
>    downstream kernel with ASPM enabled for r8169.

mainline kernel and enable L1, the issue is also observed.

> 2. Issue occurs only with ASPM L1.1 not disabled, even though this chip
>    version doesn't support L1 sub-states. Just L0s/L1 don't trigger
>    the issue.
>    The NIC doesn't announce L1.1 support, therefore PCI core won't
>    enable L1 sub-states on the PCIe link between NIC and upstream
>    PCI bridge.

More precisely, when L1 is enabled, the issue would be triggered.
For RTL8106E,
1. Only disable L0s, pcie_aspm_enabled return 1, issue is triggered.
2. Only disable L1_1, pcie_aspm_enabled return 1, issue is triggered.

3. Only disable L1, pcie_aspm_enabled return 0, issue is not triggered.

>
> 3. Issue occurs only with a GBit-capable link partner. 100MBit link
>    partners are fine. Not clear whether issue occurs with a specific
>    Gbit link partner only or with GBit-capable link partners in general.
>
> 4. Only link-up interrupt is affected. Not link-down and not interrupts
>    triggered by other interrupt sources.
>
> 5. Realtek couldn't confirm that there's such a hw bug on RTL8106e.
>
> One thing that hasn't been asked yet:
> Does issue occur always if you re-plug the cable? Or only on boot?
> I'm asking because in the dmesg log you attached to the bugzilla issue
> the following looks totally ok.
>
> [   61.651643] r8169 0000:01:00.0 enp1s0: Link is Down
> [   63.720015] r8169 0000:01:00.0 enp1s0: Link is Up - 100Mbps/Full - flow control rx/tx
> [   66.685499] r8169 0000:01:00.0 enp1s0: Link is Down

Once the link is up,
1. If cable is unplug&plug immediately,  you wouldn't see the issue.
2. Unplug cable and wait a long time (~1Mins), then plug the cable,
the issue appears again.

>
> > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 2c89cde7da1e..a59cbaef2839 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -4914,6 +4914,19 @@ static const struct dev_pm_ops rtl8169_pm_ops = {
> >
> >  #endif /* CONFIG_PM */
> >
> > +static int rtl_phy_poll_quirk(struct rtl8169_private *tp)
> > +{
> > +     struct pci_dev *pdev = tp->pci_dev;
> > +
> > +     if (!pcie_aspm_enabled(pdev))
>
> That's the wrong call. According to what you said earlier you want to
> check for L1 sub-states, not for ASPM in general.

As per described above, that's why use pcie_aspm_enabled here.

>
> > +             return 0;
> > +
> > +     if (tp->mac_version == RTL_GIGA_MAC_VER_39)
> > +             return 1;
> > +
> > +     return 0;
> > +}
> > +
> >  static void rtl_wol_shutdown_quirk(struct rtl8169_private *tp)
> >  {
> >       /* WoL fails with 8168b when the receiver is disabled. */
> > @@ -4991,7 +5004,10 @@ static const struct net_device_ops rtl_netdev_ops = {
> >
> >  static void rtl_set_irq_mask(struct rtl8169_private *tp)
> >  {
> > -     tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> > +     tp->irq_mask = RxOK | RxErr | TxOK | TxErr;
> > +
> > +     if (!rtl_phy_poll_quirk(tp))
> > +             tp->irq_mask |= LinkChg;
> >
> >       if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> >               tp->irq_mask |= SYSErr | RxOverflow | RxFIFOOver;
> > @@ -5085,7 +5101,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
> >       new_bus->name = "r8169";
> >       new_bus->priv = tp;
> >       new_bus->parent = &pdev->dev;
> > -     new_bus->irq[0] = PHY_MAC_INTERRUPT;
> > +     new_bus->irq[0] =
> > +             (rtl_phy_poll_quirk(tp) ? PHY_POLL : PHY_MAC_INTERRUPT);
> >       snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x", pci_dev_id(pdev));
> >
> >       new_bus->read = r8169_mdio_read_reg;
> >
>
