Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE253986E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhFBKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhFBKtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:49:36 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CDDC06138E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yoH2LiBrhNQoxKYBVg4LIMYjTL8KWNG9mNtpWnGT4C8=; b=v0Lr8E7Qy6jOfQvVwyTaoE8E0
        m28MgInAnW/jHUeyRkOf6TDGdVfjIJA4PvU/BimIXYzjr9Giax+RTRu/JR8WEyWfGoDMVBN+XIeR1
        JM7nGTEIHJfiqc6V3+78B7dP090GOMimDNmLakttFCsdDQQ6vsK2ckpYneM+MPf2CDoyb9vRdJ1X3
        50QPiQhCb7BpzMKP33+Ra+69bSEfcLtZo32dhGmA7ifwqmQlIwx5N7HcHUnyxzzL7XFSdlmmnmTky
        A6UVyVehku94AcekZKofJu7kWn5yAl0VkVyjvX7Joxfdrf3x3rLss/EDIIFcLs2rpKKmPMpJf/qup
        M/y8zDDcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44618)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loOPQ-00012W-Mk; Wed, 02 Jun 2021 11:47:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loOPP-000148-RJ; Wed, 02 Jun 2021 11:47:35 +0100
Date:   Wed, 2 Jun 2021 11:47:35 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH v2 5/7] ARM: mm: Print physical address of page table
 base in show_pte()
Message-ID: <20210602104735.GI30436@shell.armlinux.org.uk>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-6-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602070246.83990-6-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 02, 2021 at 03:02:44PM +0800, Kefeng Wang wrote:
> Now the show_pts() will dump the virtual (hashed) address of page
> table base, it is useless, let's print the page table base pointer
> as a physical address for debug.

I think we could probably get rid of this line - I think the last time
the PGD address was of use was a very long time ago.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
