Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48723E49CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhHIQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:31:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60688 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhHIQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54B8521EB5;
        Mon,  9 Aug 2021 16:31:03 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7199C13AC8;
        Mon,  9 Aug 2021 16:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +4SvC0VYEWEbTwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 16:31:01 +0000
Date:   Mon, 9 Aug 2021 09:30:57 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/7] perf/bench-futex: Factor out futex_flag
Message-ID: <20210809163057.no4icet42g6vu6uo@offworld>
References: <20210809043301.66002-1-dave@stgolabs.net>
 <20210809043301.66002-4-dave@stgolabs.net>
 <YRFBj3jGABt1zkQX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YRFBj3jGABt1zkQX@kernel.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2021, Arnaldo Carvalho de Melo wrote:
>Wouldn't be better to have it defined in one place and then in futex.h
>just have a 'extern int futex_flag;' declaration?

Sure.

>
>I applied the first two patches already.

Ok so I'm clear, this one just won't get picked up right now then.
(you don't want me to respin this patch then in a form v3, right?)

Thanks,
Davidlohr
