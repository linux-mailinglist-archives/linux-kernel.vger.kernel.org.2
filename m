Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E684498D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbhKHQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbhKHQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:00:20 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF8C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:57:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id o4so2388634pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aAjH05HC+Yq1fpsWfaNYfykzHpOqzzS4xldmSGauAaM=;
        b=U47JQ9Gbtp8jgoX0SWnGU0TaWD8J7Y54lErjWuV0xiAq+NpnBpzUzJzu2+BOHoCWfk
         SThivXCjXqDs0VvAe64Sgd9iVUu7Uy9bXAcleMtJnQa/QEBXAK9hFhmGheCd2q/ptZ90
         DDO81JVBaFhuYzkrbllw8Zyl0JzAmwKZEu+PqBeoufrHPlRRQX53BSyqQogRjlPZSoT7
         SeVcu6UQPGlxONCiXDx83aFYBS6J53iY5yasKsJiR9MFDWrF3radP+TE96kXANonIG7u
         op8Yrtlw1GVPb67r3oPSswMJ8EvRkHBa1wM9+WoC77JIFFHqzqlEW9cre2VA1nFUZY1w
         xChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aAjH05HC+Yq1fpsWfaNYfykzHpOqzzS4xldmSGauAaM=;
        b=gorNkaDDxbtOIIAMNKzPki+7BpQexq+cDM5ORi+2Hh//Hg97ykTE6SO/noCYb4gU7I
         TheuXCYQmLxcMlAkWghJb/w0bwUP90FRk0cqpk9fTO3IS72qPzd0glS0eaq2/tLtEyRd
         KxN8hZjHzSK/0KOsZRlB1NacA+/AiBQI9KPw4qHIdGRLycQ/rptikGrFNN2XhtwvszVp
         vFkjFh4HTYdA8ILZBWadifBXcl75fE7F/6MrCpO+kzrOtEXRHFKzvEXs/x1DETu6ulSg
         DMbXeqpM/8q2VKx+5nAk2G44aTHvTEK/LHcT96G52alkgYUvawO3v6qkokVP6rBQo35h
         xIkg==
X-Gm-Message-State: AOAM531FwT/OKnvM9H5mmKQcNYWbpBbtxL1T0wrwtPNRpCJqZ3Em7acX
        8jotxYNUoMNPob+kiJaL2hsd8UfMYSeisw==
X-Google-Smtp-Source: ABdhPJysuDsGhta8Eh9p88a5MKNlvAtiuKLqEkwJivaPV5LjcttH3PQSpuwr2xo0o+VYUXzJsmI9zQ==
X-Received: by 2002:a05:6214:3004:: with SMTP id ke4mr368613qvb.48.1636387045135;
        Mon, 08 Nov 2021 07:57:25 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id y6sm10409448qkp.116.2021.11.08.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:57:24 -0800 (PST)
Date:   Mon, 8 Nov 2021 10:57:23 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: vfs-keep-inodes-with-page-cache-off-the-inode-shrinker-lru.patch
Message-ID: <YYlI40bWhtbKMwrz@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I promised to give this patch some more testing exposure while it sits
in -mm. We've been steadily rolling this version of the change to our
fleet over the last months and it's currently on 20% of FB servers. We
have not noticed crashes or performance regressions because of it.
(The other 80% is running a previous version of the patch.)

The comment in 'series' says "extra cycle" but that was 5.15 :-) Do
you think we can get it merged into 5.16?

Just to reiterate, without the patch, there is very broad production
breakage for FB beyond reduced cache effectiveness. Yes, we lose cache
pages prematurely. But a bigger problem is that we lose nonresident
info we store in the inodes. This defeats thrash detection, which in
turn defeats psi and central reclaim deciscion making. The downstream
effects of this are quite severe and widespread:

- memory prioity inversion between containers
- failure to offload cold memory to swap with proactive reclaim
- breakdown of container health monitoring and userspace OOM killing

I'm not exaggerating when I say we can't reliably operate our fleet
without this patch. We've had to carry variants of it for two years
now. It'd be great to get this fixed upstream.

Thanks,
Johannes
