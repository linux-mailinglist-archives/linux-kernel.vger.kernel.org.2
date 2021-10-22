Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE08437289
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 09:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhJVHOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 03:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhJVHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 03:14:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A010C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 00:11:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m42so1903490wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yIa6E/k8roJgRdabf3ndgbTTDoOGJ85US9AeRzUkbNo=;
        b=c04Px1A/n8RDfZ3bxtjde3WudxXpEMma/E6/tyegFKiGoi7EB23VDT8upDoJOpDTfO
         ubZWbS6HdPldVB/OlgtQzi+I/zA4lVZ2Q4Ztkm2RqzAK+qDn6u1jBXjvFWFBAhfkx/64
         bbnRyIt/u5NU5ktxx5NU/0mW5DDSysxwdVhtYQvUGsne6PtN4gnqjOrycXB+Ja072mGM
         BVYueleCos9aD2zhyuX42v34SQYerid+42PMbqyf5l10xBvUBijczPld77aWY7MuF5sE
         ml8cpmoYW0UHqph8d0mYPTHq3pMP4YIHkNqHoRIyC+0jvhI1qdLcCzWsrSD1+9q+oLC0
         zKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yIa6E/k8roJgRdabf3ndgbTTDoOGJ85US9AeRzUkbNo=;
        b=wB1yy67JS9lLvOJB8zLgLeSPIrK1WYtrhA5wwbufyv3mt+VHXFC0HgHb0GvisgrF2q
         t+nRvgquxJxausaBwmZ+BdrypLsR8Qvl2jjkoax2O4FxYegLNsX3Xdqz/WUfZT+CQQlQ
         2uB/Nj4JNSl0R0sOzm1AMBprxv3qLOHF/Zjk75v4+JtWs62M23MZX5qz8M+lqWdAe9GR
         P+Xo09jRNI3WoYxh1kW3aVTD2A4o+OrozyGUU2LL/qDy+5DDh27HUJdFN8vISPMOxJtH
         2sFDEgPKJM0/rVI8jS2NBFwVCU9Db51ZiSSDerLeaU3PtAcKcSfTATOqayjJmISj/DrT
         ZOwA==
X-Gm-Message-State: AOAM531jjgS4kwn9gP4GXFQOJPRxcN7fKsehG89VjgHMT34hXkvq3Ee+
        QiWEKinITXXin96Ddg7bh/w=
X-Google-Smtp-Source: ABdhPJw33wO03azS0afaTwb4cziYj7DERCH2I7PoCEcN7ZDBJ4RL4Nrv74aAtJH1fTj412bUgH6cVw==
X-Received: by 2002:a1c:ac03:: with SMTP id v3mr12416623wme.127.1634886717753;
        Fri, 22 Oct 2021 00:11:57 -0700 (PDT)
Received: from gmail.com (563BB2F5.dsl.pool.telekom.hu. [86.59.178.245])
        by smtp.gmail.com with ESMTPSA id 6sm2887434wma.48.2021.10.22.00.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 00:11:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Oct 2021 09:11:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: MAINTAINERS: Add Dave Hansen to the x86 maintainer team
Message-ID: <YXJkO9MiUzyWceOi@gmail.com>
References: <87zgr3flq7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgr3flq7.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Dave is already listed as x86/mm maintainer, has a profund knowledge of
> the x86 architecture in general and a good taste in terms of kernel
> programming in general.
> 
> Add him as a full x86 maintainer with all rights and duties.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20336,6 +20336,7 @@ X86 ARCHITECTURE (32-BIT AND 64-BIT)
>  M:	Thomas Gleixner <tglx@linutronix.de>
>  M:	Ingo Molnar <mingo@redhat.com>
>  M:	Borislav Petkov <bp@alien8.de>
> +M:	Dave Hansen <dave.hansen@linux.intel.com>
>  M:	x86@kernel.org
>  R:	"H. Peter Anvin" <hpa@zytor.com>
>  L:	linux-kernel@vger.kernel.org

Acked-by: Ingo Molnar <mingo@kernel.org>

Welcome Dave!!

	Ingo
