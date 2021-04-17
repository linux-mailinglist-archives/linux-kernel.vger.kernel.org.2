Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF5362EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhDQJHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:07:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhDQJHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:07:01 -0400
Received: from zn.tnic (p200300ec2f1c420068be28058de9c1f3.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:4200:68be:2805:8de9:c1f3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57E921EC0505;
        Sat, 17 Apr 2021 11:06:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618650394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MLaYfHZLuafpD046iFgNR2L8DFL3ZSII/0dVtUdJgTw=;
        b=F27m6cK9KV/P93SnTfjucRKvVeIpJdFalciUIzP98AVmChB/8b5N6QHDHUeg9bI1ARlkDL
        QbupsQKBIoQTyTNv+TMn2mS4Fa/8JeVLWjQAeeHu6gDyU+cvEwjHYzSv2MhusNn9hmqRNN
        mbKjR22dk6Hx7Pd4CQuEQcOm4NavBoY=
Date:   Sat, 17 Apr 2021 11:06:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:sched/core 23/23] kernel/sched/topology.c:17:2: error:
 'sched_debug_verbose' undeclared; did you mean 'sched_debug_setup'?
Message-ID: <20210417090628.GA9196@zn.tnic>
References: <202104171441.AKFwtRfO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202104171441.AKFwtRfO-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 02:47:46PM +0800, kernel test robot wrote:
>    kernel/sched/topology.c: In function 'sched_debug_setup':
> >> kernel/sched/topology.c:17:2: error: 'sched_debug_verbose' undeclared (first use in this function); did you mean 'sched_debug_setup'?
>       17 |  sched_debug_verbose = true;

I guess it needs this:

---
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 55232db745ac..916bb96ff9a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2364,6 +2364,7 @@ extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
 
 #ifdef	CONFIG_SCHED_DEBUG
 extern bool sched_debug_enabled;
+extern bool sched_debug_verbose;
 
 extern void print_cfs_stats(struct seq_file *m, int cpu);
 extern void print_rt_stats(struct seq_file *m, int cpu);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
