Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629774199B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhI0Qzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:55:41 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:38904 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbhI0Qzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:55:40 -0400
Received: by mail-pl1-f180.google.com with SMTP id x4so4701153pln.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LzV6OOmZa/qvBdae7Jcnof6iK8r853c6tPcY+9ZAt6o=;
        b=f8yV0W2bGjUXPGpUzGiJ3+JgzZMdFZWqCpG27TCPMLxEdA7u7NmXycTT+d7PDKCzvt
         z+eWEmuJDpRaBtvmToXAgPN4W32jgqpZap3imwJp43ZXGGhezmq3eswQsKok2BE//rfL
         bYPFoH8xVQfF8i4UTefccQAdAMoDedrYW4tw7TpPuUePawmq1+SdPqTQcpuSICszvCb2
         3aPMdyCKqDvMBDdEpiPyG4x/lrspKhlKECP0L/niAzvUe8O/5586Yzz0JmlBg+uyb+Mi
         s2Lq8lZrE26PkyMQO4SKfAFJS9O3VTDFkyNG8oxWZWXmDziBCSjwQ19+coDfzE57Hcu6
         zC5A==
X-Gm-Message-State: AOAM530cz2UrKdcwoB6ESdUeYI5Pg2T/v2xNL/5TQHt1XqQpgnEYf9iZ
        RmwY3TAn81qqMgZWcXb1Uzc=
X-Google-Smtp-Source: ABdhPJw5w+ElVIJ+JGw99m6Ms/0MuX0gHwyQ419Kpo+mWLmE05v5KETYWHqu3MXb1mkhuQozak8+4A==
X-Received: by 2002:a17:90b:4b06:: with SMTP id lx6mr99940pjb.160.1632761642247;
        Mon, 27 Sep 2021 09:54:02 -0700 (PDT)
Received: from sultan-box.localdomain ([204.152.215.247])
        by smtp.gmail.com with ESMTPSA id r7sm17568873pff.112.2021.09.27.09.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:54:01 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:53:59 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: Replace shrinker_rwsem trylocks with SRCU
 protection
Message-ID: <YVH3J+bIGmCLVr0e@sultan-box.localdomain>
References: <20210927074823.5825-1-sultan@kerneltoast.com>
 <YVGClLWLXO8AWaEk@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVGClLWLXO8AWaEk@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:36:36AM +0200, Michal Hocko wrote:
> Can you be more specific about those scenarios please?

I see frequent tmpfs mounts/unmounts in Android which result in lots of
superblocks being created and destroyed, and each superblock has its own
shrinker.

> I have a vague recollection that this approach has been proposed in the
> past. Have you checked previous attempts?

I wasn't aware that there were previous attempts. Is this [1] the previous
attempt you're thinking of? It seems like the thread just died out. Was the main
gripe that always enabling CONFIG_SRCU increased the kernel's size too much when
tinyfication was desired?

Sultan

[1] https://lore.kernel.org/all/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
