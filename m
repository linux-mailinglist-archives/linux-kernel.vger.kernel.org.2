Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA143DD322
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhHBJmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhHBJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:42:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA0C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3DhzGFuBtUG7+9wyciHp3RFxAl1GfNiYwIuvXAzbdNU=; b=j6EewaR+rlidvE+z018zeYkc3h
        yuYWx6iMB6Y/bdKgkoVHmUkprkwR9FdV+0bMIkSoM/ZXB2dVqLgYC/cLiduRiKRZl3Vjso11I42Yk
        YjugvQbduueZqCHOj9K8xZ5TGABNjF96Uo7w16jxEfcUtf3XxznrDFlPZ4P1m0VpLxMIq4CL5cRhM
        h3fVBpZWl5YOm/eolCi1L+jthxWoSgBNnrF8NPmVotQeEcOLvaNQGeR3Gge2IXCRoww5YTvGEPRrf
        EOLUKmpbewr3aPXAxhyt4WAru4MoUX6Imqrg0ahI0uhSdywkBK81AsCDgkzEP6eLFbCfXjmv+0hf5
        srNWFuBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAUSW-0057lH-N3; Mon, 02 Aug 2021 09:42:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 648FC30027F;
        Mon,  2 Aug 2021 11:42:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45D862028FBCA; Mon,  2 Aug 2021 11:42:06 +0200 (CEST)
Date:   Mon, 2 Aug 2021 11:42:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 0/2] locking/lockdep, drm: apply new lockdep assert in
 drm_auth.c
Message-ID: <YQe97lDFTmxnR5/b@hirez.programming.kicks-ass.net>
References: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
 <YQesKIRQKYyTFyxJ@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQesKIRQKYyTFyxJ@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:26:16AM +0200, Daniel Vetter wrote:
> On Sat, Jul 31, 2021 at 04:24:56PM +0800, Desmond Cheong Zhi Xi wrote:
> > Hi,
> > 
> > Following a discussion on the patch ("drm: use the lookup lock in
> > drm_is_current_master") [1], Peter Zijlstra proposed new lockdep_assert
> > helpers to make it convenient to compose lockdep checks together.
> > 
> > This series includes the patch that introduces the new lockdep helpers,
> > then utilizes these helpers in drm_is_current_master_locked in the
> > following patch.
> > 
> > v1 -> v2:
> > Patch 2:
> > - Updated the kerneldoc on the lock design of drm_file.master to explain
> > the use of lockdep_assert(). As suggested by Boqun Feng.
> > 
> > Link: https://lore.kernel.org/lkml/20210722092929.244629-2-desmondcheongzx@gmail.com/ [1]
> 
> Can you pls also cc: this to intel-gfx so the local CI there can pick it
> up and verify? Just to check we got it all.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Feel free to take it through the drm tree.
