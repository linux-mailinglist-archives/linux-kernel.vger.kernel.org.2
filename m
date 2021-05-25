Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7511B38FDEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhEYJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbhEYJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:34:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A02C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:33:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso13005108wmm.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6kjvv3YNnHMO/UJjVB7qqgBNxh5QL8EaN6jFc+x6A+M=;
        b=dYve/ksRNHNKl+8wiBtIRks0wz2KAW+jcmlQk8jOd15Fe9gOIbJVEBlFa6Tggy694U
         MzIKfUD/su2/F5NXp0Zgx+rcGvsHKdJ3XaH8lSa5NcqnjRGyCX52GOthKcXkN0LMdBiy
         tBdHnW+mLlKywIroWdKmxa0V0nK9Nzvvam2i+ZDq+KvX3CVM+p3iDZhENKIKkXRSVhtm
         R4RFLgQfXnsEUeZobuchWf7pjTArW0qBm4TLhsAP6HS30Z/mJmiVwSMFo5v2ssBF5mSX
         cQYbywMVOGljKn06+w6sEjq/F/nPQi0IOFODeSk8viueIYEY/XQHIqLh72AQnsDII64E
         lQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6kjvv3YNnHMO/UJjVB7qqgBNxh5QL8EaN6jFc+x6A+M=;
        b=Srlfn1Qm2DZFxoj8Us3kKHihb3s7fepQzY+3ZVHqEoP72xZpf3Is+LWhH0G7syoDTs
         IoL7S21+bpGv1iVfGTSw2dJVbfBH0zq4dXWomN03lwKZ4KQKvPcfAH0XrJqWsEu27oqH
         4gQzZJXrMk8NJIcCwaPzhoFfLQzvZ+YdXY83VsicWBnx/bcdPLgO+qj8ujvAekZiY128
         xTBNNulxwABEKb4JbDgA7sLTEMNGG3XXS7Pr9TAYvfF/bAPLg0ul1foeMNONhykizhNe
         kyDE2wGW0GLmCcwdmrd26Kac53ENWvvlmVKmXnA9AK+dY529OYKECMn5/hkom7Flr16i
         8jZg==
X-Gm-Message-State: AOAM533H0GWXSmZFtROegkGxiJUPVK//3xlVj66FClBapCLr/FT3m3iM
        zYWqbKLpIl4VYQOZvfZqXwitww==
X-Google-Smtp-Source: ABdhPJzdOsNCfCpThLEUohgWHuCpedtqkhSnMHE8Lx9MztgTi8iyEJeDSryof/Bp68qiNqkLVJAxPQ==
X-Received: by 2002:a1c:4c03:: with SMTP id z3mr23177949wmf.58.1621935185092;
        Tue, 25 May 2021 02:33:05 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id a16sm14878926wrw.62.2021.05.25.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:33:04 -0700 (PDT)
Date:   Tue, 25 May 2021 09:33:01 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <YKzETaPD/Flnz+dz@google.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 May 2021 at 17:54:24 (+0100), Vincent Donnefort wrote:
> @@ -161,6 +162,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>  		table[i].cost = div64_u64(fmax * table[i].power,
>  					  table[i].frequency);
>  		if (table[i].cost >= prev_cost) {
> +			table[i].flags = EM_PERF_STATE_INEFFICIENT;
> +			pd->flags |= EM_PERF_DOMAIN_INEFFICIENCIES;

If we're looking for micro-optimizations, then perhaps you could store
the index of the next efficient OPP (which would be 'i' if the current
OPP is already efficient), so you can jump to it directly when doing the
search.

>  			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
>  				table[i].frequency);
>  		} else {
