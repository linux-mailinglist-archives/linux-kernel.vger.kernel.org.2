Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185973DEAF2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhHCKbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhHCKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:31:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23016C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:31:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a20so23215654plm.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A3QeIWoPrsn+ykoo/g+jrZdeWbZ20AgRw8r993XsJI0=;
        b=Vz8U5fHeK5HrMrM8+QaQY+5fyZjHmh/Xjwf8780Ud3sv+PYV0YRRbtkyfSChhERY0P
         TtsuViRPM8zMlkqWyAExFzb30vJgSfEFI9ods7AcbHtN8+GnyrZ7C/NYooItI9JG2EPH
         Wqr9lMyUzbRk9PeEl/BTzjE/iLC3F5/MzzWosyTEypKBQdUK1JgeiiTDTctF5seA42v/
         HAClIzT9k+mVT+BAmBx/GBgJhq/WgxyHOWk0ZuQNhZGUlwLNMkOge+PWMwLMbKnhCTXk
         9qt0vbsUw+UwL+vlOqX9V53F2EzeFsr2jQHxo0ymejhVVcDKAeYcMFIlSi67NF1SUwRc
         G6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A3QeIWoPrsn+ykoo/g+jrZdeWbZ20AgRw8r993XsJI0=;
        b=jlBsetpiD80SQ7NOVBZYkcxOMxKDCPO3H3b0VQFFe3jaUzr4UKrmOVhITHOupcsmQb
         KUlsnHINmknXTyp1ozVM/FhIR9CssJRJB45ukL3ESvRv16LM9c5LmXujGYSOMzVko/cz
         K0UoffKt4wOYxNMA1UYP3JRF+fpf1BRpVsvfrJ6nRT5ogqk92qNa2sYmodx7Qvjv8M7t
         MZ8kVratj2lEl3i8lpehgeQ8NGV+f84z+TpGx6T7aF3RXbzeb0tPLt7bhNtJUoFbgv5r
         bpKeyZ7RFeyb2/duoG5rEopcPgCs/6rMrSxWiqWIMfvE8stAMHWSI93/frUFObISgbh6
         u83Q==
X-Gm-Message-State: AOAM530pod7ELNAonK8aR2ActKRWvZcMUsvDT+ER3s/UlAwyZCN9Z6m3
        cWG29omtKqVb8eI80IKeCnE=
X-Google-Smtp-Source: ABdhPJydylAov+Q0uF4ZFssQicKWJNbS+WIxDFCAYEtzFTgmc9kyx9VOMlc96NCeBwkp+EAUMuaStA==
X-Received: by 2002:a17:90b:2286:: with SMTP id kx6mr3879448pjb.11.1627986660675;
        Tue, 03 Aug 2021 03:31:00 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b17sm14788326pfm.54.2021.08.03.03.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:31:00 -0700 (PDT)
Date:   Tue, 3 Aug 2021 03:31:50 -0700
From:   CGEL <cgel.zte@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     keescook@chromium.org, ktkhai@virtuozzo.com,
        jamorris@linux.microsoft.com, varad.gautam@suse.com,
        legion@kernel.org, dbueso@suse.de, linux-kernel@vger.kernel.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] ipc: add set_ownership() and permissions() callbacks for
 posix mqueue sysctl
Message-ID: <20210803103150.GA607784@www>
References: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
 <20210729145348.hvvhu6lmlcn5js4y@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729145348.hvvhu6lmlcn5js4y@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Thu, Jul 29, 2021 at 04:53:48PM +0200, Christian Brauner wrote:
> 
> Yeah, we did that work specifically for the network namespace but knew
> there were quite a few places that would need fix up. This makes sense
> to me.
> 
> Please add tests for this patch though. Also make sure to run them in a
> tight loop on a kernel with memory and log debugging enabled.
  For now i have rebuilt the kernel turning on the config items you
  suggested and some other kernel hacking and locking debug configs.
  I tested this by a shell script concurrently writing the mqueue sysctl
  files and checking the value. Do you mean that i should add some test code in this patch?
  Can you give some examples for this tests code?

> The whole sysctl retire stuff can't be called from rcu contexts and that's easy to
> miss. 
  for this patch, retire_mq_sysctls() is called by free_ipc_ns(), and free_ipc_ns() is 
  triggered by schedule_work(&free_ipc_work) in kthread context.
  Can you give some comments on the chance this code running on rcu
  context?

> So turn on at least sm like:
> 
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> # CONFIG_KASAN_OUTLINE is not set
> CONFIG_KASAN_INLINE=y
> CONFIG_KASAN_STACK=1
> CONFIG_KASAN_VMALLOC=y
> # CONFIG_KASAN_MODULE_TEST is not set
> CONFIG_HAVE_ARCH_KFENCE=y
> CONFIG_KFENCE=y
> CONFIG_KFENCE_STATIC_KEYS=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=100
> CONFIG_KFENCE_NUM_OBJECTS=255
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_LOCKDEP=y

