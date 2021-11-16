Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320A7453C22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhKPWOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhKPWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:14:08 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB83FC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:11:10 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id s9so559501qvk.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j6hyh4DdZnqVKVPsdX1svAKgMhHegQMvJV2EoDFhpZc=;
        b=EiWMupfMYjCyDsirMoCIxHeV/JFy4OsBt6ItzFYMW9jW9fknoyNzKzpqjHLjqtCe2i
         EbHYvZMoTvY+KjyNlGfs0zRt8pIMJ7RfJqez16cxowzO6pdiEd6VV1r/h7U/F8Xy1/vk
         yyj2/OpW+GRWWoNf+2y/cyIkJXBbBJAj7sHbqLnmsG6T6Qu+5rFtwrDayWVNMz/eeNzG
         t8dd/xYDIa3MQAEmrXVzQ/bZgEgbAuAxn2lldQcpQ1zODg3/tgldav4sU+RTWLNoHl26
         PKe+TC+PMrDQ4kUh2UdQCJl8eumKDATvHmO3vdce63GUnyySziAfQmrmqro3Z5VJvwU1
         myVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j6hyh4DdZnqVKVPsdX1svAKgMhHegQMvJV2EoDFhpZc=;
        b=hOUvqfEpOKmZ10vSdr75kWKTXIs+ZpwcsPOy0I01BSuCIrmJnnfTm3dWh6opCYcvMg
         OCkwDaV8PvUEVcn/JOCFyJNg2sjqR0eycmZ5CX1O1QkLvPvpBLRc6XpzbbiRCvRWrvYS
         yYO4b701K8rK8cU8VHIN6tTQ3RA7UkSTku3FOrHNE5lGRx3gJPhizJEWXrEwY9gG1fWX
         A6MgYL6sF6xskkQRI/3xSxmu+/VVH8pOSF1/FaTFtTkk9QvPFhhtYpUzLSr+JUeUIe7j
         6rUflfqDJKXTZCnY6JNh7nrQCalOKhJiM8X4X0jO7yFrTsP3dKOKmMRJEcvXgKzMAezP
         CuCQ==
X-Gm-Message-State: AOAM532COQMVMB07qOZMrXJB5K60/BYM6CT2toJ0lGNCsebc+Gwt+ozu
        xOZkZZxMbPT+gtp+wWJjHd8qng==
X-Google-Smtp-Source: ABdhPJyMu2JZNZL43tBoXGFsgvJdf5IwHcPTfRofu5Kkcyu9EH7ioVe/o3AdA8yDRBK8zUcSy+BDmg==
X-Received: by 2002:ad4:5fcb:: with SMTP id jq11mr23009101qvb.30.1637100669760;
        Tue, 16 Nov 2021 14:11:09 -0800 (PST)
Received: from [192.168.0.104] ([66.199.72.44])
        by smtp.gmail.com with ESMTPSA id g14sm8734705qko.55.2021.11.16.14.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 14:11:09 -0800 (PST)
Subject: Re: [PATCH v5] include: linux: Reorganize timekeeping and ktime
 headers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <b5d4536f-a096-b259-1385-3c1d32754dbf@vt.edu>
 <095645cd-ce53-a803-cb99-522545a409b8@vt.edu> <YSJP18Z72t0X+xsp@kroah.com>
 <1c156aca-d0ad-e7e8-2238-5c3d904d171c@vt.edu>
 <327f5c2f-b996-8aa1-cbbf-3354e01ee1f3@vt.edu>
 <fb66b935-b498-723a-1f05-f02648f8f580@vt.edu> <YYN78YlFrV0vFPq9@kroah.com>
From:   Carlos Bilbao <bilbao@vt.edu>
Message-ID: <ce75dfa1-b51d-1988-9371-ca90ab5e1535@vt.edu>
Date:   Tue, 16 Nov 2021 17:11:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYN78YlFrV0vFPq9@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On 11/4/21 2:21 AM, Greg KH wrote:
> On Wed, Nov 03, 2021 at 03:33:52PM -0400, Carlos Bilbao wrote:
>> Hello everyone,
>>
>> Some time ago I sent a small patch to avoid implicit function declaration. 
>> In particular, timekeeping.h was using ktime_to_ns(), a static function defined 
>> in a header it does no include, ktime.h. Some maintainers saw this as an 
>> opportunity to reorganize ktime, and so I did and tested for all architectures.
>> Now, this patch has fallen into the "limbo of patches", so the original problem
>> remains unsolved. Please, either take a look at this or check the original
>> patch for the header dependencies.
> 
> Please just resend after 5.16-rc1 is out, there's nothing we can do with
> this at this point in time.
> 
> thanks,
> 
> greg k-h
> 

I think that now it is a good time to send :)

Thanks!

Carlos.
