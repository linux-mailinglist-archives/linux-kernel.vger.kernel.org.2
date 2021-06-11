Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2810A3A4356
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhFKNwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:52:35 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:35559 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFKNwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:52:33 -0400
Received: by mail-qk1-f172.google.com with SMTP id j189so31015887qkf.2;
        Fri, 11 Jun 2021 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=Vcij7NrPMkCvyJHAqP+PNXJ1m2LDMYuEJqY2GEWx4uk=;
        b=cLtaTlvzJsrycgBKgPT3J3MiVtcry9Wv/dGtaM0ra8zTVzd2cQZ0UFce+0OfJ6LgDt
         aPUzXCakTEYyW4fMcNGHx3Rr/KoUvtcL9aurZjLcFz/PvTStSwEiR7R9KQnS2mRa6+1H
         6tDWOGiz8QdRgiNSOdIqEUxKFXkJWCKcjeTTc8KicWtBcv+zuos+CLBrQFpY7WTTkjAS
         +N7n3J/+Xz54oY+Z+/EQgiEYnfLzvumdxmfg61scQ2BeXYU8PXZ8ReBrDLxq2FHnkGLx
         3wtlR9lSlZJ89HFmkTP+6+YTigEkfbpSDKRsHCg1kILNnKlxzvUO/Dv8p53MWosC5+/o
         ad4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=Vcij7NrPMkCvyJHAqP+PNXJ1m2LDMYuEJqY2GEWx4uk=;
        b=Bpd6gc+q8Kt96NdDO2YhpiqzaGyNw+9WFYxZB3kSI84AQgcFWD//XbOu01PZJs/cqx
         vmGxFrbDdrIho3UTKorLIjFi5QhJfjehg9UNcdUygGRPh8vpXj4voG3ATjwuLcfcnMxH
         U3Wh6ylsn8q+kYdTS9Y31R1rkxjbDB8t0z6/Vj0q7r4CaBquJfYl3DAbBMn7skjmj5YU
         xzra6r0uAzf4mp76xD0DvGbH4lr7OIc6r+eUkENYzXXpSff4DhSulnndna8/Bd+9vtqt
         fMbrQmhn2Does3Petv7nEJ0SipMB9SO/FpKi1DN3yImBKCastQRdxyMZJ+gs3SZPuIMt
         arsg==
X-Gm-Message-State: AOAM533zkKPWhssE7yuMJKX2NJbSynIe6xeGPvh+xvqIRh/XYOM7T8zr
        TFBpYEHkFbTRugZUhCQXAIo=
X-Google-Smtp-Source: ABdhPJzJxqYScmXh7B/Tr9VtL9iUKreQUbM9jktN5QXk1XOK3vd9AbM80/s95/fBHAaln8ELHD/qAA==
X-Received: by 2002:a37:6114:: with SMTP id v20mr3956884qkb.157.1623419375239;
        Fri, 11 Jun 2021 06:49:35 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 3sm4301926qka.4.2021.06.11.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:49:34 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     "Shah, Amit" <aams@amazon.de>
Cc:     "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "snu@amazon.de" <snu@amazon.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "linux-damon@amazon.com" <linux-damon@amazon.com>,
        "zgf574564920@gmail.com" <zgf574564920@gmail.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "fan.du@intel.com" <fan.du@intel.com>,
        "Park, Seongjae" <sjpark@amazon.de>,
        "amit@kernel.org" <amit@kernel.org>,
        "gthelen@google.com" <gthelen@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Foerster, Leonard" <foersleo@amazon.de>,
        "guoju.fgj@alibaba-inc.com" <guoju.fgj@alibaba-inc.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "greg@kroah.com" <greg@kroah.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "elver@google.com" <elver@google.com>,
        "riel@surriel.com" <riel@surriel.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v29 04/13] mm/idle_page_tracking: Make PG_idle reusable
Date:   Fri, 11 Jun 2021 13:49:20 +0000
Message-Id: <20210611134920.6302-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ac98333d677a3ae8d25a998816e025954826e5c1.camel@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hi Amit,

On Fri, 11 Jun 2021 12:55:27 +0000 "Shah, Amit" <aams@amazon.de> wrote:

> On Thu, 2021-05-20 at 07:56 +0000, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > PG_idle and PG_young allow the two PTE Accessed bit users, Idle Page
> > Tracking and the reclaim logic concurrently work while don't interfere
> 
> ... while not interfering with ...

Will fix so.

> 
> > each other.  That is, when they need to clear the Accessed bit, they set
> > PG_young to represent the previous state of the bit, respectively.  And
> > when they need to read the bit, if the bit is cleared, they further read
> > the PG_young to know whether the other has cleared the bit meanwhile or
> > not.
> > 
> > We could add another page flag and extend the mechanism to use the flag
> > if we need to add another concurrent PTE Accessed bit user subsystem.
> > However, the space is limited.  Meanwhile, if the new subsystem is
> > mutually exclusive with IDLE_PAGE_TRACKING or interfering with it is not
> > a real problem, it would be ok to simply reuse the PG_idle flag.
> > However, it's impossible because the flags are dependent on
> > IDLE_PAGE_TRACKING.
> 
> For better readability, I suggest:
> 
> For yet another user of the PTE Accessed bit, we could add another page
> flag, or extend the mechanism to use the flags. For the DAMON usecase,
> however, we don't need to do that just yet.  IDLE_PAGE_TRACKING and
> DAMON are mutually exclusive, so there's only ever going to be one user
> of the current set of flags. 
> 
> In this commit, we split out the CONFIG options to allow for the use of
> PG_young and PG_idle outside of idle page tracking.

Thank you for the suggestion, it looks better to me, either.  I will update so
in the next spin.


Thanks,
SeongJae Park

[...]
