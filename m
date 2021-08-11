Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C873E9505
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhHKPuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:50:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32970 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232946AbhHKPuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:50:15 -0400
Received: from zn.tnic (p200300ec2f0d7c00c5d666a347f4c0f8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7c00:c5d6:66a3:47f4:c0f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 660481EC04F0;
        Wed, 11 Aug 2021 17:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628696986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Zbc1Agl3LGZzQ4c2hBGGXpqbK9OXFObDT/acgb1b9io=;
        b=ThTDol6a0ayPm9FRQkd+ti/dDUFLYNzu9/RqRxQPZbJTNplW2qqZV6UyMsKNB4XPspWxRy
        s1HJH1mLvFt7UfeuqB+9AgyQoZJCLp2Kp3Wae8gmCLGiLSV/xRAOoCyIQQyD7au1kVKtLL
        OUzIj1Tc90fl2FbRMWSebt0L4gLhYvM=
Date:   Wed, 11 Aug 2021 17:50:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH v7 16/24] x86/resctrl: Add a helper to read a closid's
 configuration
Message-ID: <YRPxwC99/jjZE8pO@zn.tnic>
References: <20210728170637.25610-1-james.morse@arm.com>
 <20210728170637.25610-17-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210728170637.25610-17-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 05:06:29PM +0000, James Morse wrote:
> +void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
> +			     u32 closid, u32 *value)
> +{
> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +
> +	if (!is_mba_sc(r))
> +		*value = hw_dom->ctrl_val[closid];
> +	else
> +		*value = hw_dom->mbps_val[closid];

I don't like functions which are of void type but which still return a
value through an arg pointer. Please send a cleanup ontop of the whole
set converting it to return u32 as the mbps value instead.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
