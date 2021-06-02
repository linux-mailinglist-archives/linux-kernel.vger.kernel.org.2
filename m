Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C74C3986CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFBKqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBKqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:46:40 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qYu8Ts1bocEFsnGvP/afFPXEZr07RjH9FpTtWVZLYEs=; b=ylvDKbIwGwezg3/kif1P+zkXT
        arbiVveeV4MTPzepIHP5eN1vpmGE/3kVkP9abSNWv0nRziMtsYzilaj/6KoET09rVXJccLBtyESld
        YjzREIbdyzzwmozLeLEyQM9oUS2NecNlX3hpH5AVn8SVs1fHF4nOqBWpjQ/DBT7sXs3gK8sNUfX6z
        jbp5ckdNvMJodF9TVyHY7Jb/fOzADM311QKdsuK6hVjmYVjJ3RbvsYA9p6wA7C2NSrdmYF5EQrxYA
        zV7q8Mr7iZD9WqpOVy/vxKirhCRXFjpJYAeDd0ojW+uGHOwI8TpxLxaZjCL0pH9JiF2lGeOv5lPoT
        UTVZEnEVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44616)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loOMn-000120-50; Wed, 02 Jun 2021 11:44:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loOMk-00013t-I7; Wed, 02 Jun 2021 11:44:50 +0100
Date:   Wed, 2 Jun 2021 11:44:50 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH v2 4/7] ARM: mm: print out correct page table entries
Message-ID: <20210602104450.GH30436@shell.armlinux.org.uk>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602070246.83990-5-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:02:43PM +0800, Kefeng Wang wrote:
> Like commit 67ce16ec15ce ("arm64: mm: print out correct page table entries")
> does, drop the struct mm_struct argument of show_pte(), print the tables
> based on the faulting address.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

This can be misleading on 32-bit ARM.

The effective page tables for each thread are the threads *own* page
tables. There is no hardware magic for addresses above PAGE_OFFSET being
directed to the init_mm page tables.

So, when we hit a fault in kernel space, we need to be printing the
currently in-use page tables associated with the running thread.

Hence:

>  /*
> - * This is useful to dump out the page tables associated with
> - * 'addr' in mm 'mm'.
> + * Dump out the page tables associated with 'addr' in the currently active mm
>   */
> -void show_pte(const char *lvl, struct mm_struct *mm, unsigned long addr)
> +void show_pte(const char *lvl, unsigned long addr)
>  {
>  	pgd_t *pgd;
> -
> -	if (!mm)
> +	struct mm_struct *mm;
> +
> +	if (addr < TASK_SIZE) {
> +		mm = current->active_mm;
> +		if (mm == &init_mm) {
> +			printk("%s[%08lx] user address but active_mm is swapper\n",
> +				lvl, addr);
> +			return;
> +		}
> +	} else {
>  		mm = &init_mm;
> +	}

is incorrect here.

It's completely fine for architectures where kernel accesses always go
to the init_mm page tables, but for 32-bit ARM that is not the case.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
