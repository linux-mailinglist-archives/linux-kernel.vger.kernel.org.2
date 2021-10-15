Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7577542E787
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 06:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhJOEOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 00:14:10 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51964
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233680AbhJOEOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 00:14:07 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 197554005C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634271120;
        bh=VkQNKanW6J45PUNBM67VvUtIKTUpwQuF1nL5FyFppEE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=c37he0BdOhePTj6VKY5MRr4NWuYcRpEBK1Jh5mzS2QqffuHSNAMwrr9WTX3QG4Jlg
         TOLwjnha18pA/u/lbur2VDejuFQrLAch6GIhvkUkP31WoSyPkg3pEMfcW3xUTwDP3q
         BZ3K/avyMbod+sdQwtpDjzM8aWGb9jJrqvVPjH6TfWyAHOzntBpXXbFHdx2PO0Gyna
         IH73Bxf4tzZKfwwp1FQ8E8h/FpAHKfl91VGd/yU38S7ns1FxkSFzFb+IoGbMyJQsGM
         /jTVuRhTGxp9pRjBtmvkpWlXGmq4bdRu+sJ01wrCesKa3RqgelQyJ4mfUw26hs6wYf
         CehlUdwOuS5aA==
Received: by mail-oi1-f199.google.com with SMTP id x145-20020aca3197000000b002986e47af95so4759213oix.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 21:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkQNKanW6J45PUNBM67VvUtIKTUpwQuF1nL5FyFppEE=;
        b=K0ShsX6o8X9qYAzl9XX63GjkGMi4Kj0t1RYw/N60hwdVl3aSchSocDD7/yqZ7jcSHE
         N6iA+yDQPiYcx82txtrUAxfs7EoqFr9ACkoYshnI9wJtuEnN/pN1sG9UBa3SvxWkJ8A4
         3ViM4XHGglefZWykDdV1k/PyMEV1Y768Gwmzqar2+bY1by2oFeKnNPY59fEIUgOr5RGr
         uPj7MGyOvBfhCQoGyYFmEky3qFW9ZEnSZHbFKFi+9w/SbmUkd+qzBmcM9/iMsYp/Y5p/
         24CXRFzU1KnC/XNS0JMvLcvW3VzSerFW+W3uxfetLMlYdGVgiGB18rNE0tOf9d8iDSOP
         ANzQ==
X-Gm-Message-State: AOAM532dsjFsBkR/T2b1hZ6xyE8TSKUK/BrkErQJ12Qn8gXvry3t5rul
        5eG6CKt07u8d0+xNV/Yf4QULKVAcyseA4VYI4pQw2VZjF/cdmxGZ1/W/TNbn5trp0fpuI2NwJbo
        cRuhfV7yOAksz8KaWXOYSSYE+u4mqkl+uG0nE14bu+J/gjfXm6FgZ33aF7Q==
X-Received: by 2002:a05:6808:10d5:: with SMTP id s21mr16056002ois.98.1634271118912;
        Thu, 14 Oct 2021 21:11:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaiHm2G7XZVZEqFR4bQ7ScvEI4IpC62Z7F9tOh8xzse8b/KH/rrxlb0aJs1f/fExK7bOuM0e6I+M3e6iNUcqE=
X-Received: by 2002:a05:6808:10d5:: with SMTP id s21mr16055983ois.98.1634271118568;
 Thu, 14 Oct 2021 21:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p4v+CmupCu2+3vY5N64WKkxcNvpk1M7+hhNoposx+aYCg@mail.gmail.com>
 <20211008135821.GA1326355@bhelgaas>
In-Reply-To: <20211008135821.GA1326355@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 15 Oct 2021 12:11:47 +0800
Message-ID: <CAAd53p5w_tE8URs0R7eog6X-kMSUQAeLiGS-CvDvnfQq+=i3TA@mail.gmail.com>
Subject: Re: [RFC] [PATCH net-next v6 3/3] r8169: Implement dynamic ASPM mechanism
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

On Fri, Oct 8, 2021 at 9:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Oct 08, 2021 at 02:18:55PM +0800, Kai-Heng Feng wrote:
> > On Fri, Oct 8, 2021 at 3:11 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Oct 08, 2021 at 12:15:52AM +0800, Kai-Heng Feng wrote:
> > > > r8169 NICs on some platforms have abysmal speed when ASPM is enabled.
> > > > Same issue can be observed with older vendor drivers.
> > > >
> > > > The issue is however solved by the latest vendor driver. There's a new
> > > > mechanism, which disables r8169's internal ASPM when the NIC traffic has
> > > > more than 10 packets per second, and vice versa. The possible reason for
> > > > this is likely because the buffer on the chip is too small for its ASPM
> > > > exit latency.
> > > > ...
>
> > > I suppose that on the Intel system, if we enable ASPM, the link goes
> > > to L1.2, and the NIC immediately receives 1000 packets in that second
> > > before we can disable ASPM again, we probably drop a few packets?
> > >
> > > Whereas on the AMD system, we probably *never* drop any packets even
> > > with L1.2 enabled all the time?
> >
> > Yes and yes.
>
> The fact that we drop some packets with dynamic ASPM on the Intel
> system means we must be giving up some performance.
>
> And I guess that on the AMD system, we should get full performance but
> we must be using a little more power (probably unmeasurable) because
> ASPM *could* be always enabled but dynamic ASPM disables it some of
> the time.

Yes that's the case here.

>
> > > And if we actually knew the root cause and could set the correct LTR
> > > values or whatever is wrong on the Intel system, we probably wouldn't
> > > need this dynamic scheme?
> >
> > Because Realtek already implemented the dynamic ASPM workaround in
> > their Windows and Linux driver, they never bother to find the root
> > cause.
> > So we'll never know what really happens here.
>
> Looks like it.  Somebody with a PCIe analyzer could probably make
> progress, but I agree, that doesn't seem likely.
>
> Realtek no doubt has the equipment to do this, but apparently they
> don't think it's worthwhile.  In their defense, the Linux ASPM code is
> pretty impenetrable and there could be a problem there that causes or
> contributes to this.

I do hope they can put more effort on their ethernet driver like what
they do on their wireless drivers.

Kai-Heng

>
> Bjorn
