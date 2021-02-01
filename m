Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC530A51D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhBAKM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhBAKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:11:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF4C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:10:48 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g10so15915806wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pVJj2fCNRWDjUKRwKtv4goRlFguknC7kv1PKeYxdDv0=;
        b=QpSF/puU9glqsBVwzcqqEmZ+yqtBGPHqZ4Wx3nKZSW0hDu5DzYxl8MFw2IAbz3QwU4
         ZRV0Q1yXyYh+KJHbYdonUwJ5UhccmdjM2/4fGWbMpfGUfT5xpVV0fKN01/emB1ZaGftc
         pRVwankpaNsK0b/YN482tYTe/VLH4zN3eSIkSQkvAtds3EEiBSwrNfeYLpfDRMnH9CkO
         oag9NCeb5dor7Vy7JFf+3iroi4KkoQT7zGEfUkM+MQpuKS25jhWmaFa6HFB8NP/vL1o4
         lxb4pRkykaEVegRAITjQpeMMEEpXkwUIJVcbe9yHrmVS4A+s7GEBMkCU0MDYGi/WLKnA
         fVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pVJj2fCNRWDjUKRwKtv4goRlFguknC7kv1PKeYxdDv0=;
        b=oY6qg5J29PzssJgfxKExTefLrB4FHwMjNzrrSsdo7BSXouaE8dzLZX8GYyf9+TQU33
         38rK86cuK8//5Y3G6OTQaMRZsDI1nq27nJwiUGw+nUO4gIG87IGIfeX46BIqcLDOWzbD
         Hm+6f2wQeYzXf0ksBMShZxv2Bmy2ULMbmgHldIX0BhT1rRrpy5gTnrS+wFbCk6n6UskN
         3zJHf8U7gX1ngwhlAPoQLKcHagNZXUwHJDvrt+2hulrChHA9jUpZHWT8HMGNu7Vmen08
         jOHCDFV+ibMHjAG2aTDwZK9Ma1siRqgUsqkaQACY2djF+lb8Mk/WNuDT0LO89EpU1rQ5
         V3NQ==
X-Gm-Message-State: AOAM530VfyR5xKNU/+JcS9++Qwo7CZ3EHWlKd0Cr8rDHfHx6KlC9SO9g
        XnZnb0xV9Ivalm4TRK2fMso=
X-Google-Smtp-Source: ABdhPJyUB5Ka00Ak9FmyIPy5DCcHp6v+/2ialUaMqLt+5D2jZXLZyrm6xe+A0qYitj8K6swxCuuxgw==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr17343321wrs.346.1612174247504;
        Mon, 01 Feb 2021 02:10:47 -0800 (PST)
Received: from p4 (net-93-70-85-165.cust.vodafonedsl.it. [93.70.85.165])
        by smtp.gmail.com with ESMTPSA id q4sm26762945wrg.22.2021.02.01.02.10.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 02:10:47 -0800 (PST)
Date:   Mon, 1 Feb 2021 10:10:43 +0000
From:   Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
To:     linux@armlinux.org.uk
Cc:     giancarlo.ferrari@nokia.com, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201101040.GC13349@p4>
References: <1610470147-22641-1-git-send-email-giancarlo.ferrari89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610470147-22641-1-git-send-email-giancarlo.ferrari89@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Jan 12, 2021 at 04:49:06PM +0000, Giancarlo Ferrari wrote:
> machine_kexec() need to set rw permission in text and rodata sections
> to assign some variables (e.g. kexec_start_address). To do that at
> the end (after flushing pdm in memory, inv D-Cache, etc.) it needs to
> invalidate TLB [section] entries.
> 
> If during the TLB invalidation an interrupt occours, which might cause
> a context switch, there is the risk to inject invalid TLBs, with ro
> permissions.
> 
> When trying to assign .text labels, this lead to the following issue:
> 
> "Unable to handle kernel paging request at virtual address <valid_addr>"
> 
> with FSR 0x80d.
> 
> Signed-off-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
> ---
>  arch/arm/kernel/machine_kexec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

has been re-submitted here:

https://lore.kernel.org/lkml/1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com/


GF
