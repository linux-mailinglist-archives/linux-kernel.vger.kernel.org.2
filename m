Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A46133F20A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhCQN7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhCQN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:59:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808ECC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 06:59:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615989542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7Dpc9wi5plmHVUqhEzB+naRL6Q83VO/uBFhukxo5j8=;
        b=C/eRE8ML00TQFE2haXfN9LQg/A/TsIYVa8qsf2dcK+5L/A8pLILENS3MyXjcsvaPuwTY2I
        zQkO/Wee7mobhmUdO13atpsDmB9O3HgD73/A8OzDh/UvOFutMubm9NqcVVZXOHZ5KzR45Y
        MP1J0/sMWEZsbFyxwFavyCS37diHrGO3eIiJrlzpGJnW2Y5Q1uU2IJhlBNEROdvV9GNWHN
        YA+11WZmt3iovKVdRIatomLhfQbDliDS0iqSsaAI6W9C+Dcdj2C8QMaEKGJ2Nf1ACqkego
        rG4pLjNopBsWx95+sCcEhtPr+T691r67ThRu2Vnh+d6/N27gKhKb2s1lM2tfPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615989542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7Dpc9wi5plmHVUqhEzB+naRL6Q83VO/uBFhukxo5j8=;
        b=E24NrR2WkMuti7VPjAor92J8iF/mcTaUuNwYHtLaK5kqJfOYo2jcTkZ3LC+ctcGmFNdplq
        nYhKr8uy4fBrPABQ==
To:     Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: kmap_local semantics
In-Reply-To: <20210312153646.GE3014244@iweiny-DESK2.sc.intel.com>
References: <20210312065413.GA29805@lst.de> <20210312153646.GE3014244@iweiny-DESK2.sc.intel.com>
Date:   Wed, 17 Mar 2021 14:59:01 +0100
Message-ID: <878s6lzxsq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12 2021 at 07:36, Ira Weiny wrote:
> On Fri, Mar 12, 2021 at 07:54:13AM +0100, Christoph Hellwig wrote:
>> So with the new kmap_local interface is it possible / advisable to
>> use local kmaps over code that might schedule(), e.g. to wait for I/O?
>
> It is possible yes.  "Advisable" I think so.  Thomas knows better than I what
> performance would be.

The performance impact is only relevant for 32bit machines with HIGHMEM
enabled. On 64bit kmap_local is a NOOP except when you enable
CONFIG_DEBUG_KMAP_LOCAL there which then actually does the mapping (on
x86 only for now) with guard maps between and that will do the 'drop
map' on schedule out and restore on schedule in dance. But for regular
64bit there is absolutely _NO_ overhead.

> FWIW I have been working on converting kmaps to kmap_local.  Most of the
> instances don't schedule AFAICT.

The whole point of kmap_local is to be preemptible and does not have the
nasty side effects of kmap_atomic, except for the 1 page per map and map
nesting ordering requirements.

> What I really don't want to see is any kmap'ings handed to another thread.  I
> am working hard to eliminate the use of kmap for that use.  Is that going to be
> a problem?

kmap != kmap_local

kmap_local mappings are thread local and can't be handed anywhere. It's
documented.

Thanks,

        tglx
