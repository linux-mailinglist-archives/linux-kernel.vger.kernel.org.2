Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85139F70E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhFHMsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:48:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhFHMsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:48:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 262FB219D4;
        Tue,  8 Jun 2021 12:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623156384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8YAiePi9RyrJ6ec0Pw7MGiV+w8Y5LZOcRMmCLi4RrY=;
        b=dDdYOMlWgXYz5wdnDhNGLLASczxB+H9YnLvM3CUljf44k+9YH4u8mC09ZHFB0AGLXglZAZ
        T95KY8rqppgUIzqP2jSBemFfOeNh6+newNMAxsSa77ewSH4ym0qbVjjKuz81i33zjLHZ8U
        B1KEigRQbUroH86TZHC19AxkznSG5X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623156384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8YAiePi9RyrJ6ec0Pw7MGiV+w8Y5LZOcRMmCLi4RrY=;
        b=2weqSWBLJNroPBi+APv/kEDjnVgrqSx5QAkwvDc9C59q1aTVA3hQ4JMAdoG2gdN2TLFu+X
        oAC29PhMSNs5YdAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BD15D118DD;
        Tue,  8 Jun 2021 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623156384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8YAiePi9RyrJ6ec0Pw7MGiV+w8Y5LZOcRMmCLi4RrY=;
        b=dDdYOMlWgXYz5wdnDhNGLLASczxB+H9YnLvM3CUljf44k+9YH4u8mC09ZHFB0AGLXglZAZ
        T95KY8rqppgUIzqP2jSBemFfOeNh6+newNMAxsSa77ewSH4ym0qbVjjKuz81i33zjLHZ8U
        B1KEigRQbUroH86TZHC19AxkznSG5X8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623156384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8YAiePi9RyrJ6ec0Pw7MGiV+w8Y5LZOcRMmCLi4RrY=;
        b=2weqSWBLJNroPBi+APv/kEDjnVgrqSx5QAkwvDc9C59q1aTVA3hQ4JMAdoG2gdN2TLFu+X
        oAC29PhMSNs5YdAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id kdiVKp9mv2CCTwAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Tue, 08 Jun 2021 12:46:23 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id df03d76d;
        Tue, 8 Jun 2021 12:46:23 +0000 (UTC)
Date:   Tue, 8 Jun 2021 13:46:22 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Michael Matz <matz@suse.de>
Subject: Re: gcov: NULL pointer dereference with gcc 9.3.1
Message-ID: <YL9mngUhaBjTawDD@suse.de>
References: <YLZYwgs5hyzFZMlw@suse.de>
 <0a013450-75eb-de2c-f90a-3df193800cea@linux.ibm.com>
 <YLeUMit+CTfZl8pw@suse.de>
 <e8207b09-265b-60a6-7fb0-51dda7cf59d6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8207b09-265b-60a6-7fb0-51dda7cf59d6@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:32:14PM +0200, Peter Oberparleiter wrote:
> On 02.06.2021 16:22, Luis Henriques wrote:
> > On Wed, Jun 02, 2021 at 02:35:31PM +0200, Peter Oberparleiter wrote:
> >> On 01.06.2021 17:56, Luis Henriques wrote:
> >>> Hi!
> >>>
> >>> Maybe this is a known (gcc?) issue, but I'm seeing a NULL pointer splat if
> >>> I instrument my kernel (or a module, more specifically) using gcc 9.3.1.
> >>>
> >>> It looks like, during initialization in __gcov_init(), gcov_info struct is
> >>> invalid: the filename seems to be correct but ->function is NULL and
> >>> ->n_functions contains garbage.
> >>
> >> Thanks for reporting this issue. The symptoms you're seeing look similar
> >> to those that occur when the struct gcov_info layout emitted by GCC does
> >> not match the one used by the kernel. In particular a change in the
> >> GCOV_COUNTER value can cause this behavior.
> >>
> >> I've checked upstream GCC 9.3.1 and it seems to match what is used by
> >> the kernel for that GCC version. Could you provide the exact version of
> >> the compiler you are using? Both 'gcc --version' output and the GCC
> >> package version should help. Also what architecture are you seeing this on?
> > 
> > Here's the output of 'gcc --version':
> > 
> > gcc (SUSE Linux) 9.3.1 20200903 [revision 9790fa53b48f3a48e0f7a7ad65e2bbf3b206a7b0]
> > Copyright (C) 2019 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > 
> > This is the version shipped with openSUSE Tumbleweed, and I'm using it to
> > compile an x86_64 kernel.  Regarding the 'package version', I'm assuming
> > the packages as per the distro package version, right?  Here's the data
> > from 'zypper info':
> > 
> > Information for package gcc9:
> > -----------------------------
> > Repository     : Main Repository (OSS)
> > Name           : gcc9
> > Version        : 9.3.1+git1684-3.5
> > Arch           : x86_64
> > Vendor         : openSUSE
> > Installed Size : 94.6 MiB
> > Installed      : Yes (automatically)
> > Status         : up-to-date
> > Source package : gcc9-9.3.1+git1684-3.5.src
> 
> I've checked the source you referenced and found that it contains a
> backport of a change to gcov_info that was only introduced with GCC 10
> to upstream source: the value of GCOV_COUNTERS was reduced from 9 to 8.
> 
> Since I don't think it's feasible to implement support for such
> vendor-specific changes in the upstream kernel source my suggestion for
> you would be to either
> 
> a) fall back to a vanilla GCC version,
> b) fall back to a known-to-work vendor-specific GCC version (GCC 10
>    should be fine), or
> c) to manually change the GCOV_COUNTERS value in
>    linux/kernel/gcov/gcc_4_7.c to 8.

Thanks a lot for looking Peter, I've already reported this issue to the
maintainers.  Hopefully it'll soon be looked at.  Anyway, to be honest I
just hit this issue accidentally -- I don't really have a requirement on
using this version specifically.

Cheers,
--
Luís

> > Do you have a link with binaries I could test for upstream 9.3.1?  I
> > checked [1] but there's only 9.3.0.
> 
> I'm not sure there is any. My analysis was based on source code for
> 9.3.0 alone.
> 
> 
> Regards,
>   Peter Oberparleiter
> 
> -- 
> Peter Oberparleiter
> Linux on Z Development - IBM Germany
