Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7873A90AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhFPElv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhFPElu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:41:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C79C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:39:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 69so478799plc.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5w3M3t3Z4U9itzhliFyQ9k6bBdvkeu8fXdsAtgl3rqo=;
        b=BhoZH0Nr3ZHtpXLjF2kiPY7YRdY/6qIXrextonsCRJ2vn3Ezw0B6jrysimae7W7qYW
         GJT+ozMHK5wtRIoAwyz/ClsSc9N8NjfRoqLmP+nkRlD07lAlZHdxBXpDjiEXhF1kl+MA
         k7rvWoYBPTW3FwCCoyeB+RXgdsINqgpyon4BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5w3M3t3Z4U9itzhliFyQ9k6bBdvkeu8fXdsAtgl3rqo=;
        b=ppX9pYJX4aL5wYRSmt27oIL018Yu5jZMTxKEDkLCnIoW9nD4O78vtdpoaPMtM28i3/
         8ytOsqjVeMXN0N9esonT3PcJb2YnOKc/w2Pa3ue4ZztmsfiAbYmcsx3u+v3U3sntnrW+
         wAKA9cnvdkL9S6PWk4tpPsqI4210B1sGGd3sEP6r0LNfRpMHhmDp/1iSMAE0h5Autk2A
         AsW1Y1rbFNPy8+AYIgN6unzC7JE8ihpNloMVvtyUKWdKYeD3bRRulY6BlF8nRb5ebT9h
         vHMwQt5uRtxvSmTmpJLPYp9djwjfZNcipI9y6IohQmzHsxpPUMLvSM8bedfiKm+/siV4
         3cPA==
X-Gm-Message-State: AOAM532KYwfACdsJcETpEfXWVyyvbzczoh7/2+hF3HcO8QvCPRkFMeAF
        bcoCf1RRA9X4tLRgq7Z+fRWCvhJ09ns6yA==
X-Google-Smtp-Source: ABdhPJxS52+0zEjYNpTjrkU9yDk9Lb9mREVnKzrzxmFtRrSP1pLKGqx/loFfJeSlNx4FwkYBioRzNg==
X-Received: by 2002:a17:90b:1805:: with SMTP id lw5mr2950044pjb.120.1623818383687;
        Tue, 15 Jun 2021 21:39:43 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id f28sm732424pgb.12.2021.06.15.21.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:39:43 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        aneesh.kumar@linux.ibm.com, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v12 1/6] kasan: allow an architecture to disable inline
 instrumentation
In-Reply-To: <CANpmjNOa-a=M-EgdkneiWDD0eCF-DELjMFxAeJzGQz6AgCdNWg@mail.gmail.com>
References: <20210615014705.2234866-1-dja@axtens.net>
 <20210615014705.2234866-2-dja@axtens.net>
 <CANpmjNOa-a=M-EgdkneiWDD0eCF-DELjMFxAeJzGQz6AgCdNWg@mail.gmail.com>
Date:   Wed, 16 Jun 2021 14:39:38 +1000
Message-ID: <87im2ev2wl.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

@@ -12,6 +12,15 @@ config HAVE_ARCH_KASAN_HW_TAGS
>>  config HAVE_ARCH_KASAN_VMALLOC
>>         bool
>>
>> +# Sometimes an architecture might not be able to support inline instrumentation
>> +# but might be able to support outline instrumentation. This option allows an
>> +# arch to prevent inline and stack instrumentation from being enabled.
>
> This comment could be moved into 'help' of this new config option.

It could. I did wonder if that made sense given that this is not a user
selectable option so I'm not sure if the help will ever be visible, but
I see that we do this sort of thing in Kconfig.kcsan and Kconfig.kgdb.
I've changed it over.

>> +# ppc64 turns on virtual memory late in boot, after calling into generic code
>> +# like the device-tree parser, so it uses this in conjuntion with a hook in
>> +# outline mode to avoid invalid access early in boot.
>
> I think the ppc64-related comment isn't necessary and can be moved to
> arch/ppc64 somewhere, if there isn't one already.

Fair enough. I'll pull it out of this file and look for a good place to
put the information in arch/powerpc in a later patch/series.

Kind regards,
Daniel

