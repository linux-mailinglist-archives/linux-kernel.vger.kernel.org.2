Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B804A3E49AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhHIQV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhHIQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:21:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94903C06179A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=eUQciBda9Y37TXzkfjlsG8pAQz1mayNlgBbkWTxZA0w=; b=WTl6NUjuxgbZdI6QWmlDG+pxh4
        sA1TsPcP6uXAy25IrF0S0q9zWflcV60HJn0pC/x1V3ODRa3KeMCfmIB/qvliyCof7P5k7yfinfr5R
        8cT50/VlC5D7CTQO8okTjRw7IDwZdSvlWBOJuawqOyO/f67ke1vYbL76i2KJsCbToicJo8Dxw61uc
        G5q238wTJlhDn9huasLfYJW6Gd1YjeFhtr1/bUU1nhIQTxdaFWfrZkiIno8IJL0xH+qvsxUaUOOp9
        wHrKJRfQ7gEOHmDuHRFdb4eNFBuDytt4gmQaeItyNyxhHyYHHgRMXdbJVHt6yK+ilcLQMA9vrfTRE
        3PLjhQjg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD80Y-00BAy5-DR; Mon, 09 Aug 2021 16:20:30 +0000
Subject: Re: Build regressions/improvements in v5.14-rc5
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <20210809075016.414276-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47e64acf-5537-bf5a-5a49-0a6897de17ff@infradead.org>
Date:   Mon, 9 Aug 2021 09:20:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809075016.414276-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 12:50 AM, Geert Uytterhoeven wrote:
> *** ERRORS ***
> 
> 13 error regressions:
>    + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'boot_cpu_has' [-Werror=implicit-function-declaration]:  => 74:6
>    + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'cpuid_eax' [-Werror=implicit-function-declaration]:  => 64:18
>    + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'cpuid_ebx' [-Werror=implicit-function-declaration]:  => 17:31
>    + /kisskb/src/drivers/pci/controller/vmd.c: error: 'X86_MSI_BASE_ADDRESS_HIGH' undeclared (first use in this function):  => 150:20
>    + /kisskb/src/drivers/pci/controller/vmd.c: error: 'X86_MSI_BASE_ADDRESS_LOW' undeclared (first use in this function):  => 151:35
>    + /kisskb/src/drivers/pci/controller/vmd.c: error: 'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no member named 'base_address':  => 151:19
>    + /kisskb/src/drivers/pci/controller/vmd.c: error: 'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no member named 'destid_0_7':  => 152:19
>    + /kisskb/src/drivers/pci/controller/vmd.c: error: control reaches end of non-void function [-Werror=return-type]:  => 127:1
>    + /kisskb/src/drivers/pci/controller/vmd.c: error: dereferencing pointer to incomplete type 'struct pci_sysdata':  => 700:4
>    + /kisskb/src/drivers/pci/controller/vmd.c: error: field 'sysdata' has incomplete type:  => 116:21
>    + /kisskb/src/include/linux/compiler_attributes.h: error: "__GCC4_has_attribute___no_sanitize_coverage__" is not defined [-Werror=undef]:  => 29:29
>    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1857' declared with attribute error: FIELD_PREP: value too large for the field:  => 328:38
>    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1864' declared with attribute error: FIELD_PREP: value too large for the field:  => 328:38

Hi Geert,
Would you tell me what arch & config these build errors are from?

thanks.
-- 
~Randy

