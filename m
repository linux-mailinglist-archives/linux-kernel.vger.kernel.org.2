Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A458340F0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbhIQEUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:20:40 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46456
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244386AbhIQEUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:20:35 -0400
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 57D93402D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631852353;
        bh=UUDjDxYA0DPw3fgzrTN4mBMpElX++DxNM0RaIoCame4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=r+TqK7uwYaGHWjMo5nS/iJ0CQM+mrf69lLEwsqKzwJ8K8jqkz9Kvyi2pOPXuAHHvs
         FetcamnYvscSupxsAWFauGl/KiUEw/VqLtwQ4BmwfYAKha/owv0Kdgdqaepcm8i3zU
         Y2zP8UeHM46ICw/pLRZMGfpRODh+TqUJ/aC31p3i8KaiAXSjRIJA8jPwAwB7TDMEIL
         sWKOXMtKPmG4K0tpcppBbAD+w3+7AG1Kq/rDJyzbcDHghGBISMItq6Tc3cfNutjJCO
         ytWafQCjKRTmApPEpIo/fR3jJGdVSsQ7Bo3w30O4nisR9H2sJrnb10WHJilHm61GXg
         a0+nGeWT+0XnQ==
Received: by mail-oo1-f69.google.com with SMTP id k1-20020a4a8501000000b0029ac7b9dc82so24141510ooh.17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 21:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUDjDxYA0DPw3fgzrTN4mBMpElX++DxNM0RaIoCame4=;
        b=35n5ZY3TgPybKT00UVV4xRl0bgy9EiUQu7HN6X5PYrPfv0BWcCQ0ZJlNB0ehrZgfbm
         J28CDvqK+JCmJdlGeYz4SKZn1liwuJenMS7orSyEqTAQqfaGEZRp9xgHD1PbkUVqKobr
         4FosZlXHHswMPUqS1GjOMZypGJfPIYFaXJH3kH1avEW/IDG0ioGWv9O9VFjWSYqzGYqX
         QD/BaDdj3XM3Yi034gbQ8eSJbteeIgh8oGY0tMER/o3VbCLogmv5k2JuOpT98fPocIRJ
         u/jK/EAJ1zE2YjAJnoNsr017kR7NS9QdMduQm1HUXStw4Spik9U7/HNaYKxs53RFeq7I
         CJzg==
X-Gm-Message-State: AOAM533APDQcjuTSb79tL3jmskBOn/HGtG1ZWWjwtNmXgdgI0Y9lDi7Z
        nQ0SumNEgKmuRSn7QItJpRM8hVd3LAyVKPBLjzdGWImAOjtNuMjHdjbvOHG7rhfPd/RkQ8fQYzc
        vbHfPQDZ+B1/VkJY7HmjNE/x719U4ogynFYgyOs4GjVYWnaUQ3UQ6Jw1Mzg==
X-Received: by 2002:a9d:1708:: with SMTP id i8mr121637ota.233.1631852352164;
        Thu, 16 Sep 2021 21:19:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8BWvVRCIlOJi8BFuwwjSCsvzkqqa2wh2Z9e6SpR3Fxj99L8az3VQO5HrHlQdiS87jESWpUulbibbQ/b0/2Js=
X-Received: by 2002:a9d:1708:: with SMTP id i8mr121620ota.233.1631852351941;
 Thu, 16 Sep 2021 21:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210916154417.664323-4-kai.heng.feng@canonical.com> <20210916171232.GA1624808@bjorn-Precision-5520>
In-Reply-To: <20210916171232.GA1624808@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 17 Sep 2021 12:19:00 +0800
Message-ID: <CAAd53p4OKjX8EAuujasaDRD_V=bO5A=euETR5kJeAGfa-84DcA@mail.gmail.com>
Subject: Re: [RFC] [PATCH net-next v5 3/3] r8169: Implement dynamic ASPM mechanism
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 1:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 11:44:17PM +0800, Kai-Heng Feng wrote:
> > r8169 NICs on some platforms have abysmal speed when ASPM is enabled.
> > Same issue can be observed with older vendor drivers.
> >
> > The issue is however solved by the latest vendor driver. There's a new
> > mechanism, which disables r8169's internal ASPM when the NIC traffic has
> > more than 10 packets, and vice versa.
>
> Obviously this is a *rate*, not an absolute number.  I think you mean
> something like "10 packets in 1000ms".

Will amend this in next iteration.

>
> > The possible reason for this is
> > likely because the buffer on the chip is too small for its ASPM exit
> > latency.
> >
> > Realtek confirmed that all their PCIe LAN NICs, r8106, r8168 and r8125
> > use dynamic ASPM under Windows. So implement the same mechanism here to
> > resolve the issue.
> >
> > Also introduce a lock to prevent race on accessing config registers.
>
> Can you please include the bugzilla link where you attached lspci
> data?  I think it's this:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=214307

Yes I forgot to add it. Will include in in next iteration.

Kai-Heng

>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
