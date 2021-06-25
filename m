Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0003B3F43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFYIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhFYIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:30:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EADC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:27:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x22so4342840pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SuAVI13cBWsgTYPg+9DS2RRHYD9Q2Xn2GuOOKy8LhEM=;
        b=mxcRHY1nP71h34SAlJeXoh1Tpj68vMX+e6XsRPrY40L9cYIEGmpXsaueZK1sUEj0Fm
         2H8AI4odQt4azj6X15SJfi6CRlSqD8V2p9l8hJrOsxiwjqDKWXZeDHbokOa+3Amoivel
         POktcETgUzzEBauYxzuNdU0R8R6r5Enn6wXj6PBvf8qdXtdfiaGUO/T+tyFkKXt2tDT1
         HtHW2SAq839R/rIwOxOrMD+w/Uu5aH++IAwHnEVZUC5jLmIwNB0/ctK7kCq3mXlnMkM9
         HtAMWg8ETxX4y52V7e4E2y1IOPoNTfKPumqkax55UztVtDqHwvj8XRNShEVXutU4q/74
         lKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SuAVI13cBWsgTYPg+9DS2RRHYD9Q2Xn2GuOOKy8LhEM=;
        b=W7L+V9IRzn+Zf/g84dlEnZhVYqTTrXlPUfliIZLZH4S8iq3kmm8tkBBfMbJqnclq94
         frvfO2OCC6M1aybgAciLzp8CBhllQF6IWJIG96S487M9wG71bWcbM3wlfsc5NXRKLRg/
         3K8otpsKDimfL3R/2BTeBk5e4fUAuHoD9tqcC0EiowQdr2oDEdDOuaHCIL61qEXcajWj
         VzHEOFA3M0BC5RXhqMNnaZdRFgz9Kx+Pi9eYXboCN2SbuY4Ej30b6qilZMqvXIZUg3y1
         IDTs2feV6SRA3k3P8GHvRn8Fz7Oyn+y55vZbYb2jbt/O2DSFM4ZqCbjC+BKuKjnkAOVd
         KIpA==
X-Gm-Message-State: AOAM5307rRTNs10h61DwarnIcr2xc0+bUSkLMMawcTibZ1qFqxw/Qs0D
        e40W7frNAaaOGZ9cj0NCzx4=
X-Google-Smtp-Source: ABdhPJyG9wwTAFtn+NBwCC/CzNWcxhQPZWOzLXZOcEHqj70pMzD86cXrXwA+ovA+5itVz06YOCn5fw==
X-Received: by 2002:a17:902:eac2:b029:107:b14c:423d with SMTP id p2-20020a170902eac2b0290107b14c423dmr8387550pld.77.1624609670441;
        Fri, 25 Jun 2021 01:27:50 -0700 (PDT)
Received: from [10.101.46.79] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id n4sm5275849pfo.188.2021.06.25.01.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 01:27:49 -0700 (PDT)
Subject: Re: [PATCH 0/3] Perf: Some fixes for Alder Lake and Sapphire Rapids
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
References: <1624029174-122219-1-git-send-email-kan.liang@linux.intel.com>
From:   You-Sheng Yang <vicamo@gmail.com>
Message-ID: <299b3215-cd98-8ad9-7dc2-7fadb272073c@gmail.com>
Date:   Fri, 25 Jun 2021 16:27:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624029174-122219-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've tried to apply this on Ubuntu's 5.13 OEM kernel[1], and yet it
still doesn't fix reported issue[2][3].

Vicamo

[1]: https://launchpad.net/~vicamo/+archive/ubuntu/ppa-1933617
[2]: https://bugs.launchpad.net/bugs/1933617
[3]: https://bugzilla.kernel.org/show_bug.cgi?id=213443

On 6/18/21 11:12 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The patchset includes several fixes for a special configuration and
> specific events on Alder Lake and Sapphire Rapids.
> 
> A single fix patch is easily buried in the numerous LKML emails. So I
> put them together to attract more attention.
> 
> They are independent small fixes and can be reviewed/merged separately.
> 
> Kan Liang (3):
>   perf/x86/intel: Fix fixed counter check warning for some Alder Lake
>   perf/x86/intel: Add more events requires FRONTEND MSR on Sapphire Rapids
>   perf/x86/intel: Fix instructions:ppp support in Sapphire Rapids
> 
>  arch/x86/events/intel/core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
