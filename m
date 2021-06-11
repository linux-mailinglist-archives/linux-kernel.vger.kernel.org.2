Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F91A3A4963
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFKTTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhFKTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:19:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:17:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c5so7129124wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZtDjxi16fCK+vtg0oWwTQHBYR+QgijKvH/kCVk+EgJg=;
        b=C3+wvn1ZvKh/y0tljlQAWqIhsCZzbsNwnKk3z0zofPUSrWFJZ975bfG0RvX+xs0lOA
         Oa5287YpTsJC+m/4Ys4dWlu+iEZL0bJ8zXI2fRHys15+5XHEvY2MO4hmXRFuJqlEncn5
         9fCMohpLgwSwa7+2c0cjlngC3VbFIu2n1qmXVtTzfBh+Nr/RYLO9KxxSBJI2FYVfztTk
         VeK/ybFApjrW0RZVE6DQ2C+zMMViMAY7qazwoMdc1Wm9zsIJrZpOUe0/gvvMWnj4oaCC
         TyVbSL2eJ5wihC2uaKwr6mwY3R75qW75hWxGvb+Y780BzWkpZ/VRGzPOVqepCiUjcQMm
         eNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZtDjxi16fCK+vtg0oWwTQHBYR+QgijKvH/kCVk+EgJg=;
        b=QyDqfghf/oP/czCaTduxZ3JzLZ1Z2RJBLQgcxSPGNGXth7WbihVujOHb01dcaj4w5z
         SDj+Ymas9Bne3YQ5JGXd7Og0eBEgTxCD4YRGGlJ3W/oISuQRjsjXz23S1lL4Uu6eunC+
         NQ+6KckgSLajoj8dArHfdMUD9bVyhGIDI8h4uXi0Mj1j/UtlXOpf57BGB0OHl+TJa2aV
         oMbsb3moBasH7XdkIVWylTYlgkqlPYo7aH1VUR+1qCMqcHRPvc0GEe2TeKW+XAnuDFHZ
         s8Vtj3mWC0wwKfxy4rqN6TST+4WhPKXNxSoIF0WGk0LMXPj2NF26jZTR/OUdNQq7eS2D
         6/Gw==
X-Gm-Message-State: AOAM5309ZP0g/9KElxGKdujCWxE/hwgcVPP6BktpeopqDP0npWYir8pW
        H3vlNAJ3VbBcy/510clARw==
X-Google-Smtp-Source: ABdhPJz5XIOh6M/1Xty7N5eRIB4RvtX/sCtwGZVYixYqYCNdZLuIkaeQn09PUW+QgdhY+UXiqJm/sA==
X-Received: by 2002:a05:6000:1b8f:: with SMTP id r15mr5589927wru.119.1623439056889;
        Fri, 11 Jun 2021 12:17:36 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.180])
        by smtp.gmail.com with ESMTPSA id u7sm9505232wrt.18.2021.06.11.12.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:17:36 -0700 (PDT)
Date:   Fri, 11 Jun 2021 22:17:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: uninline simple_strtoull()
Message-ID: <YMO2zoOQk2eF34tn@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc inlines simple_strtoull() too agressively.

Given that all 4 signatures match, everything very efficiently calls or
tailcalls into simple_strtoull():

	ffffffff81da0240 <simple_strtoll>:
	ffffffff81da0240:       80 3f 2d                cmp    BYTE PTR [rdi],0x2d
	ffffffff81da0243:       74 05                   je     ffffffff81da024a <simple_strtoll+0xa>
	ffffffff81da0245:       e9 76 ff ff ff          jmp    simple_strtoull
	ffffffff81da024a:       48 83 c7 01             add    rdi,0x1
	ffffffff81da024e:       e8 6d ff ff ff          call   simple_strtoull
	ffffffff81da0253:       48 f7 d8                neg    rax
	ffffffff81da0256:       c3                      ret

Space savings (on F34-ish .config)

	add/remove: 0/0 grow/shrink: 1/3 up/down: 52/-313 (-261)
	Function                                     old     new   delta
	vsscanf                                     2167    2219     +52
	simple_strtoul                                72       2     -70
	simple_strtoll                               143      23    -120
	simple_strtol                                143      20    -123

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/vsprintf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -61,6 +61,7 @@
  *
  * This function has caveats. Please use kstrtoull instead.
  */
+noinline
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
 {
 	unsigned long long result;
