Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE71A3E497D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhHIQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:11:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhHIQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:11:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AFEF821F91;
        Mon,  9 Aug 2021 16:11:16 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE0C713AFB;
        Mon,  9 Aug 2021 16:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qvWOIKJTEWFwSgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 16:11:14 +0000
Date:   Mon, 9 Aug 2021 09:11:11 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 4/7] perf/bench-futex: Add --mlockall parameter
Message-ID: <20210809161111.5miya55l6za2bibh@offworld>
References: <20210809043301.66002-1-dave@stgolabs.net>
 <20210809043301.66002-5-dave@stgolabs.net>
 <YRFCFqM9QBoUrl18@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YRFCFqM9QBoUrl18@kernel.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2021, Arnaldo Carvalho de Melo wrote:

>Applied.

Thanks!

>
>At some point these options could be handled in a common
>futex_parse_options() function that would consume argv[] and then the
>specific futex benchmarks would continue from where the common function
>left off.

I agree. I'll see about a follow up to this series in the future, there
are a few other things we can share among the programs.

Thanks,
Davidlohr
