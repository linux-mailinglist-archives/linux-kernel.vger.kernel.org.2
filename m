Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CBD3FF05E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbhIBPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbhIBPl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:41:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C671C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 08:40:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so5254044lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuYhyTGw4lWqSUdES+fH4JDl0igY3Z4nvbSSawEsyY8=;
        b=q2wgJmOJjmwtv6XnpZyovktbSHyXroKKJ2fF1aUJor5EIp3Rd/ebY/PBptHCiPGyMz
         bzpoFgKjl6118ndzykrhkCWga2CoqXIJTRYJTrSM6B/64Xqnl0shWAmpUUcuCSuetWqm
         p5ps+nYVeSQW4aVY/aIJYAvr2RL/ybwK6xC3tJTDItyPDasKPB/GiyFqY+QjDPzHPLrd
         Cl4o7i1RZMjc7ryI324/et0O73ZFmBqcMv+uNslz5k4LcPwWV1StWy5LFt+supK7k66A
         jaHzDiLzfqceMzTkLzSNaFJjOeEsquwp2MT7fF0ZkXchXoV81KQ9V0c9DW+01SmR98D6
         L6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuYhyTGw4lWqSUdES+fH4JDl0igY3Z4nvbSSawEsyY8=;
        b=ZTeccl4Kas5b00KigDR6q6kpHp+zNzoA5ltXspX7vjCBAAl7pCrt9ELgLTIdsJsToc
         nnpa+9Np7reTwF7YaqAD7UlWgEHh4lYmWXBg9wHfsAAjxsQP4sMvKUjaWarqQQysdy+c
         HgSug1HAyXKHN0/YPSTPv6Y49pz90HaMK4vQTMly5ip0TqgfhHrrxUbZZ8W1QkzFcEg6
         WpZZIN4y4N6PRTAwJugtB1q5QuLbF8/8FPS3sycJhzWGLAdgrnawjn/Pl+dDaCPrtLgY
         IPCAeLWJ1YnRnJuc428uQhDsh+2aTREOSSwWD9e0UcBo+XxA1Aj7YtQafHeyTEmXI1Dt
         bIbQ==
X-Gm-Message-State: AOAM533J71wQpILoyG9lJS8m4S7RPSilieoTXIQXkIXW3FnI8s5qwS8h
        DMUEVJkXHXP2mER3gPB9YJ8fy/ld/uX/gw==
X-Google-Smtp-Source: ABdhPJyHgof7YjHUqCBdwf9LcChC69K35HwidG8abusTBlBaVtir5R1C9iO1PLdN3iVOmgCNY9Qmyw==
X-Received: by 2002:a05:6512:22c4:: with SMTP id g4mr2936623lfu.500.1630597254951;
        Thu, 02 Sep 2021 08:40:54 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id 25sm258630ljw.31.2021.09.02.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:40:54 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH 0/3] fs/ntfs3: Make entry binary search faster
Date:   Thu,  2 Sep 2021 18:40:47 +0300
Message-Id: <20210902154050.5075-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series will make binary search faster with removing the need of
allocations. We will only use stack memory. This will also make possible
to remove linear search completely.

It is good also point out that full binary search not quite fit with
entry search because entrys are not always same size. This why we first
need linear table fill algorithm. My implementation try to use the fact
that we should not linear fill full table before not doing any checking
of the entrys. It is example 50/50 change if we are in middle that entry
is in first half. So it is very inefficient to fill table after we are
middle point.

We could also predict how many entrys there is and use this information,
but I did not do that in this point. I'm more than happy to improve this
more if someone has ideas.

I have tested this with xfstests and did not see regressions. Checkpatch
and build tests for every patch have been done. I haven't done major
bench marking with this one. Idea that this is better is just my two
cent. Paragon has hopefully done bencmarking with old binary search
compared to linear search? I'm quite certain that this will win old
binary search algorithm because no need for allocations.

Thanks Joe for let me notice this improvement.

Kari Argillander (3):
  fs/ntfs3: Limit binary search table size
  fs/ntfs3: Make binary search to search smaller chunks in beginning
  fs/ntfs3: Always use binary search with entry search

 fs/ntfs3/index.c | 153 ++++++++++++++---------------------------------
 fs/ntfs3/ntfs.h  |   3 -
 2 files changed, 45 insertions(+), 111 deletions(-)


base-commit: d3624466b56dd5b1886c1dff500525b544c19c83
-- 
2.25.1

