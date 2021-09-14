Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C4740AAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhINJX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:23:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36700 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhINJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:23:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2504F220D8;
        Tue, 14 Sep 2021 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631611329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eK0M2+u819RbPSbOa+TChxkR/yeNh/tZ0Wr5oxu1nPw=;
        b=ALiATahMKwWdxKrIMjcRx4ccjHnyv1c+BPI5ZNi2w7gnbKrpjEU0SvnsTIg2jAapmOVTrX
        WVnAK1s2gKzy+vc6kz/kYGVv8rJg0aXvj+zkbQ7tAgGvlymh7SGD9iUQnwILxCBjshv+eY
        5YoT89LI/+gUezjmzZla2iUYkoy1OoU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBB6E13D3F;
        Tue, 14 Sep 2021 09:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rsJPLcBpQGGnQAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 14 Sep 2021 09:22:08 +0000
Date:   Tue, 14 Sep 2021 11:22:07 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [RFC PATCH v2 4/5] sched/fair: Simplify load_cfs_rq_list
 maintenance
Message-ID: <20210914092207.GA23743@blackbody.suse.cz>
References: <20210819175034.4577-1-mkoutny@suse.com>
 <20210819175034.4577-5-mkoutny@suse.com>
 <CAKfTPtCAxksmsR6DJuAoSZ7XTon+gesyic36EHL-nQk0LiHWQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCAxksmsR6DJuAoSZ7XTon+gesyic36EHL-nQk0LiHWQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:19:27PM +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> Your proposal looks interesting but I need more time to make sure that
> all cases are covered. We have faced several odd corner cases and
> sequences in the past that I need time to check that you don't put
> some back

Do you have any pointers to the cases that come to your mind? I wonder
if those could be reproduced with a simple setup.
(FTR, I used the LTP test (at b673f49ae) cfs_bandwidth01 to check this change.)

Thanks,
Michal
