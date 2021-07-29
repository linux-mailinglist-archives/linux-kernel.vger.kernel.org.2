Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124E93DA79A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhG2P3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbhG2P3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:29:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC05C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:29:05 -0700 (PDT)
Date:   Thu, 29 Jul 2021 17:29:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627572542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2CCQpDu+Wh/+qkhN+yZUjWWKa1Docl1gGJrBzm2ZODQ=;
        b=a+z03BVPqnI9tj0fUTKUjoebinZSckDM5wCxkZ8GxM2AY9isU7rd7dbiyR40SzTDtbgNlN
        0dZAAxUTeB54qgllA/tWsicJzucpOMiw3Z45pca3t+AhADkSy1Dgd4fSNjtt8UBZ5ka/8t
        XMYjo5YWAhLlK8U6cwXVIUTtbXwV/syH7KYgsC2J78a1UyigYvKZAsSQFUtuaruKVCwP5s
        1Fztu7+vnUyKEAJy3ZBTb8sj5GwaOUxVyHY8Y7Yymyb78vT18QrlNHPbLmZKNHogiHYYZ6
        9pseD4wt9nwvnMvLaQPPq3BUWlIMot9wBf2Mc6rfiJ9DDe6nVOBcMMQ7jfEPvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627572542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2CCQpDu+Wh/+qkhN+yZUjWWKa1Docl1gGJrBzm2ZODQ=;
        b=5+rilswg5yYmiS7OPWmvGokdqMLJ5cLVTjYbd0m//jsNSoN52Sc365jNAJpKHmQXQ794fL
        ssRH8/qCXmTo0/BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210729152901.uvbgquzwyk7lt7a3@linutronix.de>
References: <20210729132132.19691-1-vbabka@suse.cz>
 <20210729152400.ed35ocv5jtpf3ns5@linutronix.de>
 <803269ba-d4f4-6016-067f-8f9e02b3c794@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <803269ba-d4f4-6016-067f-8f9e02b3c794@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 17:27:18 [+0200], Vlastimil Babka wrote:
> On 7/29/21 5:24 PM, Sebastian Andrzej Siewior wrote:
> > On 2021-07-29 15:20:57 [+0200], Vlastimil Babka wrote:
> >> Changes since v2 [5]:
> > 
> > With PARTIAL enabled on top of -rc3:
> 
> Is that also PREEMPT_RT? Interesting...

No, plain -rc3.

Sebastian
