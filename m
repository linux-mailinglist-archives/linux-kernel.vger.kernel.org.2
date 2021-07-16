Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002563CB7C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhGPNUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhGPNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:20:04 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7DDC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:17:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id p67so10862320oig.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gS9kOJpcGK76eRo5Aofr06uYyb4BuGzYuKkE7nL44x8=;
        b=GrYNadcR5amCn2iDHt4hMO2O2LQIQzTsyizX7WVUE9JxK3q7CCJNaimFjmWm10aBwj
         WVSUXw/xBLVkWh7fNyh8PHc74VAYtjeMna7Dm0NdlClt8x0vFU7u7ydFA/lzjmQ3UYYt
         BPotPlxKSql8X2+bKqRqVE9zlfM/wF7hX8O7BX/XyMxsGFrdAC2nNjCigRJBNXCq7agO
         0ro8a/61pJCVPZNZ2IbpVNS8BN3KyHWJHjNu1YEGIlxDlv/hmHG/nh+ldkrjcCpmBhb5
         ySMyCdQegMuFWjFljwohdZVvr5kngrY0h7nINLfiusJjvrg+2bz16C7SF5gHrWRKDpBA
         UOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gS9kOJpcGK76eRo5Aofr06uYyb4BuGzYuKkE7nL44x8=;
        b=FnhqRlx7vy5zSplzGjDcDRj4cckcWpxi6WtgC67ICIaa98AqjJX11Y9AU9c4awMnyC
         Ux0EEib1UIV49r+VYeGpiUFGUjNsv0vlCyMyiT4WrJAuejlPwIofiv5nDpgzLc4K5SMK
         g2TT/MJISZABTLwDKisvT+YffvWc7aSgm6dxCvt8IidERXHLK8OX2I7WoUBUgDqhyskJ
         fGt+HX2rYBekWIatHlA8aubauu8HmFmyaRSRgPDBMqLgeJ01uzeV4ch+avghv7HzjLAH
         6ZFQzFRolyBcAlEyAFtGe8g7zv6xnoanwsGUO4TBOOCUjO3hsgCIiN8VU0IYFrOUPSq0
         GNTA==
X-Gm-Message-State: AOAM531L4jFeqz/vPXTZtLCnLgq3tfbf3Bu7lqHBuV6UK0cmBUEaQrvj
        Ff+1ryhFYnsgVinPcroqPPJS0w==
X-Google-Smtp-Source: ABdhPJyCnbfm9K3k3TkPCw3E0oHuQpDTPd9rqx/ncyn2f8DYEnq9d+jlXtztU1J0SjkpBvc9pLN8Ig==
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr12079068oig.58.1626441429627;
        Fri, 16 Jul 2021 06:17:09 -0700 (PDT)
Received: from ?IPv6:2607:fb90:e658:f352:6680:99ff:fe6f:cb54? ([2607:fb90:e658:f352:6680:99ff:fe6f:cb54])
        by smtp.gmail.com with ESMTPSA id a7sm612997oti.47.2021.07.16.06.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 06:17:08 -0700 (PDT)
Subject: Re: [PATCH] mtd: fix size in mtd_info_user to support 64-bit
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     richard@nod.at, vigneshr@ti.com, David.Woodhouse@intel.com,
        Artem.Bityutskiy@nokia.com, ext-adrian.hunter@nokia.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linfeilong@huawei.com
References: <20210708131359.21591-1-linmiaohe@huawei.com>
 <20210716010224.44582046@xps13>
 <95e3d455-ccb1-0e22-ee83-78dc6ad8aab1@huawei.com>
 <20210716114808.246e92ba@xps13>
From:   Rob Landley <rob@landley.net>
Message-ID: <f7f55c5e-f6b2-542c-66d2-20f4d88bf669@landley.net>
Date:   Fri, 16 Jul 2021 08:34:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716114808.246e92ba@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/21 4:48 AM, Miquel Raynal wrote:
> Hi Miaohe,
> 
> Miaohe Lin <linmiaohe@huawei.com> wrote on Fri, 16 Jul 2021 09:42:19
> +0800:
> 
>> On 2021/7/16 7:02, Miquel Raynal wrote:
>> > Hi Miaohe,
>> > 
>> > Miaohe Lin <linmiaohe@huawei.com> wrote on Thu, 8 Jul 2021 21:13:59
>> > +0800:
>> >   
>> >> From: Feilong Lin <linfeilong@huawei.com>
>> >>
>> >> The size in struct mtd_info_user is 32-bit, which will cause errors
>> >> when obtaining the size of large-capacity MTD devices, such as TLC
>> >> NAND FLASH-2048Gb.  
>> > 
>> > Besides the fact that such devices are far from being supported by the
>> > Linux kernel, this change would basically break userspace, it cannot
>> > enter as-is...
>> >   
>> 
>> I see. Many thanks for your reply! We're working with these large-capacity
>> MTD devices now, any suggestion to work around this?
> 
> The only way is to create a second UAPI.

Twelve years ago a patch was submitted to add a 64 bit MTD api:

  https://lwn.net/Articles/326418/

But for some reason they only merged 64 bit erase:

  https://github.com/torvalds/linux/commit/0dc54e9f33e2

But NOT the rest of the 64 bit mtd API in the same patch. I've never understood why.

Rob
