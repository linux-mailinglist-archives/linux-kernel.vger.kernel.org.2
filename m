Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78EF3E369F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhHGS2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhHGS2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:28:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A203960F10;
        Sat,  7 Aug 2021 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628360903;
        bh=hUy6JCFT7S9GDfapP7Jen82ePlO0aa/6QvYnH01I6KE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0laZdmp6mlS97qz3LHmO1crutgDpb0s9DZKQtGk0YGTw81d+4EXyrvedzyg7mlF4H
         L5wLTkyuNsKp8/DwhTd1yRHLoUp6IsZ6RJeyW57poFwmVVBFac/WHZrdiONU6ZvZgp
         JOhNfHNer1F53YyxgIkZHEQi5c8b8TqWRooXP90g=
Date:   Sat, 7 Aug 2021 11:28:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Message-Id: <20210807112820.dd8d0a7ae972730f196631c3@linux-foundation.org>
In-Reply-To: <20210806114831.7009-1-sjpark@amazon.de>
References: <20210805174324.2aaf0fb67cd19da893a86d80@linux-foundation.org>
        <20210806114831.7009-1-sjpark@amazon.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Aug 2021 11:48:30 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> > 
> > Presumably there are companion userspace tools for DAMON.  Are they
> > available?  Is there a plan to release and maintain these?
> 
> Yes, the userspace tool[1] is available, released under GPLv2, and actively
> being maintained.  I am also planning to implement another basic user interface
> in perf[2].  Also, the basic test suite for DAMON is available under GPLv2[3].
> 
> [1] https://github.com/awslabs/damo
> [2] https://lore.kernel.org/linux-mm/20210107120729.22328-1-sjpark@amazon.com/
> [3] https://github.com/awslabs/damon-tests

Ah.  Useful info to have in the changelogs!  I added the above words to the [0/n] introduction in mm-introduce-data-access-monitor-damon.patch
