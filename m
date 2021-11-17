Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213D6454B32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhKQQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhKQQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:44:19 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4035BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:41:21 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id i9so3183599qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yywXD1t0aKxa5O7/b7oQn7MA8G3McZTsPmhzcEBaaqY=;
        b=ExVQQkxA46esbKl0Hm+BQizqZLFLgXwgHcDCpivzEYhinRR3Mu7cDf780S5It4M/3v
         +CZhm9Znr0KiJLOH4tj9EKJMSdokR+4Ktslvk4Rv6iJRFeqEqAs/KBmd9/CGPtbK3Bv5
         S3wUXVxVwvEIRy6sQ79rOwxQ2XrjmwD46tbH1JGyxyn49LQ7wOz9FE+JCIGXWlhmM5qa
         3fyY7dxtHRug5kYGtlCG+oVoBye0jk35/LGd55nVSHrZzVZbG7HJxPSx2DkOxRL+sksP
         97sl6mjPVW7OMj0A67OtdhBzY5z/jZvyTvnzHFcW1AfgTxNmE/xI/FQHPfzWkbRM3i4G
         2qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yywXD1t0aKxa5O7/b7oQn7MA8G3McZTsPmhzcEBaaqY=;
        b=upiQr+pN1+uHlbtpIoZjfD3Y/tAUI9kNik+B/vPTaSKl7GrN0bSrZ7+TZl2BH2XW4o
         Q0zm8nWn+sE5lqK1DBgOHTBZ5k4GjuDpph40asqO4Dd6Jl1+2x6CXjKszJ6XmGH50EBX
         Cj+abMkvxzrNCNkPxpb5y/h9v2T4xDqceG+podeUWsmYS828qv/ddWPPZn5/tOsjt26w
         gKiesRQjI4JVS1zIxobppv7G3b6vtSKcsn/JAlzJTVKmM4j+xFp+SfLJcCu2htwAfhtN
         NLiVOfIWNSuSYELMG9VYzJYLnp99j2hvABSeaEJyEotaVTbxFFlaRud7dpDqhMYq+ZwR
         oW0w==
X-Gm-Message-State: AOAM532v08Yxu4gXJmvBDuxY43pZABlyAlroxZBeRsYcp8chpuT2d1sb
        l+M6NXfp301aonPcFL/OM+trvA==
X-Google-Smtp-Source: ABdhPJyblfJl+bLY3H3VO8xZs0G9MbDqGcVZxluvJDssaYfFOkdL/wZFstqiUxbZpgGOzNU1SsOTzQ==
X-Received: by 2002:a05:620a:24c9:: with SMTP id m9mr13858906qkn.317.1637167280184;
        Wed, 17 Nov 2021 08:41:20 -0800 (PST)
Received: from [192.168.1.173] (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
        by smtp.googlemail.com with ESMTPSA id j20sm165166qko.117.2021.11.17.08.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 08:41:19 -0800 (PST)
Message-ID: <4ed23cd5-f4a1-aa70-183f-fbea407c19ee@mojatatu.com>
Date:   Wed, 17 Nov 2021 11:41:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/3] selftests/tc-testing: add exit code
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>
Cc:     Li Zhijian <zhijianx.li@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, lizhijian@cn.fujitsu.com,
        linux-kernel@vger.kernel.org, lkp@intel.com, philip.li@intel.com
References: <20211117054517.31847-1-zhijianx.li@intel.com>
 <YZTDcjv4ZPXv8Oaz@dcaratti.users.ipa.redhat.com>
 <20211117060535.1d47295a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
In-Reply-To: <20211117060535.1d47295a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-17 09:05, Jakub Kicinski wrote:
> On Wed, 17 Nov 2021 09:55:14 +0100 Davide Caratti wrote:
>> On Wed, Nov 17, 2021 at 01:45:15PM +0800, Li Zhijian wrote:
>>> Mark the summary result as FAIL to prevent from confusing the selftest
>>> framework if some of them are failed.
>>>
>>> Previously, the selftest framework always treats it as *ok* even though
>>> some of them are failed actually. That's because the script tdc.sh always
>>> return 0.
>>
>> yes, also tdc was lacking support for KSFT_SKIP for a long time.
> 
> Should this go via netdev? Is the risk of conflicts low enough
> so it doesn't matter?
> 

Yes, discussions should at minimal Cc netdev + tc maintainers.

> We should probably add a MAINTAINERS entry for tdc. Adding Jamal.

Did you mean adding a maintainer for tdc or just generally point
who/what to involve when making changes? Typically the mailing list
should be sufficient. Outside the list, at the moment, any outstanding
issues on tdc are discussed/resolved in the monthly TC meetups (where
all the stake holders show up)...

cheers,
jamal


