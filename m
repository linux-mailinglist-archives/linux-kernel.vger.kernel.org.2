Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67AC380E05
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhENQSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhENQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:18:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C04C061574;
        Fri, 14 May 2021 09:17:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso1910706pjb.0;
        Fri, 14 May 2021 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hhqZIG2WSjMZChaCteViTaKoqe3TyX4xP+LLXRxZ7BM=;
        b=q84C9WBnn6b/Sa+AQj1Sss4oqNU+YlBHxirU2Q7/00b+6OxkZCfLKi8CPoz2e+zE5e
         LME7Gvn27LD0GW2RIxVD3mEABYOzL/t2jVrjkRjv+oCeNIkm3nVznkG9d6jTjC1cW8sl
         QXkyvrkBzqy5Jyfxobp7kaBBSA21fWMQpbeWlaakiRt8VeJ8j1GSpGponPWm8qpdWLGT
         fsQ3tYTbzkpPJCxqO2YfT4i7wxbl8U9JTy2WySkMtKgJ3ISeDIcLhcRljDiUyAXhH6Ob
         UcxbpnymTOhq3orv8T46JdpfNWe1OM/26k8Dynz/wUA1iBtrv3oeX8g4umAg0VEU5P/V
         jjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hhqZIG2WSjMZChaCteViTaKoqe3TyX4xP+LLXRxZ7BM=;
        b=Oj5QZUapVmJZO/bktsDlToHWpCYf+vF3v2dQEXiUsHrjhz5cDpBvZ9JnctwTOyM5k6
         HszyaCGDYLwiyuHqxtuJF25aZC9yZGocSlQ2D/54kgCDVG5bs0sBTsBJqO4kF8jo0jZZ
         AzJD28NqPHLftJafi4ZOMGouLl85sPH5ZvVJT8l78qwUFKXxsJiNh255xVPVk97Ovder
         qJMkIcRNU8ohEmUZ1gRNi/cwVPeTMHF11FDPyF1vFWIBpGmWH+CXh6GJiBOGtXuz8jHi
         98R/F9F+lxOqde54xjjG8xnEUQ09voO7GJUlikQN677qLdIWzW1p4sSfdFiUvsgI6ixU
         O88A==
X-Gm-Message-State: AOAM530PLKxoXV+YUQlgOHDdjHw8CroZ0UKxPY2JoOhisTbEYoCv7ct2
        UZETnSk3ZA8wnQW4gytiyeuLW5uQVexV4Q==
X-Google-Smtp-Source: ABdhPJxdmZrGd2QCLLhUZObOuDHWo6bMr8tvvLbnlKWOCNkxVBPvtT6WDrO7ca7p/7qnzIUjprf2zA==
X-Received: by 2002:a17:902:e752:b029:ed:8636:c525 with SMTP id p18-20020a170902e752b02900ed8636c525mr46302950plf.60.1621009053027;
        Fri, 14 May 2021 09:17:33 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a93f:3d36:ea03:6cce:19ef? ([2405:201:600d:a93f:3d36:ea03:6cce:19ef])
        by smtp.gmail.com with ESMTPSA id x11sm4783986pjr.21.2021.05.14.09.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 09:17:32 -0700 (PDT)
Subject: Re: [RFC v3] scripts: kernel-doc: reduce repeated regex expressions
 into variables
To:     Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210427165633.GA235567@casper.infradead.org>
 <20210429063729.8144-1-yashsri421@gmail.com>
 <20210501154336.GS1847222@casper.infradead.org>
From:   Aditya Srivastava <yashsri421@gmail.com>
Message-ID: <490cdb39-74a1-951a-0688-0f72f58ae7f8@gmail.com>
Date:   Fri, 14 May 2021 21:47:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210501154336.GS1847222@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 9:13 pm, Matthew Wilcox wrote:
> On Thu, Apr 29, 2021 at 12:07:29PM +0530, Aditya Srivastava wrote:
>> +    my $name = qr{[a-zA-Z0-9_~:]+};
>> +    my $prototype_end1 = qr{[^\(]*};
>> +    my $prototype_end2 = qr{[^\{]*};
>> +    my $prototype_end = qr{\(($prototype_end1|$prototype_end2)\)};
> 
> Would this be better written as:
> 
> 	my $prototype_end = qr{\([^\(\{]*\)}
> 

Hi Matthew
I have actually tried this earlier, but it does not work as expected,
probably because of greedy matching. I have produced the list of
warning differences before and after over the files, when using this
regex:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/kernel-doc/diff_on_alt_protend


> And now that I look at the whole thing, doesn't this fail to parse
> a function declared as:
> 
> int f(void (*g)(long));
> 
> (that is, f takes a single argument, which is a pointer to a function
> which takes a long argument and returns void)
> 

I think this will match against:
$prototype =~ m/^($type1)\s+($name)\s*$prototype_end/

Thanks
Aditya


