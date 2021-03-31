Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873A234FD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhCaJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:52:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50468 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhCaJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:52:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617184319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1O7Ro6mrGBXJy3LP3Zw2Gkl3YAtQijGkEfBpifq0EY=;
        b=HOyvQwSa53zJ3yf71cTgELVGcLqHXdkEK2CEu0gp8OOSYvuiixqKkqMfNgPS0F8oVFPIHE
        jmTzygMsSqwM+rt29Adn27OOdO49isF18RvQg0mAQfmkFgpaJNv4mh1DRS9+lAtrRi6b+P
        Ro21ZHuRiMHNvQUb+nXtLIzOIg3JEvJeGMMyri2/ypbeOCuJMZvchRNPnovTvqdE1BbA7T
        R2vKVR4tyr+SiXlTslxxbG0DHokYavrSaZNNT1G4SUzhnFFcwg5e15WaZHNZwyf9UTXZbL
        xavqaUR4MieS1A7hev8sMd33SCgzb1Gb+gQgVJS1eWXoPhtyx53w8qC//dfFAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617184319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1O7Ro6mrGBXJy3LP3Zw2Gkl3YAtQijGkEfBpifq0EY=;
        b=b37v2WvjQZmtY/D9COwHoRQgG0LNzM16wZTVkFlEwRlC91LuvoB0tJpX9LKQezq8LIoIc1
        pYKfVfp3jHfyD4Cg==
To:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/6] Use local_lock for pcp protection and reduce stat overhead
In-Reply-To: <20210331085213.GZ3697@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net> <20210331085213.GZ3697@techsingularity.net>
Date:   Wed, 31 Mar 2021 11:51:59 +0200
Message-ID: <87a6qj6474.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31 2021 at 09:52, Mel Gorman wrote:
> Ingo, Thomas or Peter, is there any chance one of you could take a look
> at patch "[PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to
> local_lock" from this series? It's partially motivated by PREEMPT_RT. More
> details below.

Sure.
