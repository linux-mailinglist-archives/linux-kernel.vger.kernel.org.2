Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3EC401BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhIFM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbhIFM64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:58:56 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEA6C0611C2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SpHVySU81J3sESD43nj/2jkGTDf8wGJk/uyN68gQocs=; b=c7+UTnfHxhUW3ngTlShTrj8dlv
        /ogCi1QcbOATu7jH+G2UTmC87GxeAZKc2wz9ucW4YmHEBqUfl6L/sjSS2EsSrAxoKAvRIVerTcU3b
        2ResgvY/rZew2LYVlqcyVumjb/6ISTPMownNAvp39fCDEzSKwz4T9rgLcoba54tvvv1/tpBrVbdFk
        5gYZ6fEOVb4dV6mMfFvinSBpxcg4ecKgvFPJ/iJtM7BITECXixo4mvTzTiNUzCk7tpGhl5SBOmhsm
        VsoNT8v2fHhcFOuRvdcKv7647GiE59FXlYiEAe3+2Hsq9scFV3z8kHa8M57E1qjk81VEOXrW8VQbz
        OKdDC12w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44978)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mNEBa-0001jY-Ed; Mon, 06 Sep 2021 13:57:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mNEBW-0003IF-13; Mon, 06 Sep 2021 13:57:14 +0100
Date:   Mon, 6 Sep 2021 13:57:14 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "pcc@google.com" <pcc@google.com>,
        "amit.kachhap@arm.com" <amit.kachhap@arm.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Vaneet Narang <v.narang@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
Subject: Re: [PATCH 1/1] exception/stackdepot: add irqentry section in case
 of STACKDEPOT
Message-ID: <YTYQKgKspSPORGH8@shell.armlinux.org.uk>
References: <1629270943-9304-1-git-send-email-maninder1.s@samsung.com>
 <CGME20210818071602epcas5p4fecf459638312c95c5d5aaa29e7e983a@epcms5p6>
 <20210906124351epcms5p6020fbfe5f885f1e8834a72784b28d434@epcms5p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906124351epcms5p6020fbfe5f885f1e8834a72784b28d434@epcms5p6>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 06:13:51PM +0530, Maninder Singh wrote:
> 
> Hi,
> 
> Any inputs on this?

No, I've not heard of stackdepot, I don't know what it is, or what
it does. It doesn't appear to be documented in Documentation - case
insensitive grep for "stackdepot" gets no hits. No help text on its
Kconfig option.

How are arch maintainers supposed to know anything about this?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
