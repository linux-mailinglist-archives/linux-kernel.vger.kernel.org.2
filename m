Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20B4000FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbhICOG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhICOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:06:56 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291BC061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 07:05:56 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j15so5328662ila.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgwrXJbGZw7LvqCtZ3SUKKuQrirCjvwKHoEkBgKAZaU=;
        b=sXrYf6ZM3c1JtQU/3qv/sJb1LUKy8mMGlGmQeonO7HS0NJj0acwq/UI25oqmDf58n4
         qqRtijFCHOMLwxe7o0aX434rsvKmUvLjOVufuM4CIU65JkY4dnAuVVh/yUuOFA53K7as
         wrmNbmyXbO48oXrm76jzfnEZTD5R96EUUtddyr5whSb6BCPQErXw2ZiT+9UcHDVqQ3Ym
         gl/7ldYNQ6tVd3gJ2X7QEyDRT6UoUVKtl7N/qvq4ceQZW+x+bHXnD0ql8A3oUwIK6DWQ
         MoRMRl2q4s/hwXjdjwk8R7yNN+ok+ntw32Sc2qtIKJSktRPkhB4Ggoa2lK+HxkUEf5PR
         fgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgwrXJbGZw7LvqCtZ3SUKKuQrirCjvwKHoEkBgKAZaU=;
        b=dr7HLUutekQgIOvnxwCqa3AcYxMcmDrggv10x31T6YoeFv1zrTvFxtB3FKmd9ycWMH
         JP3k5AWmQdxKosiwmcyVD8iTij5l1dr6f16pBbbmIU5cUDCnFIaP3xavmcyOt71fjGm3
         Wt45Sf5Q1C4CKEF8pZMtACp3Z6VRNK9asOvmOSOpDWWYJK0aOU29KTQB48+nLEZeeBhG
         2OxsX64Tbly+jCnxPs4w04B0DVXsqFLyGkceJ/Ui4UhlRCks0dhxttPWjhokuRHMNRbH
         wTlEtHs7LDa5eMoKtBy8jRdF6FdKUcVoBSRp7lrhJwZnSObbLqko3JmDovzPehY0tvt2
         c5AA==
X-Gm-Message-State: AOAM531IzJxSqKPeRG2rb8TqSk9Lf9RGpY2kCfmxIEarpsT6bA8o9EsO
        5mUIOypnuANRPqauBToJsr/aG3glkmgmpg==
X-Google-Smtp-Source: ABdhPJwvWaYxLtiQdTjFxqxZ0hGQBViYTZVn6oVs+J+gayqWtyQsVVSB1BUnidGmWIMevchMp6TatQ==
X-Received: by 2002:a05:6e02:1d06:: with SMTP id i6mr2758385ila.113.1630677955708;
        Fri, 03 Sep 2021 07:05:55 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o2sm2674640ilg.47.2021.09.03.07.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 07:05:55 -0700 (PDT)
Subject: Re: [PATCH v6] libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung 860
 and 870 SSD.
To:     Hans de Goede <hdegoede@redhat.com>, Kate Hsuan <hpa@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210903094411.58749-1-hpa@redhat.com>
 <d3488035-d269-2a63-f958-746f371cf490@kernel.dk>
 <f1f0b799-6676-ae06-6a71-05dfeeab8512@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb497516-a2f9-9ebf-a9c6-70aa3ce52940@kernel.dk>
Date:   Fri, 3 Sep 2021 08:05:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f1f0b799-6676-ae06-6a71-05dfeeab8512@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 8:03 AM, Hans de Goede wrote:
> Hi,
> 
> On 9/3/21 2:35 PM, Jens Axboe wrote:
>> On 9/3/21 3:44 AM, Kate Hsuan wrote:
>>> Many users are reporting that the Samsung 860 and 870 SSD are having
>>> various issues when combined with AMD/ATI (vendor ID 0x1002)  SATA
>>> controllers and only completely disabling NCQ helps to avoid these
>>> issues.
>>>
>>> Always disabling NCQ for Samsung 860/870 SSDs regardless of the host
>>> SATA adapter vendor will cause I/O performance degradation with well
>>> behaved adapters. To limit the performance impact to ATI adapters,
>>> introduce the ATA_HORKAGE_NO_NCQ_ON_ATI flag to force disable NCQ
>>> only for these adapters.
>>>
>>> Also, two libata.force parameters (noncqati and ncqati) are introduced
>>> to disable and enable the NCQ for the system which equipped with ATI
>>> SATA adapter and Samsung 860 and 870 SSDs. The user can determine NCQ
>>> function to be enabled or disabled according to the demand.
>>>
>>> After verifying the chipset from the user reports, the issue appears
>>> on AMD/ATI SB7x0/SB8x0/SB9x0 SATA Controllers and does not appear on
>>> recent AMD SATA adapters. The vendor ID of ATI should be 0x1002.
>>> Therefore, ATA_HORKAGE_NO_NCQ_ON_AMD was modified to
>>> ATA_HORKAGE_NO_NCQ_ON_ATI.
>>
>> What's this patch against?
> 
> linux-block/for-next + my pre-cursor patch from here:
> 
> https://lore.kernel.org/linux-ide/20210823095220.30157-1-hdegoede@redhat.com/T/#u

Still had to fixup a hunk, but it was trivial. In any case, I've applied
both now, thanks!

-- 
Jens Axboe

