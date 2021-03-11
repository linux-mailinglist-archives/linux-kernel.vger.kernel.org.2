Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1AB3374DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhCKODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhCKOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:02:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B872C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:02:33 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id q204so14448309pfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wu8fFbt6pPps0sW0Am+MuqVI376zrcxTbhhiS9bar6c=;
        b=cC5IhqvV/5oVLBL9TLG80rhJAB1lQXpcoIBWKJoGPyUR0RiUvMVfinjN79y0CKRKnz
         OnXELqiRYJONd+HvVSYUgV/A/ETiZRko0Fd61hMlmR7OpiocVlUHsBugAPndW1odLmT+
         Rh8/6Iconp3bLRenDXgvTbJGddvU3RRC/w2sFpJDVP41xw70FgGzfZynuD55XCQBfY/A
         8MDtUZmUyYBwSOZbXPKCtQAZHDetm16II269cIeajcrF5kSsam8eM5TwtnXmMfss/6YW
         3a8MWuRAfS33rOWXaRkHlQAt1NPLlWj3+bCEO3APp4F+ue+ohs4vzvIemLshbxM7J733
         Ptgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wu8fFbt6pPps0sW0Am+MuqVI376zrcxTbhhiS9bar6c=;
        b=qOtBIpKOVPc3RCX6KvH5fD9aIgHXNbJJXeVYUTp+zEYyaBeZ4OKF+/HzpOcrVhTb6b
         0r0OXNSaClu16UzQguGfXCJdp1LRVLaps9DrTSKnJs9zhnLoJ48WWl4pxew+Ku8h8Bp4
         3wlqpE4z+KB75SHWcfn/Tew2mQGFkNfct14NRexKWlpMVdrs9ZsYCVYRb8MTi5FVyEbq
         vZa86Bx77/nP04rbbRtTe6llojor6RSuRCJuWdxvJ3h/CZLgj57tnx9H7KXvDZIgrR3N
         cha2mDaAiBhIKuHm3gsU3bVtcR3EFcPNB96HFzVClflZcE0yO3NqCkUz6c923zKk8LN0
         h2bA==
X-Gm-Message-State: AOAM5308TjEndytYIwimddg8pgi4gBtgw4n55G/1oXccWowzGFV2Yj6L
        wIJbIQbG1Pm7djJ1Civ/Ffl9ruEdHW2CT0lxpme2pDoYUg6S7g==
X-Google-Smtp-Source: ABdhPJzOCePPExdMTrNRTPHA6tSnt9KRAKvaxfBmfXhxn1cpJvTlQymYY+qW/liI0wajnrz1tMJFTaNzJ2TYrv7OBIE=
X-Received: by 2002:a63:ce15:: with SMTP id y21mr7410996pgf.4.1615471352621;
 Thu, 11 Mar 2021 06:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20210311132741.80989-1-andriy.shevchenko@linux.intel.com> <s5hpn05vmhm.wl-tiwai@suse.de>
In-Reply-To: <s5hpn05vmhm.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Mar 2021 16:02:16 +0200
Message-ID: <CAHp75VcxRK=NsHXRtN8k8wrE8YSyNDqyTLb37TP4ojO_CW5ceg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ALSA: hda/realtek: Sort alphanumerically the
 SND_PCI_QUIRK() entries.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 3:40 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 11 Mar 2021 14:27:41 +0100,
> Andy Shevchenko wrote:
> >
> > Sort alphanumerically the SND_PCI_QUIRK() entries for better maintenance.
> > No functional change implied.
>
> I'd love to apply this kind of cleanups (and I do sometimes
> partially), but practically seen, this may make the stable backporting
> significantly harder because many quirk patches are backported to the
> very old LTS kernels.  So, unless any specific reason (e.g. some
> entries doubled or wrongly applied) is given, I'd avoid this full
> plastic surgery.

Can we ask people to follow the ordering before patches were applied?

-- 
With Best Regards,
Andy Shevchenko
