Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B6396FAA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhFAI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:58:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2012C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:56:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v12so6493027plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mwIElpPwLoi6ULku1GJdBgBEsBDz6lBaoZcuTTv9WEM=;
        b=Q7ulzi7XqzBHwj1dXVShtgNPB0Axt8HPX2RqQga2L2WZKbCrWvsUxT6IYIW2JQSwt+
         V7JEfP4NKfiHaYkG0SooSNkm1SmkegphrPBfYn45amz/xnFdEImZzKUOMdZr3D9xzni2
         bMlF9eXFINzh4L3b8qIKNCG4cEp1SYb3MEsgjIIn79xjTsDTsGAyM6S2w6vCWELM5AOM
         Vj8UcsCUt1qzek6fdl04me5T0FQbuxlCbaB7DX6oAx9Z+tGvDFbfg2UxheEE3K3VmF2a
         CH+InvKDDkTGGCO2yhjWqJ7vyQuMKWyyNJiWLjON4lcCd9xq786+YO11HOFCgMjYSfvn
         NFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mwIElpPwLoi6ULku1GJdBgBEsBDz6lBaoZcuTTv9WEM=;
        b=YyJ9TyVocUfGwaYpV1fUGKiZ0p+hDgUp3rTQigFpL9hJn4fq0FfmkUD6XknJB9RGBJ
         O9xUz+EMdL5bFXwPgY++GjeYTgN9Ra/iSfnvBnWWdgLZOOOPGJQYvY6RuRby8Gxo/buV
         Oa6c7m9TDx64WxZzZGsZ+TAYqNtpC/sfE0rYxk74ZDUjrX0qSXMc3lR1MmDGgX2MG2ZD
         VsfT+3WTJw/KPs4UwNVI/8pvvamsNJDfvWisF/kOV6C+dBMoVWRUSfczNpAULnWGb/Ih
         /y55bteYMSb5UwIOIdQwncrCZnAY+PML8mmxYf+xMarqLR8V89QV61HtJ7qRk3vpIw/u
         tRFg==
X-Gm-Message-State: AOAM531ZlMj8EYrFhza124d/f/dciPX252BtafjsDoQ0X0enhSalG12k
        FZE5BRlzwz5mgzkLWjmlq7Jolw==
X-Google-Smtp-Source: ABdhPJxM+eBymtavNuGzYoxJ8e5tnKHl3JhD+tc6AAmskN591J1Qq+zwQxZdu9rTsf3TEFqeTkEMNQ==
X-Received: by 2002:a17:902:b10a:b029:f5:6ea5:1e14 with SMTP id q10-20020a170902b10ab02900f56ea51e14mr25215330plr.14.1622537791386;
        Tue, 01 Jun 2021 01:56:31 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id d18sm13755643pgm.93.2021.06.01.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:56:30 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:26:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <20210601085628.75atoc4e34uttqqw@vireshk-i7>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
 <20210528050934.muji5bv7ed4k4t6j@vireshk-i7>
 <20210601084725.GA223449@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601084725.GA223449@e120877-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-21, 09:47, Vincent Donnefort wrote:
> Seems like no one has been really convinced about the arguments in favor of
> keeping inefficiencies into EM :) Let me then give a shot with marking the OPPs
> for the next version.

Right, I think this is what you should do:

- Add another flag for OPP entries, and mark them inefficient.

- Whoever traverses the list to find the next frequency (cpufreq here), checks
  that flag somehow (or replicates that to its own table) and get the right
  frequency out.

-- 
viresh
