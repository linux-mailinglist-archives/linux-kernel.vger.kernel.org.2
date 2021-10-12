Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8CC42ADA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhJLUNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhJLUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:13:00 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17633C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=1Gb/DWi57fzRHrYlHoB1x8a841FAYioHmYEN1p93abM=; b=o2CicTjqaWgesajCsp+E6/I06N
        dycc5a81JhexVFNcR7SLrLKb666qI51UwP6BRmZrov2mKY2jwjoejk9j9c1Opc5urgTsxy3nu0gNu
        8Zkaw/y2K1QUI6pu8jtg180iY69iFb0dbt+J4xR7Of7nD78xsYGo3vNTy3R0xh3FHfHh0XxgVvTY8
        H0TISLFxdkbcyGGfX1rIXRujecVHO5c9kyCWg8oDGFHT1nM7LMSfInUV+Q4yZzd+0jkHV1DPETMIV
        wkxfy/JdalrKmv986GjHhNi4suoP6VK8gzZrFePGD47FUQHrWLPoTRna5Zd4jcnjVoE/BIzfXvwIY
        WLUfmd6Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maO70-00DuAN-Fj; Tue, 12 Oct 2021 20:10:58 +0000
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Arnd Bergmann <arnd@arndb.de>,
        Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211011151443.12040-1-vegard.nossum@oracle.com>
 <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
 <47e60186-2408-19cf-3231-92bd9c30483a@oracle.com>
 <CAK8P3a2nai8xGQPPMH89rO83252trdRFM67s-mmivAXeDE0zfA@mail.gmail.com>
 <8b209292-5b94-5a14-dee0-2c152ac02a5d@oracle.com>
 <CAK8P3a1X38CHrCFDxsZq=TYJw9Q_uP7MrM8fG1_D4X3-F2yL2Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d02ef168-e105-27b6-0456-6db590807dcb@infradead.org>
Date:   Tue, 12 Oct 2021 13:10:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1X38CHrCFDxsZq=TYJw9Q_uP7MrM8fG1_D4X3-F2yL2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 11:44 PM, Arnd Bergmann wrote:
> On Tue, Oct 12, 2021 at 7:54 AM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>> On 10/11/21 9:37 PM, Arnd Bergmann wrote:
>>> On Mon, Oct 11, 2021 at 6:29 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
>>
>> Otherwise it's mostly CRC32 and a couple of odd ones like this that I've
>> seen so far:
>>
>> ERROR: modpost: "dell_privacy_has_mic_mute"
>> [drivers/platform/x86/dell/dell-laptop.ko] undefined!
> 
> I have a patch for this one that I should send out.

I sent a patch for that. Hans de Goede replaced with:
[PATCH] platform/x86: dell: Make DELL_WMI_PRIVACY depend on DELL_WMI

<20211011132338.407571-1-hdegoede@redhat.com>

so no need to send your patch.

>>    CC      drivers/scsi/aic7xxx/aic79xx_reg_print.o
>> gcc: error: drivers/scsi/aic7xxx/aic79xx_reg_print.c: No such file or
>> directory
>> gcc: fatal error: no input files
>> compilation terminated.
>> make[3]: *** [scripts/Makefile.build:271:
>> drivers/scsi/aic7xxx/aic79xx_reg_print.o] Error 1
> 
> I never saw this one, as I only build with CONFIG_COMPILE_TEST=y
> and CONFIG_PREVENT_FIRMWARE_BUILD=y. I think it's generally
> a good idea to force these two options, to avoid known problems
> and long compile times, but the aic7xxx error might be something
> worth fixing regardless.

thanks.
-- 
~Randy
