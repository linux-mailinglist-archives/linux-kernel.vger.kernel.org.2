Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD3353403
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhDCMbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 08:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhDCMbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 08:31:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B4EC0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 05:31:48 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y1so8034161ljm.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhlDW8+W/+5mElmZOwadmaUF2DpTuY2UAaWBafoxcPM=;
        b=kpPNY9PmZlM5Moo4l/KEvk4b/ohTkfoBS3pv8d2gIGBV6MsFjbmdcNzeJSipM/2+Li
         58sLsawGWoWI/4IqIilwmRpoUs7FYUn16q3VH4tfTDDNjtO25BgHIZcVjpSmV8qTisJA
         ULm6PElnAjXz25P2Di5UC9AYnVidSCNJubidL+CjDs0oJl/69mHtIN5vZwyNIMbEM5sD
         Ps8hjDb0sGs0FxARwBCmAuJIFwQ6c2sjmxSNIchgZ8Qd9/9bIAbIblD8g9RCBcvVWU/T
         mifLJbQlajcqDxJHMsyx/DyFOEPztVjqeetvjMcL1bAUQbD+3W4EkQq1QdqpblKPM2Ro
         JIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhlDW8+W/+5mElmZOwadmaUF2DpTuY2UAaWBafoxcPM=;
        b=BxHn1DPIentcgSLcCukxknS5vk3mTHg/jAlDgzDQMAihbdV/j/O+KnDucyTPvde+8n
         iAGL0rFcOVs72QGj/wvQuxDynMwqfDmGcv38UykZGupYPsxW4lbQ6T09LYJ55h2Sd9lx
         qR0mxTE9De5102OymrQqT+mj/st8Ju7T/HsKe0x5hf/n2HN3vDrHyEECMQ7uo44xwigE
         pf6+yyC5B7QDGn8ff7UrQIx02TJWOZCVZh/6bsLETHEzrlNPMvrs+mMFk+B32l6gZU/F
         v8cNhspghXtnB+j6A6lYqH4URCdnm1ws0cpHzjldI8msCZ8a4liCTYEMcoOhAXN9ee/8
         om6Q==
X-Gm-Message-State: AOAM532Ha9mNv79Chem+wQ9uQ1PksQ41KI9IcIQ7Y7TPoDfBMB9YNHxn
        u3kDi9lQ6RC6Fhx+GCirAoE=
X-Google-Smtp-Source: ABdhPJwpclg9KoHYmWHg17yt0xp1Jtcx66PUSggulrktalxt4zvZXC3zSwynTJO/AVTyd9orh5rlUw==
X-Received: by 2002:a05:651c:106e:: with SMTP id y14mr10743945ljm.418.1617453106424;
        Sat, 03 Apr 2021 05:31:46 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f22sm1137093lfc.68.2021.04.03.05.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 05:31:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sat, 3 Apr 2021 14:31:43 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH-next 2/5] lib/test_vmalloc.c: add a new 'nr_threads'
 parameter
Message-ID: <20210403123143.GA38147@pc638.lan>
References: <20210402202237.20334-1-urezki@gmail.com>
 <20210402202237.20334-2-urezki@gmail.com>
 <20210402145934.719192be298eadbeecb321d2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402145934.719192be298eadbeecb321d2@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri,  2 Apr 2021 22:22:34 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> 
> > By using this parameter we can specify how many workers are
> > created to perform vmalloc tests. By default it is one CPU.
> > The maximum value is set to 1024.
> > 
> > As a result of this change a 'single_cpu_test' one becomes
> > obsolete, therefore it is no longer needed.
> > 
> 
> Why limit to 1024?  Maybe testers want more - what's the downside to
> permitting that?
>
I was thinking mainly about if a tester issues enormous number of kthreads,
so a system is not able to handle it. Therefore i clamped that value to 1024.

From the other hand we can give more wide permissions, in that case a
user should think more carefully about what is passed. For example we
can limit max value by USHRT_MAX what is 65536.

> 
> We may need to replaced that kcalloc() with kmvalloc() though...
>
Yep. If we limit to USHRT_MAX, the maximum amount of memory for
internal data would be ~12MB. Something like below:

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index d337985e4c5e..a5103e3461bf 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -24,7 +24,7 @@
        MODULE_PARM_DESC(name, msg)                             \

 __param(int, nr_threads, 0,
-       "Number of workers to perform tests(min: 1 max: 1024)");
+       "Number of workers to perform tests(min: 1 max: 65536)");

 __param(bool, sequential_test_order, false,
        "Use sequential stress tests order");
@@ -469,13 +469,13 @@ init_test_configurtion(void)
 {
        /*
         * A maximum number of workers is defined as hard-coded
-        * value and set to 1024. We add such gap just in case
+        * value and set to 65536. We add such gap just in case
         * and for potential heavy stressing.
         */
-       nr_threads = clamp(nr_threads, 1, 1024);
+       nr_threads = clamp(nr_threads, 1, 65536);

        /* Allocate the space for test instances. */
-       tdriver = kcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
+       tdriver = kvcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
        if (tdriver == NULL)
                return -1;

@@ -555,7 +555,7 @@ static void do_concurrent_test(void)
                        i, t->stop - t->start);
        }

-       kfree(tdriver);
+       kvfree(tdriver);
 }

 static int vmalloc_test_init(void)

Does it sound reasonable for you?

--
Vlad Rezki
