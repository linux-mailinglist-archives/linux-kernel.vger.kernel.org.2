Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BEC352EFC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhDBSL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:11:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0783C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:11:23 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k8so4011678pgf.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HPk2Jv+QOKLY+FRZS5imorIT3+sz59DrrESicWBnBl0=;
        b=bfQ59yf7oyksMp5c1JmFl7BXoQq1cVTIsLo/kNC1mSw2yWQFNVsO4CFuilYbjeVmk0
         4z/2HpjgSQ8P94cLhuJXo7U470eXeAbHLXQ/ZsUhjkSq0GG/dgF22e9LKvomdc++Nf8u
         kazjFb2exoCwj0GM4wd1syBMh6TZuDuXlNVPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HPk2Jv+QOKLY+FRZS5imorIT3+sz59DrrESicWBnBl0=;
        b=UQCqvxe/As02v/o2gba2EZ5LLr22pRrjXtC4iH4cjsIY7VCvRSx7lHd/yd2cDmg2+E
         6bpFbT9P4nrEgxbLoLUDkrjZHXExbr/ol9SfHvQcDCZtmZPEbSShJcEq7wF5CLHar1vv
         ntTPAG0qc7sBmFDvR6/x4OIo3OalWJJ1ZpoWY2B0afgpllpoYuan51SDNG5seeQVLjLp
         4a5TlY6kRt5BWkTduGxd22CL3CQRY0oQatx7CfwPYNEEMK/3v/TIAhKDG9erqBHHgbT4
         ixr9uoS2nQBT8/kG4D6cc3i82qJrcZYG518l6ZQ+owoXqcnKseW+TkzfJJaIllsIqAoP
         jtLQ==
X-Gm-Message-State: AOAM533vd9zwqUwTTNro6w7vaEp4zZKd96FsIyq6tqCjxZpwYQ1/7GZ5
        Yi8Qe//WKCQumpKlWSC/8WVBiQ==
X-Google-Smtp-Source: ABdhPJwn5jY5k91Flu/zYyxodYLJmpRalm7vv1tvHlDQFyTz/WIl/aOA7olrpuU+vdYwKjLKIFl8Ag==
X-Received: by 2002:a63:8c0b:: with SMTP id m11mr12737875pgd.306.1617387083370;
        Fri, 02 Apr 2021 11:11:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5sm8414578pfk.219.2021.04.02.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 11:11:22 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:11:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Hunt <johunt@akamai.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        hannes@cmpxchg.org
Subject: Re: [PATCH v2] psi: allow unprivileged users with CAP_SYS_RESOURCE
 to write psi files
Message-ID: <202104021111.AA33CFC955@keescook>
References: <20210402025833.27599-1-johunt@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402025833.27599-1-johunt@akamai.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 10:58:33PM -0400, Josh Hunt wrote:
> Currently only root can write files under /proc/pressure. Relax this to
> allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
> able to write to these files.
> 
> Signed-off-by: Josh Hunt <johunt@akamai.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
