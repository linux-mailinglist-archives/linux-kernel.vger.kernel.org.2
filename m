Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5FB3E3240
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhHGABq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhHGABq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:01:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED6C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 17:01:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id yk17so17766540ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HBtQ2hhaYUSjTBWgcpF3U+mC8/e4OqXAIMMO04ke2UE=;
        b=Ug43YjGJHgSrDzGmUYxO34YjaAlLbM6jlTwtfQYdwYD0cINtGGbEm0/2WKonJiVsqC
         jX+J/iINJfYwRnf0X38w0CMaP1TgAYMJSVBD/aZj4ZtyuElwNFSmuXIWItQt5lMgiNl2
         3Lp2+zieboe0GC9N6ImjeseN+BL5IbdEoI00m91OaQORLkEDIjcWanmdow5Xs0TFyXw0
         Bc6IC8PHGSHfcGHmbLvhkCq/Y8rKNGiMaGStnp3K7wg0lDqg0a4NRr7Z1E11f7S6EWxS
         XMJRsoAgKVrKv2702RAq1MAQtxo6UJVmw16mG1FMmM6g+df/zHpKIOPt6MDplQm+u1Cd
         zACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HBtQ2hhaYUSjTBWgcpF3U+mC8/e4OqXAIMMO04ke2UE=;
        b=M7kyk2EAwrnO6/qgYH++hlX615YHQ43RMmi+O+/n/WQ+4/FNlTnwNf8KnpJJtHhfwo
         BA5uN10pvnj5r0SRQaUQqV20uswaD8tzl00Q7/mIpEiFl99P2M5ljXvBnaNkbeTCy+2w
         feOf1yUcVjQW8s5wtKXUx8LGACm4kQFJTwe6joO3OrweS4WCcca5I8ey6+IXWcxe8f7a
         U0tWjiLw2aP2xP/TCScqrqNAnaEHVQU3hXZYDJgJmq6UeFU2rgAn9Ds82OgQMu3k5lND
         DLFGNpQ+yKWwHVBrE08x9w/axP7hjRmylWaUOWu9giPgbW7bnGHMluF0Db35RRLmh2mF
         rhgg==
X-Gm-Message-State: AOAM533BrcQWcyKa1Pgl1eU2ARhNgy69jjzYSArQ8aDmdSGvE+vIr+Ny
        jDduDGJ+Q9b11tJwwFXdnp3FiiL2fr8ndA==
X-Google-Smtp-Source: ABdhPJxGfPPi8eB3Sk09HHrqm2nw6b8V3LtJd3BiTn2/P/eRdczKSpn6up1WTWjwfwTaCd4RFwv4JA==
X-Received: by 2002:a17:906:6d4e:: with SMTP id a14mr12090534ejt.328.1628294486450;
        Fri, 06 Aug 2021 17:01:26 -0700 (PDT)
Received: from cephalopod (168.7-181-91.adsl-dyn.isp.belgacom.be. [91.181.7.168])
        by smtp.gmail.com with ESMTPSA id m20sm4470785edv.67.2021.08.06.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 17:01:26 -0700 (PDT)
Date:   Sat, 7 Aug 2021 02:01:24 +0200
From:   Ben Hutchings <ben.hutchings@essensium.com>
To:     Steve Bennett <steveb@workware.net.au>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: micrel: Fix detection of ksz87xx switch
Message-ID: <20210807000123.GA4898@cephalopod>
References: <20210730105120.93743-1-steveb@workware.net.au>
 <20210730095936.1420b930@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <74BE3A85-61E2-45C9-BA77-242B1014A820@workware.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74BE3A85-61E2-45C9-BA77-242B1014A820@workware.net.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 08:19:17AM +1000, Steve Bennett wrote:
> > On 31 Jul 2021, at 2:59 am, Jakub Kicinski <kuba@kernel.org> wrote:
> > 
> > Please extend the CC list to the maintainers, and people who
> > worked on this driver in the past, especially Marek.
> 
> Sure, I can do that in a v2 of the patch along with the more detailed
> explanation below.
> 
> > 
> > On Fri, 30 Jul 2021 20:51:20 +1000 Steve Bennett wrote:
> >> The previous logic was wrong such that the ksz87xx
> >> switch was not identified correctly.
> > 
> > Any more details of what is happening? Which extact device do you see
> > this problem on?
> 
> I have a ksz8795 switch.
> 
> Without the patch:
> 
> ksz8795-switch spi3.1 ade1 (uninitialized): PHY [dsa-0.1:03] driver [Generic PHY]
> ksz8795-switch spi3.1 ade2 (uninitialized): PHY [dsa-0.1:04] driver [Generic PHY]
> 
> With the patch:
> 
> ksz8795-switch spi3.1 ade1 (uninitialized): PHY [dsa-0.1:03] driver [Micrel KSZ87XX Switch]
> ksz8795-switch spi3.1 ade2 (uninitialized): PHY [dsa-0.1:04] driver [Micrel KSZ87XX Switch]
[...]

And do the external ports work for you after this?

I have a development board with a KSZ8795.  All ports worked before
this patch.  After this patch, when I bring up the external ports they
are reported as having link up at 10M half duplex, when the link is
actually down.

The ksz8873mll_read_status() function is trying to read a non-standard
MDIO register that is not handled by the ksz8795 driver's MDIO
emulation (and is not documented as existing on the KSZ8873MLL,
either!).  It also also reports link up, which is obviously not
correct for an external port.

I'll post a patch as a reply to this.

Ben.

-- 
Ben Hutchings · Senior Embedded Software Engineer, Essensium-Mind · mind.be
