Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C363A32E0EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 05:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCEE7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 23:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEE7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:59:48 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C45C061574;
        Thu,  4 Mar 2021 20:59:48 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id v12so624290ott.10;
        Thu, 04 Mar 2021 20:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0Mk72avpHdhSJAjqBV5Yll3WvB1xqe8t3SVT3h8H5k=;
        b=CI9w0x4SKtGImgBFfj3etYWLTG9vsxvaMEKVO9F8GmvkuYUUwkJyLXahEl/PpwnIXX
         4orQ0SHxLHw0+CtH2+vJNdD3np6x0FAywYPKM1jiusFpC546N3cofuwUlLOM9kE84lYo
         Sm01CW3imaRgyg4tN8HZExpfGfII5+itgs396aV88zF7D5dnHC20Kaels8rsA05eIvJL
         ehSUBPHrO9v85hNGXlmVS6rzOpaU90fOcjdNsbiUBDL+SopPnNDkKKPUkD39fAf/ReOv
         Sn3yv17JytDJ0bmDx3osG8r3vL4gCAXNrMD7zra1z4Fz0Ams2upy8kGO/eQ3Tcy4WJxa
         GIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0Mk72avpHdhSJAjqBV5Yll3WvB1xqe8t3SVT3h8H5k=;
        b=SRtaDWik+JV4SsRQmUa3l4LZ7O0hjKcMPfDlg+chj/8ppO2lE11QUUSQsF6rpGpjXA
         mzax3iVJG+kdYXt28Ddo6ScL1C0KAHLsgRvgsbujijur+xWPxv7kvWR7c6mdcU6ulY/S
         cmxGDbmAYUxLW+ZSJtz5n17tv+z/JBJDhuMtbymxdYfQldTIg+pq+psTDQFz3SwcekyL
         5uwjgeZGrACwnxTN4AApKANZ6z6TB7wez3H4E/HVMPokXRmnVZ0V1IK9h2jrXKPpRZkK
         7RsGoLNOiHbfKHjz4u1wZP/CCKhsRP0w0Xm7V6oJbqy3MnmU8MQa+I5wbzhJOVm0D8pM
         dJpw==
X-Gm-Message-State: AOAM533B6U+zIvk/avikGNvFIV+zOsswm4s+laoGga9/tZQVVDSh8jWx
        4jwnyAuScBgpdnScAuhsqVVL1e7NIEmumQ5eakw=
X-Google-Smtp-Source: ABdhPJw9g001D7R/evptKBtMKwJyyDDxQePDW9srrI1add9OteIESjKLHzaOl6RFJ9mLGuVmNoOrcNNMMRCBhZST/Oc=
X-Received: by 2002:a9d:6e01:: with SMTP id e1mr6552620otr.74.1614920387915;
 Thu, 04 Mar 2021 20:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20210305034931.3237558-1-weiyongjun1@huawei.com>
In-Reply-To: <20210305034931.3237558-1-weiyongjun1@huawei.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 5 Mar 2021 05:59:36 +0100
Message-ID: <CAMhs-H_0wPa+sFSs4hEx+52e3gMYm=xDVjOEnv2A6v6nSs-JUg@mail.gmail.com>
Subject: Re: [PATCH -next] phy: ralink: phy-mt7621-pci: fix return value check
 in mt7621_pci_phy_probe()
To:     "'Wei Yongjun" <weiyongjun1@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 4:40 AM 'Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Fix the return value check which testing the wrong variable
> in mt7621_pci_phy_probe().
>
> Fixes: d87da32372a0 ("phy: ralink: Add PHY driver for MT7621 PCIe PHY")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/phy/ralink/phy-mt7621-pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
