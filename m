Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35536C02F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbhD0Hfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhD0Hfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:35:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6683AC061574;
        Tue, 27 Apr 2021 00:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ynYUvvQwtKFpeyU2i90AFKHXQPnWabFPz7ALlFpC2Rg=; b=RHD6kIiQUOJhtpS41HTKXNsgX9
        f1iTwRdlVGanGWtBuCW1CgmU/Ru6npRFtxlYb76xSVUnvpeeuD6MDODKSm8IIejpOvdNdTA7njuwL
        BHczjj9tpNkvMPmVnlF0OrckiuiBeMKs2yZix/1+cvwDnxTMFRXhcPjpxQQ/rdG4POjF3uEweH+QJ
        fV/7oJCwmmFBOuWMPTUCOPDdfE5IOEZ9jWiDfhSAHU+gOju+qp5sFsuI9BFVKNQVQ27Tv2oniO6NM
        ycFekqHM37CPDSVheif9KmRAr4+1Qj/zzUdXLt9w1h7TwAt0MbcuEpaZGw5sn6tE1ma1zV4iDpFWu
        WEhN+M8g==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbIF1-006d6N-9U; Tue, 27 Apr 2021 07:34:47 +0000
Subject: Re: [resend v1,1/1] adv_mix955x is a scheme that multiplexes
 PCA9554/PCA9555 into LED and GPIO
To:     =?UTF-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>,
        "345351830@qq.com" <345351830@qq.com>
Cc:     =?UTF-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>,
        =?UTF-8?B?eXVueGlhLmxpKOadjuS6kemcnik=?= 
        <yunxia.li@advantech.com.cn>,
        =?UTF-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <d368a617c11446f2baff6c9cb06b24e4@ACNMB2.ACN.ADVANTECH.CORP>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ccf562f-f73d-7193-dd9b-551dd4a29201@infradead.org>
Date:   Tue, 27 Apr 2021 00:34:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <d368a617c11446f2baff6c9cb06b24e4@ACNMB2.ACN.ADVANTECH.CORP>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/27/21 12:17 AM, yuechao.zhao(ÕÔÔ½³¬) wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d92f85ca831d..3871c0d3bc6a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9210,6 +9210,12 @@ S:	Maintained
>  F:	arch/x86/include/asm/intel_telemetry.h
>  F:	drivers/platform/x86/intel_telemetry*
>  
> +ADVANTECH MIX995X DRIVER
> +M:	Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> +M:	Sui Jia <jia.sui@advantech.com.cn>
> +S:	Maintained
> +F:	drivers/platform/x86/adv_mix955x.c
> +

This new entry is way out of place. This file is supposed to be kept in
alphabetical order by the first line ("title"), that being
ADVANTECH MIX995X DRIVER

>  INTEL UNCORE FREQUENCY CONTROL
>  M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>  L:	platform-driver-x86@vger.kernel.org


thanks.
-- 
~Randy

