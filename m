Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DE24447FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKCSOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhKCSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:14:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571B5C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 11:11:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o18so6817728lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=e9PtYTgDB8+YB1gBdzoSlzG5vdler0u+y3rsoEKkHvc=;
        b=lwQrLmaO+xWXb4nQyOXOmoa+LQxFBWIekcWBM/+2SNeO4ndZ7Pwsj8OKvb0Mbl3+ns
         iIiuKabv3bz2r/UzmJm1JbUMs+iF+mcWfhtf6wnh/qjVNWRd3D1GhyDfJ9Ri630Z9W+P
         twhQ1e6+Crfo4qWkSRT6Fo2JxbgxSwhli7an34Kq/LFwIqyom4E9vXbRARiC7yMN9o2Y
         3vBwKf6xnpvJm7JBEGMn4JB+ZCUe3OHmavnfs3mqjSyjouuq4XaO+yLLy3hMNTxh4Fkx
         g3ThT3sfMCjjNuDBtg3Pc7vF6K+SvhPsjy9b/wKAth1wb3ZLGfWWqJrtPTwBy6fSWMz5
         CWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=e9PtYTgDB8+YB1gBdzoSlzG5vdler0u+y3rsoEKkHvc=;
        b=CmS1R0xUOB49SSmAzkMlHPGybGYJ4C6/UK2bPjJPkkRT2GzThUv48c8Nobt3SLJVwW
         Taifo6rc88fs9p8xO/pyTs9aZboJmYAamM5JUQkQWE7I300QXARhm1L0sogtdvUP+sPW
         CNLwQctwZICmnc2sRV455Fa9PqmNCB+1B35MHSp77mGIlMeT/RFQUgaknjdNECuQ3QvK
         7iMsvYcIcXX7Ge8Hz34DPqyl/CCTI5oo1oYPgd+egubx03uwk6yPfmFi1L50MfHRpXFz
         aY62c+rO1T01r7/oz6T7+y6Hs5sGuzwt1HJ+L718YCr9WbtNMQgHrCa3QUR6XjOCKVZw
         AaxA==
X-Gm-Message-State: AOAM533f0gtTqvbemGMsUF2RX7kSAaHbWzab1Q5vroKg4J2h9DINGIQy
        QUP904I8p1nfz4eJmfg91jITDOElilz42al9fxM=
X-Google-Smtp-Source: ABdhPJz4BXTmYFgNtYGbuA2uXdiy347wtzl3YsUGgG3Y5frLuYrMIinyq4T0tlXTI1/rdI8dc9cXQz/Gu0p/oCYH7mY=
X-Received: by 2002:a05:6512:400f:: with SMTP id br15mr15374657lfb.377.1635963084643;
 Wed, 03 Nov 2021 11:11:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:834c:0:0:0:0:0 with HTTP; Wed, 3 Nov 2021 11:11:23 -0700 (PDT)
Reply-To: emmaludwig64@gmail.com
From:   Emma Ludwig <dpakiyendou@gmail.com>
Date:   Wed, 3 Nov 2021 18:11:23 +0000
Message-ID: <CAKEWdAjUvPzAwkLZ5LMhW_X5YWnv6vQi4777h-O7Aib1oR2zww@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ich habe dir vor zwei Tagen auch eine vorherige Nachricht geschrieben,
aber keine Antwort von dir,
