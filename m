Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1CD3DA6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbhG2OrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbhG2Op4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:45:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEC2C06179E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yXVoVs90MS1xZ9tjxl4bGWV3as2/GFBM7qNojQie/p4=; b=NQVTi6MOTMOFnA5GJnFX0Xd5GJ
        HPir7Vag2LISCmHW7sWkZbCucsXBS1h25ee4xy+eeVwqRONc36m8sSE516mdDKAiHrorePAR6NOZ/
        MVOvIHpwEFovnYhOuiGQm6wsjT9Cuw6+uOH/7WqqqbDb3IKQVUHruAQ9Rt+ANkwN/WxsMEBB5lw9b
        mmSp9hjza3Ijnh/IA7rxrxinhl8gmepWpSSlX9IZf3egqd0tLE3B6GfUaPpIQrPM9j9Z5gpgbT/7F
        imD4I01sncchnnRHubC7jUDk+wnb+tDeJkFsnIYpxGhEWUUe9b+yJK5Dra3TlkItp3X/MKx02bLOa
        aRqmtYAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m97Hd-003z22-Ow; Thu, 29 Jul 2021 14:45:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 407DF300215;
        Thu, 29 Jul 2021 16:45:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1099229A0995A; Thu, 29 Jul 2021 16:45:11 +0200 (CEST)
Date:   Thu, 29 Jul 2021 16:45:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/3] drm: use the lookup lock in drm_is_current_master
Message-ID: <YQK+9p+RIcFuzD3O@hirez.programming.kicks-ass.net>
References: <20210722092929.244629-1-desmondcheongzx@gmail.com>
 <20210722092929.244629-2-desmondcheongzx@gmail.com>
 <YPlKkvelm/mcnCj0@phenom.ffwll.local>
 <YQAaIrNUXa6i2gxD@hirez.programming.kicks-ass.net>
 <YQJSE3TMRydDNhqT@phenom.ffwll.local>
 <fbf2ec46-5ef5-7108-450a-13a7c48c30ce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf2ec46-5ef5-7108-450a-13a7c48c30ce@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 10:32:13PM +0800, Desmond Cheong Zhi Xi wrote:
> Sounds good, will do. Thanks for the patch, Peter.
> 
> Just going to make a small edit:
> s/LOCK_STAT_NOT_HELD/LOCK_STATE_NOT_HELD/

Bah, I knew I should've compile tested it :-), Thanks!
