Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060BB381D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhEPHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 03:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEPHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 03:53:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A2C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:52:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u21so4467030ejo.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MF9guD3du1Cs53O/MpCr6YwNs2PZZZTpZYjYQIWKr60=;
        b=HrSZ8Wbt9MUDPhbW+CYAbhQXpJoEyUw2HIrthznA2a+6ju6yjePGa1uq+iT8gARJS5
         WBn5W7AYd+daVQDvnfmau38u+uFjbEx9Lk6MmLt7fSusaxqcfc4EyQuNDRAFpciW+Q3D
         TF/bzAq4htfqocgBq7UZspHHt2sCvjkrJXU+qGqIDXVJOE65AAuqem6IN1XlAk/dj6Yh
         dCN65ri2HLwNk6vRQ8My5ZjFmJBMtZhcAxq54PsHL7y1ilIWRfiWZFRKml/1NwZEr+0P
         xuQvYjTfHUR+lmc/QimphvshWaFo3Pm8ph48wBRLVawEdVkcdn/LkTmatN7YKNpZQd4c
         Iwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MF9guD3du1Cs53O/MpCr6YwNs2PZZZTpZYjYQIWKr60=;
        b=Eb+i6l9BCt2P1csHOCjZ5rWtHU6XVA8dIdZmgL+zq51a4CMIYgunTzatmwADoDsMGY
         6i5awYJzJ82HDI6L3Cwnik16/pBc/PxkxPsOFge3A5z268WqNfZzu0ROYPjqX8SnuQHj
         rxPFXN9436UrJdafcI6qErre/DmGTeBxWfksnRX2Ws+rEb+H6+bmlk7zNA4n119wIs3D
         5CJRSVCWDY9UL3TprWz/puqnh/CxtzxSHtsW0Xr1McH+WMCGmr2BUuf0qRd2fgrx3XrP
         /AhsQnLZHxGZUyTB1/PhQ9ihRD0rjTBcfCLl7u5WuUuJLiVYiX9vmSgOWyNSTAIBwwZ6
         t/cQ==
X-Gm-Message-State: AOAM531WZg1jP/ng2WqI3aow8763p1sWws0fwY9usyrVRX9vk0keP8Sz
        yNs12eMYOvuMJDQWOPd62Ys=
X-Google-Smtp-Source: ABdhPJwSaqWke1aVZDvTr3hsfGYYUBhqQzqwh8Q1omYRbxEzyoaPcpN0qnN9JhJtVxL2R5IFYasCWQ==
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr56322024ejo.471.1621151528808;
        Sun, 16 May 2021 00:52:08 -0700 (PDT)
Received: from gmail.com (563BBFD3.dsl.pool.telekom.hu. [86.59.191.211])
        by smtp.gmail.com with ESMTPSA id v12sm8517591edb.81.2021.05.16.00.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 00:52:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 16 May 2021 09:52:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] x86/syscall: update and extend selftest
 syscall_numbering_64
Message-ID: <YKDPJum3pB/Ma9Gs@gmail.com>
References: <20210515011015.2707542-1-hpa@zytor.com>
 <20210515011015.2707542-3-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515011015.2707542-3-hpa@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Update the syscall_numbering_64 selftest to reflect that a system call
> is to be extended from 32 bits. Add a mix of tests for valid and
> invalid system calls in 64-bit and x32 space.
> 
> Use an explicit system call instruction, because we cannot know if the
> glibc syscall() wrapper intercepts instructions, extends the system
> call number independently, or anything similar.
> 
> Use long long instead of long to make it possible to compile this test
> on x32 as well as 64 bits.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> ---
>  .../testing/selftests/x86/syscall_numbering.c | 274 ++++++++++++++----
>  1 file changed, 222 insertions(+), 52 deletions(-)

Small request: I'd suggest moving this to the first place - so that we can 
easily test before/after effects of (current) patch #1/4.

Thanks,

	Ingo
