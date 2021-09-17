Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71E340FF72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbhIQSfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:35:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38760 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhIQSfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:35:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0FC51FF75;
        Fri, 17 Sep 2021 18:33:39 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D11EE13A96;
        Fri, 17 Sep 2021 18:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dMMdKH3fRGGZBAAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 17 Sep 2021 18:33:33 +0000
Date:   Fri, 17 Sep 2021 11:33:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dvhart@infradead.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, atish.patra@wdc.com,
        arnd@arndb.de, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 2/2] perf bench: Add support for 32-bit systems with
 64-bit time_t
Message-ID: <20210917183328.fpybzahm5flcxexm@offworld>
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
 <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210917061040.2270822-2-alistair.francis@opensource.wdc.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021, Alistair Francis wrote:

>From: Alistair Francis <alistair.francis@wdc.com>
>
>Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
>time_t and as such don't have the SYS_futex syscall. This patch will
>allow us to use the SYS_futex_time64 syscall on those platforms.

Not objecting, but this ifdefiry will hurt my eyes every time I have
to look at this file :)

Acked-by: Davidlohr Bueso <dbueso@suse.de>
