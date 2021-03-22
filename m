Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BDA344EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhCVShG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhCVSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616438203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOKW4UZJN2rIhPYsnMRdNPfK5rnJKkqKYGET3na5MPM=;
        b=EeV7IhuZA7dC72MRcLo3Lz3oMUKPV3uFZOuASpB3/FwVxtrs6eh/gPW6THGR0B344FjW63
        0rh5qgHr5P4NS+nWL0WB2cNAkjO2DstFL62T/vEr76CucfUuhzroumOIMeRt34xW28m0rQ
        Wva5gckAmFL1PHA6eyhXZ5I7ltfbksA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-BRtJTXkPNbKprI6fX78e6g-1; Mon, 22 Mar 2021 14:36:40 -0400
X-MC-Unique: BRtJTXkPNbKprI6fX78e6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34856871377;
        Mon, 22 Mar 2021 18:36:39 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-115-53.rdu2.redhat.com [10.10.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFA55610F6;
        Mon, 22 Mar 2021 18:36:38 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 836731206EA; Mon, 22 Mar 2021 14:36:37 -0400 (EDT)
Date:   Mon, 22 Mar 2021 14:36:37 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 5.10.25
Message-ID: <YFjjtSi+H33zXQOn@pick.fieldses.org>
References: <161623579648126@kroah.com>
 <YFZpy9Ov99npi9T8@audible.transient.net>
 <YFbwUPaIgNv035+j@kroah.com>
 <YFb1G4goExfAXGnu@audible.transient.net>
 <YFfRnGyisaqcfygs@audible.transient.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFfRnGyisaqcfygs@audible.transient.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 11:07:08PM +0000, Jamie Heilman wrote:
> Jamie Heilman wrote:
> > Greg Kroah-Hartman wrote:
> > > On Sat, Mar 20, 2021 at 09:31:55PM +0000, Jamie Heilman wrote:
> > > > [ugh, resent with the lkml headers unbroken, sorry about the dupe]
> > > > 
> > > > Greg Kroah-Hartman wrote:
> > > > > J. Bruce Fields (2):
> > > > >       Revert "nfsd4: remove check_conflicting_opens warning"
> > > > >       Revert "nfsd4: a client's own opens needn't prevent delegations"
> > > > 
> > > > Hrm, just got this when I udpated my nfs server (32bit Via EPIA system)
> > > > from 5.10.20 to 5.10.25:
> > > > 
> > > > [   49.225914] NFSD: Using UMH upcall client tracking operations.
> > > > [   49.231919] NFSD: starting 90-second grace period (net f0000036)
> > > > [   50.036973] ------------[ cut here ]------------
> > > > [   50.041771] WARNING: CPU: 0 PID: 2284 at fs/nfsd/nfs4state.c:4968 nfsd4_process_open2+0xf9c/0x1170 [nfsd]
> > > > [   50.051434] Modules linked in: md5 cpufreq_conservative cpufreq_userspace cpufreq_powersave cpufreq_ondemand autofs4 quota_v2 quota_tree nfsd auth_rpcgss nfs lockd grace nfs_ssc fscache sunrpc xt_mark cls_fw sch_htb iptable_nat xt_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_multiport iptable_mangle xt_state xt_conntrack nf_conntrack nf_defrag_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_limit iptable_filter ip_tables x_tables nhpoly1305 chacha_generic libchacha adiantum libpoly1305 dm_crypt dm_mod snd_hda_codec_via snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_pcm snd_timer snd via_rhine psmouse soundcore mii via_agp sg via_velocity evdev agpgart
> > > > [   50.113386] CPU: 0 PID: 2284 Comm: nfsd Tainted: G                T 5.10.25 #1
> > > > [   50.120669] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS 080014  06/01/2009
> > > > [   50.131652] EIP: nfsd4_process_open2+0xf9c/0x1170 [nfsd]
> > > > [   50.137036] Code: 04 88 45 a4 88 07 8b 45 a0 8d 78 49 8b 45 84 8d 70 01 e9 2b f8 ff ff c7 45 9c 00 00 00 00 31 ff bb 00 00 27 67 e9 04 f6 ff ff <0f> 0b e9 a0 f5 ff ff 0f b6 d4 0f a3 15 94 3f 23 f8 0f 83 b1 fd ff
> > > > [   50.155866] EAX: 00000000 EBX: 82da25b0 ECX: 830c0920 EDX: 00000000
> > > > [   50.162187] ESI: 82da25b0 EDI: 82da55a0 EBP: 8310be68 ESP: 8310bddc
> > > > [   50.168507] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00010246
> > > > [   50.175338] CR0: 80050033 CR2: 00551e50 CR3: 03222000 CR4: 000006b0
> > > > [   50.181654] Call Trace:
> > > > [   50.184165]  ? inode_permission+0x17/0xc0
> > > > [   50.188289]  nfsd4_open+0x429/0x910 [nfsd]
> > > > [   50.192483]  ? nfsd4_encode_operation+0x185/0x1e0 [nfsd]
> > > > [   50.197900]  ? nfsd4_rename+0x1a0/0x1a0 [nfsd]
> > > > [   50.202439]  nfsd4_proc_compound+0x457/0x6c0 [nfsd]
> > > > [   50.207419]  nfsd_dispatch+0xdc/0x1a0 [nfsd]
> > > > [   50.211816]  svc_process_common+0x38a/0x650 [sunrpc]
> > > > [   50.216880]  ? svc_xprt_do_enqueue+0xd7/0xe0 [sunrpc]
> > > > [   50.222017]  ? svc_xprt_received+0x5d/0xf0 [sunrpc]
> > > > [   50.227000]  ? nfsd_svc+0x300/0x300 [nfsd]
> > > > [   50.231190]  svc_process+0xa9/0xf0 [sunrpc]
> > > > [   50.235468]  nfsd+0xcd/0x120 [nfsd]
> > > > [   50.239025]  kthread+0xe1/0x100
> > > > [   50.242259]  ? nfsd_destroy+0x50/0x50 [nfsd]
> > > > [   50.246588]  ? kthread_create_on_node+0x30/0x30
> > > > [   50.251165]  ret_from_fork+0x1c/0x28
> > > > [   50.254789] ---[ end trace 171bde4774bc9795 ]---
> > > > 
> > > > Can't readily reproduce it though, so likely a race condition or
> > > > something that requires more state buildup than I have after a few
> > > > minutes of uptime.  Kernel config at
> > > > http://audible.transient.net/~jamie/k/nfsd.config-5.10.25 in case you
> > > > think this worth more investigation.
> > > 
> > > Do you also have this issue in Linus's tree and the latest 5.11.y
> > > release?
> > 
> > Haven't tried it, but like I said, I couldn't even reproduce it again
> > with 5.10.25, or booting between 5.10.20 to 5.10.25 again ... I'll
> > give the others a shot and see if I can repro it there.
> 
> Yeah, can't repro it with 5.11.8 or 5.12.0-rc3-00281-g1d4345eb51a1
> either, seems to have been a spurious thing.

I've seen at least one report previously, so it's not a regression.

I'm not sure what's going on there.  I think it might actually be
possible if a CLOSE arrives from the client at exactly the wrong moment.
In which case, all that happens here is we decline to give out a
delegation.  Probably the warning should just be removed.

--b.

