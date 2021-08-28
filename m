Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100FE3FA6CD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 18:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhH1Qg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 12:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhH1Qg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 12:36:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C401C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 09:36:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g18so7946838wrc.11
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yw6QjJ2SFguANxccOBY3RjF0kVj4G1Ry9pMp4cwJu6Y=;
        b=rdjhtAdT8yNFKrNd7VJib5phVK0TSvVLw3LGhRFgzGKikcjJvi6G57CrOUV0F+nLlh
         bgrTnTXI/eJiq4YCPgSgWAr/7e2VrWGNxYcWIl5rKck5Jj9yAALARK02v3MNf66jEeDD
         UAnMamGH846HKCdElVJmfCtkljQeQfs1DwOdLXtilcAFUSPxqBwinJT2vLuVjQTlCXvH
         UZlo7VN35DlKOClYdu6WA58gYP2hZa8CBm48tY5iy3E+zobq8FeQx+RsxblYeHTo9dWY
         uBjYWridsU7oiFj6gL1oF52NgaT1tttKM0BCNbbYC/7CcAuyK70AvTXwvcRiUWZDue2S
         Wgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yw6QjJ2SFguANxccOBY3RjF0kVj4G1Ry9pMp4cwJu6Y=;
        b=tNrs45aaf3ywHKvn3w7u2Gk2xZ1DP+3CxJpd7S5vmHM1NEk4F+2ptOs2Z6Ay/WtPaP
         C/8wv1dI6sHzQ8WpTF4Nn7LgUOj+SRLsK2F2GnNWXC8SPDV9kpaukS7udN8Mz4Gjz2hU
         yNlge7qrLSQnScf6pz7z9xvYt7CY5lV3NpkiLC2RpQsKyveg3Wv6NR8DHwVZ1WexLwMM
         jED0IAzNuw8Fz/sqYD6CHUJ2RVNizSm2DpyAigCVH8LFtZpPzcEINc0l1HOnrkWDGLFF
         NY+nhkbqsy3mqKhzo1W6iMr5FPGjHyzI18HMoBlEbYnyXghoAUXPCi5Ubyjky3AThp+1
         124g==
X-Gm-Message-State: AOAM533Po5Pwd55inDfZEovaXuwh5lLCz2nSAkUYzWvNC1dEHo7JqcA9
        QOG26l8F2Aw1VbRmYIUiTRLnSw==
X-Google-Smtp-Source: ABdhPJzSyGUGIB674cHGiooZB0yAbHvFMogIDNFQN7cKZq3Cokty3AaTEhP8C4SGf0dRr03ipf1g9A==
X-Received: by 2002:a5d:6483:: with SMTP id o3mr16547978wri.197.1630168563898;
        Sat, 28 Aug 2021 09:36:03 -0700 (PDT)
Received: from localhost.localdomain (p200300d997377800bfcce9c41b9fab2f.dip0.t-ipconnect.de. [2003:d9:9737:7800:bfcc:e9c4:1b9f:ab2f])
        by smtp.googlemail.com with ESMTPSA id o5sm9760207wrw.17.2021.08.28.09.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 09:36:03 -0700 (PDT)
Subject: Re: [PATCH] ipc: replace costly bailout check in sysvipc_find_ipc()
To:     Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>
References: <20210809203554.1562989-1-aquini@redhat.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <42b60dd8-8393-5e0f-e576-da5303f29fe7@colorfullife.com>
Date:   Sat, 28 Aug 2021 18:35:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809203554.1562989-1-aquini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 8/9/21 10:35 PM, Rafael Aquini wrote:
> sysvipc_find_ipc() was left with a costly way to check if the offset
> position fed to it is bigger than the total number of IPC IDs in use.
> So much so that the time it takes to iterate over /proc/sysvipc/* files
> grows exponentially for a custom benchmark that creates "N" SYSV shm
> segments and then times the read of /proc/sysvipc/shm (milliseconds):
>
>      12 msecs to read   1024 segs from /proc/sysvipc/shm
>      18 msecs to read   2048 segs from /proc/sysvipc/shm
>      65 msecs to read   4096 segs from /proc/sysvipc/shm
>     325 msecs to read   8192 segs from /proc/sysvipc/shm
>    1303 msecs to read  16384 segs from /proc/sysvipc/shm
>    5182 msecs to read  32768 segs from /proc/sysvipc/shm
>
> The root problem lies with the loop that computes the total amount of ids
> in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
> "ids->in_use". That is a quite inneficient way to get to the maximum index
> in the id lookup table, specially when that value is already provided by
> struct ipc_ids.max_idx.
>
> This patch follows up on the optimization introduced via commit 15df03c879836
> ("sysvipc: make get_maxid O(1) again") and gets rid of the aforementioned
> costly loop replacing it by a simpler checkpoint based on ipc_get_maxidx()
> returned value, which allows for a smooth linear increase in time complexity
> for the same custom benchmark:
>
>       2 msecs to read   1024 segs from /proc/sysvipc/shm
>       2 msecs to read   2048 segs from /proc/sysvipc/shm
>       4 msecs to read   4096 segs from /proc/sysvipc/shm
>       9 msecs to read   8192 segs from /proc/sysvipc/shm
>      19 msecs to read  16384 segs from /proc/sysvipc/shm
>      39 msecs to read  32768 segs from /proc/sysvipc/shm
>
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

I've tested the patch, no issues or objections.
Thus: Let's merge your patch, and then switch to ipc_get_next() later.

Acked-by: Manfred Spraul <manfred@colorfullife.com>

--

     Manfred

