Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9663BB9BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGEJDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:03:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhGEJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:03:00 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1m0KSk-0006yJ-Cc
        for linux-kernel@vger.kernel.org; Mon, 05 Jul 2021 09:00:22 +0000
Received: by mail-ot1-f69.google.com with SMTP id q20-20020a9d7c940000b02903f5a4101f8eso12853188otn.17
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6wYMggQL4Kc/x8xMyA7h2j3whmdqB7IgTt34u11Uos=;
        b=dHY4WfwMkPQTHIFxM3ZBymaMexa7+NxJLF+oHwq+yANlsFQPUFDVEMaK0LhIpy7c19
         8be4bBRnYFT4HAd205PVfsvSc9Fl9yYRpT/thUAwdK41OB8a1CqEwIqY0unfMPPbiQDO
         eVCOa5oBcYoAJGMY4nj6OmVr7eoLL9JmeOdQpALPqHovi5SKt2+xnbRa8poKg+zgjA/a
         qQneEAS+Tq5B1Syjijb+l5lXhQNqw9Ss2yM9sGOV8Pq+zjhv+It7dS/BVf/AtrtjjIHH
         ANcHCObfsZjcAo91yI+yuWbMTeYyv40KIzmIS11Be9/ICiJuiA9e3HlZq3LWE4Fol7BL
         K6XA==
X-Gm-Message-State: AOAM533FTVunit4yFU+P0+HwvTKhRlnFRwEbPR9Y3YIA6HpGJNGReexq
        mQ5x6hqT8lO+86BGlUDY6FO/Du2LAWw3H0Dm0DabTELLRDlYnz2yGsiZ4yD/XKwFoFjr6oMbMUd
        jMeZ5nRtfX/wvBzcR1BhkFPxw2JLBXkMcG9sKJHS2m8Nqt8jr1DG3yO6Muw==
X-Received: by 2002:a05:6830:1f19:: with SMTP id u25mr6524524otg.303.1625475621314;
        Mon, 05 Jul 2021 02:00:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9roYChfxAr/TO7KIQukCmHCx/xq1CtOLOyNW4WqCG9AUmbVemwjMekcOUHAfCzMs3mnJDH06AMTJrb7zjkaM=
X-Received: by 2002:a05:6830:1f19:: with SMTP id u25mr6524509otg.303.1625475621095;
 Mon, 05 Jul 2021 02:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210701163354.118403-1-chris.chiu@canonical.com> <87v95thzu1.fsf@codeaurora.org>
In-Reply-To: <87v95thzu1.fsf@codeaurora.org>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 5 Jul 2021 17:00:10 +0800
Message-ID: <CABTNMG2_Cb7RhguJZNKZxAna6oBaDPhomBWRreO-adFX2Erwkw@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: disable interrupt_in transfer for 8188cu and 8192cu
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jes.Sorensen@gmail.com, davem@davemloft.net, kuba@kernel.org,
        code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 4:42 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> chris.chiu@canonical.com writes:
>
> > From: Chris Chiu <chris.chiu@canonical.com>
> >
> > There will be crazy numbers of interrupts triggered by 8188cu and
> > 8192cu module, around 8000~10000 interrupts per second, on the usb
> > host controller. Compare with the vendor driver source code, it's
> > mapping to the configuration CONFIG_USB_INTERRUPT_IN_PIPE and it is
> > disabled by default.
> >
> > Since the interrupt transfer is neither used for TX/RX nor H2C
> > commands. Disable it to avoid the confusing interrupts for the
> > 8188cu and 8192cu module which I only have for verification.
>
> The last paragraph is not entirely clear for me, can you elaborate it
> more? What do you mean with "confusing interrupts"? And is this fixing
> an actual user visible bug or are you just reducing the number of
> interrupts?
>
It's confusing because there are 8000~9000 interrupts per second even
though the association is not done yet and no traffic is pumped. It's
also way too many even the reception of the beacon frames triggers the
interrupt. This huge number overwhelms the normal interrupt we
expected from the register setting (only < 100/sec if runs with
rtlwif/rtl8192cu driver instead). It's difficult to judge where/why
the interrupts come from and what possible overhead it could possibly
incur.

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
