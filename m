Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1E3F32C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhHTSHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhHTSHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:07:44 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C235C061757
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:07:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id bk29so5988475qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2P/6ZDosW5/PVcVOFh8CyCIBugd9jmsRIXNI9frVp7k=;
        b=eKlYoSg3dyAbESo+fqg+WE15YLNT8pnJoLbLlt4p3gPHdJcPfp3zxOG3s4YPxNRYRA
         wA/+17Kcf4OTu6WSv5rvKqFSNJjVgyZil/Aa+dRjpq1fyJs7xT7HCyWE5Lez19Fctvpn
         fnt8zYEUB6XDJTwGrbo+cxtaQ8xBfy2lhSw/pUcTUjHq3SYmL42O7NATxxGUxx/p6PSR
         X9CvVNLLR5FUVuHZUm2uMHxa9qn0/npIpTtFzrf84CoEsU3pVNpAkQHFSKrI4BjqhFYk
         jKjg6TogdUzt0VlXmNMV8Hk+zLDxDpdka2jmr+B9Uk7If6pBiWAdgmz88s0DbRPoFKJU
         sMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2P/6ZDosW5/PVcVOFh8CyCIBugd9jmsRIXNI9frVp7k=;
        b=S+uATMAdeghSc4ufpFA550JyKczaxBIjcKeSTJk8gk8v2EApff4U0YxrQpD3RsIxuu
         jgl5O3aacaFYgksxPsxc7roSCd/wQZMwfLCHiC2ZSm31aH1IxNZdRrmCPmuwrrwxgKTS
         XI6MLBJOvtO20YzShOAnM3qj+UWwJuIjvW0HuG0oFl93/Mod3CMvdDHbGUJPrp3X79aH
         7wHQLt9cIPwgWBlCxUWWjLekqWyw64mgK3gFNEk2OlyGdLzrn0TXDJEyXSNUf1hg0dEo
         NCsPa+nnnY9QApR7UTKoQ+U8qdB3a3MDITUjzoOJBd/qNgynooLPy0ROhWxMPaj9juWD
         7vgg==
X-Gm-Message-State: AOAM530ZwIuGzImWfQF+wI5KTtQJYLic6PsawNSiV6kgl/6gydwlzRYj
        4O4XWclVNf5Eu/dM6ebkdwJaq/VJgzkl5seYoYtqxw==
X-Google-Smtp-Source: ABdhPJy0huyrDFkZklcWqufreDpJu2i+J+NGLsKEiT3nXZbNTjdURslsF8xR7EyStcydsSHXMEetryziZu3Y6KGLCVk=
X-Received: by 2002:a37:7801:: with SMTP id t1mr10378336qkc.162.1629482824676;
 Fri, 20 Aug 2021 11:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
 <1CA665D1-86F0-45A1-862D-17DAB3ABA974@holtmann.org> <CAA8EJpoOxerwmwQozL3gp1nX-+oxLMFUFjVPvRy-MoVfPuvqrw@mail.gmail.com>
 <YR/gQ0K9MjddBVwY@ripper>
In-Reply-To: <YR/gQ0K9MjddBVwY@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 20 Aug 2021 21:06:53 +0300
Message-ID: <CAA8EJpo7R4azxybBmKC4uzAm_dvP4tpm4g9VoDMTdw6XZCxzTg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/15] create power sequencing subsystem
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Andy Gross <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-mmc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 at 20:01, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 20 Aug 06:08 PDT 2021, Dmitry Baryshkov wrote:
>
> > Hi,
> >
> > On Thu, 19 Aug 2021 at 18:23, Marcel Holtmann <marcel@holtmann.org> wrote:
> > > > This is an RFC of the proposed power sequencer subsystem. This is a
> > > > generification of the MMC pwrseq code. The subsystem tries to abstract
> > > > the idea of complex power-up/power-down/reset of the devices.
> > > >
> > > > The primary set of devices that promted me to create this patchset is
> > > > the Qualcomm BT+WiFi family of chips. They reside on serial+platform
> > > > interfaces (older generations) or on serial+PCIe (newer generations).
> > > > They require a set of external voltage regulators to be powered on and
> > > > (some of them) have separate WiFi and Bluetooth enable GPIOs.
> > > >
> > > > This patchset being an RFC tries to demonstrate the approach, design and
> > > > usage of the pwrseq subsystem. Following issues are present in the RFC
> > > > at this moment but will be fixed later if the overall approach would be
> > > > viewed as acceptable:
> > > >
> > > > - No documentation
> > > >   While the code tries to be self-documenting proper documentation
> > > >   would be required.
> > > >
> > > > - Minimal device tree bindings changes
> > > >   There are no proper updates for the DT bindings (thus neither Rob
> > > >   Herring nor devicetree are included in the To/Cc lists). The dt
> > > >   schema changes would be a part of v1.
> > > >
> > > > - Lack of proper PCIe integration
> > > >   At this moment support for PCIe is hacked up to be able to test the
> > > >   PCIe part of qca6390. Proper PCIe support would require automatically
> > > >   powering up the devices before the scan basing on the proper device
> > > >   structure in the device tree.
> > > >
> > > > ----------------------------------------------------------------
> > > > Dmitry Baryshkov (15):
> > > >      power: add power sequencer subsystem
> > > >      pwrseq: port MMC's pwrseq drivers to new pwrseq subsystem
> > > >      mmc: core: switch to new pwrseq subsystem
> > > >      ath10k: add support for pwrseq sequencing
> > > >      Bluetooth: hci_qca: merge qca_power into qca_serdev
> > > >      Bluetooth: hci_qca: merge init paths
> > > >      Bluetooth: hci_qca: merge qca_power_on with qca_regulators_init
> > > >      Bluetooth: hci_qca: futher rework of power on/off handling
> > > >      Bluetooth: hci_qca: add support for pwrseq
> > >
> > > any chance you can try to abandon patching hci_qca. The serdev support in hci_uart is rather hacking into old line discipline code and it is not aging well. It is really becoming a mess.
> >
> > I wanted to stay away from rewriting the BT code. But... New driver
> > would have a bonus point that I don't have to be compatible with old
> > bindings.
>
> It would be preferable if this was a implementation-only change and that
> we kept the existing binding and existing dtb continued to work.

This would require setting up the pwrseq from within the bt driver. I
did not have that in mind. However that'd ease the bt code, since we
won't have to handle the fallback/back-compatibility. Let me think
about it.

-- 
With best wishes
Dmitry
