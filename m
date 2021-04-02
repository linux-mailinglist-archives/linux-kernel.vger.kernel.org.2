Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20E352EC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhDBRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhDBRxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:53:11 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC230C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:53:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id t5so2819488qvs.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKflX5jMdNtO1G8b2MdcdLIZYhVve5XTRnZ5EPOMQY8=;
        b=cokK/yHjMME0ZWlqRKtLC3Y8y4hkBEbEN2/vp7QXbMlYI0ptDC173WD+Sohx3R6n5A
         BubMos0/s4sVyDFNuEVi2xEKs4JWSnq5x0HnL3G0rdC6W2F+b49WDpbnrZrKqYljDpCT
         2aKsU7u9SFeL4P+i/JUHkv5dM/D0K8xYOKoOJSupV8kMHdGkQjDOFCFAdKVjYIMR2XRW
         McrA8LsEN/drb5xNcJVm+GV6/vTtCilCWaK7rChKQxJDpZ4TQmaw2S/chVX7vJtmMZYF
         lAkSuHplsZyZyQbAUiPEYT4qjdwdvkQMgnEf8ZMon9UGvxL1ljrfcSQQai47TIramF6y
         KO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKflX5jMdNtO1G8b2MdcdLIZYhVve5XTRnZ5EPOMQY8=;
        b=B0mzYgi1pqJMsTbT7OPhprf6BZWeA8h/FnkHxRLM+0cvM6DrenHeIjVih11AU02Ud3
         agP7Xr3iULhJ5cGVbVJD3qXLKkb1hwcu1VZYSXHy6vc9c7IuMbla/AvIcpFGkqccgz2Z
         9VmgTetngglISNXRFdZKxeyqJM09wVUizs1nTl0ai7Ytx2oXy+7vwUjsCcvalFxjJfRz
         a0cLY2HSglN2BJlWNIVcJgiuWhK7jLvRsDH08B44REzBGsllvW37GY9fdO1afxhTFvKS
         6R4UwYFORvn2G2kilzcxNgRKYCNBwUAKCER3fcxUjMShdZf06nyNxTj7eKj0dLYUtULU
         Hiew==
X-Gm-Message-State: AOAM530xmJM4cgeBMYlMOD8Hg7vBnIWTLF9pQMrOvcANbScJvt6eiysb
        wMp+4vpk+5qKOJmnNfBDa3njlw==
X-Google-Smtp-Source: ABdhPJyxtsmMGesJxLMmulQYPLF1n6/A1aDon8C+mHGH/+m7wf+/Vle2HxXNMt4herG6EDZg40TdTg==
X-Received: by 2002:a05:6214:2628:: with SMTP id gv8mr14106450qvb.19.1617385989081;
        Fri, 02 Apr 2021 10:53:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8ca7])
        by smtp.gmail.com with ESMTPSA id r17sm7077362qtn.25.2021.04.02.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:53:08 -0700 (PDT)
Date:   Fri, 2 Apr 2021 13:53:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Josh Hunt <johunt@akamai.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        keescook@chromium.org
Subject: Re: [PATCH v2] psi: allow unprivileged users with CAP_SYS_RESOURCE
 to write psi files
Message-ID: <YGdaA4EegXUACSA+@cmpxchg.org>
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
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

v2 looks good to me. Thanks
