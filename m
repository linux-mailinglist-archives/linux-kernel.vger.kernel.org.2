Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB042839E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 22:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhJJUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbhJJUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 16:55:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C025C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=dY+e0+GivX+BFolWbrBQUWXwzOA/TgaPNehM3ikoutE=; b=Hv8ff7DNG/OdsjKQdgUibJUTRd
        VM1Ad+5Wctr9hbkanBq9fCw+PyMdPWflX8K9+Tj9ds3A2QhnSitDOnPYJY9QrkQkiYmA/NMbVFVHt
        Rbj3UcYV+BH5KeRBktPHxanptklkSXx3kWdeXX2KP835PsgSwuug7EhMQ03WPV6GYZh4n3e4gY2Gp
        LUul+ceQ0Ce5BrTvqzo0lxVYwz8oVUnrJb6kivjGjS1/fPmIXytCmh2vQSXZoa+oQ928EBHaubf8U
        qcTBFU2cmI9kVXFCUtXnvMb8BVWJCA+x6Z03FYFecs1sFEjKRekEfF50vEH/Cnc8hwXwy/ciz4bHo
        FQBbMCLg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZfoz-007MZk-Jb; Sun, 10 Oct 2021 20:53:25 +0000
Subject: Re: [PATCH v2] drm/r128: fix build for UML
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
References: <20211010172955.30088-1-rdunlap@infradead.org>
 <YWND2QZTZRB92XHX@ravnborg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30fa4926-6054-40ab-74c5-2a1f641966be@infradead.org>
Date:   Sun, 10 Oct 2021 13:53:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWND2QZTZRB92XHX@ravnborg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 12:49 PM, Sam Ravnborg wrote:
> Hi Randy,
> 
> On Sun, Oct 10, 2021 at 10:29:55AM -0700, Randy Dunlap wrote:
>> Fix a build error on CONFIG_UML, which does not support (provide)
>> wbinvd(). UML can use the generic mb() instead.
>>
>> ../drivers/gpu/drm/r128/ati_pcigart.c: In function ‘drm_ati_pcigart_init’:
>> ../drivers/gpu/drm/r128/ati_pcigart.c:218:2: error: implicit declaration of function ‘wbinvd’ [-Werror=implicit-function-declaration]
>>    wbinvd();
>>    ^~~~~~
>>
>> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: linux-um@lists.infradead.org
>> ---
>> v2: update Fixes: tag (thanks, Johannes)
>>
>>   drivers/gpu/drm/r128/ati_pcigart.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20211007.orig/drivers/gpu/drm/r128/ati_pcigart.c
>> +++ linux-next-20211007/drivers/gpu/drm/r128/ati_pcigart.c
>> @@ -215,7 +215,7 @@ int drm_ati_pcigart_init(struct drm_devi
>>   	}
>>   	ret = 0;
>>   
>> -#if defined(__i386__) || defined(__x86_64__)
>> +#if (defined(__i386__) || defined(__x86_64__)) && !defined(CONFIG_UML)
>>   	wbinvd();
>>   #else
>>   	mb();
> 
> If we look at drivers/video/fbdev/i810/i810_main.h
> then it looks like we can replace the above with a simple:
> #ifdef CONFIG_X86
> 	wbinvd();
> #else
> 	mb();
> #endif
> 
> If you think this would work could you try it out.
> It would be nicer with the simpler variant.

Hi Sam,
Good idea, thanks.

OK, I tested it, it works fine.

Will resend the patch later...

> Note: I have no clue what wbinvd() does - seems like some x86 assembler
> specific thingy.


-- 
~Randy
