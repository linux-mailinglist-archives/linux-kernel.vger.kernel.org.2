Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678D43F76EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbhHYOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHYOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:12:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB41C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:11:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z1so31057054ioh.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAZ2PSpb5uNN5FzzHlrzAuRUdIpWiic98EAha6BxBOA=;
        b=Y7l6cYQgM5Wl6xcD9oI3x+2l5lb/U5fD1JzyPRVVKoUVBvpY7q02yBEX19UiQQmDm7
         9puLcgi+gwxguRFPxzvYXICrS/lL2eF4sPS08ZcQJQFC7imt9HhCzGFlTLLW6ibgKixl
         npc8ru5540oDXyGuoodJTJakDDMT9Sdzme2lH1gAWOTsfFsP21YeReWq4OBmdXYfQcht
         wgaWltVvhD1svaRq2akOf23UHT+cL1mUSSInA2OYjlBNZtM4ex9pdVNMgIwzFNpZPb6d
         EU4MG3GwVi5aycDbTP9N+wzBS+glwzlpDDDXYN1UTDWP5hM+/35LlDvsI5O8+FDEtu2R
         UxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAZ2PSpb5uNN5FzzHlrzAuRUdIpWiic98EAha6BxBOA=;
        b=a5QKqeeKIhh8L40mQgNVVFArrXqJMgTr+mYJnmf+cQ9YM3mCFCBmUS9b9pysg1osyg
         +o9jTv9uzyFDsTYBDFBfKkmfmk5ICah/5s/cErrrQf5TMF3si0+XJRbqi0oV9446mTGt
         QUDlgYgVulu6yJEAtJmR8S3iMGLeF33up3v8d8tqJQTGUza8PlXKvYNrI1xKgKdIJQVx
         UMQGugOSezPuqsoW/Fb544GMKDZAzASwpX7yMToXELqQlxCCVnD8xcMkQQSM7nIXuprB
         C8jvLn6RaTv/XcXE+Y5gJmb9VrQ4izNbWlpN56HHX4+h2bmMY94rgXoE4O3gnafTn9Jf
         LAPQ==
X-Gm-Message-State: AOAM532lgxWtRLX0QokZqEbAyCle0iFz7O+BW/gBNTFAcsKAHrQyAefp
        PEPXdBHxv7f7zK7LxnKkjjVGLURTgnBJw1okwQ==
X-Google-Smtp-Source: ABdhPJyFq9GhH17ZazNFQDDbxDFMdHLvR6eWMzuzEIJ/IOMC5cjlRjRm/0YMrYIT6mioCDh2kD66PR7CaLDG9cQdQWA=
X-Received: by 2002:a02:5442:: with SMTP id t63mr9987402jaa.7.1629900682674;
 Wed, 25 Aug 2021 07:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210824070707.5731-1-kernelfans@gmail.com> <20210825065000.GA11343@in.ibm.com>
In-Reply-To: <20210825065000.GA11343@in.ibm.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 25 Aug 2021 22:11:11 +0800
Message-ID: <CAFgQCTtW1fapRLWwXzWE2Y3903SGeqJbBre=8jZt9NEzPcybkg@mail.gmail.com>
Subject: Re: [PATCH] kernel/cpu: fix spelling mistake of cpuhp_thread_run()
To:     ego@linux.vnet.ibm.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 2:50 PM Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
>
> Hello Pingfan,
>
> On Tue, Aug 24, 2021 at 03:07:07PM +0800, Pingfan Liu wrote:
> > According to the name of cpuhp_should_run(), cpuhp_thread_fun() should
> > be a spelling mistake.
>
> I think cpuhp_thread_fun() is short for "CPU Hotplug thread
> function". It seems correct since the function pointer "thread_fn"
> (short for "Thread function") in the struct "smp_hotplug_thread
> cpuhp_threads" is assigned the value cpuhp_thread_fun().
>
This makes sense to me.

Thank you very much.

Regards,
Pingfan
