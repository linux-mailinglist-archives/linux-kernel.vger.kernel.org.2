Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068C2391F28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhEZSdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbhEZSdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:33:05 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1WnsrtUBknRy01baw7UyEUeOvHtXPbZ1Ph2+lJo90Dw=; b=CX6F5LsjQXtbvbkG1aIFbsQ75
        kaijHEVcoNoUaTPG/04j7D6XrGaKoZvK6OjVkhb+8eAV3nsRzlBj7tlP6ntO7hsWasUticzjTkP9H
        uqm4Ww4z4/M/TKLJINP+Ao8up6TlXeckj/y9y+S2HnVYq1DF3QFlMPHZCUQ7NiLmCT50q/uylQkVU
        azW+Nz9frRFKupsYkX7dAOKHelpKCVHjA4PQPaTEX8LCZhwxd4tymVxDkvOSj9Wv3GcvPFOUzC1QI
        bCcC8LYCwYilN/kRYkUl/ddpq5qIcv54lAGaTP0QYRFBwYH3gTEHCXFiKkygMNEhf5cdqbiFgIadQ
        7VumJUgrw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44390)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1llyJX-000667-6O; Wed, 26 May 2021 19:31:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1llyJW-00032W-N2; Wed, 26 May 2021 19:31:30 +0100
Date:   Wed, 26 May 2021 19:31:30 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: perf-kvm unable to resolve guest kernel symbols
Message-ID: <20210526183130.GK30436@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While attempting to use "perf kvm --guestkallsyms=g-kallsyms report",
I have found that perf 5.13-rc2 fails to convert IP values to symbols.

After spending a while debugging, what I've found is:

1) perf_session__new() will not read the gust kernel symbols in this
   case (data is non-NULL, and is open read-only.) The comments say
   that symbol reading will be deferred to the MMAP and MMAP2 events.

2) all of the MMAP and MMAP2 events seem to be for
   PERF_RECORD_MISC_KERNEL and PERF_RECORD_MISC_USER. There are none
   for PERF_RECORD_MISC_GUEST_KERNEL.

I have found that disabling the checks in perf_session__new() mentioned
in (1) allows the command above to give me symbolic information. As I
don't know the code all that well, I'm not sure if this is a correct
fix, or whether the problem lies in the "perf kvm record" side - that
depends whether there are supposed to be MMAP/MMAP2 events for the
guest kernel.

Below is the debug diff I've been using so far... (building out of the
kernel tree.) The change to tools/perf/util/session.c seems to be what
has fixed the problem for me, but I don't think this is the correct
fix.

diff -ur -x '*.o' -x '*.cmd' perf-5.13.0-rc2.orig/tools/perf/util/machine.c perf-5.13.0-rc2/tools/perf/util/machine.c
--- perf-5.13.0-rc2.orig/tools/perf/util/machine.c	2021-05-19 15:04:47.000000000 +0100
+++ perf-5.13.0-rc2/tools/perf/util/machine.c	2021-05-20 14:41:55.425771482 +0100
@@ -1234,7 +1234,7 @@
 	char path[PATH_MAX];
 	pid_t pid;
 	char *endp;
-
+printf("machines__create_guest_kernel_maps: %s\n", symbol_conf.default_guest_kallsyms);
 	if (symbol_conf.default_guest_vmlinux_name ||
 	    symbol_conf.default_guest_modules ||
 	    symbol_conf.default_guest_kallsyms) {
@@ -1293,7 +1293,7 @@
 int machines__create_kernel_maps(struct machines *machines, pid_t pid)
 {
 	struct machine *machine = machines__findnew(machines, pid);
-
+printf("machines__create_kernel_maps: %p\n", machine);
 	if (machine == NULL)
 		return -1;
 
@@ -1763,7 +1763,7 @@
 		bid = &__bid;
 		build_id__init(bid, event->mmap2.build_id, event->mmap2.build_id_size);
 	}
-
+printf("%s: cpumode %d\n", "machine__process_mmap2_event", sample->cpumode);
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
 	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
 		struct extra_kernel_map xm = {
@@ -1821,6 +1821,7 @@
 	if (dump_trace)
 		perf_event__fprintf_mmap(event, stdout);
 
+printf("%s: cpumode %d\n", "machine__process_mmap_event", sample->cpumode);
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
 	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
 		struct extra_kernel_map xm = {
diff -ur -x '*.o' -x '*.cmd' perf-5.13.0-rc2.orig/tools/perf/util/session.c perf-5.13.0-rc2/tools/perf/util/session.c
--- perf-5.13.0-rc2.orig/tools/perf/util/session.c	2021-05-19 15:04:47.000000000 +0100
+++ perf-5.13.0-rc2/tools/perf/util/session.c	2021-05-20 12:17:31.251730384 +0100
@@ -243,14 +243,14 @@
 	session->machines.host.single_address_space =
 		perf_env__single_address_space(session->machines.host.env);
 
-	if (!data || perf_data__is_write(data)) {
+//	if (!data || perf_data__is_write(data)) {
 		/*
 		 * In O_RDONLY mode this will be performed when reading the
 		 * kernel MMAP event, in perf_event__process_mmap().
 		 */
 		if (perf_session__create_kernel_maps(session) < 0)
 			pr_warning("Cannot read kernel map\n");
-	}
+//	}
 
 	/*
 	 * In pipe-mode, evlist is empty until PERF_RECORD_HEADER_ATTR is

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
