Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3577B333043
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhCIUug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCIUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:50:20 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FB9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:50:20 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id g9so13448131ilc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8Beol1vwvugLcX6dyhYM7QV2XmUWY2CELTq49rlsJk=;
        b=D4CmLh/h2w/J1i0VPcOxlMFzEuqzUjkpZtNtGOHi/2VTPRS7Z4qe8S9++KSJqtONh2
         GOPmuiR+6JbHCGHAK13IqjCjXyDgT+XXLFglPrNmHuLwPgKTq7CqhnBpQJQ70AMRdJjx
         9AcgAFs/YLmF9GzqzhmbtkFISp6+3GH3IngohIJDFQBaAml64P+bL1kaBQDvjiHAD+nZ
         ylIvnP/ECzkcH6FTu/Eq8i3heCzxDc+WojQ+JLZxZg36GU20orXdHOUYWfHzCBedmaED
         sMWf4IbjzJFW7nkYDaVelbHDETMOt1gMYXO8haqGobcIHTaasa4OPllmCpVlfRC4Ix3c
         YTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8Beol1vwvugLcX6dyhYM7QV2XmUWY2CELTq49rlsJk=;
        b=EH5/cYUbwbjTWBMhJgLj23C21b2skUS6M2Yfw1hPqK8e/8F/yrryfLhzY4aBERPsOb
         wikQTAmgik8/gWC9mD4OYogKA+y3w6kCpwYBlt+27HhNoofefCHTcsPBHafXjfdf2Eex
         jHx1Tp0ObIh3Mpw2qRnXG/K+lxo8UPT3O9sZ1g9bHn//+M9V6amjBK4rI9jzX6+SWXrK
         CawwvS9l2CRPbWWdNPQSta+vexogEnd/WRsj//aD/NgJ4Hs6xCjKdyO+Tz2QSO6wCnDe
         vFSH1azfQy/PH7/tYH2LnF0rFSmr3EcQ5yiKf46TdF5KOhaxKOSFg1OdxWwYnLKacJCr
         7dJw==
X-Gm-Message-State: AOAM531Rb+/aXLiyHJGvKPt5gCgfW1WKf28/gXGs/x00QxT9qKkwjqnY
        qG92y0DwdO9MtQPMLRqWwrupqg==
X-Google-Smtp-Source: ABdhPJzL4us6wU9N46CCAROdfi7JEXE1HxM1m4J4+Smd3ru46Jtr3H8nfy06m2kjHYjK9tiAsRTGag==
X-Received: by 2002:a92:ddd0:: with SMTP id d16mr45367ilr.52.1615323019838;
        Tue, 09 Mar 2021 12:50:19 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c19sm8079624ile.17.2021.03.09.12.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:50:19 -0800 (PST)
Subject: Re: [PATCH v2] include: Remove pagemap.h from blkdev.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-scsi@vger.kernel.org
References: <20210309195747.283796-1-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b4d3285a-e1a2-1381-2bfd-ceeaf5ab55c9@kernel.dk>
Date:   Tue, 9 Mar 2021 13:50:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309195747.283796-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 12:57 PM, Matthew Wilcox (Oracle) wrote:
> My UEK-derived config has 1030 files depending on pagemap.h before
> this change.  Afterwards, just 326 files need to be rebuilt when I
> touch pagemap.h.  I think blkdev.h is probably included too widely,
> but untangling that dependency is harder and this solves my problem.
> x86 allmodconfig builds, but there may be implicit include problems
> on other architectures.

For the block bits:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

