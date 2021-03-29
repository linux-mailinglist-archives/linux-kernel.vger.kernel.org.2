Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447B834D846
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC2TbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhC2Tas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:30:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3787C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:30:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e14so4899159plj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=obZ+GpJjqBDtqxvYFyMbZyPSIXXyagLFH5qtJ8HsExQ=;
        b=HHhQPWAK96gQvI6JJPOnIFVc/FznBCpCUgJanyhV1/94rYU1ByXo2ua2XSsY0qQgmp
         KIaZTSyo5SuA6seJ5a/O7TcMaCc8Ha00PbefwymFFN6Bh4SozydEAVhqPLhRmlGm00ka
         lScMH+FJN19u14o2jaisyvXsm3zBEVeZY+xULE8uu7a5h6oH+HAG77+RU3KPPteH9R6B
         WYiKhCcxB/ecADLL2AoxhTy/NQbZ1fI6E7lpLVdSZ9SlfLS0OYYmiVb21b6R9Bvt3FBZ
         41HDs14NdrUmwSNuMRWHhJisDMdHRjsyzIaX26cb0dW7YCSZj0e5a/nwIBZO9C/Xvcjp
         DOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=obZ+GpJjqBDtqxvYFyMbZyPSIXXyagLFH5qtJ8HsExQ=;
        b=SvahDJZeZmqos8Ab1ilm/o8AxkkY2PRgXEzT62NxIHeXc9BcBrP2JAfZjEVcDCTRr+
         J9+QoAfPS7/L8X291UM8WNyYPFXJTBMiVbDWuJydwo5A4c3e1mTSPnX+iBLZ2TuCd/CT
         QE+kU+C6+72hw9hRvBO90oWUcAWqxqdXio6eBKs5NFr3EXxTR3mg8/KqGj+bilI4KExm
         P8qqci3JpeBq5UVP1H6IHzRsBYU0hCKYqHsX0BOVnJaUnnRpWAzJwFYsyRP+YX8+FHHu
         8nudM1KG5JttbyxxOrRRdurRVd3U/BhrWf5JRH6BZwhFpILGdFS0sU9wg5amgUB8/WJa
         jx9g==
X-Gm-Message-State: AOAM530d332JGiewfMrMStFCTE3hsoiqXfr3NJ55r5UmIQ+7awOnkIQn
        xBGtNuXL/g/bmUh7QKo4RRF3OV3VeWI=
X-Google-Smtp-Source: ABdhPJxy4vuS0N+tsZKwReXwZHG1+vd1B7r82n2+XtMrMVGst8TxZghuZ5z5ETykyH/7joqAlbYfUA==
X-Received: by 2002:a17:90b:10a:: with SMTP id p10mr668776pjz.148.1617046248127;
        Mon, 29 Mar 2021 12:30:48 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t19sm18375620pfg.38.2021.03.29.12.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:30:47 -0700 (PDT)
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, xen-devel@lists.xensource.com,
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3db926f4-6047-cc62-8654-a965b8570e75@gmail.com>
Date:   Mon, 29 Mar 2021 12:30:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2103191718210.439@sstabellini-ThinkPad-T480s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 5:22 PM, Stefano Stabellini wrote:
> On Fri, 19 Mar 2021, Konrad Rzeszutek Wilk wrote:
>> On Fri, Mar 19, 2021 at 02:07:31PM +0100, Christoph Hellwig wrote:
>>> On Thu, Mar 18, 2021 at 09:03:33PM -0700, Florian Fainelli wrote:
>>>>  #ifdef CONFIG_ARM_LPAE
>>>> +	if (swiotlb_force == SWIOTLB_FORCE ||
>>>> +	    max_pfn > arm_dma_pfn_limit)
>>>
>>> Does arm_dma_pfn_limit do the right thing even with the weirdest
>>> remapping ranges?  Maybe a commen here would be useful.
>>>
>>>> +		swiotlb_init(1);
>>>> +	else
>>>> +		swiotlb_force = SWIOTLB_NO_FORCE;
>>>
>>> Konrad: what do you think of setting swiotlb_force to SWIOTLB_NO_FORCE
>>> and only switching it to SWIOTLB_NORMAL when swiotlb_init* is called?
>>> That kind makes more sense than forcing the callers to do it.
>>>
>>> While we're at it, I think swiotlb_force should probably be renamed to
>>> swiotlb_mode or somethng like that.
>>
>> swiotlb_mode sounds good.
>>
>> Also it got me thinking - ARM on Xen at some point was a bit strange, so not sure how
>> the logic works here, Stefano?
> 
> There is nothing strange in regards to swiotlb_force. swiotlb_force is only used
> in swiotlb-xen map_page to figure out whether:
> 
> - we actually have to use the swiotlb bounce buffer (this is the
>   swiotlb_xen == SWIOTLB_FORCE case)
> - or we can use the provided page directly for dma if other conditions
>   are met (dma_capable, !range_straddles_page_boundary, ...)
> 
> 
> I don't think that switching to "swiotlb_mode" would cause any issues.
> 

Should I toss this in Russell's patch tracker or do you need me to make
some changes to the patch?
-- 
Florian
