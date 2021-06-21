Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40C13AE695
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFUJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFUJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:57:24 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6770C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:55:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bj15so27155003qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9JDp9HOgPxFOjYO36t2fKrvGXWr9xGcLN7LKHpuyZs=;
        b=RFQH5oxZSZU3HJjB9ZugZzZVrBuZk/jeZyqnqPNqw9QZwYg6+9DxQzu8qWxefvfaFR
         ICnrY0AnYT7V0B0u5FneQ92Xtq1zpKfYijWuDa1cD+bknYtwrjfjlo0sMQWwCfAo4vdP
         sZvU9ISu8v98DyAdiDOQgvKL4PK7AWYACi19f2v2OyOeZziyLbV4tA3Fah3eb2u0Czzb
         pHMyffUwdcOY7vtaObvIPlWRWeSmv2fdaZXtrWIPSYDPLYJibZMhV5z9GHP9NoE1CdJ7
         6cT1CXuL4AHch+FNilt9yQYh2NnSLVEWEm9wjKqjH8gzFi857vvC4EV+sj7SsqT9ujSE
         KYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9JDp9HOgPxFOjYO36t2fKrvGXWr9xGcLN7LKHpuyZs=;
        b=XxIrAQdCfjEmjjIWn17t1EzEYpK1K0POzIUhXZc06zL9WZLwNYqE7NBI/Y55V+Q1TD
         o8MOtKHRVT9bUJdZC92A7TxqC6MBMVISt3RLqH9wCMIGEOGjt14bRbTTe2BaAg1f5KOj
         zTKa/SS+LOZYFK4c00qWx+v6jcs4rQS9ISGzLqjfSsk9IMoGEoGNljJZWRkmHWaEDnhs
         X1VHcDO6TAcTxqzZQ+ClpR1TQrNZJOY5ceLouuCJUaTE4SASMU4iWKIGizAFR31e0nLs
         wTbxVilAZ9QF2E69ayK4JutrpTHE0N6ZU2MhKlvCcFANxKccV+WRef+wj8ajXMlYJdXn
         KLrQ==
X-Gm-Message-State: AOAM533kW/zT3gqD6qnqXrePv0Vh1HRh5z9s/POZIxSzN7FEgoel/fAN
        h8nLrZvJz6nWpqqKSBFeclKCLNg5sy9vaBt6vmZUwyTZFB4sGV3U
X-Google-Smtp-Source: ABdhPJz50ZSywsY5Ml3VlgDQjgkgvqH5Bhf8Nt04S7JpxzIj+v3aXYDZi2QEXbLXd8sXKlaWP88HBFUsUtANv4dnkF4=
X-Received: by 2002:a37:8b47:: with SMTP id n68mr21534165qkd.209.1624269309012;
 Mon, 21 Jun 2021 02:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com> <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
In-Reply-To: <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Mon, 21 Jun 2021 11:54:29 +0200
Message-ID: <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

man. 21. jun. 2021 kl. 11:50 skrev Vincent Guittot <vincent.guittot@linaro.org>:
> This means that a child's load was not null and it was inserted
> whereas parent's load was null. This should not happen unless the
> propagation failed somewhere

My initial thought is that the patch below will fix it, if that is the
issue (that a leaf is inserted, but the propagation is not "completed"
in unthrottle). Might that be the case? Still working on reproducing
the issue tho.


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfaa6e1f6067..015c5a5c1a4d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4930,12 +4930,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
                if (cfs_rq_throttled(cfs_rq))
                        goto unthrottle_throttle;

-               /*
-                * One parent has been throttled and cfs_rq removed from the
-                * list. Add it back to not break the leaf list.
-                */
-               if (throttled_hierarchy(cfs_rq))
-                       list_add_leaf_cfs_rq(cfs_rq);
+               list_add_leaf_cfs_rq(cfs_rq);
        }

        /* At this point se is NULL and we are at root level*/
