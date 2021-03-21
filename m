Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE6343194
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 08:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCUHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 03:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhCUHFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 03:05:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2D4D6192D;
        Sun, 21 Mar 2021 07:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616310355;
        bh=LVQIo8E2L4heNrkz8TmgtJDUdTrrgojDsXkGOptHwRI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=jTrh/i6QyA+BqiaMHBWL1nbXopzoi+R8rCDvmPa36DLNd8FPmizlBuhG61gSXAI8x
         Fm7hyBueuhYP/FYTQPKe3s/RVyS7PMGZKtkJ3swaI95sEAgraRYIgFXhp/M/X0aQRc
         u3F75HabBg8E1/1Xwnj5b4oRM6695fBR1xAnzvo8=
Date:   Sun, 21 Mar 2021 08:05:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 5.10.25
Message-ID: <YFbwUPaIgNv035+j@kroah.com>
References: <161623579648126@kroah.com>
 <YFZpy9Ov99npi9T8@audible.transient.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFZpy9Ov99npi9T8@audible.transient.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 09:31:55PM +0000, Jamie Heilman wrote:
> [ugh, resent with the lkml headers unbroken, sorry about the dupe]
> 
> Greg Kroah-Hartman wrote:
> > J. Bruce Fields (2):
> >       Revert "nfsd4: remove check_conflicting_opens warning"
> >       Revert "nfsd4: a client's own opens needn't prevent delegations"
> 
> Hrm, just got this when I udpated my nfs server (32bit Via EPIA system)
> from 5.10.20 to 5.10.25:
> 
> [   49.225914] NFSD: Using UMH upcall client tracking operations.
> [   49.231919] NFSD: starting 90-second grace period (net f0000036)
> [   50.036973] ------------[ cut here ]------------
> [   50.041771] WARNING: CPU: 0 PID: 2284 at fs/nfsd/nfs4state.c:4968 nfsd4_process_open2+0xf9c/0x1170 [nfsd]
> [   50.051434] Modules linked in: md5 cpufreq_conservative cpufreq_userspace cpufreq_powersave cpufreq_ondemand autofs4 quota_v2 quota_tree nfsd auth_rpcgss nfs lockd grace nfs_ssc fscache sunrpc xt_mark cls_fw sch_htb iptable_nat xt_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_multiport iptable_mangle xt_state xt_conntrack nf_conntrack nf_defrag_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_limit iptable_filter ip_tables x_tables nhpoly1305 chacha_generic libchacha adiantum libpoly1305 dm_crypt dm_mod snd_hda_codec_via snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_pcm snd_timer snd via_rhine psmouse soundcore mii via_agp sg via_velocity evdev agpgart
> [   50.113386] CPU: 0 PID: 2284 Comm: nfsd Tainted: G                T 5.10.25 #1
> [   50.120669] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS 080014  06/01/2009
> [   50.131652] EIP: nfsd4_process_open2+0xf9c/0x1170 [nfsd]
> [   50.137036] Code: 04 88 45 a4 88 07 8b 45 a0 8d 78 49 8b 45 84 8d 70 01 e9 2b f8 ff ff c7 45 9c 00 00 00 00 31 ff bb 00 00 27 67 e9 04 f6 ff ff <0f> 0b e9 a0 f5 ff ff 0f b6 d4 0f a3 15 94 3f 23 f8 0f 83 b1 fd ff
> [   50.155866] EAX: 00000000 EBX: 82da25b0 ECX: 830c0920 EDX: 00000000
> [   50.162187] ESI: 82da25b0 EDI: 82da55a0 EBP: 8310be68 ESP: 8310bddc
> [   50.168507] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [   50.175338] CR0: 80050033 CR2: 00551e50 CR3: 03222000 CR4: 000006b0
> [   50.181654] Call Trace:
> [   50.184165]  ? inode_permission+0x17/0xc0
> [   50.188289]  nfsd4_open+0x429/0x910 [nfsd]
> [   50.192483]  ? nfsd4_encode_operation+0x185/0x1e0 [nfsd]
> [   50.197900]  ? nfsd4_rename+0x1a0/0x1a0 [nfsd]
> [   50.202439]  nfsd4_proc_compound+0x457/0x6c0 [nfsd]
> [   50.207419]  nfsd_dispatch+0xdc/0x1a0 [nfsd]
> [   50.211816]  svc_process_common+0x38a/0x650 [sunrpc]
> [   50.216880]  ? svc_xprt_do_enqueue+0xd7/0xe0 [sunrpc]
> [   50.222017]  ? svc_xprt_received+0x5d/0xf0 [sunrpc]
> [   50.227000]  ? nfsd_svc+0x300/0x300 [nfsd]
> [   50.231190]  svc_process+0xa9/0xf0 [sunrpc]
> [   50.235468]  nfsd+0xcd/0x120 [nfsd]
> [   50.239025]  kthread+0xe1/0x100
> [   50.242259]  ? nfsd_destroy+0x50/0x50 [nfsd]
> [   50.246588]  ? kthread_create_on_node+0x30/0x30
> [   50.251165]  ret_from_fork+0x1c/0x28
> [   50.254789] ---[ end trace 171bde4774bc9795 ]---
> 
> Can't readily reproduce it though, so likely a race condition or
> something that requires more state buildup than I have after a few
> minutes of uptime.  Kernel config at
> http://audible.transient.net/~jamie/k/nfsd.config-5.10.25 in case you
> think this worth more investigation.

Do you also have this issue in Linus's tree and the latest 5.11.y
release?

thanks,

greg k-h
