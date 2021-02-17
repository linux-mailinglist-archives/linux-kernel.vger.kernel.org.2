Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051DB31D598
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhBQG7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 01:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhBQG7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:59:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 22:59:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id q4so11185469otm.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 22:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbjfjYta5sV8enFGeBHD9iVlSdE6T1W0VjCM7Pv5gRY=;
        b=QPLhm1DYU3gzhCacsYqU2Xh6jgbyz4u5pM6qIcqdkwkMnPBeeYsuMPVps3IArhzIH+
         M+MhX/Mx+6nkxbBdHnE/KFCoGIv5UJyBkaTVr/0N6h1re626SvU8N/rlpO+bBGy1Cvel
         OhweLPrRqU8L8jPCoh+P+HmQTMx79KYxMlbU1MWNRItqkB+BJk9TcckOFK4RE6gawLPk
         Qr8y2BPMo0qCGhCckHRTVXOKF83GzQK37kxRXI6+YjG/ik0bzIe9xu8Mnd4D9R4WfZDz
         8Wy/tLW4qSl2aKZ37TUZoWxLGuaQQwcnuFnn/pRZpy+mTTgirTD9H77fLNIhCEL12Gf2
         E3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbjfjYta5sV8enFGeBHD9iVlSdE6T1W0VjCM7Pv5gRY=;
        b=J2TkmZDA1dhbrb8JaKY9loTBSfdxyW4c24uOisog1W4ACkwHXE/IXAT7zhsKoyw0jY
         QS6/FW60IAruJAB+mrx3BrSNYIyQdFkMLTFulyNEt0vx4DWPwusLOMzd/tVpL9Yo7P45
         hfM45BF7CWZ9gAsOM0eM7K7DNCcpkIopSbSwYtSPDktR9edPiPZ0jFdli/0hp8weKrbc
         VTHADVN5EZzB7Fe7xmiNfnwuThnTxpREA8A9RmcQskYCkirXAh53e6a4IS+1141FlBwS
         7WFXaTOpCW9aOu2UlzL3CsUUJgWDlang5hftKMBkZ8If01ApGcXmQSMrmPuaGOD8zms7
         0Pmw==
X-Gm-Message-State: AOAM533s6lbR8GomLVirhydr0Uj8LdcGvotPzl4A+3rw026/rX0Y8Q05
        jT3b8OT15kye7/g8RiANDXPV2tZNIXOAsEDOi9tsoefLkvOP4g==
X-Google-Smtp-Source: ABdhPJyKVNYPxfx4WcKXdTfB2zXkaqpLkAvWwVawlsvzYTijOr6TLnNZRf/agDtcSveXe1UXjmhigvYgfBeauSGs/Pw=
X-Received: by 2002:a05:6830:120c:: with SMTP id r12mr17075240otp.72.1613545143740;
 Tue, 16 Feb 2021 22:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20210217065318.6685-1-selvakumar16197@gmail.com>
In-Reply-To: <20210217065318.6685-1-selvakumar16197@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 17 Feb 2021 07:58:52 +0100
Message-ID: <CAMhs-H-FTUxSFAsbNe9Gja4f6WR2259KQpZ3q5ByP7hYnXzwyw@mail.gmail.com>
Subject: Re: [PATCH] Staging: mt7621-pci: pci-mt7621: fixed a blank line
 coding style issue
To:     Selvakumar Elangovan <selvakumar16197@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Selvakumar,

On Wed, Feb 17, 2021 at 7:53 AM Selvakumar Elangovan
<selvakumar16197@gmail.com> wrote:
>
> Removed an unecessary blank line before closing brace reported by
> checkpatch.pl

Typo:

s/unecessary/unnecessary/g

>
> Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
> index c3532bc138fb..1781c1dcf5b4 100644
> --- a/drivers/staging/mt7621-pci/pci-mt7621.c
> +++ b/drivers/staging/mt7621-pci/pci-mt7621.c
> @@ -521,7 +521,6 @@ static void mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
>
>                         if (slot == 1 && tmp && !tmp->enabled)
>                                 phy_power_off(tmp->phy);
> -
>                 }
>         }
>  }
> --
> 2.17.1
>

Please, also change commit short message to:

staging: mt7621-pci: fixed a blank line coding style issue

With that changes:

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
