Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9E740861D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhIMIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:12:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58032 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhIMIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:12:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D559D21FA6;
        Mon, 13 Sep 2021 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631520662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TqgJzUE+9F845jwNISUetj2Rzh0zRQ8LjCewshk/MlE=;
        b=q7U/4fqRf+vvcwcLH/cGJZbSxdXFmACu4zKTAtMqHeUYILWWUbut1J3M/qc4kQg+l1Ff2A
        KHznSxQ/VzSQnjEGvOuVpHVN8nrVEsTzb5lbDPMplK61IuexNH2RmMvWa9WI4t16EsG196
        lkGjYg8EGC73rqRhy7ZNuR06um/8cQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631520662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TqgJzUE+9F845jwNISUetj2Rzh0zRQ8LjCewshk/MlE=;
        b=emCtZzuWGiaaOkzBFF1C9h9c/GQhJMDxuPoCjZuN17pMQRJat6t6GsOJkXV5H25PC3mfly
        OmO921G4ZXfr1nCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE84213A09;
        Mon, 13 Sep 2021 08:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lEpFLpYHP2EFQAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 13 Sep 2021 08:11:02 +0000
Date:   Mon, 13 Sep 2021 10:11:22 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Chi Wu <wuchi.zero@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>,
        lkp@intel.com, lkp@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ltp@lists.linux.it
Subject: Re: [LTP] [mm/page]  ab19939a6a: ltp.msync04.fail
Message-ID: <YT8HqsXsHFeMdDxS@yuki>
References: <20210912123429.GA25450@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912123429.GA25450@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20210907
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls-03
> 	ucode: 0xe2
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/

The msync04 test formats a device with a diffrent filesystems, for each
filesystem it maps a file, writes to the mapped page and the checks a
dirty bit in /proc/kpageflags before and after msync() on that page.

This seems to be broken after this patch for ntfs over FUSE and it looks
like the page does not have a dirty bit set right after it has been
written to.

Also I guess that we should increase the number of the pages we dirty or
attempt to retry since a single page may be flushed to the storage if we
are unlucky and the process is preempted between the write and the
initial check for the dirty bit.

-- 
Cyril Hrubis
chrubis@suse.cz
