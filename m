Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5E366FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbhDUQGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:06:25 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:39810 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbhDUQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:06:21 -0400
Received: by mail-pf1-f179.google.com with SMTP id c17so29290396pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8yTVX8+oRbYXLONfEb90CxPaxaI5p8TKq6tQSe8PKmc=;
        b=qb2G1wkXmwEBVMrfjQvja3ZDozrWXcHce8yw3+xvaNt8n4546zPolO2qqHBKQtRj8A
         I3LsrjABuj80buGax+GdzEqmsUQIDqehYdxrNBFFGdi9fvBmkkACg4aR2QDSPaI4Q3ua
         HZuVuGFNIk6kOL0WdsjmTCjHOf0sWaKGM1WP5C7Z25UBOBMyrnBCouQdIpBYOpRBHMsT
         Gv66Yv+CnGAaYCFqUDXV+iTexx2jDrXabLh+dvV4PJdDEz5MgXyc1BPZOqHR6xQ/sglk
         cAfbMn8DTg/hHRYv06wxeelcdA8+3BeVIEpG3ikb7ALtWdrFV6+VZn3pz1n+F1JMyZb8
         hfjQ==
X-Gm-Message-State: AOAM5321afIyA+aAqjoULVkookhizyTWm6CrrjqVWlIWebmLCBRNVrRv
        eKmzQp3wh6IKDc5WcCTW5yc=
X-Google-Smtp-Source: ABdhPJzhHgA/jxYBJG2T49SANDsNTCG54bEF/+2bJHv7wt0AQdpuV9PE0i7S14XDGdJS4+THRV8eaQ==
X-Received: by 2002:a17:90a:f3d1:: with SMTP id ha17mr12386702pjb.123.1619021146615;
        Wed, 21 Apr 2021 09:05:46 -0700 (PDT)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id t1sm2398836pjo.33.2021.04.21.09.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 09:05:46 -0700 (PDT)
Subject: Re: [PATCH 059/190] Revert "RDMA/srpt: Remove unnecessary assertion
 in srpt_queue_response"
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-60-gregkh@linuxfoundation.org>
 <20210421140247.GG1370958@nvidia.com> <20210421140553.GA2268573@nvidia.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ab214d8e-bc80-ddfe-10e9-25389f84471b@acm.org>
Date:   Wed, 21 Apr 2021 09:05:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210421140553.GA2268573@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/21 7:05 AM, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 11:02:47AM -0300, Jason Gunthorpe wrote:
>> On Wed, Apr 21, 2021 at 02:58:54PM +0200, Greg Kroah-Hartman wrote:
>>> This reverts commit 9f48db0d4a08624bb9ba847ea40c8abad753b396.
>>>
>>> Commits from @umn.edu addresses have been found to be submitted in "bad
>>> faith" to try to test the kernel community's ability to review "known
>>> malicious" changes.  The result of these submissions can be found in a
>>> paper published at the 42nd IEEE Symposium on Security and Privacy
>>> entitled, "Open Source Insecurity: Stealthily Introducing
>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>>
>>> Because of this, all submissions from this group must be reverted from
>>> the kernel tree and will need to be re-reviewed again to determine if
>>> they actually are a valid fix.  Until that work is complete, remove this
>>> change to ensure that no problems are being introduced into the
>>> codebase.
>>>
>>> Cc: https
>>> Cc: Aditya Pakki <pakki001@umn.edu>
>>> Cc: Bart Van Assche <bvanassche@acm.org>
>>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>   drivers/infiniband/ulp/srpt/ib_srpt.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>
>> I think this one is fine
> 
> Sorry, I realize that is unclear. I mean I don't see a reason to
> revert this patch.

Greg, I share Jason's opinion and would like to see this revert dropped. 
The function srpt_queue_response() dereferences the 'ch' pointer before 
the BUG_ON(ch) statement is reached. I think this makes the BUG_ON() 
statement that would be reintroduced by this revert superfluous.

Thanks,

Bart.
