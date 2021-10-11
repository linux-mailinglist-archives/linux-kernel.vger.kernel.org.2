Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0884C4289B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhJKJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235510AbhJKJdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:33:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73CB860EB6;
        Mon, 11 Oct 2021 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633944665;
        bh=XDIblqlutEfRJNxZ+D4WczGIbNP8xXOFJOb8drGkZNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=kuPT9kVFbcAdhsV6/NUq5gextuRPNAS0pKpSqUztC7JbFczn5H/1M1gb6NAi7kPvA
         1FrzYOqw08TSJa01aLmFp3fAKM/1cp26Hk3hMrjFs9xPDvEKTUILDcJyZRBF+ucTtj
         KogBjuPGZPATku/MGmLDvCHYV/oTO+fy3QCYDhcXuztuKrLT5pGeWfRmKLmxUSLRg7
         vWRzSGfNPeI6IRNr11mnqprHNYYbgQLTSGWzatu0dudj/EiXXD7lKHADqspPC1R4Ga
         12c2Cy+mcNQPk/DK1Vgi3WVFSdfwRmuVRqtr2myAkluNGHguUtoteMDlvGLpwAZ8wW
         JIbs+pwpW1MaQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/damon/dbgfs: Implement recording feature
Date:   Mon, 11 Oct 2021 09:30:57 +0000
Message-Id: <20211011093057.30790-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211010150140.be96f07048079188d9d6b613@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,


Thank you for great questions!

On Sun, 10 Oct 2021 15:01:40 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri,  8 Oct 2021 09:45:06 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > The user space can get the monitoring results via the 'damon_aggregated'
> > tracepoint event.  For simplicity and brevity, the tracepoint events
> > have some duplicated information such as 'target_id' and 'nr_regions',
> > though.  As a result, its size is greater than really needed.  Also,
> > dealing with the tracepoint could be complex for some simple use cases.
> > To provide a way for getting more efficient and simple monitoring
> > results to user space, this commit implements 'recording' feature in
> > 'damon-dbgfs'.
> > 
> > The feature is exported to the user space via a new debugfs file named
> > 'record', which is located in '<debugfs>/damon/' directory.  The file
> > allows users to record monitored access patterns in a regular binary
> > file in a simple format.
> 
> Binary files are troublesome.
> 
> Is the format of this file documented anywhere?

No.  I intended the Python script in the following patch[1] and the user space
tool[2] to be used as such documents.  I will write up one before the next
spin.

[1] https://lore.kernel.org/linux-mm/20211008094509.16179-3-sj@kernel.org/
[2] https://github.com/awslabs/damo/blob/v0.0.5/_damon_result.py#L38

> 
> I assume that the file's contents will have different representations
> depending on host endianness and word size and I further assume that
> the provided python script won't handle this very well?

You're right.  I will make the script properly handle the cases in the next
spin.

> 
> >  The recorded results are first written in an
> > in-memory buffer and flushed to a file in batch.  Users can get and set
> > the size of the buffer and the path to the result file by reading from
> > and writing to the 'record' file.  For example, below commands set the
> > buffer to be 4 KiB and the result to be saved in '/damon.data'.
> 
> > With a simple test workload[1], recording the tracepoint event using
> > 'perf-record' results in 1.7 MiB 'perf.data' file.  When the access
> > pattern is recorded via this feature, the size is reduced to 264 KiB. 
> > Also, the resulting record file is simple enough to be manipulated by a
> > small (100 lines of code) python script which will be introduced by a
> > following commit ("selftests/damon: Test recording feature").
> 
> How useful and important is this?  I mean, is it tremendously better or
> is it a little bit nice to have?  A description of the overall benefit
> to DAMON users would be useful in helping others to understand the
> benefit of this change.

Very good point.  Expected benefits are 1) better access pattern recording
space efficiency and 2) making it not depend on tracepoints.  Nevertheless, I
realized the importance of the benefit is not well quantified, thanks to this
question.  I will make it clear in the next spin.

Nevertheless, this feature is not critical for now.  I will deprioritize this
patchset and post other patchesets in DAMON development tree, namely 1) support
of physical address space monitoring and 2) DAMON-based proactive reclamation
first.


Thanks,
SJ
