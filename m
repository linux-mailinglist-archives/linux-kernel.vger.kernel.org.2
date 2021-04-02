Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A958352EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhDBSKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBSKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:10:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED84C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:10:03 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r193so3158013ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yjrmCjuaNHWTMVtf+Ev+uBc6DnJZmXfXNY+A28CCtys=;
        b=OxZOKHA1AirLfe4HR0wmt1+tSU1Zq+F4Uo2VFWtWUzxkLeSFYJxLcY8B17QC/A/Dcu
         DzhFGqVTIDpiGjVhsIF9oB1+nK+Rw205KeHmnj04XPZ33s9Q4U+OVn+h9nWh+wi2BAbR
         M7T/uzEvdVd9NeyYuw7nn4jqU8yZwgigYibgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yjrmCjuaNHWTMVtf+Ev+uBc6DnJZmXfXNY+A28CCtys=;
        b=nKSonAn/yg/O6Qz4E61aUZa0RTayAURrytm/IgpUI25eBlldd13kCtHBhorgPaM/T3
         +4ipTsAbn05OrUDUFNChLMZGgXi/d9+3yGPQ1PhzYiekL8JILwvmNibb2lyJItkXsXV1
         zSDnw6d2IO/9S6aTHeiOjtPsEsqzDcTvkARBT26NN35r35zs6hfYLqGCKPgLgeh0/rVa
         1RL6XQ6E2MHdwPzLELp0missQCxfO1eXOVXy+9ICUn51N3PIQrjQGzXZYlSMs/w4oO3d
         hMEyBz35PUyua2EuhBv++pdBTrvauEp8FkNX0nnTC7V65bPHzPg3zGQ8EN1KeN0pZb3Z
         z2Qw==
X-Gm-Message-State: AOAM5303V15N6jkC16fAsuYnw6p/9HHhTNIINJY9+884uSxFpVSLupRV
        cNc9Kml24c1LeU4OkDRe7mo2Kw==
X-Google-Smtp-Source: ABdhPJzkcGhvBhQO8pqLTozGIowK9K7OA25Vy28EDdf/exqM7v7Xx8eoMG/ZzXzNA8nKbkxOfyWDsQ==
X-Received: by 2002:a05:6602:722:: with SMTP id g2mr11985733iox.1.1617387002717;
        Fri, 02 Apr 2021 11:10:02 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 13sm4347668ilq.8.2021.04.02.11.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 11:10:02 -0700 (PDT)
Subject: Re: [PATCH v5 00/21] Miscellaneous fixes for resctrl selftests
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <652bfb1c-91d4-13b1-b9be-be8a4147d304@amd.com>
 <YEvnGQ0W1IlOMjOf@otcwcpicx3.sc.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <57162752-1db4-35a1-b6ca-0dcb7344dc27@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 12:10:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEvnGQ0W1IlOMjOf@otcwcpicx3.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 3:11 PM, Fenghua Yu wrote:
> Hi, Babu,
> 
> On Fri, Mar 12, 2021 at 01:08:11PM -0600, Babu Moger wrote:
>> Hi Fenghua, Thanks for the patches.
>> Sanity tested them on AMD systems. Appears to work fine.
>> Few minor comments in few patches.
>> Tested-by: Babu Moger <babu.moger@amd.com>
> 
> I will add Tested-by: Babu Moger in the series and address your
> comments.
> 
> Thank you for your review!
> 

Looks like a few patches in this series needs updates. Do you plan to
send the new revision for consideration for 5.13?

thanks,
-- Shuah
