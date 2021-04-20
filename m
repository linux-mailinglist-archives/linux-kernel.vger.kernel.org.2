Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C53662AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 01:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhDTX6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 19:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhDTX6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 19:58:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 16:58:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sd23so52178536ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGzMMFSDXVEyac1L/55cUpZpjU4bjjoWfcDw+JMob04=;
        b=ytcrxr8wbn8/5f4pqgMPFBPjgsUCFDMD5TM1ZAF0QU4PlCzmA8rMWxyXrHIAUt0ou2
         likfPwJsXJQb9HKQzvOOmw0EhLFS3MQYnmxFxXqw2N1399atYkC1XYjiqJj7RqqZh4+Q
         JpWAi5g7hqpN3qL0OWufzjzfNHRViTkPpLCVFo00Ni2WG0UFdHbw62zSVLySFf3Ux9Ka
         Bb6IqTZJaiE/gB4S1CMCofM9zPtdLM03pVYgiWdHXM4uWAjTIyKcEJgiFSB8qSl5zI5W
         vlnn3bLaR42S3SQYoNYpzQe1aOgvkvlInqtvY8boxyTwfsbKB17BmZgvK3HsgJ1wER3g
         g3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGzMMFSDXVEyac1L/55cUpZpjU4bjjoWfcDw+JMob04=;
        b=eFIeePI7OknHJMzKHuoTe/r7lyVYnlsTaLQVAjLHcDr9YmZIp+qiMV0GYB70Vl0XB/
         Nljg9t1OR5dRgoVxInz7279LR0s8OhjHY7oHwBkMrvJdrYrKOQ1HxWZIVJnNeHJJBCbC
         x4i11I8/ZXYRpuGXbH6jNRgqw5vrvTyp5LNoXFT4fVGiXhhfg3zJY7FAhp27umTv00mT
         nJq2dAdJ0Qkvn/cKag15Y4lLpx8e9H7zmEBFsp9+eU9LLcWvRMqIEJQV6HScLttzs2Vl
         sYKgHKXFRWjcp63VbZTeghIotCv5/V4hfTcJ0epM68IFNr/kmvUFmiv3+xSr0djppqbC
         DrQw==
X-Gm-Message-State: AOAM531ICqz/XETQ1tKGX9G7jv7WSiu3J9RGG4AXhtXZCYHoUSl5mWPs
        ZtkWKB3oF277nnkoTfCenRA/ZUY6QpC9d0TovdHlTleCfE4=
X-Google-Smtp-Source: ABdhPJyz2D3hyXViWoO0yuscrp5I4sCJibwSSLOeRSpnxbMCw7pAbd5G4W4YTnawc/5sPprgOM8OCcCPsMSFL51a71M=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr30069454ejc.418.1618963094537;
 Tue, 20 Apr 2021 16:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <1618904867-25275-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1618904867-25275-1-git-send-email-zou_wei@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Apr 2021 16:58:06 -0700
Message-ID: <CAPcyv4hV1HhFRw42s=tc_8dLeY4+avB_2jauSxVzUBzKsEr8ew@mail.gmail.com>
Subject: Re: [PATCH -next v2] tools/testing/nvdimm: Make symbol
 '__nfit_test_ioremap' static
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 12:31 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> tools/testing/nvdimm/test/iomap.c:65:14: warning:
>  symbol '__nfit_test_ioremap' was not declared. Should it be static?
>
> This symbol is not used outside of iomap.c, so this
> commit marks it static.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Looks good to me, thanks.
