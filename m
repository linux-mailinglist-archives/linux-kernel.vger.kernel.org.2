Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6EC37F5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhEMKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhEMKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:48:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45BAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 03:47:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k19so21364463pfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GIWNgKfERCd8ws3NEsOZmkaYsKxmmQTX5MnGldnYq+U=;
        b=SCfZUxU/raf0MeD34FQA8j/mu/bumWsmxOixENlweE2AnYBqD61gmHC9ekehgIDBPI
         5/dE6sUjReq6fWS8+gZjwcSEjrwFfOQRhdTXxBrlTfzbNKvLX4LRs8QGak6c0Qtzch/+
         GftKOFi8Osl41Tv+9wST7Fqoe7pMoFRI9W7n5yJwyDbtn63np1AaETDXHLcS/xgvkfmH
         MuMxgToZYFVslZohgrQfucmHsb8kdk2j2S2NE7XnbIDrSCMcKyPDpx4XHuvw0OV9vy2W
         HBSXvr0pPL9GL/9aj5HX7wP7oQ5kFOf1UhrmFnW1G7bzqfUeDAF2mBw3By48eUXbtIYA
         fEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GIWNgKfERCd8ws3NEsOZmkaYsKxmmQTX5MnGldnYq+U=;
        b=DbY3fLOLkz9muQpuv05YKEIZBlyUatX0SnCX3gTR1Uo5j9qoS1/7X6R/9h51SR75+H
         F/+V2kqmwmw8ritdy9KW+pA5XE9xraueG2s31vDhJ29pBHkX3i9hNXefzi9P4jV5mKlr
         ANKXAJ/gm1YdJDEVHNlFCJExOOJl1XkgDh5PP0jMTmCV7xxeKDggb0hc6mvKL8B/KScd
         RPmx6xTguMbAIWFnnsObMs97+AO66MXfx+zael6sF0qk7Fw8v1IYFNSzfofLiTEJ9hD1
         efGDwUuteKwzP6s2p8fyBkM4k0QfLIKLBAY9ms26jtLlrF/0KRLKlrYk7mIgH3Y92wH3
         Rm1g==
X-Gm-Message-State: AOAM533lHiUCJn3T3Cpy1+5+HCHuGFlZph2J68oxGeSnQ2ExnzEs7ky6
        3thQbzBBqBWS1A5JkOQMrxY=
X-Google-Smtp-Source: ABdhPJxpDzutLLKiLP0HXR8ob0jjFkadOQeYuOr3OqUH3oZI6auLLAh5IiVFix5U5vn7DQmb+DGQuQ==
X-Received: by 2002:a63:1c6:: with SMTP id 189mr30948951pgb.144.1620902867026;
        Thu, 13 May 2021 03:47:47 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q24sm2178996pjp.6.2021.05.13.03.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 03:47:46 -0700 (PDT)
Subject: Re: [PATCH tip/core/rcu 01/10] kcsan: Add pointer to
 access-marking.txt to data_race() bullet
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
 <20210511232401.2896217-1-paulmck@kernel.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <a1675b9f-5727-e767-f835-6ab9ff711ef3@gmail.com>
Date:   Thu, 13 May 2021 19:47:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210511232401.2896217-1-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, 11 May 2021 16:23:52 -0700, Paul E. McKenney wrote:
> This commit references tools/memory-model/Documentation/access-marking.txt
> in the bullet introducing data_race().  The access-marking.txt file
> gives advice on when data_race() should and should not be used.
> 
> Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/dev-tools/kcsan.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index d85ce238ace7..80894664a44c 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -106,7 +106,9 @@ the below options are available:
>  
>  * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
>    any data races due to accesses in ``expr`` should be ignored and resulting
> -  behaviour when encountering a data race is deemed safe.
> +  behaviour when encountering a data race is deemed safe.  Please see
> +  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
> +  tree for more information.
>  
>  * Disabling data race detection for entire functions can be accomplished by
>    using the function attribute ``__no_kcsan``::
> 

I think this needs some adjustment for overall consistency.
A possible follow-up patch (relative to the change above) would look
like the following.

Thoughts?

        Thanks, Akira

-------8<--------
From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] kcsan: Use URL link for pointing access-marking.txt

For consistency within kcsan.rst, use a URL link as the same as in
section "Data Races".

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 80894664a44c..151f96b7fef0 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -107,8 +107,7 @@ the below options are available:
 * KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
   any data races due to accesses in ``expr`` should be ignored and resulting
   behaviour when encountering a data race is deemed safe.  Please see
-  ``tools/memory-model/Documentation/access-marking.txt`` in the kernel source
-  tree for more information.
+  `"Marking Shared-Memory Accesses" in the LKMM`_ for more information.
 
 * Disabling data race detection for entire functions can be accomplished by
   using the function attribute ``__no_kcsan``::
@@ -130,6 +129,8 @@ the below options are available:
 
     KCSAN_SANITIZE := n
 
+.. _"Marking Shared-Memory Accesses" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt
+
 Furthermore, it is possible to tell KCSAN to show or hide entire classes of
 data races, depending on preferences. These can be changed via the following
 Kconfig options:
-- 
2.17.1


