Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D790B362392
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbhDPPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhDPPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:11:45 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0FAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:11:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 18so12289196qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=keIT10QQjocHKJyfD7YBeoaigDEvtt9IBYvkNbGcasQ=;
        b=fkGizxZ7b1PnawFuMt06pOmAE9k86OvXob09tNCZ/M6Ulu7aDG8a5jrH0qNW4CBYm4
         m/hz31GQihFGT3bcqwrixJXNYXPxLlWGOBvd1Ld7Zfuy0NZewTjIe9nhIEWdqK5p/goa
         t2MfuOyXOL+/wYCVedhhnNTg+PPjLKE4+r4yb9cxPxyuBRSkd3sezjU5S23ZJATbx7Kf
         6z0rYZaRaIIra0WL/LeG8TawDViJ43hQTFBD5LpzG9e6khD/0m/jS7d/jqcc2BgdnC4p
         kAt9YD+wbRWo/nhd8Giwk32TKcRtJApRGu6rGm/WDEpWzbB+k/MJAixSQqV/Vrw/peXF
         UEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=keIT10QQjocHKJyfD7YBeoaigDEvtt9IBYvkNbGcasQ=;
        b=NUkky00p/ll+k7o7/hj3vf4zXHxtNgWpSdkceL9blolUxhmXYdRL8wJgnAoyWd5B4n
         D9P97TnR4daM6VhMRcjZatK1xT0jC++Rb2uSluVC1e3LNTMr0DpU17ID1H4oPUwpMYOj
         upB+goC0/V9q0Pnm/3SiQtFHxrSgXwwWWwfEMpq/h5reOsXSEAYgcjgUyeV+7m9vKkkD
         T+vbADxGYy5E60b5EUlqaA5DMAgBbLhC1x4NeywoB6L4K6GsPNDJI2iEdDRI8BELjLja
         EnahCTo2efT/SDVItkn4JFI08bxkmBdiNERjdAHUh1+wqTeioY1w8kQ/oifm2yl1GlD3
         uQIQ==
X-Gm-Message-State: AOAM530BnxekFIZbimLHfa/O04mQm/ZXHK/F0o14/SbCGHjP2S0U8uqd
        uGoq7UXvvAyROvDwJMVXVcajJg==
X-Google-Smtp-Source: ABdhPJyBFRbHhM8B+qVR+eV7j4cR/cMobKGifiVECXI03gONSXMlkFza/+utPWZH5Bc1ORmDnUZf8A==
X-Received: by 2002:a37:2f41:: with SMTP id v62mr9404743qkh.408.1618585865760;
        Fri, 16 Apr 2021 08:11:05 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 188sm4539399qkf.27.2021.04.16.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:11:05 -0700 (PDT)
Date:   Fri, 16 Apr 2021 11:11:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] sched,psi: fix the 'int' underflow for psi
Message-ID: <YHmpCOz339T67yTt@cmpxchg.org>
References: <1618585336-37219-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618585336-37219-1-git-send-email-charante@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 08:32:16PM +0530, Charan Teja Reddy wrote:
> psi_group_cpu->tasks, represented by the unsigned int, stores the number
> of tasks that could be stalled on a psi resource(io/mem/cpu).
> Decrementing these counters at zero leads to wrapping which further
> leads to the psi_group_cpu->state_mask is being set with the respective
> pressure state. This could result into the unnecessary time sampling for
> the pressure state thus cause the spurious psi events. This can further
> lead to wrong actions being taken at the user land based on these psi
> events.
> Though psi_bug is set under these conditions but that just for debug
> purpose. Fix it by decrementing the ->tasks count only when it is
> non-zero.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

The subject should be

  psi: handle potential task count underflow bugs more gracefully

since it's not fixing a known bug at this point. Otherwise,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
