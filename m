Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66887401D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 17:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbhIFPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 11:12:15 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35460
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231823AbhIFPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 11:12:13 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1490F40779
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630941068;
        bh=qrn6Lwq5UjF65G8mpT9qRaUrzJDuHvD3Z3rSvaAaYKs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=gS0nrOOK0AHKtT65Y4XZhUnuex+XyDXciDpmBQL2Lv0xhhP3fy2lb5WQiEkiSkUBp
         HgBUYcOhctNt91vrqapvgbeb1VNz2DMUU3w1PhEMF9icW5xqPuBwHkAvIOZxX6HYd6
         udh8vh3EA6DTRNyVNcyYKb4ldPv486cWxNL+FDqR0445n4U33iqQdOC3dbqEXTovB+
         /AfGCqUOhEOgvtVJ2NXZYL1jpDcbcLNw1iHg1yjNNTJUVe/nGtrH7SIec5zfXTb4/R
         j8/u6+GmUq7nu1qA+0eesQYdemXzn+fI/XZCZAcPh6KWEPSIRWWne3HBOVK+PZYA2D
         B+GeseugLK0uA==
Received: by mail-ot1-f72.google.com with SMTP id i7-20020a9d6507000000b0051c10643794so4581464otl.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 08:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrn6Lwq5UjF65G8mpT9qRaUrzJDuHvD3Z3rSvaAaYKs=;
        b=NY16+QCD/wuE4vtVOSgDXazyj9f5qpFiMJTO3MvUUuATolFXwjZSLVg3f1iXmaTsDd
         j6tsWaOZlOeMEFiuleNTOr9ddcGHZTqLGsTzafOaWP/iWJhoU+HTkG1f880Bc2xKKYQp
         F5YT+9YbNBxXgPau8o6MBdJIv+4Ol2a21qaKr82vEYwqOEKvwVrOTutnB6mi9w3zH1qf
         A3Khq0n/rDFHBE43anTathyDwA1B9Dqpl9Cp4FODeGiX8QMineEHEEywqTo2DPTIwtv4
         0730c7IlYrUcW3hgc9/x8lK2Ta9dFkl/NhzchjpsFP4BPkhTrE4D8cmuH/pkPPxz6kVN
         /Lew==
X-Gm-Message-State: AOAM531gZ0Nw5QiWU2Vwylw0Br9GFtaK+CaeGVb5O0t6b6NOFWt0IZqz
        yV80HyXZHpgM+xHUhi6fxX56xo/BudQ3gJQtf2p0nBwlOqSE6TA69VDxuES+WmBWe23PhFljkSs
        YtnkAGsjcH5qdo/DcKARGTfhCIHZpjIyGdTj5EgBnsZknhw6bnNGpHnsA/A==
X-Received: by 2002:a4a:d04d:: with SMTP id x13mr14295635oor.65.1630941066594;
        Mon, 06 Sep 2021 08:11:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvj0oQe2bL8r0PFOgcgSewvyaRSPTOPhAPexL9N4kMaThlyUks3ALTEErtHaVmg/sSB7jKLzyUJvA+BmtjFTk=
X-Received: by 2002:a4a:d04d:: with SMTP id x13mr14295598oor.65.1630941066190;
 Mon, 06 Sep 2021 08:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210827171452.217123-3-kai.heng.feng@canonical.com>
 <20210830180940.GA4209@bjorn-Precision-5520> <CAAd53p634-nxEYYDbc69JEVev=cFkqtdCJv5UjAFCDUqdNAk_A@mail.gmail.com>
 <71aea1f6-749b-e379-70f4-653ac46e7f25@gmail.com>
In-Reply-To: <71aea1f6-749b-e379-70f4-653ac46e7f25@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 6 Sep 2021 23:10:53 +0800
Message-ID: <CAAd53p7XQWJJrVUgGZe0MC1jO+f3+edAmkEVhP40Lwwtq2bU2A@mail.gmail.com>
Subject: Re: [RFC] [PATCH net-next v4] [PATCH 2/2] r8169: Implement dynamic
 ASPM mechanism
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 4:00 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 03.09.2021 17:56, Kai-Heng Feng wrote:
> > On Tue, Aug 31, 2021 at 2:09 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >> On Sat, Aug 28, 2021 at 01:14:52AM +0800, Kai-Heng Feng wrote:
> >>> r8169 NICs on some platforms have abysmal speed when ASPM is enabled.
> >>> Same issue can be observed with older vendor drivers.
> >>>
> >>> The issue is however solved by the latest vendor driver. There's a new
> >>> mechanism, which disables r8169's internal ASPM when the NIC traffic has
> >>> more than 10 packets, and vice versa. The possible reason for this is
> >>> likely because the buffer on the chip is too small for its ASPM exit
> >>> latency.
> >>
> >> This sounds like good speculation, but of course, it would be better
> >> to have the supporting data.
> >>
> >> You say above that this problem affects r8169 on "some platforms."  I
> >> infer that ASPM works fine on other platforms.  It would be extremely
> >> interesting to have some data on both classes, e.g., "lspci -vv"
> >> output for the entire system.
> >
> > lspci data collected from working and non-working system can be found here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=214307
> >
> >>
> >> If r8169 ASPM works well on some systems, we *should* be able to make
> >> it work well on *all* systems, because the device can't tell what
> >> system it's in.  All the device can see are the latencies for entry
> >> and exit for link states.
> >
> > That's definitely better if we can make r8169 ASPM work for all platforms.
> >
> >>
> >> IIUC this patch makes the driver wake up every 1000ms.  If the NIC has
> >> sent or received more than 10 packets in the last 1000ms, it disables
> >> ASPM; otherwise it enables ASPM.
> >
> > Yes, that's correct.
> >
> >>
> >> I asked these same questions earlier, but nothing changed, so I won't
> >> raise them again if you don't think they're pertinent.  Some patch
> >> splitting comments below.
> >
> > Sorry about that. The lspci data is attached.
> >
>
> Thanks for the additional details. I see that both systems have the L1
> sub-states active. Do you also face the issue if L1 is enabled but
> L1.2 and L1.2 are not? Setting the ASPM policy from powersupersave
> to powersave should be sufficient to disable them.
> I have a test system Asus PRIME H310I-PLUS, BIOS 2603 10/21/2019 with
> the same RTL8168h chip version. With L1 active and sub-states inactive
> everything is fine. With the sub-states activated I get few missed RX
> errors when running iperf3.

Once L1.1 and L1.2 are disabled the TX speed can reach 710Mbps and RX
can reach 941 Mbps. So yes it seems to be the same issue.
With dynamic ASPM, TX can reach 750 Mbps while ASPM L1.1 and L1.2 are enabled.

> One difference between your good and bad logs is the following.
> (My test system shows the same LTR value like your bad system.)
>
> Bad:
>         Capabilities: [170 v1] Latency Tolerance Reporting
>                 Max snoop latency: 3145728ns
>                 Max no snoop latency: 3145728ns
>
> Good:
>         Capabilities: [170 v1] Latency Tolerance Reporting
>                 Max snoop latency: 1048576ns
>                 Max no snoop latency: 1048576ns
>
> I have to admit that I'm not familiar with LTR and don't know whether
> this difference could contribute to the differing behavior.

I am also unsure what role LTR plays here, so I tried to change the
LTR value to 1048576ns and yield the same result, the TX and RX remain
very slow.

Kai-Heng
