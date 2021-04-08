Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F894358DA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhDHToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhDHTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:44:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8F2C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 12:44:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l1so1575792plg.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bfastjAcTH6GvPwsRgj4kE1AV0IU20Avq5QkV1jf3r4=;
        b=EJAHG+Uic46Jnmh+49aazvcUkUVTtFlYpkrr7bKQDNzWmlAzr7wuVZCTqKnJo576Uj
         I6caQ9M3WepGXq8KfauX3Kz0E4DW5cZMtRc4OR/R9wPAWKD2BOLF/z2KXK3AGQy+J3aG
         3H7UueJOv+dgTrAgF/+TiTbJUHBGezmWFYx5BXdLZrGBu7xfJ57v+rJbewkEf5hVQ5i7
         dn9oyKikDARyd1AFWtyKSu1bZkW3Cb+0qtsEUNT8dRp8ai7CcNcDKip3rcUZZlhsFjbW
         pZNBXKU1Uo9E8jDdZm/cc5iIgOj3DgQbJNiVB3JVCDe93ggFZXOBWgDBgSly8WXXwkpJ
         XbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bfastjAcTH6GvPwsRgj4kE1AV0IU20Avq5QkV1jf3r4=;
        b=d5PMeGfEtCExrOZAeNr9wckqza4jFRZxgC2LB09ymsC1qLLsleFx7DUeFHJt7dFAFy
         mkYihf1oCgpgEw7Op6h3QLAKxzJhGcEs6ROqktCmGQFY2OoxH+cv+WzFdh9vrKPpv/WJ
         EqcWN3yEQJ2q0+en6efAA/sPFI3Xi9vESwtSASQyNxlwM4pBeSFg3eavf1ZCO+GPy4Wn
         K0aEjK3Uc9c7rjiMdD22SzqLWQPVkIFxc4uX8wccB4rJUhSvfZtFeNjSoooMGzkO8+2E
         UZ1/s52gkcE7l+aUAtzM/chHgKc0ABtgCrQ+8aG+Y3psifB5AwW4T8xjRvLupTzGVyfm
         Gyog==
X-Gm-Message-State: AOAM532YFRyHNSq18K6jxFKfwV6GPJ0UxYqr9sOzEdkhCnpMoFeuMQZD
        3U0jsniZXOBHtRdKQbSS2y+1UGieGe53mg==
X-Google-Smtp-Source: ABdhPJwLOPv5mYkBNpJyACmTwL9RSZ7tTYjT58P3V4Ml4mAfiOEPPlBWb3tBEh7V6+dxN64G/duR4A==
X-Received: by 2002:a17:90a:300f:: with SMTP id g15mr4386373pjb.88.1617911064537;
        Thu, 08 Apr 2021 12:44:24 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q10sm168327pgs.44.2021.04.08.12.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 12:44:24 -0700 (PDT)
Subject: Re: [PATCH] block: Fix sys_ioprio_set(.which=IOPRIO_WHO_PGRP) task
 iteration
To:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YG7Q5C4Rb5dx5GFx@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e8579a4e-2456-a89b-b750-892d265ba053@kernel.dk>
Date:   Thu, 8 Apr 2021 13:44:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YG7Q5C4Rb5dx5GFx@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 3:46 AM, Peter Zijlstra wrote:
> 
> do_each_pid_thread() { } while_each_pid_thread() is a double loop and
> thus break doesn't work as expected. Also, it should be used under
> tasklist_lock because otherwise we can race against change_pid() for
> PGID/SID.

Applied, thanks.

-- 
Jens Axboe

