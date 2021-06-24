Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C143B2C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhFXK3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhFXK3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:29:08 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5522FC061574;
        Thu, 24 Jun 2021 03:26:48 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f16so2997488qvs.7;
        Thu, 24 Jun 2021 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=KxS5ydGPGSrGpr8bpknASMX+EaA4On+/9KPX0g5P9o0=;
        b=Y46p3HJAOO0UApSgTJ/BNEu/h3xZ7r0dnW0ioPlm8N1OmHoyiMf7/up+Bymi3gAwsO
         ZIwwsCtsmaez9PhsLYnyEzQvlA6dy2S5O+WWRIEO7iBsrt3xhqMmOkRysQOzVRafR7+s
         DmfoZhzALS5JTyeGFw70a1QQqWdjy58RQJUoim9iBDisO2WVxX29QErw9GRZBiE5DZwM
         ZsFOiR5oRRVAhy+M0WwF8EG3wj2ZKckxbWjgiQzElBAKYlmdYKc4wJ9knJH5Z7o9JaaY
         jNSOLSnuMQTx8UUhLDYG5GIgi19wkZR/tPa8AwXJOxF9d+igaxCPYc/eIvc7mQOLeBZg
         utbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=KxS5ydGPGSrGpr8bpknASMX+EaA4On+/9KPX0g5P9o0=;
        b=DM2kobYEjYmJtWhupmCxwYCE6No7mahI45Mvi3s4vOrAJ1q4dk41sdc7rcLEQ6PbFB
         T/rsK6uNEY0srKuv9ggyX2UU3/O5z9iW5ebIxvPmERsrCBPWT5UndDiI98FXO34BfSuK
         jHcbWuX+/botOz421Qv7xQLaSHTxaXOUmdnNctEmR1ZvteiNCKCjpeE7+1HSwQDeQUN0
         aXgnWzrte7o/DmFaKaot1gFlLr0dONNCQsrVVmAsT1zxrJC+TYrVisaDnJbIFa9WmEOh
         +gSh7ByD+oDkqkEUTtCUFKUrXbhwSQ7AT0rZOKgJ0/QQnj7yxwRv8BSMIC5gkpmZbxK8
         hZlw==
X-Gm-Message-State: AOAM530Gi/EqSsX20cIA2hlyN4Sd0oN/eFyKQG15G22vLlevBdEXi42M
        xPI1GYUnsuO/e0o/BkPzfxM=
X-Google-Smtp-Source: ABdhPJzz84D03CiKPqZ8W17GBXg5Z7jOn2ynPlYRpZuazv6R5do/6ygSamxJ9F3m5NSnGJ2w4NPLzA==
X-Received: by 2002:a05:6214:15c2:: with SMTP id p2mr4674594qvz.8.1624530407601;
        Thu, 24 Jun 2021 03:26:47 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id w195sm2132842qkb.127.2021.06.24.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:26:47 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, greg@kroah.com,
        Greg Thelen <gthelen@google.com>, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, Mel Gorman <mgorman@suse.de>, mheyne@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        sieberf@amazon.com, snu@zelle79.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        zgf574564920@gmail.com, linux-damon@amazon.com,
        Linux MM <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v31 08/13] mm/damon/dbgfs: Export kdamond pid to the user space
Date:   Thu, 24 Jun 2021 10:26:23 +0000
Message-Id: <20210624102623.24563-5-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210624102623.24563-1-sjpark@amazon.de>
References: <20210624102623.24563-1-sjpark@amazon.de>
In-Reply-To: <CALvZod703WD0Ab8EMpd6+JxzhKEjnwZkYRA9VB5LoUmG_yccSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 22 Jun 2021 11:23:12 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jun 21, 2021 at 1:31 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > For CPU usage accounting, knowing pid of the monitoring thread could be
> > helpful.  For example, users could use cpuaccount cgroups with the pid.
> >
> > This commit therefore exports the pid of currently running monitoring
> > thread to the user space via 'kdamond_pid' file in the debugfs
> > directory.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Fernand Sieber <sieberf@amazon.com>
> > ---
> 
> [...]
> 
> >
> > +static const struct file_operations kdamond_pid_fops = {
> > +       .owner = THIS_MODULE,
> 
> I don't think you need to set the owner (and for other fops) as these
> files are built into modules. Otherwise it looks good.

Good point.  Will remove those from the next spin.


Thanks,
SeongJae Park
