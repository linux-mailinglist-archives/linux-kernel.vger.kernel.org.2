Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B531C32A24C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381456AbhCBHdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbhCBHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:05:52 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7BC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 23:05:06 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mj10so13086403ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 23:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66TYp+n2vdORrHIy8yY1LGpfAbTwn2i4pgNuMUqrSkg=;
        b=ovf3jTvfuiCTGX7H74d433zOHZ4X8oDxTY7nlinIE3vYPgRkKbuo2Vj1GNbFWJqj89
         ei5FT/YVK741o8vc0gF+BiqboQEk9xfFTpohI+3mvGf9RXprwerEEdI3/NVjYz+m/e2Q
         YmerzYedZRjBTPB6WUH506lA4b6MKADiDsKeEv/juvLO4UhIdCOeeMy7fnRWb+aP7KMf
         lWsbsEc/YkDC2Mmy78j/dYo9eokXbJaTFDs0dt85Bqpfc2XdquSGrgAwVIFzVxE28xMf
         CdKeFwmmwD5gM1UxTb3msvoXVHaln1zXpFB7lAoBBxxhx/sbuMy3yQJviIhhOtrT6ewX
         vP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=66TYp+n2vdORrHIy8yY1LGpfAbTwn2i4pgNuMUqrSkg=;
        b=TdrvvaK+vgvwA9rx4c9lSRPmnU3TA75oR9c1/WkJo7ps1JnV4mhdZhaiXl2k7NtqLd
         JFXjrZOuX2rGDFEF0BD+vkeDLS6r460BakYKEXGaS8t8EG1Tsx3mJTbziBl6+/lPC8JH
         YWeazcQ+5WQ5+m0rx4ey6+d8M9NzcJwKqFKUQrEK+/Hk03iAvVlGQhNxvrAgP3XaZoV8
         V8t86rVvw1K4/7OAi0119Bqwb82jCu+rVq6Pc/6s66p+eca9CIhYYZoHsT5cPDbL0g95
         rIm1KzOaxPrguWqxBiNh+INkcjlD4UOxhadVMEj0fZzWzyIbZXBYs245Pc4jemcnwykk
         q1Mw==
X-Gm-Message-State: AOAM531KHvfHx5lsXpFDTPcRoXgBEX5NiWqd+gwIjNMtIjPkyzVAotBg
        fnK5vMJD/vyUzkuHSnNGu1E=
X-Google-Smtp-Source: ABdhPJzDXME+iX279QfQEjOXL4N6p/Epv+FljgUkFlePlsJQbMKaj/8Wo2bCWNlkwJEi1q9rCc+hWw==
X-Received: by 2002:a17:907:2d93:: with SMTP id gt19mr19239222ejc.246.1614668704901;
        Mon, 01 Mar 2021 23:05:04 -0800 (PST)
Received: from gmail.com (20014C4E1C864000F9B8756A94F10216.dsl.pool.telekom.hu. [2001:4c4e:1c86:4000:f9b8:756a:94f1:216])
        by smtp.gmail.com with ESMTPSA id s2sm8795897ejn.112.2021.03.01.23.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 23:05:04 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Mar 2021 08:05:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] smp: Micro-optimize smp_call_function_many_cond()
Message-ID: <20210302070502.GA2809110@gmail.com>
References: <20210220231712.2475218-1-namit@vmware.com>
 <20210220231712.2475218-2-namit@vmware.com>
 <YD0gF9VuqKyVUgVS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD0gF9VuqKyVUgVS@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Feb 20, 2021 at 03:17:04PM -0800, Nadav Amit wrote:
> > +		/*
> > +		 * Choose the most efficient way to send an IPI. Note that the
> > +		 * number of CPUs might be zero due to concurrent changes to the
> > +		 * provided mask.
> > +		 */
> > +		if (nr_cpus == 1)
> > +			arch_send_call_function_single_ipi(last_cpu);
> > +		else if (likely(nr_cpus > 1))
> > +			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
> 
> I just ran into conflicts with another patch set, and noticed that the
> above should probably be:
> 
> 		if (nr_cpus == 1)
> 			send_call_function_single_ipi(last_cpu);
> 		else if (likely(nr_cpus > 1))
> 			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
> 
> Which will avoid the IPI when @last_cpu is idle.

I turned this into the additional patch below, on top of Nadav's series.

Thanks,

	Ingo

===============>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 2 Mar 2021 08:02:43 +0100
Subject: [PATCH] smp: Micro-optimize smp_call_function_many_cond()

Call the generic send_call_function_single_ipi() function, which
will avoid the IPI when @last_cpu is idle.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index b6375d775e93..af0d51da84a2 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -694,7 +694,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		 * provided mask.
 		 */
 		if (nr_cpus == 1)
-			arch_send_call_function_single_ipi(last_cpu);
+			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
 			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}

