Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2541E14A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbhI3Sgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbhI3Sgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:36:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD41C06176D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YrtIz+ep/DxIfqhvvjJuW+nRriShNBtbNJqcMLuVJG0=; b=YJeaLT3CrjnFJXJG5OvJYTdTAe
        l/vlfxtt+1WGsKf5ENQI+EUzZNCeheuj6EbqJpSUk04lZ03T6+jlfDenHKg51hV/rnzJjJyR5Emu4
        yNkCL3/N6331VzMe6onHcIhPsoZzQ8m1Zwwv3loYVUw6DVJ42kMb+x846J8T7mCpHGxE6FSPSZAhM
        x0qv6YHcztisb5e6FePv3EBy0ayspIDCnNxLCuP1Uw1wsWmN+hWBfkWzyfuTrAwduU5insnSfhTq0
        U+KlT3K+uUiyGwOY4Tknba7YbEgm9I3XWeu9seJO6tX4t5ZyNl8x0BAVcN1OgJ5XYUo/8mumhHi7c
        TWJ8hHzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mW0tE-0070Dc-J7; Thu, 30 Sep 2021 18:34:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7EFE981431; Thu, 30 Sep 2021 20:34:40 +0200 (CEST)
Date:   Thu, 30 Sep 2021 20:34:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC 0/6] CPU + GPU synchronised priority scheduling
Message-ID: <20210930183440.GD4323@worktop.programming.kicks-ass.net>
References: <20210930171552.501553-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930171552.501553-1-tvrtko.ursulin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 06:15:46PM +0100, Tvrtko Ursulin wrote:

>     (Note I did not copy
> everyone on all patches but just the cover letter for context and the rest
> should be available from the mailing list.)

In general, if you can't be arsed to send it to me, I can't be arsed to
dig it out. I've got plenty other email I can read without having to go
looking for more.
