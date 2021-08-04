Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB03DF9C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhHDCkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhHDCkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:40:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F9F61029;
        Wed,  4 Aug 2021 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628044827;
        bh=b/yCEEYrBrU+A3fTEWp0ZEibouN5QfokYnKFbTWvxss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQOZ9FSdm+2PCME3CspbMkLT7pOP/d89rmPN+Iw8wbJRwemq4lViz37QJtRdt7JiO
         VrQOkqCkO1eW+yrdj+yQAPbPfEJ5FXJErfsJNpwgg8nNkr57Q6OnG7cGctvI7BRnB/
         ZP3LtND+r1YBI+LvXu1IdVpdVi/+bEygAak59SBAu61BRuf+ErCEk0+EVSAyvOyYcs
         IQ+vVS2QeN48ASCpuLjoo5t1TjEGmaYPNWj1sm7FRIztUhKvy9UWAMIr7f8bHhYkKa
         5qlz47Kl4kQDfxzwcOdgvh0kk03PqObqBzgyBPylFnSZbHci4OT+Tq4blHihs7nmz6
         lbVY5/VRdlSIQ==
Date:   Tue, 3 Aug 2021 19:40:26 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ucounts: add missing data type changes
Message-ID: <YQn+GomdRCoYc/E8@Ryzen-9-3900X.localdomain>
References: <20210730062854.3601635-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730062854.3601635-1-svens@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 08:28:54AM +0200, Sven Schnelle wrote:
> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
> changed the data type of ucounts/ucounts_max to long, but missed to
> adjust a few other places. This is noticeable on big endian platforms
> from user space because the /proc/sys/user/max_*_names files all
> contain 0.
> 
> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

This patch in -next as commit e43fc41d1f7f ("ucounts: add missing data type
changes") causes Windows Subsystem for Linux to fail to start:

[error 0x8007010b when launching `wsl.exe -d Arch'] Could not access starting
directory "\\wsl$\Arch\home\nathan"

Specifically, it is the change to max_user_watches in
fs/notify/inotify/inotify_user.c, as the below diff gets me back to working.
Unfortunately, I have no additional information to offer beyond that as WSL's
init is custom and closed source (as far as I am aware) and there are no real
debugging utilities.

Cheers,
Nathan

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 55fe7cdea2fb..32178a95c1b3 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -68,9 +68,9 @@ struct ctl_table inotify_table[] = {
        {
                .procname       = "max_user_watches",
                .data           = &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
-               .maxlen         = sizeof(long),
+               .maxlen         = sizeof(int),
                .mode           = 0644,
-               .proc_handler   = proc_doulongvec_minmax,
+               .proc_handler   = proc_dointvec_minmax,
                .extra1         = SYSCTL_ZERO,
                .extra2         = SYSCTL_INT_MAX,
        },

