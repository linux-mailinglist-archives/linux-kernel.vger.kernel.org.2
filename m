Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED823BDBB6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhGFQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:57:01 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47415 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhGFQ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:56:59 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 11D4D5804F6;
        Tue,  6 Jul 2021 12:54:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Jul 2021 12:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=8
        rd+SESy7RfCY2bCQq2bIfiW/IwT2QHexSr7RrznIFs=; b=n3wVvPaMFKv4Nq5El
        EbFFJcWIZM6/o5r6Nd3hgr0Hl3aQVlDKmMGB8ktqBkt3JOnCAEXcxNil5bCZ8hEf
        hHxef2ZEGe1aqROYnlQODs8BADU4Yql33Nr+GFy4gqHvinnKWjvZ20YuSUc9/Dm8
        /UUU/lzfTRKCx3T9UBLUwS50FkN9jeZ9hl+26pyqukOTj4TAXNVtm+2KzVlLLWqw
        w3Oz+NOXw+Ij1OoUDatcnR5WZ18NtuDgsGy9dFQWSz3ZjzgXfMasvSWqFzgw3s0A
        /1H+YNv6Q+ur9cpVIxYmaPqwzKkh/qkFqxyWv9WEVOVL/P7zO7t4JwTDzIWTQI/D
        3zr4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=8rd+SESy7RfCY2bCQq2bIfiW/IwT2QHexSr7RrznI
        Fs=; b=Qblnt3o9k4fX6l1pWq9pWpk01zwpn7tg0S9w11Gi+fuklm3my51RJr4ov
        GMeADGmX91G5Ud/Yj79dxB50HXxo5u6XuPQ757AG+9pLoswhNYdt49qGCeGNheu6
        dQTtOcKPCJablYgHK2rCIczuxPPva/qmWMOUysTSpH6RYfMaBrgrWABgb3vosL3d
        tMegcqM/kSkZxl7770kROFTX8WA1G4KfACyXwDbfdY+UV2rS0CnXCsTDgGH93k5V
        d9rfzm1MTizKAgRYbADX9OJFGoDyWG72jNHwpYcuySkKOAy39TOZpHWpVH+DwR0g
        spyLOQ+1rt1WsPB5lSgtMBXfVY5fg==
X-ME-Sender: <xms:u4rkYHWXhYQFYp4kde_QvwaMTmM5KBCljjZHF7rp7FH6L0UCfVWFSw>
    <xme:u4rkYPm2xtDaLy__HBPgVoXcaUX92GKE2C0uLGGaAJsLrjQPdt6Ly4MPCki7OTjtv
    IWqSrh3l3IQlw>
X-ME-Received: <xmr:u4rkYDb26_-yBWdYAtL4n5Ttxc8gvG7ui_mq52jVTpQA5bHkdEuwtBaUfI29K1t2UIDmCpu6qPO-tRDONVTC2cJ9ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddtgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmrhhorghh
    qdfjrghrthhmrghnuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrh
    hnpefhhedtueelheffgfekvdehvedtuddviedvtdelieejjeelheeuffeuieetjedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgh
    eskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:u4rkYCXFVwmQOvIQcOdHfUnnAMWOwzyf1UDrx_zMSREMCZojv-egvA>
    <xmx:u4rkYBnz3eVrvwje_GgW1c8LMlL6K9AP0cMwTwaDkX7uGX_LRIW-0w>
    <xmx:u4rkYPeT25HeZ8Kg7pYknu_WaqHhcoDDxS_0tbCiyjU6J6yPwBRaBA>
    <xmx:vIrkYG_0OqiaXq62z_PvfkcCOd7EF3VvwZMqlNW9TEqFhRE8NZvWBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jul 2021 12:54:18 -0400 (EDT)
Date:   Tue, 6 Jul 2021 18:54:16 +0200
From:   Kroah-Hartman <greg@kroah.com>
To:     Norbert Manthey <nmanthey@amazon.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Coverity Scan model file, license, public access
Message-ID: <YOSKuEcPoy/dw0st@kroah.com>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 09:45:47AM +0200, Norbert Manthey wrote:
> Dear all,
> 
> I would like to work with code analysis on the Linux kernel. The
> currently used Coverity setup already uses a model file [1] to improve
> the precision of the analysis. To the best of my knowledge, this model
> file is currently not publicly accessible. I did not find a license
> attached to  [1], nor any information about licensing.

I have no idea who wrote that thing, sorry.

> To improve the way Coverity is used, I would like to move this model
> file into a public repository, and add a license. I wonder whom else I
> should involve into this process. Is there a recommended place for the
> location of the license? I assume the targeted license should be GPL,
> and would like to understand whether that works with the way this file
> is currently maintained.

How is adding this file anywhere going to help?  Coverity is a closed
source tool that a few of us are "lucky" to be able to use, and even
then, it's tightly restricted what we can do with it.  The only real
users that this could benefit is anyone who is paying for the tool, and
if they are doing that, they are not allowed to share the results of the
output with anyone else (as per the license of the tool).  So unless you
are going to be doing this work on your own, with a paid copy of the
tool, who will use it?

thanks,

greg k-h
