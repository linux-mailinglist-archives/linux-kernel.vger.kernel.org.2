Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE73E3DB5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbhG3JUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:20:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhG3JUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:20:06 -0400
Date:   Fri, 30 Jul 2021 11:19:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627636801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/yVxQt81Lvnto5E+OS1bnTnxWcuHkCulCyeXamA66Q=;
        b=eZQEIK06Da9igtEbso9af2Bk87Ly2yjzx1UdHKGypQL63pJlDVajAdjbO8VspIYu4eXKiQ
        M2VUwgm/p+gjTb7AFEqvGslf9maL9bILt5NVjdcwn1L9Lb1bbcV30HTlMZhlMc1c1yMPeB
        ibyFYEUUUpPNd5TPQF+XyJ5lcftOBIusB/JE0+gY4XWd8jq7tVprBJEaUk4Lr5KdjEzxMP
        mnQDE1wz+aJ76lIsqIoCyIOlLxh/phjmO5WKe0HaxJMgrcR7eFH4GN57LpKsqgzGT2FVh+
        A+nHba1EoQ5adpdEQJpC+GewtKyr5tK5P+K84Hov0I799boBq9pMM6jMzP37cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627636801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X/yVxQt81Lvnto5E+OS1bnTnxWcuHkCulCyeXamA66Q=;
        b=3oEfhvZfQVU0JO3fhLyMLyatlpjhi4u/UN0jGbWnB3H42Vb9jblWmW0IHFWwr388mQedFe
        gZeNtpuZayqiHjCw==
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
Message-ID: <20210730091959.ju42zpuoqihqz2yb@linutronix.de>
References: <20210729132132.19691-1-vbabka@suse.cz>
 <7ce60b82-a8c5-f31c-b344-b214a6ca38f8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ce60b82-a8c5-f31c-b344-b214a6ca38f8@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 17:47:20 [+0200], Vlastimil Babka wrote:
> Branch with fixed memory leak in patch 33:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v3r2

This looks stable, nothing happen during the night.

Sebastian
