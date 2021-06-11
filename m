Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDEB3A38B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFKAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhFKAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:30:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5FAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:28:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u18so2980726pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lJ6pC3vRgajvw25G5uh7zoFY2OKcw8ZZYBkSXgUjChk=;
        b=BVsq+nuvUcoL0M+jgJqZAg9gjyOHv2V1eReYVMPhvO+6vr2gNrEHItXE3je02WB60u
         JjKLvXe+wf0+iI9qmn+Q3KG/ddrqGqbWU6m0AhkB9zvqNITFc11hHenneETyTIoJfACx
         tuRp1JZJCGTZzFxsNyhaDYFELT4oPNuVSiB+Uv1YPfQEIhPfuerc7bGMmh6VZ0fczcB+
         YvbxigG59jkhSLsIUnWcyoXmy2eVc0KpDYjIy/gZuXOvOJi9ciUqo68i5IQ7R83008Cq
         ggrXOkTNchPuKM3j+JTIq/jRC9HBCSjrjJSgZSTfyTi/u2jCPKovB6KJ7yR56sVZf+eB
         m9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lJ6pC3vRgajvw25G5uh7zoFY2OKcw8ZZYBkSXgUjChk=;
        b=U2NRn2bdiJmVJT+t5ul06XXVaz4hClDcqvSPm1EIpWpeY/Mta8d/inVa2RD18WSROX
         sBvSPVrkG6bUX4h9aMNm68eylTPO/G0pni+mAlVodKZRD168YFxX0T6OkDCarbEzzU/r
         6UIRviiAvD8PBQVxUsJrrOEgd1kA/mhhrWvdSmYexcpLsZ5IHAdHj56K23v7e9j2+sFj
         OSfSbqlwIIVeGJzyJgK/xFNpYOv5+DXJVKdsxgbmEbwb2B666DrFpBr3LZUDNU5sAWFO
         98805k5TG2doNlF4V2q8UwtQDQwNP4r11/yU3KfqHajfweOm3HtW/aERy4jWmlga6AFL
         vJDw==
X-Gm-Message-State: AOAM533X4pIrS4G2nVt8KyjF2YYfG4vOJWko313M9vzQvWUCQ1JE5rqd
        K5O/vD7Ekh/YhtRA9jEmC64qZUlir4Q=
X-Google-Smtp-Source: ABdhPJwIiIUIBRaW38LEtCHpIdlbiuWMs5Y18aX9aU27rOJ11aPusTe5woknfazy0ggnm18DiiLTog==
X-Received: by 2002:aa7:9216:0:b029:2e5:6989:4f1a with SMTP id 22-20020aa792160000b02902e569894f1amr5430534pfo.50.1623371294218;
        Thu, 10 Jun 2021 17:28:14 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t13sm3431317pfh.97.2021.06.10.17.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 17:28:13 -0700 (PDT)
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, neeraju@codeaurora.org,
        urezki@gmail.com, Akira Yokosawa <akiyks@gmail.com>
References: <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: [PATCH] rcu/doc: Add a quick quiz to explain further why we need
 smp_mb__after_unlock_lock()
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <41a783b3-db66-a30d-4ff1-d1fa77135db0@gmail.com>
Date:   Fri, 11 Jun 2021 09:28:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610165710.GT4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 09:57:10 -0700, Paul E. McKenney wrote:
> On Thu, Jun 10, 2021 at 05:50:29PM +0200, Frederic Weisbecker wrote:
>> Add some missing critical pieces of explanation to understand the need
>> for full memory barriers throughout the whole grace period state machine,
>> thanks to Paul's explanations.
>> 
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> Cc: Uladzislau Rezki <urezki@gmail.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
> 
> Nice!!!  And not bad wording either, though I still could not resist the
> urge to wordsmith further.  Plus I combined your two examples, in order to
> provide a trivial example use of the polling interfaces, if nothing else.
> 
> Please let me know if I messed anything up.

Hi Paul,

See minor tweaks below to satisfy sphinx.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit f21b8fbdf9a59553da825265e92cedb639b4ba3c
> Author: Frederic Weisbecker <frederic@kernel.org>
> Date:   Thu Jun 10 17:50:29 2021 +0200
> 
>     rcu/doc: Add a quick quiz to explain further why we need smp_mb__after_unlock_lock()
>     
>     Add some missing critical pieces of explanation to understand the need
>     for full memory barriers throughout the whole grace period state machine,
>     thanks to Paul's explanations.
>     
>     Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>     Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
>     Cc: Joel Fernandes <joel@joelfernandes.org>
>     Cc: Uladzislau Rezki <urezki@gmail.com>
>     Cc: Boqun Feng <boqun.feng@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> index 11cdab037bff..3cd5cb4d86e5 100644
> --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> @@ -112,6 +112,35 @@ on PowerPC.
>  The ``smp_mb__after_unlock_lock()`` invocations prevent this
>  ``WARN_ON()`` from triggering.
>  
> ++-----------------------------------------------------------------------+
> +| **Quick Quiz**:                                                       |
> ++-----------------------------------------------------------------------+
> +| But the whole chain of rcu_node-structure locking guarantees that     |
> +| readers see all pre-grace-period accesses from the updater and        |
> +| also guarantees that the updater to see all post-grace-period         |
> +| accesses from the readers.  So why do we need all of those calls      |
> +| to smp_mb__after_unlock_lock()?                                       |
> ++-----------------------------------------------------------------------+
> +| **Answer**:                                                           |
> ++-----------------------------------------------------------------------+
> +| Because we must provide ordering for RCU's polling grace-period       |
> +| primitives, for example, get_state_synchronize_rcu() and              |
> +| poll_state_synchronize_rcu().  For example:                           |
> +|                                                                       |
> +| CPU 0                                     CPU 1                       |
> +| ----                                      ----                        |
> +| WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)            |
> +| g = get_state_synchronize_rcu()           smp_mb()                    |
> +| while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)           |
> +|         continue;                                                     |

This indent causes warnings from sphinx:

Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst:135: WARNING: Unexpected indentation.
Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst:137: WARNING: Block quote ends without a blank line; unexpected unindent

> +| r0 = READ_ONCE(Y)                                                     |
> +|                                                                       |
> +| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
> +| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
> +| or offline) and thus won't interact directly with the RCU core        |
> +| processing at all.                                                    |
> ++-----------------------------------------------------------------------+
> +
>  This approach must be extended to include idle CPUs, which need
>  RCU's grace-period memory ordering guarantee to extend to any
>  RCU read-side critical sections preceding and following the current

The code block in the answer can be fixed as follows:

++-----------------------------------------------------------------------+
+| **Answer**:                                                           |
++-----------------------------------------------------------------------+
+| Because we must provide ordering for RCU's polling grace-period       |
+| primitives, for example, get_state_synchronize_rcu() and              |
+| poll_state_synchronize_rcu().  For example::                          |
+|                                                                       |
+|  CPU 0                                     CPU 1                      |
+|  ----                                      ----                       |
+|  WRITE_ONCE(X, 1)                          WRITE_ONCE(Y, 1)           |
+|  g = get_state_synchronize_rcu()           smp_mb()                   |
+|  while (!poll_state_synchronize_rcu(g))    r1 = READ_ONCE(X)          |
+|          continue;                                                    |
+|  r0 = READ_ONCE(Y)                                                    |
+|                                                                       |
+| RCU guarantees that that the outcome r0 == 0 && r1 == 0 will not      |
+| happen, even if CPU 1 is in an RCU extended quiescent state (idle     |
+| or offline) and thus won't interact directly with the RCU core        |
+| processing at all.                                                    |
++-----------------------------------------------------------------------+

Hint: Use of "::" and indented code block.
 
       Thanks, Akira
