Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD9351FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhDAT2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbhDAT2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:28:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB59AC061225
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 12:11:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i6so2193208pgs.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOfInNzyAI5n5uuvyOU/R9wIOSoVssHANnSsxc40Tv0=;
        b=P4q0WGAaYPNzIS1QN5UUmz8y/nBzzUzx1osrwmAklYJAbmdWBPDi7NcJTPCw2pUfPb
         2LRLLWlFqBn8po5H6Bw2S6DhGIEjJFNL2ke755YcLkowpFnZCKOOCy2QwfQoHULoYbP9
         dmeXAJ6ttyVVMxGkeJPHmB7tnbDUEpziN7qfm+cQtV9eyPzJEzaiIH/WIyDFQ6y9JReX
         XbF6WEfDr5zzG3VmUVDxN24bnoqgupZqZqjJSDA2vEkTr52z+DIJzRgMndDU7YKNvlSg
         P9Jy4D9wApxjIB7EWfjBGTJD6w4cN+bX+GLsbeaIkjD7x9/IBurzXZ3UpDRr6MNThLKr
         GRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOfInNzyAI5n5uuvyOU/R9wIOSoVssHANnSsxc40Tv0=;
        b=HN5oEY/dHYNftVSRwifG0MaSskGPjqDRyEjjWqL9Ow1q79ZoVWqW4xSJSfRY0S4LY5
         tRg1MBSlrD1kyocrN1UyB1dR8OWg/GUFmnoOGRbVdW2cxGWrrTV+uvyhO7joJaKKnNub
         CFYd0luClAx7TIoO55S00tW644bVxB32DOfuArLL/DjkOj+7dDeL7PcSwmC0E3CptHsC
         3cwsd2hpTt5FWVijn1hzeJ+M/nifN+xEhiIpXqOgkoNAHX1HwnyOtyCAd8OiKKOFtTv8
         hAItJtbU2no8GaKg+Boyy14d+RmzQKqhPoXvMrKfVvsw/8DjuSNzqDD0wQyP/os7Cxem
         zWgw==
X-Gm-Message-State: AOAM530DTiELmIAUjwjY7ZrJun2sR4t5HfyKfyJ2icu81w7Rx9C86EpQ
        5cxUXwcSLI8TSapq8o2m6/M=
X-Google-Smtp-Source: ABdhPJx7UXDGtNgZqUZmzxM7QbPC+DD3Vbo36Tj6FNh5bPPsgp8IZ+Dmg8WbKqJ9Fmyyqo4cgsNKmA==
X-Received: by 2002:a63:dd14:: with SMTP id t20mr8795237pgg.258.1617304295360;
        Thu, 01 Apr 2021 12:11:35 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a8sm6151272pfk.138.2021.04.01.12.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 12:11:34 -0700 (PDT)
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xensource.com,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, opendmb@gmail.com
References: <20210319040333.183827-1-f.fainelli@gmail.com>
 <20210319130731.GB2624@lst.de>
 <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
 <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s>
 <3db926f4-6047-cc62-8654-a965b8570e75@gmail.com>
 <20210330053607.GA4863@lst.de> <YGYD40RbKN9r8I8n@Konrads-MacBook-Pro.local>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c3811249-8e34-499f-e3f3-ed84319bcffa@gmail.com>
Date:   Thu, 1 Apr 2021 12:11:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGYD40RbKN9r8I8n@Konrads-MacBook-Pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 10:33 AM, Konrad Rzeszutek Wilk wrote:
> On Tue, Mar 30, 2021 at 07:36:07AM +0200, Christoph Hellwig wrote:
>> On Mon, Mar 29, 2021 at 12:30:42PM -0700, Florian Fainelli wrote:
>>> Should I toss this in Russell's patch tracker or do you need me to make
>>> some changes to the patch?
>>
>> Due to all the other changes in this area I don't think anything but
>> the swiotlb tree makes much sense here.
> 
> I've put them all on 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
> devel/for-linus-5.13

Thanks! Did you also want to queue up this one:

https://lore.kernel.org/lkml/20210323015350.399493-1-f.fainelli@gmail.com/
-- 
Florian
