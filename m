Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E24283F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 00:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhJJWDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 18:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhJJWDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 18:03:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CC4D60ED7;
        Sun, 10 Oct 2021 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633903303;
        bh=lo9M+TDpC7LJs9JEpSPlR/TOsXRJVkyYrlp/12sLFj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vXfG4FjMIJU43l453teCwBEi3xUtQWjwfj6iqPEyK41FtzBhpE5xvhAzquqZ/zHS0
         4uKaGjqZHJKAQO29TwT5mVNjmFz2DBUAXzb+L8greEkwwmIvKRVANqWChrW4qr3/9u
         wi62lTjaqMWZSsMVhAYfDaaMidNjCS9rOS7YQXcc=
Date:   Sun, 10 Oct 2021 15:01:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan.Cameron@Huawei.com, amit@kernel.org,
        benh@kernel.crashing.org, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, foersleo@amazon.de,
        gthelen@google.com, markubo@amazon.de, rientjes@google.com,
        shakeelb@google.com, shuah@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/damon/dbgfs: Implement recording feature
Message-Id: <20211010150140.be96f07048079188d9d6b613@linux-foundation.org>
In-Reply-To: <20211008094509.16179-1-sj@kernel.org>
References: <20211008094509.16179-1-sj@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Oct 2021 09:45:06 +0000 SeongJae Park <sj@kernel.org> wrote:

> The user space can get the monitoring results via the 'damon_aggregated'
> tracepoint event.  For simplicity and brevity, the tracepoint events
> have some duplicated information such as 'target_id' and 'nr_regions',
> though.  As a result, its size is greater than really needed.  Also,
> dealing with the tracepoint could be complex for some simple use cases.
> To provide a way for getting more efficient and simple monitoring
> results to user space, this commit implements 'recording' feature in
> 'damon-dbgfs'.
> 
> The feature is exported to the user space via a new debugfs file named
> 'record', which is located in '<debugfs>/damon/' directory.  The file
> allows users to record monitored access patterns in a regular binary
> file in a simple format.

Binary files are troublesome.

Is the format of this file documented anywhere?

I assume that the file's contents will have different representations
depending on host endianness and word size and I further assume that
the provided python script won't handle this very well?

>  The recorded results are first written in an
> in-memory buffer and flushed to a file in batch.  Users can get and set
> the size of the buffer and the path to the result file by reading from
> and writing to the 'record' file.  For example, below commands set the
> buffer to be 4 KiB and the result to be saved in '/damon.data'.

> With a simple test workload[1], recording the tracepoint event using
> 'perf-record' results in 1.7 MiB 'perf.data' file.  When the access
> pattern is recorded via this feature, the size is reduced to 264 KiB. 
> Also, the resulting record file is simple enough to be manipulated by a
> small (100 lines of code) python script which will be introduced by a
> following commit ("selftests/damon: Test recording feature").

How useful and important is this?  I mean, is it tremendously better or
is it a little bit nice to have?  A description of the overall benefit
to DAMON users would be useful in helping others to understand the
benefit of this change.


