Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B043093E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 11:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhA3KC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 05:02:59 -0500
Received: from mail-41103.protonmail.ch ([185.70.41.103]:37235 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhA3KC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 05:02:26 -0500
X-Greylist: delayed 3501 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2021 05:02:25 EST
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 8A5B823B5A50;
        Sat, 30 Jan 2021 08:16:47 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="G0E1cUEu"
Date:   Sat, 30 Jan 2021 08:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1611993895;
        bh=lw9NipPj9ZmUjA+q3t5yaTgBtEXb/vo2lGVSIlDNbZM=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=G0E1cUEuBoW0hJR0QCxXhwslQ8+PR8nwqlnc4it/NA+ZDJskvRAuDn/dwmrNCnflW
         P9fJvy+gibXgA1lN8InTC/O4c2+CL5UIlJfvDP1qAXDzJqdNg/9v8dx/J/7FejK70E
         f8YZiVMoMdCi+1KUY4F6fR3W2SCxs1xz0DyOjCj0=
To:     "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     "agross@kernel.org" <agross@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v2 3/5] pcie-qcom: provide a way to power up qca6390 chip on RB5 platform
Message-ID: <Y6qqfCwC-O5b_bSR-8HY9-0aCeREaoAPsyOw5EVhv6YkZgPkzafs28dd5ldWZvT1Pkln-XfkB0t2gLFOClvJNDuny7zFAfYxbQzt0UMNjrE=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:52 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Some Qualcomm platforms require to power up an external device before
> probing the PCI bus. E.g. on RB5 platform the QCA6390 WiFi/BT chip needs
> to be powered up before PCIe0 bus is probed. Add a quirk to the
> respective PCIe root bridge to attach to the power domain if one is
> required, so that the QCA chip is started before scanning the PCIe bus.

I'm lead to believe that this is also needed for QCA6174. I tried taking
the driver you wrote and changing regulators to match the ones used by QCA6=
174,
but I found that it gets probed after PCIe, which makes it get -EPROBE_DEFE=
R
when it tries to attach to the power domain, which it doesn't handle it and
just proceeds to scan the bus and not find the chip as usual.
