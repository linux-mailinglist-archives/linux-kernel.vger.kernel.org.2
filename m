Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379EB3B8C77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 04:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhGADBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 23:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhGADBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 23:01:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 19:59:10 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v7so4812434pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HD7nLLZFahFZKeQRkjIKTsUXoINqr80+ydWGPG7amAY=;
        b=JipM+EK81ndjv8XjmzmAJdM7nmoKLbmYH/ud029YPFjEHHQVbB/Fo5LE4SsvNyIO5b
         gERHOXdwhdz+t4OYKRRGVblLlhzuS2lo8OTBXlqDDB0W3KY1OYKqL2l7xHrFG7ZJZqT1
         2JILMRYYp/3JlubEa9F1YPhupMcEzRTqegorrJ69vvLNZa1nUc73hpMvkdtg6ExOKhMB
         6TW+ug59UI0zGXJIMD+Uwx+OaiPvQJfixASfK6Z6NwsPqS94k0+oxoyeypiZqaB8HbTY
         8u7xBcQnv1L1RfxoZlY5EqoU8jbUVaZcMnqRE676a6M3yTjeHnp4nf5/Y0qYTqURgZLH
         Yzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HD7nLLZFahFZKeQRkjIKTsUXoINqr80+ydWGPG7amAY=;
        b=cAdBXOXwofu97tuyvn45KMEV+tnduaPUqZ/ywaACQZTW9rWOxk8XIzUwhcamQiYsCJ
         gL4t2cSj9xwvHn/q77X7JhxAIyGuZmEuqbGZlnnoP2VEBrx8Qfzz9l71X7sw8Akq7E/Y
         eKsS6cv3+2bJ8L+SX89afS3+Tn6AITL5XfLIG/FprYXK0shlURFrU9533I0DYBIOdMUn
         EyQ4AEmkzWcVbtcNnZUt+uA63ff7f7hgZ/g8SCqN7KKQ5X/jKViP09dzU4OZJI573XSm
         O37eoEaQ841Q9kZ2MsYdTrydBca1tf5UfF3BAaK/e75UP+ip3dip//pUTf+e/+KHpSTG
         Y9Ng==
X-Gm-Message-State: AOAM533vRbmkIEL8aX6hDACSeh+QPvVOVxE8iYinFWllrDpdB1KxndA2
        qxJpUe6iIDWMuFfF96Fp2oz80w==
X-Google-Smtp-Source: ABdhPJz2BHWOJV3UUYXKeWeaBZ/AB8h/54zHJj9UpIKDhfF3sYh79IHmRjAQOd7jI6yIM/InDUUhmw==
X-Received: by 2002:a63:4c5e:: with SMTP id m30mr37239105pgl.153.1625108350026;
        Wed, 30 Jun 2021 19:59:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k8sm14831808pfa.142.2021.06.30.19.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:59:09 -0700 (PDT)
Date:   Wed, 30 Jun 2021 19:59:09 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Jun 2021 19:58:58 PDT (-0700)
Subject:     Re: [PATCH v5 1/3] riscv: Move kernel mapping outside of linear mapping
In-Reply-To: <87czskonsn.fsf@igel.home>
CC:     linux@roeck-us.net, alex@ghiti.fr, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-99340121-50f8-49ca-ae6e-0f737fc4d736@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 02:14:48 PDT (-0700), schwab@linux-m68k.org wrote:
> On Jun 16 2021, Palmer Dabbelt wrote:
>
>> This seems a long way off from defconfig.  It's entirly possible I'm
>> missing something, but at least CONFIG_SOC_VIRT is jumping out as
>> something that's disabled in the SUSE config but enabled upstream.
>
> None of the SOC configs are really needed, they are just convenience.
> They can even be harmful, if they force a config to y if m is actually
> wanted.  Which is what happens with SOC_VIRT, which forces
> RTC_DRV_GOLDFISH to y.

Ya, in retrospect the SOC configs were really just a bad idea.  I think 
we've talked about removing them before as they break stuff, I just 
haven't gotten around to doing it.
