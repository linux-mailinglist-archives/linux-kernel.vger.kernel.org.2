Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCCC44C988
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhKJTxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:53:25 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:40684 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhKJTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:53:22 -0500
Received: by mail-pj1-f43.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so2562201pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mo5YZKmHyRzCkm81yC0SP0wa5RXfdbdNjSOonoGLKIQ=;
        b=iPlvH7gkM6vL/x5YYeCJLXPguV2wcAIAEkwSsz3SQokgyjO/1607TlnoSHHNtGXYP3
         w+xt6jpFHustjMqmS3pvTevoigaY5Lx+9ffy+q+W1Gp3w8Z8WalX36t8zFJ/H0vKTsCG
         nLAyTpwjeawr7V0O+cpCelRNSOzJ2jbKdf67Arxo5gCA/YeMSa3UrCqp0aDrTwBUJWTG
         9qjMP/ymVb9RYbPDSSkdhzFMPXhR2p/qNP3mx/+jMoRM5UvmekHkYZwpnhmSIT0kS5KW
         RbxJd0GxDB/ciN/U5v2nNYkfMZjA5/JqxZLCUoYLySl88jTtkrng2+SsWKNqJrP/EsOj
         ln2A==
X-Gm-Message-State: AOAM533IIcbUHkmHhE7GpS5batG8xSKwsofbQTYvYKQNoqrmhTmVCXsj
        /z8pkbD8FbvhQElSusxvKy8=
X-Google-Smtp-Source: ABdhPJya2DgM3aSAJccMby5bM3ok2fVFwWCNM7NUIHMJrIAqOTjmGRXJZ72if4N5reehWnZR92vzSA==
X-Received: by 2002:a17:903:2344:b0:142:25b4:76c1 with SMTP id c4-20020a170903234400b0014225b476c1mr1798630plh.43.1636573834724;
        Wed, 10 Nov 2021 11:50:34 -0800 (PST)
Received: from sultan-box.localdomain ([199.116.118.235])
        by smtp.gmail.com with ESMTPSA id ml24sm402251pjb.16.2021.11.10.11.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:50:34 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:50:30 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>, mkoutny@suse.com
Subject: Re: printk deadlock due to double lock attempt on current CPU's
 runqueue
Message-ID: <YYwihj21abVmf9Ag@sultan-box.localdomain>
References: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
 <20211109213847.GY174703@worktop.programming.kicks-ass.net>
 <CAKfTPtC_A-_sfQ+rm440oHwd2gUZ222FMwsi-JTkyLPc-x0qrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC_A-_sfQ+rm440oHwd2gUZ222FMwsi-JTkyLPc-x0qrw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:00:35AM +0100, Vincent Guittot wrote:
> Is it the same SCHED_WARN_ON(rq->tmp_alone_branch !=
> &rq->leaf_cfs_rq_list); that generates the deadlock on v5.15 too ?
> 
> one remaining tmp_alone_branch warning has been fixed in v5.15 with
> 2630cde26711 ("sched/fair: Add ancestors of unthrottled undecayed cfs_rq")

I should clarify that I didn't actually reproduce the issue on v5.15; I just saw
that the call chain leading to the deadlock still existed in v5.15 after looking
through the code.

Failing the SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list); assert
is extremely rare in my experience, and I don't have a reproducer. It has only
happened once after months of heavy usage (with lots of reboots too, so not with
crazy high uptime).

Sultan
