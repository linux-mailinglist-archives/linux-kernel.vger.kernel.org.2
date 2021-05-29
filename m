Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83553394AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 08:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhE2GQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 02:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2GQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 02:16:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E702C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 23:14:28 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso3710033pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W5FAkzTr89CgevOtnWohGvbeekfDCwIv65rUKl5JoZs=;
        b=Mf1zzQXg8/dcFULFmvH6aCDce7f5MNnrKclpGXq6gIWYJSgc3YknwuQa6cdj1e/wGE
         WV73tAA6nBZXnPARPgy/ztcYay4oygwQJM1mgeiRHmcvt3OoYm7ig0kOEB97A6DwT3r0
         ZPVzVwaMqSqbJEWsRvRcwT0Ow9rkEsEBwOt2KfzH4rQcntAql4pouXYydxo/bObTPskL
         sKjTxugEScRICbbHU7/Q0an+Lm6CFmzZ7KJwBykpDNg0g8CxH8sZhBWeKQoPA63mv5jv
         g8al38hLxCRNLvNvijODqEig581i3BMz04zneE6tf0QUZUhsVRj1HsIE1BBgkQtk7lum
         2K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W5FAkzTr89CgevOtnWohGvbeekfDCwIv65rUKl5JoZs=;
        b=jC+JttUrk4vuURYLITv1OaFagJKmMlYKH92lil5Stpv/mwjZm3Y/ta9WgOb763LwAa
         pNRJrqPIph/+gzsq7leMNJnTLexyoH+hYML9IFEI/21KUGkKpO5G1Z+Dahkz2QffHgj9
         RKZRjz338peF34AmMSc3VeMChTlulaGwwAJz269KZelkALIQmafcWy91eFsuRxT5coli
         IgbR3RpoQnUqcIhykY0qblZfOsRUNCpDY/ApF80DQCnA7Qw4TgtXmo5NUyat/PrCwQkh
         +cVbYgQA/b0hQYEYolri5bCSsjQSCKxeD3k3atMWnj8t5z8/mJQbm1jw/crsXu29m+YJ
         eIZw==
X-Gm-Message-State: AOAM532X963/vNAJNfcGBpuHV6Iqr2Sg2bx3o2fPtDA24Nv4KPeM8nav
        kZSyUqBFIdEdivWjHulMLPU=
X-Google-Smtp-Source: ABdhPJy8prW34mc5XEF8Q3stjlrAKDm1l5YceLzOnJNPMtCBuyD0TmwqzxjAuUG5yg3RPH9/ZvPo8w==
X-Received: by 2002:a17:902:8f8f:b029:fa:5d6b:f08b with SMTP id z15-20020a1709028f8fb02900fa5d6bf08bmr11338713plo.44.1622268867918;
        Fri, 28 May 2021 23:14:27 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id q3sm5851914pff.142.2021.05.28.23.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 23:14:27 -0700 (PDT)
Date:   Sat, 29 May 2021 15:14:23 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Add WARN_ON_ONCE when returned value is negative
Message-ID: <20210529061423.GA103954@hyeyoo>
References: <20210527171449.GA145584@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527171449.GA145584@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

