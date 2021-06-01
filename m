Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB44396FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhFAJJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhFAJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:09:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D30C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:07:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so1051731wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zEt3HFPe09o0ckZsYClTr0bQexAxs0o1KqTS66rUt2k=;
        b=Ms1+vTOLxPIDbCVEtqKP/81D25pVmVzkG6ZBvL3jBz5SbnjQXhENBBAe10jUp23Q9L
         uu+pKMcryhb7fxcqf0YDWjSXz+txEQZQ6ZM3mjSmAlo38fk7ZrkBl6RzPLZwRsdyuo7G
         hqJG7M17a0W6iCMIgIBR77Bmh7cXLtibBQAutqq8T4Qgsfcl1ib/J0U87R1IsOGl/Xkf
         0m6p05hJyssvOju92ku2FYnlAGg70jHuSSQdlHEZTWeLhGjGEOOyyb8e6cXnNgTVZRmI
         JtCLmDYmAW25+ZOafAknmXWNBgYjqOpcD3dfz3vceqgxGy75nBYfOLANCNhLXIsGEAm6
         RE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zEt3HFPe09o0ckZsYClTr0bQexAxs0o1KqTS66rUt2k=;
        b=S5DQeplFF3Ubee6eGLBtnfB0PUnvPQ4RaCRWUWa3MMSCjNKR1X+UKMpUupXuiLy3Qq
         ymKk5vEzfF/ARIcmRWL/Itos7wqJOmq0J54LLTdCQvFV8T8d1AvH3BQDdMJj81Nngvd1
         CpLfILcqTWSeB1NRcXKG5Bt3e+DZAGOJSh8dEM5npNNHgcUGsI4uW/B2ORHKDFnB0MdH
         ShNYNTdjy9S/qfg2AH7g26SxNGWTwCFpFRN1+rP20pbhDNZBexHyYtKL2KOVIoHijpy7
         1Sub90AHB3HK7EyFl3rpHebfNtxHasMc32RQdJCeapm9u5eaeYRLczkMdT6Gi0vdHfgY
         AG1g==
X-Gm-Message-State: AOAM533fflxjkeishQHJxJ3rJEQryo4KefJ4ouKqWzYa1hPvOEwc6Vo6
        8GweCausVfUaikqE7EvWG2wbiA==
X-Google-Smtp-Source: ABdhPJxk5PNDiLkv3H83jVwq9zMK6clxpGewQUlMMJ+GzyN5TfeyhjT/ic08DFR7dKkW/z7fJdxWcg==
X-Received: by 2002:a1c:e354:: with SMTP id a81mr9583848wmh.98.1622538464647;
        Tue, 01 Jun 2021 02:07:44 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n6sm16726370wmq.34.2021.06.01.02.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:07:44 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:07:41 +0000
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <YLX43QT+5r/4zHoP@google.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
 <20210528050934.muji5bv7ed4k4t6j@vireshk-i7>
 <20210601084725.GA223449@e120877-lin.cambridge.arm.com>
 <20210601085628.75atoc4e34uttqqw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601085628.75atoc4e34uttqqw@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 Jun 2021 at 14:26:28 (+0530), Viresh Kumar wrote:
> On 01-06-21, 09:47, Vincent Donnefort wrote:
> > Seems like no one has been really convinced about the arguments in favor of
> > keeping inefficiencies into EM :) Let me then give a shot with marking the OPPs
> > for the next version.
> 
> Right, I think this is what you should do:
> 
> - Add another flag for OPP entries, and mark them inefficient.
> 
> - Whoever traverses the list to find the next frequency (cpufreq here), checks
>   that flag somehow (or replicates that to its own table) and get the right
>   frequency out.

Just to reiterate here what was discussed on IRC the other day, I still
feel that the choice of an efficient OPP or not is a policy decision,
and should be left to the governor.

It's not obvious to me that the userspace govenor for instance wants any
of this. Same thing with e.g. the powersave governor if the lowest OPPs
are inefficient (yes skipping them will not impact energy, but it will
impact instantaneous power).

So if we're going to move that logic to the cpufreq core, then we'll
probably want two separate APIs and make sure to use the effiency-aware
one is used only from the places where that makes sense.

Thanks,
Quentin
