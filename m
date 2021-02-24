Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D7232406C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhBXPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhBXOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:04:58 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1506AC061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FKo27kP6bPoTFaEgNUhT3kOhszGvSDXkiGvKHnLVuc4=; b=v88BLMp8Jlv/IhPa0X6p6VPq/
        iKsgGbnhHi3O5dmWqDdE8DnAzITrnXxTLp38at5EWC5cV1s9AkLODNcoVUSMHAtON2JrEP5nxozhx
        pBW9ThJ+07++O5wqpXsFhDPy36Sf6JIEoxvn3e0rjcWQgA6rYfdGUIgmoWd8icvwNBVlYBXykGaem
        UCDdMcfOjSlivEo/CA2tXZgMrYjejVsjNOyoxuZnDlpqGDO2RdeQyY3zDWral1voZ404FL4gI4MeF
        tUmuL2Qfr/Wf8WcgWfTgJJuuu8bKQAjx5eLoWMdpB6wIPybw+oN0+6EW9eIStAcaUhdFVSl7Fgwuz
        NM9TLTFwQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46656)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lEulb-00005z-Dn; Wed, 24 Feb 2021 14:03:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lEulX-00042p-Ej; Wed, 24 Feb 2021 14:03:47 +0000
Date:   Wed, 24 Feb 2021 14:03:47 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Vaneet Narang <v.narang@samsung.com>
Subject: Re: [PATCH 1/1] arm: print alloc free paths for address in registers
Message-ID: <20210224140347.GS1463@shell.armlinux.org.uk>
References: <CGME20210224123759epcas5p1c1143b69537467c5135283d590c89bf7@epcas5p1.samsung.com>
 <1614170254-3207-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614170254-3207-1-git-send-email-maninder1.s@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 06:07:34PM +0530, Maninder Singh wrote:
> +bool slab_page_object(unsigned long address, void **object, struct kmem_cache **cache)
> +{
> +	void *addr = (void *)address;
> +	struct page *page;
> +
> +	if ((addr >= (void *)PAGE_OFFSET) &&
> +			(addr < high_memory)) {
> +		page = virt_to_head_page(addr);

This check is not sufficient. There can be holes in the page array.
You need to use virt_addr_valid() to validate "addr".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
