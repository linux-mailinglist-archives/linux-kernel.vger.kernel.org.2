Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7386343AADE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 05:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhJZD4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 23:56:34 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57500
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234019AbhJZD4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 23:56:33 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4C4A44029B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635220449;
        bh=kZhcWeItYaRn2Q+IUotz7XPZmZ0X9JIZ6LR4JyyCG6I=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tTDulzASt3/eOzKhHqGvw3YcJz5V5bD/Ar0WvVCzyI3uFiskhOaBb4NnWSqmCitN+
         e0r5OBsnudTrsHljzJSivnoc/ihtB4OVlbmViZ+rZSuG2K64USAsAIHkV/ozjEE16c
         bpqdQlPoFavZf9QXvmT6naELsgq1Ef5PbRSGIWrapqga/IyXf3nVEwYae3XgrT/BEX
         /8A7VyRmvPql6qo3Y1ua5JmmHqLmpVhrVn72F8Gpw4RvLSgaWOo4RXppgVkByFoS2w
         tofoTAAJPUw1j2kuFW838aKKkZmAG8rSyWhk0AsWTF5LN5pdX/Q6beiUDwyd8WdQqD
         0aCbob9UnfL1g==
Received: by mail-oi1-f197.google.com with SMTP id s125-20020acac283000000b00299f2f36eb2so3362425oif.22
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 20:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZhcWeItYaRn2Q+IUotz7XPZmZ0X9JIZ6LR4JyyCG6I=;
        b=VBa/2XCVncnKueQ5jN5JMw8Y6zeKF9cI5v6hvqGzcl+7YLxYM47QIgkqroxWo65L6B
         Fve5RwjWG8wkaeWAW2nySaDCK17FuetRxw/UkJhg3Riz4LgNzzQIjeivQiKu05Ox9faC
         TrcfOWYhEK9z6E/KC3k1AfHGinfza1dtOHwKKe9bsMNxSXsDis6h6pux436xV/docRGB
         hhQeiwJxsnti/A4YV10W8MZ0MOn3azxH9y05FTtN7H1PoGS7+Er8/TsA793Sh0dJwMBI
         nKNJt5l9putXqr/iiTHXEcK9Lh+FF5yUVwswKDJ9R/pTAG3ab3237yJcLi6WDM6UNzbZ
         KfCw==
X-Gm-Message-State: AOAM531CDcfw/261jPFxLZIcPdNzcIylyilbZo7t/6CteisVf9V+uhxH
        OwICzHsmCz9RSGeNpd4NqgWdQop+bNZwkC4hN3s6C/im/WXZwZftmpeL3h8Xca2imb0GPmlPEgU
        olxM5aruoUqlSwuVF4/44ma5geDWvhCwStW3X7rOjf6JhJDIqyl/Sgbs8wA==
X-Received: by 2002:a05:6830:1f55:: with SMTP id u21mr17726423oth.233.1635220448142;
        Mon, 25 Oct 2021 20:54:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDNWrIRoaXDuL/UzlYuaqCo7n4hiSiCoSfk+ehSUmXeWJblkVKdUJowBaTHmvH57YUmnxSB1e7qALZKTOymuw=
X-Received: by 2002:a05:6830:1f55:: with SMTP id u21mr17726410oth.233.1635220447919;
 Mon, 25 Oct 2021 20:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211016075442.650311-1-kai.heng.feng@canonical.com>
In-Reply-To: <20211016075442.650311-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 26 Oct 2021 11:53:56 +0800
Message-ID: <CAAd53p5tOveDd_dFm=EOyc4z3wMhHcOXVx7WQZpSuAaeDLCysQ@mail.gmail.com>
Subject: Re: [RFC] [PATCH net-next v7 0/4] r8169: Implement dynamic ASPM
 mechanism for recent 1.0/2.5Gbps Realtek NICs
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

On Sat, Oct 16, 2021 at 3:54 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> The purpose of the series is to get comments and reviews so we can merge
> and test the series in downstream kernel.
>
> The latest Realtek vendor driver and its Windows driver implements a
> feature called "dynamic ASPM" which can improve performance on it's
> ethernet NICs.
>
> Heiner Kallweit pointed out the potential root cause can be that the
> buffer is to small for its ASPM exit latency.
>
> So bring the dynamic ASPM to r8169 so we can have both nice performance
> and powersaving at the same time.
>
> For the slow/fast alternating traffic pattern, we'll need some real
> world test to know if we need to lower the dynamic ASPM interval.

Do you think we can include this to downstream kernel in its current form?

Kai-Heng

>
> v6:
> https://lore.kernel.org/netdev/20211007161552.272771-1-kai.heng.feng@canonical.com/
>
> v5:
> https://lore.kernel.org/netdev/20210916154417.664323-1-kai.heng.feng@canonical.com/
>
> v4:
> https://lore.kernel.org/netdev/20210827171452.217123-1-kai.heng.feng@canonical.com/
>
> v3:
> https://lore.kernel.org/netdev/20210819054542.608745-1-kai.heng.feng@canonical.com/
>
> v2:
> https://lore.kernel.org/netdev/20210812155341.817031-1-kai.heng.feng@canonical.com/
>
> v1:
> https://lore.kernel.org/netdev/20210803152823.515849-1-kai.heng.feng@canonical.com/
>
> Kai-Heng Feng (4):
>   PCI/ASPM: Add pcie_aspm_capable()
>   r8169: Enable chip-specific ASPM regardless of PCIe ASPM status
>   r8169: Use mutex to guard config register locking
>   r8169: Implement dynamic ASPM mechanism
>
>  drivers/net/ethernet/realtek/r8169_main.c | 70 ++++++++++++++++++++---
>  drivers/pci/pcie/aspm.c                   | 11 ++++
>  include/linux/pci.h                       |  2 +
>  3 files changed, 74 insertions(+), 9 deletions(-)
>
> --
> 2.32.0
>
