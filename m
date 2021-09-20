Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3894118AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbhITP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:56:45 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:45786 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhITP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:56:44 -0400
Received: by mail-pg1-f179.google.com with SMTP id n18so17785901pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6jFxJJuT4Dtwqmcu5yYwgUvY5yux5mAiO+wx0G598Y=;
        b=goRMTi2Hjxg30SVQFKfq9+a5rq7fuY+/ayRWgPdRm5I22PvOZ682oqZw5wScH+vYma
         2v4ILMQZgm7VZz5pSTz33VBncEu6FJtmYMRWM9V3H4hqDYNtVA+Rdmr/fxGAskzifzER
         7A3uFWNc2ImUDKNqiFK9OqAy/Of0atyO7hL3pm9RtuQ5z2hpe/B/hKUulIxBd56mOtPy
         rErhkaSexcwSTsVacduoaPZtxcUPKGm/3OTxawLxIbwzR0tPUmLA9EzGgC/hKEa//6vu
         mtviv3ePZJwdn/Rr25frWd2Pq5I3QVQRzZcE7CAbQKZuhSRzpy1mt0LfmBH1lu5ErkWF
         Jvwg==
X-Gm-Message-State: AOAM5300gDURTwUX/6DtLt9Df9SDon8GaWahCgvTaMoI6CYhJLl6D6UG
        FOCS5uU3ZxxffhukhWdUrfk=
X-Google-Smtp-Source: ABdhPJwPGOxfJ+V57SFYoxgpHJJ4/CVeutyP823krqlMz/AVcwyszW+yNR8Dwmj9/u/By+QOPChRJg==
X-Received: by 2002:aa7:94a2:0:b0:447:ce69:7601 with SMTP id a2-20020aa794a2000000b00447ce697601mr2838614pfl.46.1632153317073;
        Mon, 20 Sep 2021 08:55:17 -0700 (PDT)
Received: from sultan-box.localdomain ([204.152.215.247])
        by smtp.gmail.com with ESMTPSA id t13sm13790293pjg.25.2021.09.20.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:55:16 -0700 (PDT)
Date:   Mon, 20 Sep 2021 08:55:15 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-ID: <YUiu42krQjSTVPnc@sultan-box.localdomain>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
 <YUiBRdrkjIdB/rSN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUiBRdrkjIdB/rSN@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 02:40:37PM +0200, Michal Hocko wrote:
> What is the actual problem you are trying to solve here.

There isn't any specific problem I'm trying to solve here; simply that, it
appeared as though you intended for the reaper thread to be freezable when it
actually isn't. The OOM killer is disabled after processes are frozen though so
I guess it could be considered a matter of consistency to freeze the reaper
thread too.

Do you remember why you used wait_event_freezable()?

> Freezer details are hairy and I have to re-learn them each time again and
> again but from what I remember wait_event_freezable doesn't really depend on
> tyask being freezable. It tells the freezer that the task is OK to exclude
> while it is sleeping and that should be just the case for the oom reaper. Or
> am I missing something?

The task indeed doesn't need to be freezable, but the rest of what you remember
isn't quite true. It tells the freezer to exclude the task only because the task
will handle entering the freezer on its own. When a task sleeps on
wait_event_freezable(), it will be woken up when system-wide freezing starts,
and then it will try to freeze itself (see freezable_schedule() and
freezer_count()).

If the freezer bits here are undesired then I think wait_event_interruptible()
should be used instead.

Sultan
