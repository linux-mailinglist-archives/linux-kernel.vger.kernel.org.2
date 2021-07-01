Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014563B8F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhGAJCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhGAJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:02:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A3BC061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2qqgC+Ulx5UrM01EMJZVrA3rn7EUXuF7xXclSNsscao=; b=hueftNHuJVVsy8VqzYarbH7xZ6
        OVqpjm1YF3YsRXMpBA9jY8na8Pb5Np44UNj+z3NT0Zr8bmiygqxQASHMJ3FJ48PrIY66O2CyW0q+M
        CMHrftyLF+oN2tuFIqWv7plKtDcNuCZzpmq+Tz9JoN43+LT+OBRSNn5LUqidFEUSSTHZVkQHKSf6E
        EFeEonSZHjDebT3OYHCeS+O7pgGaorDRmZ9O49Vv5s02ILgtEPDZ45vP4OJexU8k3uVwBkNxhAmbL
        SItpOa8tzZypbJVt+IDkP+i7Aux7rFjpuM0nvbpqnh60I6xqXpooyqZEhHUk17JXRKHBAxwDd3i/g
        JnAdCGlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lysWh-006N2B-S9; Thu, 01 Jul 2021 08:58:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 029FA3001DC;
        Thu,  1 Jul 2021 10:58:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D45642041E842; Thu,  1 Jul 2021 10:58:24 +0200 (CEST)
Date:   Thu, 1 Jul 2021 10:58:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, matthias.bgg@gmail.com, minchan@google.com,
        timmurray@google.com, yt.chang@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com,
        SH Chen <show-hong.chen@mediatek.com>
Subject: Re: [PATCH v2 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
References: <20210630205151.137001-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630205151.137001-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> +	/* cmpxchg should be called even when !force to set poll_scheduled */
> +	if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
>  		return;

Why is that a cmpxchg() ?
