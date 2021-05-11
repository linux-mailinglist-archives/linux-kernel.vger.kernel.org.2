Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908C937AF78
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhEKTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhEKTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:40:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22356C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:39:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i14so16509218pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PSahpPiUc5NKlDdMwb0qNt2ijCCQMz01ED1EXmqSDhI=;
        b=RMj+4EQb/aRuO2A1yJ0dCHholXt9fKvAu8HwhU86akDazzDLxb4yDhKAxxKHGtAhO+
         86FQBFH5Y82XbqNv6+iL++1iTewno1EvqwwIXvvWpRx8bWjTvpGNEx0udu4iE2NLwe/V
         /3g4jmcVeyUigddLFMrO/tQkjF4YLDmQLRlAIOZHtnA8BmEjnAPVRda1uuMtc8uaATe6
         2ROU6OWc2xLskRBiS4CqvEoYoQSwXGQAruOwoI/0Js8tYupLxAyVsTb5I4TFKNQYQBsH
         O3npy1g2LZ3EXSY1q05D0N072coptdd6Vli/wBMF1lcDClwejZuDN0x3UNJL+Tadd3NY
         BFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PSahpPiUc5NKlDdMwb0qNt2ijCCQMz01ED1EXmqSDhI=;
        b=AJUVG6sU30X5qyCw/rSMfBf/gM08oP3sTn8db5iDYkNfBZIYblEVsq/Ud2GR+i8k/D
         uPKd2C4/PUQeRsEAG8ylyoXmzBqRvihG4vsRJvR6e0bR+xk5H+NzlDw5TKPSBnwnvfzD
         mpRmIF1/3NFZ0v3Lvd4MJyawHmnpl2Q3KcpFSvXkKz3bjQ/cwA1EjiWCg+Uh/Ce/sV9N
         5aiQLnwnv3fgUt31OnmV0MMBYVfnmIfGeI6OnaH5Yii/eqviGESwEjULqSA5KRPBoXy8
         Ic6xvKjIVMYWWw/f4ADIMy97U3VQ/u4gDOP9+9QLgyNRc6bq6l8i1Pk2+RKqMbENONPp
         J1GA==
X-Gm-Message-State: AOAM532W6hvmJbxbYdjeTjliRLXVui8ffS6I/YfJ2/uyikhoEUOVTn8k
        GO1JBHxizp+9oXU7v5jYzH1tmg==
X-Google-Smtp-Source: ABdhPJy0QyoG/x4CMUJXHO5sAdjw2fW0Lb6xqTo+sdK0LLlv7pBZXhwhFqStH9BhS91SP8hhdlIYAw==
X-Received: by 2002:aa7:908c:0:b029:250:b584:a406 with SMTP id i12-20020aa7908c0000b0290250b584a406mr31778622pfa.44.1620761950492;
        Tue, 11 May 2021 12:39:10 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i3sm2711436pjv.30.2021.05.11.12.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 12:39:09 -0700 (PDT)
Subject: Re: [PATCH for-5.14/block] blkcg: drop CLONE_IO check in
 blkcg_can_attach()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
References: <YJrTvHbrRDbJjw+S@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f89d141-fc55-a41e-4783-649fbd7e34ee@kernel.dk>
Date:   Tue, 11 May 2021 13:39:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJrTvHbrRDbJjw+S@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 12:58 PM, Tejun Heo wrote:
> blkcg has always rejected to attach if any of the member tasks has shared
> io_context. The rationale was that io_contexts can be shared across
> different cgroups making it impossible to define what the appropriate
> control behavior should be. However, this check causes more problems than it
> solves:
> 
> * The check prevents controller enable and migrations but not CLONE_IO
>   itself, which can lead to surprises as the outcome changes depending on
>   the order of operations.
> 
> * Sharing within a cgroup is fine but the check can't distinguish that. This
>   leads to unnecessary conflicts with the recent CLONE_IO usage in io_uring.
> 
> io_context sharing doesn't make any difference for rq_qos based controllers
> and the way it's used is safe as long as tasks aren't migrated dynamically
> which is the vast majority of use cases. While we can try to make the check
> more precise to avoid false positives, the added complexity doesn't seem
> worthwhile. Let's just drop blkcg_can_attach().

Applied, thanks.

-- 
Jens Axboe

