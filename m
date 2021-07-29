Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85B3DAAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhG2SHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:07:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59966 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhG2SH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:07:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 99F84223C1;
        Thu, 29 Jul 2021 18:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627582045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=HDYq/z6PdlUP94JVU6Rwiyjo1kknfFWM1ZaRitbslAg=;
        b=OyK+nmD/1YC1IwC4vzHOZ+akmru4RH8Ta2rxBG9a/4m2fFyedDOoQtc8RX7s5JD4gw4ik3
        G6VKj2mkXic8CvXrD/evP5TsbYaHuof6V01XY6hO1Q7KOc1gjB7YpVkVB7wYdizodMTuOO
        5zUZmja5y2Jbehn2uJoCRcSCwxvCtio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627582045;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=HDYq/z6PdlUP94JVU6Rwiyjo1kknfFWM1ZaRitbslAg=;
        b=saIlOc2vBXoN4+PtV/7gJZRgyBzk+WJidP64t6Fu5pQxCTrNy6jLj+s4cNpoym+TDSquqy
        CMYF+L8sJHHbhOCw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 71848A3B87;
        Thu, 29 Jul 2021 18:07:25 +0000 (UTC)
Date:   Thu, 29 Jul 2021 20:07:24 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: checkpatch does not like quoting patch subject with doublequotes
Message-ID: <20210729180724.GG21290@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the following message from checkpatch:

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#18: 
commit 7c6986ade69e ("powerpc/stacktrace: Fix spurious "stale" traces in raise_backtrace_ipi()")

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 7c6986ade69e ("powerpc/stacktrace: Fix spurious "stale" traces in raise_backtrace_ipi()")'
#18: 
commit 7c6986ade69e ("powerpc/stacktrace: Fix spurious "stale" traces in raise_backtrace_ipi()")

total: 1 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-powerpc-stacktrace-Include-linux-delay.h.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

AFAICT there is not problem with the way the patch is quoted but rather
checkpatch is confused by the patch subject containing double quotes.

Can you please have a look?

Thanks

Michal
