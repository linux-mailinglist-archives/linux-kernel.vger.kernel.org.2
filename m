Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECFC399FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFCLhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:37:00 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:53843 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhFCLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:36:59 -0400
Received: by mail-wm1-f42.google.com with SMTP id h3so3184319wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dDlsfUVoPz4mflmjcY/17kiGQZC/D+4tAfNsl24/syY=;
        b=I33Sa5PdYGfNQKY6cAOIwcMXmeroW1m4Oz5alOZxht7s147JhQGghyjwGeESW8gRo6
         SuP7K1TW+jJxffBQf2GxFw1F6/UzK1CV4s4VSF8AE9U4cL9xDRHxoG/oa6eHYczCRMj+
         ahTYmh0FeW4SmS7S7hRi1WnWRh6Ci+cqtf3UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dDlsfUVoPz4mflmjcY/17kiGQZC/D+4tAfNsl24/syY=;
        b=QANP4H/Arrqc+rdpPiUUhNKw1RLofWT+Tk82X+2TsOemhVoezcgLFxScnQ/DKMp5iw
         DXD//DTFakbwQos11VqZLFXoMFs4KTDr9FNcUuuBaa4f8qodVDswsB5T7VXHgBwi4Zki
         mNGDedmlbhF8mb8Xxi0rC1nZ4p2y+Tl4QXp6w7pH2O0MBW4jjF9rrorjlMcqSf3TxllZ
         XX7GF5h1S4xKIgjg2PMrzb27AvOuUgJP5FSN6kdLjhHd50Kf//8iA4x0MKv9+gQVN0xB
         p6CJuBHiphe8dIFjhE8gZOXVyGa9y1nR7UdSichlosN0ZFKi4IDEkun5U6n/h9X1uACW
         ZI5w==
X-Gm-Message-State: AOAM533KpA9kPeiYCpRV0QOZkOt5219j7DITQlhObWMR2/3WQXPo+TwM
        /v7ZAVpthgtpTy630bBv1M/UyXygbUHUvrVmZsc=
X-Google-Smtp-Source: ABdhPJzxGp42YLePRB+COjvEZscGLJ1f57oLKFzG258csqxuu/Y26xpaJN44MSJysb/GFA/LgvlFLA==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr9615488wmc.88.1622720039043;
        Thu, 03 Jun 2021 04:33:59 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6726])
        by smtp.gmail.com with ESMTPSA id l16sm5710461wmj.47.2021.06.03.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:33:58 -0700 (PDT)
Date:   Thu, 3 Jun 2021 12:33:58 +0100
From:   Chris Down <chris@chrisdown.name>
To:     legion@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
Message-ID: <YLi+JoBwfLtqVGiP@chrisdown.name>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

legion@kernel.org writes:
>From: Alexey Gladkov <legion@kernel.org>
>The /proc/meminfo contains information regardless of the cgroups
>restrictions. This file is still widely used [1]. This means that all
>these programs will not work correctly inside container [2][3][4]. Some
>programs try to respect the cgroups limits, but not all of them
>implement support for all cgroup versions [5].
>
>Correct information can be obtained from cgroups, but this requires the
>cgroups to be available inside container and the correct version of
>cgroups to be supported.

Then they should add support for it. We already export these metrics as part of 
cgroups and plenty of applications like Docker, podman, containerd, systemd, 
runc, etc already support it.

Putting stuff in /proc to get around the problem of "some other metric I need 
might not be exported to a container" is not a very compelling argument. If 
they want it, then export it to the container...

Ultimately, if they're going to have to add support for a new 
/proc/self/meminfo file anyway, these use cases should just do it properly 
through the already supported APIs.

>+	for_each_online_node(nid)
>+		mem_cgroup_nr_pages(memcg, nid, mi->pages);
>+
>+	mi->slab_reclaimable = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B);
>+	mi->slab_unreclaimable = memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
>+	mi->cached = memcg_page_state(memcg, NR_FILE_PAGES);
>+	mi->swapcached = memcg_page_state(memcg, NR_SWAPCACHE);
>+	mi->anon_pages = memcg_page_state(memcg, NR_ANON_MAPPED);
>+	mi->mapped = memcg_page_state(memcg, NR_FILE_MAPPED);
>+	mi->nr_pagetable = memcg_page_state(memcg, NR_PAGETABLE);
>+	mi->dirty_pages = memcg_page_state(memcg, NR_FILE_DIRTY);
>+	mi->writeback_pages = memcg_page_state(memcg, NR_WRITEBACK);
>+}

This presents an extraordinarily confusing API. A cgroup can contain more than 
one process, so it's not right to present this information as "meminfo" in 
/proc/self when these statistics may not have any relation to the current task 
under question.
