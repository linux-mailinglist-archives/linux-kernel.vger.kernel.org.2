Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D425434A11F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 06:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCZFpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 01:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhCZFpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 01:45:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED62C0613AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:45:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 32so3886026pgm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 22:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OqOZYiaXe2/4wha1fEs1gVf5T6I4+DZt+BtbIfVMO+A=;
        b=NTfOSkbbavoRe1I6wHo5nMJh++tgT4yErZ9HicwtA0cg85vQvQq9byvRgoV807Y5p0
         pKkzxaDg7V4iAOPeZn/xEAXQQo+vZ5eIUNo9sQEm8xVW7PEb0906GAQJFs9brSP4pxVL
         zFUl4mAYffjkMLE2jAY8RPKeBsfsr0w8pWQSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OqOZYiaXe2/4wha1fEs1gVf5T6I4+DZt+BtbIfVMO+A=;
        b=MsqbUYIpzCqBWGTmy1wCb/1ygBMiQDHEjS4zXMx+GZiZAc+6+gxHivHujhNsMFca2j
         jE2fqk6i6ISEZso1QrmFdjDW26VCfAIwBSWzssNolIC+duPBiXj9ed/ctzsOtvOiiPcc
         E0uRsVTv7/nCezmDNE2v6tF4jqLeguC029pyWqhgvml0Hr1VvqW4ogBGj0tLnXlLdA9m
         7WuI9WIc1ZNUNAs7fsi5dDDE388YjmA1LNWpgN1arwxtQ4FL9jzmVFDLbzwJV6JRXwOr
         rpkibssw2FKYsStz0fFHJhKPDyTzfTfwqHPgojTgTkPCwn3NHLDWgAv6LUf6dlTSTonU
         hhzg==
X-Gm-Message-State: AOAM531tFfgPsL0zBLPfXzFtG7SVG10zTKDxVZBPpy5paV3DPo1pAjEH
        MmG4HUsBpNh5Ko63akBINV6SSQ==
X-Google-Smtp-Source: ABdhPJzNEr7O3Y4iBRs57Wo7KFkaic8g91kRGbfEuj3r1OipG51u0rllrwWAbzkp4/W2IqFt/5InAw==
X-Received: by 2002:a05:6a00:c8f:b029:213:db69:18af with SMTP id a15-20020a056a000c8fb0290213db6918afmr11139010pfv.76.1616737513575;
        Thu, 25 Mar 2021 22:45:13 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
        by smtp.gmail.com with ESMTPSA id u2sm6875572pgf.93.2021.03.25.22.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 22:45:13 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: Re: [PATCH] [v2] tools: testing: Remove duplicate includes
In-Reply-To: <20210323061604.289958-1-wanjiabing@vivo.com>
References: <20210323061604.289958-1-wanjiabing@vivo.com>
Date:   Fri, 26 Mar 2021 16:45:10 +1100
Message-ID: <87v99e79jt.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> writes:

> sched.h has been included at line 33, so remove the 
> duplicate one at line 36.

> pthread.h has been included at line 17,so remove the 
> duplicate one at line 20.

I can see that both of these are correct from the diff.

> inttypes.h has been included at line 19, so remove the 
> duplicate one at line 23.

For this one I checked the file. Indeed there is another inttypes.h, so
this is also correct.

Again, all the automated checks pass. (although I don't think any of the
automated builds include selftests.)

So:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  tools/testing/selftests/powerpc/mm/tlbie_test.c     | 1 -
>  tools/testing/selftests/powerpc/tm/tm-poison.c      | 1 -
>  tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
> index f85a0938ab25..48344a74b212 100644
> --- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
> +++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
> @@ -33,7 +33,6 @@
>  #include <sched.h>
>  #include <time.h>
>  #include <stdarg.h>
> -#include <sched.h>
>  #include <pthread.h>
>  #include <signal.h>
>  #include <sys/prctl.h>
> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
> index 29e5f26af7b9..27c083a03d1f 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
> @@ -20,7 +20,6 @@
>  #include <sched.h>
>  #include <sys/types.h>
>  #include <signal.h>
> -#include <inttypes.h>
>  
>  #include "tm.h"
>  
> diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> index e2a0c07e8362..9ef37a9836ac 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
> @@ -17,7 +17,6 @@
>  #include <pthread.h>
>  #include <sys/mman.h>
>  #include <unistd.h>
> -#include <pthread.h>
>  
>  #include "tm.h"
>  #include "utils.h"
> -- 
> 2.25.1
