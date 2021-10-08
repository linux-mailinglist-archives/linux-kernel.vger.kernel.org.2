Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFA42651E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhJHHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhJHHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:20:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB1C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 00:18:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w11so5543071plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pcW2s0FOsfe5B+vyDmP4HCEBN2LXsRBrs8aoN2qtEas=;
        b=cnHlYLjkuJBOqAMrXnD9aq74+xX02yAK8SW2UD1dNoE57BpxUYAGhHGueDbCzMYcHY
         c1TDt8adHByBqGeZumrljRfSDcrLfZIQOx3Qp7KP6oQdrewIgqmJGHy6KQn5AF9kp5h2
         MD+77Eyxz/QF54XD0LiaxOTBNU5BUDFBTGPhcIXDZbo9iJjNbfiJROn8FFcUjCKc1agr
         c0k9WtQfdz6Ngj7BAneGHkxfVPGFnDehVAOo7UMJieOYe+2TgBSJL2EcFB3PA0/MXxNc
         C9cN2G2sKG5BN5jMm/qZFW3jdx5/DE4hGQB44QPv8hD3CWXhIDbwvjVNu+mcoROhQ3ek
         iNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pcW2s0FOsfe5B+vyDmP4HCEBN2LXsRBrs8aoN2qtEas=;
        b=ZsGBgZQnum/7oG2h0I3itXrMYSbccOJPsMArbYOsfC4xa5jTxibuYPo/aKnTCQHTuq
         +VLjC40AaEpmAVxWOhirXY5ie4tdbHa+YRfqUM7Dp9b3ygROayhoFoFGu+zvts5BkOmp
         IW9G6UKmzbCbw4U/Z9J2TZy/fi4kS8pkVKKEZ1DzlG2xVmoBM9yAXJMTJgiXI/DE+053
         OHBZfSEG9uJSvSCSO0xnM2N5SQ8F5eIv44pUcQlIGnbeGxdMSpcnHUKuRHx7GMYN540j
         JOvQaMkAFKAE67fx5bCaWJ18XJK71hL7Y5vRYwUCDjvJ29gPSxA0PsZBhgdNbiBYhIta
         KyCg==
X-Gm-Message-State: AOAM531PZayxYw2g0V54RTTzELr7SvV3lqtfwR70JdpLAaGTaUa3VcpL
        ogdTemIpmmJvqQXmu7kdWGk=
X-Google-Smtp-Source: ABdhPJzeKfGCEUMfwyiP1Ixm7ZttM0FX/hx+FKuzpSfAbLMEN2VSxn1IKpUE7C/BAU1zygUXcQFBEA==
X-Received: by 2002:a17:902:b691:b029:12d:2b6:d116 with SMTP id c17-20020a170902b691b029012d02b6d116mr7944935pls.71.1633677490187;
        Fri, 08 Oct 2021 00:18:10 -0700 (PDT)
Received: from cosmos ([103.105.225.252])
        by smtp.gmail.com with ESMTPSA id u1sm10205563pju.2.2021.10.08.00.18.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Oct 2021 00:18:09 -0700 (PDT)
Date:   Fri, 8 Oct 2021 12:48:06 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH resend] tracing: fix memory leak in eprobe_register()
Message-ID: <20211008071802.GA2098@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak report:
unreferenced object 0xffff900a70ec7ec0 (size 32):
  comm "ftracetest", pid 2770, jiffies 4295042510 (age 311.464s)
  hex dump (first 32 bytes):
    c8 31 23 45 0a 90 ff ff 40 85 c7 6e 0a 90 ff ff  .1#E....@..n....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000009d3751fd>] kmem_cache_alloc_trace+0x2a2/0x440
    [<0000000088b8124b>] eprobe_register+0x1e3/0x350
    [<000000002a9a0517>] __ftrace_event_enable_disable+0x7c/0x240
    [<0000000019109321>] event_enable_write+0x93/0xe0
    [<000000007d85b320>] vfs_write+0xb9/0x260
    [<00000000b94c5e41>] ksys_write+0x67/0xe0
    [<000000005a08c81d>] __x64_sys_write+0x1a/0x20
    [<00000000240bf576>] do_syscall_64+0x3b/0xc0
    [<0000000043d5d9f6>] entry_SYSCALL_64_after_hwframe+0x44/0xae

unreferenced object 0xffff900a56bbf280 (size 128):
  comm "ftracetest", pid 2770, jiffies 4295042510 (age 311.464s)
  hex dump (first 32 bytes):
    ff ff ff ff ff ff ff ff 00 00 00 00 01 00 00 00  ................
    80 69 3b b2 ff ff ff ff 20 69 3b b2 ff ff ff ff  .i;..... i;.....
  backtrace:
    [<000000009d3751fd>] kmem_cache_alloc_trace+0x2a2/0x440
    [<00000000c4e90fad>] eprobe_register+0x1fc/0x350
    [<000000002a9a0517>] __ftrace_event_enable_disable+0x7c/0x240
    [<0000000019109321>] event_enable_write+0x93/0xe0
    [<000000007d85b320>] vfs_write+0xb9/0x260
    [<00000000b94c5e41>] ksys_write+0x67/0xe0
    [<000000005a08c81d>] __x64_sys_write+0x1a/0x20
    [<00000000240bf576>] do_syscall_64+0x3b/0xc0
    [<0000000043d5d9f6>] entry_SYSCALL_64_after_hwframe+0x44/0xae

In new_eprobe_trigger(), allocated edata and trigger variables are
never freed.

To fix, free memory in disable_eprobe().

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 kernel/trace/trace_eprobe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 3044b762cbd7..570d081929fb 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -632,6 +632,13 @@ static int disable_eprobe(struct trace_eprobe *ep,
 
 	trace_event_trigger_enable_disable(file, 0);
 	update_cond_flag(file);
+
+	/* Make sure nothing is using the edata or trigger */
+	tracepoint_synchronize_unregister();
+
+	kfree(edata);
+	kfree(trigger);
+
 	return 0;
 }
 
-- 
2.17.1

