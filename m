Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F51C40FF19
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhIQSWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:22:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50536 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhIQSWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:22:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60365223FA;
        Fri, 17 Sep 2021 18:21:26 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6E7B13C4E;
        Fri, 17 Sep 2021 18:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SaenGJ/cRGH7fgAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 17 Sep 2021 18:21:19 +0000
Date:   Fri, 17 Sep 2021 11:21:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dvhart@infradead.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, atish.patra@wdc.com,
        arnd@arndb.de, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 1/2] perf benchmark: Call the futex syscall from a
 function
Message-ID: <20210917182113.nacg5zbjiexmhhjk@offworld>
References: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021, Alistair Francis wrote:

>From: Alistair Francis <alistair.francis@wdc.com>
>
>In preparation for a more complex futex() function let's convert the
>current macro into two functions. We need two functions to avoid
>compiler failures as the macro is overloaded.
>
>This will allow us to include pre-processor conditionals in the futex
>syscall functions.
>
>Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
