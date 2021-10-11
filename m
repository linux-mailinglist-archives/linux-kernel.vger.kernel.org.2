Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D364C429891
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhJKVEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhJKVEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E28360F23;
        Mon, 11 Oct 2021 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633986158;
        bh=Jm6whGm1SYWN5n0xAQTdIeZ9V6XW0chF912C9+QjTcM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nh65/IBIADLhMY9W1ThQ+x/HbV6CHO2s22TKn9rPlXzpLKdrKZHUpuZmVEbFmB1Ws
         7yfK4ne8BH9vrfsfviIBXtPVE7Z4/Md8m7I4tXLACBdAKbsd3Y2C7QMIhJWNDtKIic
         SB2TZau4xVB2gZiPlaimrGkh72Ut4efN4vhaKofU=
Date:   Mon, 11 Oct 2021 14:02:35 -0700
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
Message-Id: <20211011140235.f75b842f861b730c53e4b19c@linux-foundation.org>
In-Reply-To: <20211011093057.30790-1-sj@kernel.org>
References: <20211010150140.be96f07048079188d9d6b613@linux-foundation.org>
        <20211011093057.30790-1-sj@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 09:30:57 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello Andrew,
> 
> 
> Thank you for great questions!
> 
> On Sun, 10 Oct 2021 15:01:40 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Fri,  8 Oct 2021 09:45:06 +0000 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > The user space can get the monitoring results via the 'damon_aggregated'
> > > tracepoint event.  For simplicity and brevity, the tracepoint events
> > > have some duplicated information such as 'target_id' and 'nr_regions',
> > > though.  As a result, its size is greater than really needed.  Also,
> > > dealing with the tracepoint could be complex for some simple use cases.
> > > To provide a way for getting more efficient and simple monitoring
> > > results to user space, this commit implements 'recording' feature in
> > > 'damon-dbgfs'.
> > > 
> > > The feature is exported to the user space via a new debugfs file named
> > > 'record', which is located in '<debugfs>/damon/' directory.  The file
> > > allows users to record monitored access patterns in a regular binary
> > > file in a simple format.
> > 
> > Binary files are troublesome.
> > 
> > Is the format of this file documented anywhere?
> 
> No.  I intended the Python script in the following patch[1] and the user space
> tool[2] to be used as such documents.  I will write up one before the next
> spin.
> 
> [1] https://lore.kernel.org/linux-mm/20211008094509.16179-3-sj@kernel.org/
> [2] https://github.com/awslabs/damo/blob/v0.0.5/_damon_result.py#L38
> 
> > 
> > I assume that the file's contents will have different representations
> > depending on host endianness and word size and I further assume that
> > the provided python script won't handle this very well?
> 
> You're right.  I will make the script properly handle the cases in the next
> spin.

Well, rather than messing with the different file formats, you could
make the binary file machine-independent.  Decide on the endianness and
word size, implement them and document them.  Things like cpu_to_le32
are zero-cost on little-endian machines.

