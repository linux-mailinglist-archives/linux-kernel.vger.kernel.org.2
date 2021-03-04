Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48932C94E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441817AbhCDBGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453037AbhCDAmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:42:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB72C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 16:41:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t26so17677155pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 16:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tFv08AbuAbe3jKr7mEHbvIFM4gHAs0G2cR8M3WVE7oU=;
        b=oPJ82WXi4oso8CTu9jJVromgLEPEV+9C+4QX9nI9WIl28beU4eRYKdz2LWHQuJu7tM
         rGwaGEm0RSwfkDksmaYzRNv1NTc5leLuNlP4nDs11ocqW+OEPNLkXChKVIlhpedvjItq
         0mqvjr23EaiRW3BjMeBJwHIy88b6NVQ1zhowzo5ZFJtfN9aJkzl4PuPTB600FQxKthA0
         QWw4dhw3oGN13RtZEeTHxOkl+mdsJXIU+86I5BmSawInWBeiDPwccmNk8ZnMDku4drGZ
         64Gilv0Sf+BMFlugA17g8PzbigrvVrvgDGfvvJiqJxMlCp5ULqc/vE2tz3qxXFKxuh08
         kipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tFv08AbuAbe3jKr7mEHbvIFM4gHAs0G2cR8M3WVE7oU=;
        b=avNXH3jtmk/fRnvBb/gyb8XKt/01JfbWPMLta0T80JkcVINX/WfgkkZ1JKVAmqkxsZ
         1x28ho7YlGjZdlpG2ur1BHssG6HEw8yEduvwMoygiPUGiHiyUb5YkWha95ffro7jyROR
         6ZbyhOneI5NdrULRhMgIPryTxPLbktNK34Cr9BygqOuaGS9Cxe+N+v7jTv2ZHnVlLQB2
         eO22/v6cCnvGdhf4E1ggw3+AmurtIbTCAFNCWEhnMal8UEZonGqYJP5eLXsaNOrkc2Us
         g9dd94VQhWDdv74ZguPOJJ+B4kB4BJRsxKLEnN+EbCFkVLc9XJoLIHEmalqzcoZxz4jx
         HE0g==
X-Gm-Message-State: AOAM530XUFO4PH8wSnKM7vS0aGLHo8zB0VBWE5FAgL50/s9gO9FhC1vQ
        R/uEd/uBfYsbLFiYXbgUw2SQFQ==
X-Google-Smtp-Source: ABdhPJzlo2AoA2G6B3wfK7vW365vGZPnIFiwp4sYNQ5XX9zccNuwBUY1Ab2dielycYpQAW6JQCHFNw==
X-Received: by 2002:a63:4808:: with SMTP id v8mr1326821pga.381.1614818516590;
        Wed, 03 Mar 2021 16:41:56 -0800 (PST)
Received: from ?IPv6:2600:380:7540:52b5:3f01:150c:3b2:bf47? ([2600:380:7540:52b5:3f01:150c:3b2:bf47])
        by smtp.gmail.com with ESMTPSA id k64sm8251970pga.52.2021.03.03.16.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 16:41:56 -0800 (PST)
Subject: Re: [PATCH v2 00/20] [Set 1] Rid W=1 warnings from ATA
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Albert Lee <albertcc@tw.ibm.com>,
        Alessandro Zummo <alessandro.zummo@towertech.it>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        and cc <htejun@gmail.com>, Andre Hedrick <andre@linux-ide.org>,
        ATI Inc <hyu@ati.com>, CJ <cjtsai@ali.com.tw>,
        Clear Zhang <Clear.Zhang@ali.com.tw>,
        Frank Tiernan <frankt@promise.com>, Loc Ho <lho@apm.com>,
        Mark Lord <mlord@pobox.com>,
        Suman Tripathi <stripathi@apm.com>, Tejun Heo <teheo@suse.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Tuan Phan <tphan@apm.com>
References: <20210201143940.2070919-1-lee.jones@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0975bce4-8e69-2aa4-3ad1-5ce3b4215126@kernel.dk>
Date:   Wed, 3 Mar 2021 17:41:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201143940.2070919-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 7:39 AM, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 1 out of 2 sets required.

Queued up for 5.13, thanks.

-- 
Jens Axboe

