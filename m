Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC0394AAD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 08:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhE2GCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 02:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2GCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 02:02:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 23:00:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m190so4164339pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 23:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=InZqYx/06vcOEw+/d6hR89mWaCoTX4xtWcUygF4loTs=;
        b=npIyJuDU8bGRJ6ThHEVZPfBwamQ3V1JesTMZ9lx/kMVTX3/H8VMGuZUh1j1m2YASpg
         By0FgmzqqpnXf2lcKVxEu6fARoxUdlEsv9VvNjO7prALEwe9h5I09o6zgZnP1FihX9bO
         TkbOi0Xn9hzMlAB0xufDtzpGRFsb7bnBa6uLjUYQC4H82B1/KnfyO8dF8XrAmky2hS9/
         /ZlTkxdA8+Pqgs/CzC4gF+Ms33fU+IDWsRDuecP8vvEbiO2d+9300PqtE+5JtF+zb1kw
         z1ScogSXUg40XxtOsedn2ZfCSeofLiYHb1o5qT5GKkZwVRGgY5ch/scqrO1hEUyVl1q6
         nNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=InZqYx/06vcOEw+/d6hR89mWaCoTX4xtWcUygF4loTs=;
        b=b/0N6oDZo/0gL+Tt6Pra5GxQuXY7F9OmYIPcFA8ItQIVI4FHQaAvKg9rKgaH2nNSSQ
         61Ex76SbygCKuHZLlkrOa2RGDvjIib1ng6x5Us/OKpM7iVa4A5yiT34T21BqnXkdATJ/
         wbVC9lsuerCoK/0o1w6yLDaknitEE3dgFwXQ43xGerlRdefm+TyczAr+JB4kPHpdBz95
         /fDByNTaOwAMZD/UUeYWTKDFH5eHSGoAxk4uXr/5VSIY8nrZMI6fw9QD+IkESBYEimNP
         MfZ6UPYgIO5a+vhplyH8yK2W0zHDJckNfZL1j7kAkItiWKvyjxOBnsWR2BchskgN3+Ko
         XKBQ==
X-Gm-Message-State: AOAM531ruTG2Nw1fW5yKESVLF9cz1XvWhdIOcYiP7wohYSm5GnJ0mgYe
        ag4fDh/6jWFd6l+0uqrcoD0=
X-Google-Smtp-Source: ABdhPJwX3WrAHqQnP4GTWkM0BPIiEVT8yYAXTXATmGO9MrVQVppQtR5hPzdpiXCyabA5keMJI4kGKA==
X-Received: by 2002:a63:a70e:: with SMTP id d14mr12413500pgf.43.1622268054655;
        Fri, 28 May 2021 23:00:54 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id 4sm5422363pji.14.2021.05.28.23.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 23:00:54 -0700 (PDT)
Date:   Sat, 29 May 2021 15:00:49 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Add WARN_ON_ONCE when returned value is negative
Message-ID: <20210529060049.GB99161@hyeyoo>
References: <20210527171449.GA145584@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527171449.GA145584@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From af7124e2bd00f739010eb283c9ab07e07da52224 Mon Sep 17 00:00:00 2001
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sat, 29 May 2021 14:51:05 +0900
Subject: [PATCH v2] tracing: Add WARN_ON_ONCE when returned value is negative

ret is assigned return value of event_hist_trigger_func, but the value
is unused. It is better to warn when returned value is negative,
rather than just ignoring it.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c1abd63f1d6c..d169946ea4e9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5232,6 +5232,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 		cmd = hist_data->field_var_hists[i]->cmd;
 		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
 					      "!hist", "hist", cmd);
+		WARN_ON_ONCE(ret < 0);
 	}
 }
 
-- 
2.25.1

