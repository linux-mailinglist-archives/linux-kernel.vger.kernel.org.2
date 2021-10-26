Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDC43ADEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhJZI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:26:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47384 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhJZI0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:26:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78155218F6;
        Tue, 26 Oct 2021 08:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635236613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+f/H5/JbtnWcCCCiTOuPEBxaP/SIVVdPJpeDufpk+lo=;
        b=krcavT+1zZHh1XiXC75HzOfYF6s6JK7epcRObggU7VYhTVAo55CmCS+ROH5vK8vz2og0NX
        IXIiNHIEq7czKpe9ooqvNYb7sBkgcl8LSFy0aEX1kWXSlKHxFD8tzMrv73OCbkaTPEF53u
        npO5Yow34ww66hcHti1Qzps0ao4itc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635236613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+f/H5/JbtnWcCCCiTOuPEBxaP/SIVVdPJpeDufpk+lo=;
        b=ZKnqDdWPQKQGV4RB+i2pRfI2rt8lEuhWK9izW6fw0bPKfDCk3+zIdGNqbk+3Rdcw5l2QJ7
        TPN1z+MF8kqaGmBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B45813AEE;
        Tue, 26 Oct 2021 08:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wYK6FQW7d2F1VAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 26 Oct 2021 08:23:33 +0000
Date:   Tue, 26 Oct 2021 10:23:30 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <lkp@intel.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <YXe7AnMmiWXk36NC@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202110261614.Bt8EM6Nj-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 26, 2021 at 04:16:21PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
> commit: 7bb39313cd6239e7eb95198950a02b4ad2a08316 x86/mce: Make mce_timed_out() identify holdout CPUs
> date:   10 months ago
> config: x86_64-buildonly-randconfig-r006-20211022 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7bb39313cd6239e7eb95198950a02b4ad2a08316
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7bb39313cd6239e7eb95198950a02b4ad2a08316
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to memset() leaves .noinstr.text section

if you have the technical capability to ignore all noinstr warnings
coming from the mce code, please do so.

I have a patchset to address that but more important work preempts me
constantly from cleaning it up and sending it out properly. ;-\

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
