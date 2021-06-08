Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05E53A0582
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhFHVIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFHVIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:08:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69C9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 14:05:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n12so17532371pgs.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rTsMdC4BXmfgTF7pG31W014xkPHrZAxJCnEYouFG+gQ=;
        b=oMzG0SfeYUnoGEuhJHQ7htz2XgVPAaGjqbJCsNrsjv0VT/wTC6by508zL98Ft+ChNL
         YJ3flE4tYQf42oFERX+vkSK+a1A5e4FDwYQxuFNtDDwNBoSr0N2mvxKytkLtUpU7uzYP
         cCJ7OGIf+41isZ2k+YShyaRwJv7hxwyaBHtqHPlKg5tCRB6TQBWf58QBiNkLGtLQdawx
         mzMrlPKtVgQqgY+3J9TPxWERH/iVjIoJCKCCU5CTjjS+L967Mhu/k+frrX4pWsD0reVX
         qZ1uRRRruSBovnL0kBpyCSxnp7Id1hloFaT2wzGWDYiWrFTykDalzKCkMJE8e3LIeJ3k
         VDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rTsMdC4BXmfgTF7pG31W014xkPHrZAxJCnEYouFG+gQ=;
        b=ahsrMhBSWuWHi0SPbgETh5nqxnHXv/rTFiEyQl7rHpvUV0ZDldrUz/sLnNd0ugTSi0
         Mg79oG42aSihnHSS/UDKDk0GGy5ov7qh+S8YZxhAI6IBZGw7sdUWwErjyUU4viwQNIHO
         MExc6maElvIwsBN+ZqNUDBRPypsvOHLJo0F7RxEz7iQsC0qawgpzT0HUAtJ97cz2hQZ9
         RHkMfqTAcHqrTeVFc+TNFTqwWZxYH8d7dl15D2xBD887HMLe1wiLaJQvI46GlgZtT8Oj
         a6LfEqct9yU7OIsUN/kq9+XyzW9699uTxJh9a8UFYUcb6OT8mTKvD83tTfPoOE/Pgqk3
         cXBQ==
X-Gm-Message-State: AOAM532ouusMsI59papgkgtU1jYWBaK+foUy8T8vhff0uP4XN+yc2G5j
        GpQJjYLd4EAT1MAHMYAyKSrtPsj8UMVuAw==
X-Google-Smtp-Source: ABdhPJxmIxuV54xftG6ihDeETBpL1x1bpTjcbMTDiFUjG1Hdy0sEIgM/suXMIB2EpZgu4yPgzkKiqQ==
X-Received: by 2002:a63:1349:: with SMTP id 9mr130994pgt.235.1623186357366;
        Tue, 08 Jun 2021 14:05:57 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a66sm9471059pfb.162.2021.06.08.14.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:05:56 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] bcache fixes for Linux v5.13-rc6
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
References: <20210607125052.21277-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <180599cb-7c2e-da35-96a5-225462c6cd71@kernel.dk>
Date:   Tue, 8 Jun 2021 15:06:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607125052.21277-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 6:50 AM, Coly Li wrote:
> Hi Jens,
> 
> This series is important for recent reported bcache panic partially
> triggered by recent bio changes since Linux v5.12.
> 
> Current fix is 5th version since the first effort, it might not be
> perfect yet, but it survives from different workloads from Rolf,
> Thorsten and me for more than 1 week in total.
> 
> Considering many people are waiting for a stable enough fix and it is
> kind of such fix. Please take them for Linux v5.13-rc6.
> 
> Thank you in advance for taking care of them.

Applied, thanks.

-- 
Jens Axboe

