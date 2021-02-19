Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD50320179
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 23:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBSWuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 17:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBSWuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 17:50:04 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5ADC061786
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 14:49:22 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e7so5834369ile.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 14:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1+QL0ZJy98i2Loy47lzBuvz+WCAjo4otcQSOPkGKDA=;
        b=RBW0QcSz6mlJhrzmI044HVf7H33xiie7VtzMqoPyUVPUiCzWMDQlVd+JAdD4kCeq8E
         uCfrpsfg9/5IaESjoFjbMc7Dh2FA52tNPJgq8D+hfk8e2j6UptbbK1+yVtlABlPBTJvO
         hLA6qmg4uxx8NEq1MkKiLPMcBd0MbSt97SKQgU8UP710+LCCkKHNeEFwhLvmFSOvSFBd
         RcWplb3E9ycnwIszyXRY+ynXKuCvanhLGgsAYYN5OubASSVn7DlAfsf1HD/h9j3D4Hme
         nLdx+H4S3kDYJ1gVVEHElHZg4/JXwWbspaMQpkdIo46ruSd+SyMMT13vFr0BiPhQMVRa
         LSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1+QL0ZJy98i2Loy47lzBuvz+WCAjo4otcQSOPkGKDA=;
        b=tzaPi6afbM/ZJ1hGvGDBwK36dSuL9qoJr6yFtCIsDptryxBnjwoqZJ0WVlW1W5AJBx
         yUC76ORZ9m+d32WbhGw2bSflTM1EibDGWOSFfoPhkKcXnFPjS5BlioNn/DlMgFl/VEAi
         ti6PcSXh4q4WcbdkKuI1glLX24zwxeSErvNnW61VDaY4Roo/Dc1YUemZ/kqNaiIBwT9K
         8490tYXrf4HhQ1HAeWHG732L/yTTWUCgH5AF06b1rjPBX7HJzqV0svkJ56x8xabVcDpj
         PBThCIk57GoOWNekeGb5+4ZjeMxxRm0rmDBzjX4tuNoTNTRLqRoguQEUfS05pYbYcQGb
         YhcQ==
X-Gm-Message-State: AOAM533IWdXa+3mfwKPNl04L+9gnMSX0iQtSZHgC+tVZAXZKnMbz4rmy
        2uEYUsPgRIwUnTlADa0HupPUTitlj5Y4AIHaTqprhA==
X-Google-Smtp-Source: ABdhPJw0SO//jD+r4I3M20a9EPa+9uGZVnB6XKrlcrUvMNeZndLvUnGSJzFS9rPtoxR1/EERC+V5IL4d74bVTGOqqRs=
X-Received: by 2002:a05:6e02:214f:: with SMTP id d15mr5964595ilv.180.1613774961367;
 Fri, 19 Feb 2021 14:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20210219224405.1544597-1-shakeelb@google.com>
In-Reply-To: <20210219224405.1544597-1-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Feb 2021 14:49:09 -0800
Message-ID: <CALvZod5-wiSX8BkUAxNAOU-61e+0KNWm0hdQKhe+qtrFgPsb1g@mail.gmail.com>
Subject: Re: [PATCH] memcg: charge before adding to swapcache on swapin
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 2:44 PM Shakeel Butt <shakeelb@google.com> wrote:
[snip]
>  mode change 100644 => 100755 scripts/cc-version.sh
[snip
> diff --git a/scripts/cc-version.sh b/scripts/cc-version.sh
> old mode 100644
> new mode 100755

Please ignore these unintended mode changes. I will remove these in
the next version.
