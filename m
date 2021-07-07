Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701CE3BE82B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhGGMqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhGGMqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:46:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FE1C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 05:43:41 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f12so2450169ils.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PCvrCrmMvV1laLdUNmLRNpsahOO3ZtiZEh8I1JSMjmU=;
        b=K4LlkuzRMFBUdbHKBCNLoOpYTHSubx5w/H7U7MhiBK/I2ztFR/cxtK13DFo+vjvYaj
         ssaqk61/c8xaRIMO1od68Yi0CM9y8/7K/+AsFoXCekQQhWDhQEV1AF+NFlbp6EJGKhJb
         cqKVvBXE1ejpnYrb+NwjI4JW95HWbn92Pnq3MEQFq90khpNVRBZ1d4aHYDHKNeHZKU06
         eOP9Fyd5DeWVLBliqkB61MJ7BSkFeBHkHrjQdeH3RbGd1gIOaamkv/JfsJtdBM5ajpiz
         q4uJkKOr7CYk1EIztJK2dlpzOCxtjcB7xQxHekrLIdkA7dBUZPHVCA1YPs8fvMU3KmzC
         3vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PCvrCrmMvV1laLdUNmLRNpsahOO3ZtiZEh8I1JSMjmU=;
        b=QlQ8/uSAbFu/9o4PVVWcZgElk/Cocb3s75NBO4dnydxB77PT662zr2RkJvJRUBEhAX
         ynLDfBLJCx/K7XrQnLERdpE94dn9MfpQhyjNs3vsBx3+90nFqmKJCxrggHVJI8BQkSvw
         K0hV1QvRJGKf9OWvM2Ca5vN2RU7s4Xwnp5E5RuuIxL7Mm/5FoXXz2OZVr4LL+tjkgSeQ
         8ZfvyjjnMWby23JyCWlS6Wr0d8V7RfVTBqH/GEwSzj1y0Sw44mpQtmmSyOe44ttiSx6/
         b9gfUxGzm1SJQTrw35SVxFckSd9p6M/ehD71Fx0NvG3tUx3hOFkEz65ZVozftJJBOupQ
         E4Gg==
X-Gm-Message-State: AOAM531gq/TuxWprmxDuJAaotlHesrmyVIJ/XiynOjoxTlBkpqOD8XoM
        1OTtSQ357huHBfIMHtQ28r9IzE2rlJ7HKA==
X-Google-Smtp-Source: ABdhPJxEeAmthCg/FZBw7hIDzkyE5Y0uETAIeMrfNiY6WSlFvkZ02VadtzRpxgHf+N7sncAk7TFbWA==
X-Received: by 2002:a92:3209:: with SMTP id z9mr18409959ile.115.1625661820459;
        Wed, 07 Jul 2021 05:43:40 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id q8sm11081038iot.30.2021.07.07.05.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 05:43:40 -0700 (PDT)
Subject: Re: [PATCH v3] block: fix the problem of io_ticks becoming smaller
To:     brookxu <brookxu.cn@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d79fd9f-2dda-dc62-8298-393ee223fc0d@kernel.dk>
Date:   Wed, 7 Jul 2021 06:44:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 3:47 PM, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> On the IO submission path, blk_account_io_start() may interrupt
> the system interruption. When the interruption returns, the value
> of part->stamp may have been updated by other cores, so the time
> value collected before the interruption may be less than part->
> stamp. So when this happens, we should do nothing to make io_ticks
> more accurate? For kernels less than 5.0, this may cause io_ticks
> to become smaller, which in turn may cause abnormal ioutil values.
> 
> v3: update the commit log
> v2: sorry, fix compile error due to the missed ')'

The version log goes below the '---' in the email, not in the commit
message. I fixed that up. Applied for 5.14, thanks.

-- 
Jens Axboe

