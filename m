Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B383338198C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhEOP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 11:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232442AbhEOP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 11:28:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99530611C9;
        Sat, 15 May 2021 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621092458;
        bh=TGvIi0NbFuAxdl24Teuj+pX3jFTEIClK6MZfrq6UzJs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D5GuGccLxVvrFL79QQBo3U94J+pQYAXlYNB/v+BWrvm1zJr1ogOgx+KvBtGzaqZRw
         rZj3IEtHnV8iOk8S1I9smS04pLbKZB/QeXPl1WyJFhkU7N/I/3QEEYaUzR6beiM0+t
         jkKeRXahgqSFsGlb4jx9em5OLMIrnGnNC6R2neWav68AFJzNV+noC3Efclm/uKDmpJ
         5tMC/ggE2vRT/O6L2grAtqpKjvLdiWAfql8puCemlRSJJkzc7INObkrICT/TZ7j/9I
         l03nWVgv+JXTnam8V7XrHAhShKqFu/7umFqQ20slz71OSGxp15j9b5rLGdWQlTdb/T
         oe1wXrPxC3phQ==
Subject: Re: [PATCH v2 4/9] x86/idt: remove address argument to
 idt_invalidate()
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210515014400.2999028-1-hpa@zytor.com>
 <20210515014400.2999028-5-hpa@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <bb26d2d3-71c7-5513-5d0f-580f9da09d88@kernel.org>
Date:   Sat, 15 May 2021 08:27:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515014400.2999028-5-hpa@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 6:43 PM, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> There is no reason to specify any specific address to
> idt_invalidate(). It looks mostly like an artifact of unifying code
> done differently by accident. The most "sensible" address to set here
> is a NULL pointer - virtual address zero, just as a visual marker.
> 
> This also makes it possible to mark the struct desc_ptr in
> idt_invalidate() as static const.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Acked-by: Andy Lutomirski <luto@kernel.org>

> -	idt_invalidate(phys_to_virt(0));
> +	idt_invalidate();

This hunk is an actual change, but I'm not sure it needs to be mentioned
in the changelog.
