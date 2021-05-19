Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0090388CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350749AbhESLa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhESLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:30:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:29:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lg14so19437131ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LC8qtVxdEwMMgytLujeez3/2qAxymscp6HYNZSziD5Y=;
        b=tbjRnDfF6QQXUhnFCrHPAeUrE+OEw/Myy3ioaox8ON7T5DZq+3Kgh4uIXPbiJU0nIc
         gmwbhhGMmFgQuPDLUhCUQyCWJn2EIme8NiU+n8VEZqLMnKFBt5/7GkzP9vIR1cMQY63S
         CpZ3Ko4Ov3jjYaMoCHdtz0b4VgyXcI5m6X0G+yCz0XYH5OjoERKw5WqecKvpmj7dyv3s
         Qp4qDUzPFgp5YnR1SHBtyoMzqivFqzEuzQ5NrAxE1VTVRNpP8BIJWEraygya7o89urgF
         qgnv+n4Vm+JeyUGcPXMP4gAEymLnAoYtjUStc3Bw/73BnYXFd8taK3L/cOQpjvDfz3Oo
         a5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LC8qtVxdEwMMgytLujeez3/2qAxymscp6HYNZSziD5Y=;
        b=ZhjXMcEr/p2NWss/DQFAh6xBaGdrLLXP4/ma/Pqw10/kT2E5Uc0KqZw2jTYvcKXRR0
         hCsfFvm6Qib/DyZiELOhx9y7BYS/tfYj9YUrSx/BZCqMySja5vaHaKD9ByVYbAQ3/Ww0
         RJULLliVA+x7oKdbiRw/A87hDxD1ndRmA6o7rOZOJbNI+hjSWlzTD/iLHsp5lqSvC0EA
         JDGT0jk65oHLW4wggRuQ2BpdumlrBxo3Dkzed3hnCZR2UhKoIdpP/TrTmmix6nAY3gHo
         D9UkTn7uPAp5F7Kw1PnJJ9FMwdG2PZc9hf9ckz8SG3aXkRcB4w5H0ecQM9tvQBLm0sk1
         OTVA==
X-Gm-Message-State: AOAM5312L34IBwwlAWeZfhLCxXSow7Jeavn+5febgjgDQYhRhgVOmZ8s
        x+S25CMo8Ft08wVqU75XKKcVM6/Uxbo=
X-Google-Smtp-Source: ABdhPJwnsHAbA766q06N53kcVsO4nPY7oBrPAUYImgzHXc6IvUnkn0rGTW4PTfu+Y4w6KbiTh3+pEw==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr12047472eja.275.1621423771431;
        Wed, 19 May 2021 04:29:31 -0700 (PDT)
Received: from gmail.com (563BBFD3.unconfigured.pool.telekom.hu. [86.59.191.211])
        by smtp.gmail.com with ESMTPSA id k21sm1885861ejp.23.2021.05.19.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:29:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 19 May 2021 13:29:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] x86/syscall: use int for x86-64 system calls
Message-ID: <YKT2mW0xVZltBOSh@gmail.com>
References: <20210518191303.4135296-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518191303.4135296-1-hpa@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> This patchset addresses several inconsistencies in the handling of
> system call numbers in x86-64 (and x32).

>  arch/x86/entry/common.c                         |  93 +++--
>  arch/x86/entry/entry_64.S                       |   2 +-
>  arch/x86/include/asm/syscall.h                  |   2 +-
>  tools/testing/selftests/x86/syscall_numbering.c | 488 +++++++++++++++++++++---
>  4 files changed, 508 insertions(+), 77 deletions(-)

Thanks Peter - this series is really nice now, and I agree that this 
inconsistency should be fixed.

Thanks,

	Ingo

