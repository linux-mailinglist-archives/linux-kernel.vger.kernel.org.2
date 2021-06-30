Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A6C3B88F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhF3TF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 15:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232851AbhF3TFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 15:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625079805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P89NrR3CJ5E3u2RgI6LTGTpGC4VYgbeRbJ9x0xgMwrY=;
        b=YCos0Sy8Icx4iw/GXiB0b9LBRTjMmDtWxyd7xRrP5xXOP9oJ5nlO2OjOtABRQrXVzjLjdG
        SZeHzuIDaA6XJS54M8HptGCX4MebSiHP7+YaOl8ssUoF6k5xciDaHiVM7S9sAPeETa2BaT
        ach0r5r89pv+TYjMHyZHRX3rTj+ZE2I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-sLrbxqCANryi5NqpqgkBrA-1; Wed, 30 Jun 2021 15:03:24 -0400
X-MC-Unique: sLrbxqCANryi5NqpqgkBrA-1
Received: by mail-qk1-f197.google.com with SMTP id 81-20020a370b540000b02903b31f13f7c5so2400435qkl.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 12:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P89NrR3CJ5E3u2RgI6LTGTpGC4VYgbeRbJ9x0xgMwrY=;
        b=p6L0WJnJSSNOA10+IhFZwg0KEs1L/aT0wh9YGBP078YHavOFWxwA2W9Wde9+baHxo3
         AUMDdnxUf+XNUPh3/Let+bjVUxpkKJYTXC7I5vYurBG5b2d1F7eiiwMgLvNqouTkP8kZ
         9pDh3n4pSmMkazxwlrPqWUGI+uphiU818vhFYu6PYioC0KhT2US83MifghKdAz6HSry6
         fbxvUKt+xMmIGIQdILGJW449Um2b33DaoU1hl8NKTwkY1+nX6LUQKVzvoTxptKIxg/8O
         1mlSky+4utgv+H8uM2XN3leCcDr3RLaZDAD+P6TEDahskiVAR9FLZ1IVBtwu1ozzKdyU
         SANg==
X-Gm-Message-State: AOAM533OAVRwRyV+hV2RqjLqogNhSgwlbq5hapZquHzZL+i2KTstRK16
        lkzpx48Rkw4UJ0TzDbRgN8k1Gg/RTD2bc5N84JS1OfWWxp8kvxcZDvEaauj6czhi653F4uLQrJC
        D2dL0t1fYfpW318AENNKiwgX6
X-Received: by 2002:ad4:598f:: with SMTP id ek15mr38255719qvb.15.1625079803381;
        Wed, 30 Jun 2021 12:03:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJuv8FyvLG2QHr/lcvjRckSNGJMJE+5mOM2HQzrtsQy86Nd1ShbKcIgxazD++ta4Wqgdc2Bw==
X-Received: by 2002:ad4:598f:: with SMTP id ek15mr38255693qvb.15.1625079803164;
        Wed, 30 Jun 2021 12:03:23 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id o66sm14328475qkd.60.2021.06.30.12.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 12:03:22 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC][PATCH 0/4] locking/mutex: Some HANDOFF fixes
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        boqun.feng@gmail.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, yanfei.xu@windriver.com
References: <20210630153516.832731403@infradead.org>
Message-ID: <bdc77b11-ac81-d8ae-c7eb-5a013de5e790@redhat.com>
Date:   Wed, 30 Jun 2021 15:03:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210630153516.832731403@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 11:35 AM, Peter Zijlstra wrote:
> Hi,
>
> Cleanup and fix a few issues reported by Yanfei.
>
> Waiman, I didn't preserve your reviewed-by, because there's a few extra
> changes, and I've not yet boot tested them.
>
Other than the typo in patch 3, the rests look good to me. I had also 
boot-tested the patchset and run some mutex stress test without any problem.

Reviewed-by: Waiman Long <longman@redhat.com>

