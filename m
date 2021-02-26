Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0128532632D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBZNPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBZNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:15:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B980CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:14:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n4so6326699wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XxDrSAz+s0u9GghMJmZiJqB1we4OdhhnM7uHXW+NNPE=;
        b=ktc1OuuclGHmKXvMLlLD6jYnuTewLQk7HEJiXkEJ5+Rj8HE0Xm2Ym75TsHFXjMBTCc
         z415izJUnuxOB9AejmcZK0UuVd7gzPLIfDljK4sg7yVLVYwaytbFUFNHftoyNGkEiR91
         N2pf6b2h+7lJzLhkiAQGEL4oSTlDNLG7sgC4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XxDrSAz+s0u9GghMJmZiJqB1we4OdhhnM7uHXW+NNPE=;
        b=JSyNpTB9vxHv3Uz7GeyRDAnVtf7uibvG1PSeZ/MUMYar+4a0hk4pDIjat4gWoNJH1R
         anGVrCV6UXFN8tQOWKqqEyUkDBVFe7/kZ8RFrqYk37EOoG94NqHZ3RRVct6WxtTqx1A4
         EkC+8psSczKImDOmxeQOq0csjP8emifjvKqkbFY0/6oNKc5Hp4jOgeTWlY49nJyBFG0r
         11ZwTIAlPimA15Jeft7MvgJ4HNt1Ryta0BfL00CGXCyACqy4671MIbdaFM1LY6zpQYXG
         RnOlbspYDhmbyAcZ9zqRQi+K6RRk8cH6FegJJX3lO29siDqDoFRXbvVu53bfq1KxTp07
         5azg==
X-Gm-Message-State: AOAM53209h+lkFgnoaBELdDnE6WW3Ad+jDcjMn3JcXtSrbRJD4p6isSt
        pIZo2VHlbAqr7ZBnhPBNOZ36hw==
X-Google-Smtp-Source: ABdhPJx11ViKkHeTCGdq24CUxuZuIoHqBbIapPfsx41pNzZU0pPcPNM6MKdfoXlH0CeMaH26vgT3tQ==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr2796384wmc.35.1614345296506;
        Fri, 26 Feb 2021 05:14:56 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:87b5])
        by smtp.gmail.com with ESMTPSA id p18sm1584342wro.18.2021.02.26.05.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 05:14:56 -0800 (PST)
Date:   Fri, 26 Feb 2021 13:14:55 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] ia64: Depend on non-static printk for cmpxchg debug
Message-ID: <YDj0T7H4ZbuEAYwK@chrisdown.name>
References: <YCflN5zTvo5mxvKY@chrisdown.name>
 <YDjt/lI82VzZcCgq@chrisdown.name>
 <20210226130029.GC2723601@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210226130029.GC2723601@casper.infradead.org>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
>Why not just fix it?
>
>diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
>index 5d90307fd6e0..d955a8e3ebde 100644
>--- a/arch/ia64/include/uapi/asm/cmpxchg.h
>+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
>@@ -139,7 +139,7 @@ extern long ia64_cmpxchg_called_with_bad_pointer(void);
> do {									\
> 	if (_cmpxchg_bugcheck_count-- <= 0) {				\
> 		void *ip;						\
>-		extern int printk(const char *fmt, ...);		\
>+		int printk(const char *fmt, ...);			\
> 		ip = (void *) ia64_getreg(_IA64_REG_IP);		\
> 		printk("CMPXCHG_BUGCHECK: stuck at %p on word %p\n", ip, (v));\
> 		break;							\

I must confess I have no idea of the history of why it was `extern int` in the 
first place -- my fear was somehow we use cmpxchg.h from a different context.  
Do you have any idea? :-)
