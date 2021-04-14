Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0F35EEC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348254AbhDNHvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhDNHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:51:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kel5nAWcgLTms55fQqQrURNpeeeiQj+msHoHON8xUVk=; b=hEKePnQgXk+B3+0G0TRY+5JSeC
        nAdThLSJmNd6gEBlbF/v0u1MCwYq2q/UWAyqJyFwi8iejyGP0fsqutIYWzBBtWe9TELK6IqEd2Cdj
        i6GVlCMQLrb7wsSZWjxbaDlPw3ZPBCotm7ItYea6EEsLlufcz1xo5hisPqXbn/CV0Mv//JSgWhhGh
        9E8S7cK3GNAM0qR6HwTMRzZj/cvIvHECSnnoO6j5TWPYclWR8fnpAJ+UMErhTJIg9lcEdXTahMuDl
        kwYZoUHjqYZcM9Sz/zmPSqbUQXskoJO2XHdXQT5H8CLcJIdtLimm0sjlfzt6G4vRksTeaaPnWVSxO
        BOPAzsYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWaIv-00BtFw-ES; Wed, 14 Apr 2021 07:51:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C062300033;
        Wed, 14 Apr 2021 09:51:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45BA0203CF7D6; Wed, 14 Apr 2021 09:51:16 +0200 (CEST)
Date:   Wed, 14 Apr 2021 09:51:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, paulmck <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 0/3] rseq: minor optimizations
Message-ID: <YHae9AasEN+xY5bj@hirez.programming.kicks-ass.net>
References: <20210413203352.71350-1-eric.dumazet@gmail.com>
 <1447691783.73957.1618346433394.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447691783.73957.1618346433394.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:40:33PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 13, 2021, at 4:33 PM, Eric Dumazet eric.dumazet@gmail.com wrote:
> 
> > From: Eric Dumazet <edumazet@google.com>
> > 
> > rseq is a heavy user of copy to/from user data in fast paths.
> > This series tries to reduce the cost.
> > 
> > v3: Third patch going back to v1 (only deal with 64bit arches)
> > v2: Addressed Peter and Mathieu feedbacks, thanks !
> 
> For the whole series:
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!
