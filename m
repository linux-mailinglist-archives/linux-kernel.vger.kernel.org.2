Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3765B38E372
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhEXJis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:38:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD2EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:37:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n2so27909110wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=eDrYI330g2FzhYKn+4hPogmPRz25LSNoxfJ23kSyb5s=;
        b=tJ0hM2HiTfP+YC6rqU8Hf9M4qSZMUM/bEXPJyVK2XaI5QBuI01GybBYIiLPWmTPsDc
         gPrRZJ1A6FMrkqdw/G8l1cw53JSD54otveALt429Ks6gahJkpIFqZWFeg/MZ7hDQH4oH
         ZE8olc/FI/kO9m/0RvKVsDjBFgdGtDKtVTlR+itw1HSGRdWl5R4MkvMEjfH9kAFMofw7
         6BO4mMjkeUHTMDdZUOyN0+7gdG+EESIFSNctYRlsQOEbYNQqRtF5pUnEKgTG9X934Vi3
         /CpirNJRlSxfzJ0EA1muZSCbcybqnLDOrkacNqPxo+xez6TKs429RQaiMv393PQ3ni1n
         PZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=eDrYI330g2FzhYKn+4hPogmPRz25LSNoxfJ23kSyb5s=;
        b=cJaU0g2YY84KXe7eArqLncFniv4yjs5cUEAGcATNRHAFn605jg92IerK0OVFax5Nxt
         t8RjHUyFDWB3IfCxn5yzsa5lQconvarbV5VBqOLSmIPYmBHeNUYYtXANQF+twPBxDuCd
         +XCCFW4aAFH7ICGY24pJ3Bo6cUQt0lm81Zio4Ifj4ex6q/CIacSA3YC35qqm2T2pISW6
         85j6TTTcFcX6H/4bX23OO+nDbfK31mIUqJwhot5i1CnzLFJJ2LtUZcXlILDgG9FC6VjR
         SslnQlR1V1QgYbfBkA6rAf53kbjXxiFpAQJWJdXKAXObUpjJhVy4eFRHit98PiDUYQgL
         8NiQ==
X-Gm-Message-State: AOAM531ULyfOXTtq1VfmdxbhUKu2s4UVhgaBQTNEHRY/L9mKg1JuNVlW
        p7aDK2g5uFu1FXhTX4fZMQ86/Q==
X-Google-Smtp-Source: ABdhPJyxP4K03dqX+BVEirSz7HMQ95Xnk4RY0NTu/bRcZAbWtqcKa2tYpeP7fH6NjTaC+VDVjR9TTw==
X-Received: by 2002:adf:ffd2:: with SMTP id x18mr21126282wrs.144.1621849038532;
        Mon, 24 May 2021 02:37:18 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id i5sm11881875wrw.29.2021.05.24.02.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 02:37:18 -0700 (PDT)
References: <20210520073136.272925-1-jbrunet@baylibre.com>
 <CAFBinCB=pAipcZOi8S005SyO8ptfzy8oGpW4S8Pi++A5-Jc5eA@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: axg-audio: improve deferral handling
In-reply-to: <CAFBinCB=pAipcZOi8S005SyO8ptfzy8oGpW4S8Pi++A5-Jc5eA@mail.gmail.com>
Message-ID: <1jy2c4bhgy.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 24 May 2021 11:37:17 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 20 May 2021 at 22:18, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Thu, May 20, 2021 at 9:32 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> Use dev_err_probe() for clock and reset resources to indicate the deferral
>> reason through sysfs when waiting for the resource to come up.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied
