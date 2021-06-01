Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4AA397015
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhFAJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:15:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93232C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:13:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x73so3685210pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Blkz6MwWzhLd82jPxQi8FhWdjjdnUZ/dGYCljF9EbEc=;
        b=bhde+OHqnT0v64c17V3Jd0pDnluYjeBi1qoqnycKMFl+I+fqaVVWYK/eLNd14WrsdK
         Czawj7dmWGvMqmoVNWJ0+++qDsnmN2bhVkMXtABcKWOqk53KBHlNcV97gD/y7AUCJG+V
         g6npT2APgp1GjcmFuv4sG6FxMq0Ls4hCYuhVMVB5F5Pbu1Ysx7zksGvT1yF5lVHi3jS2
         8LXUHdQvrdaSi9Vq5rRkYtwKhCqWCP5vlLXlSowSd3xnOPPvcX+g5jt6XPT5zmZ0vEgz
         ZokyeFm9zpEx8qqQb68eTetLkd3Oa7LjlaHf+Z+dWx3WP74viKWJrIH2cGMqjpFGU9HJ
         KEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Blkz6MwWzhLd82jPxQi8FhWdjjdnUZ/dGYCljF9EbEc=;
        b=ctJNN9+sY9jrSARXAZ3KUxWr1Mm7RB0ODlx8xr/cOmlXu3amR8Hylv3o5OPF78R2Tm
         8oHzGYHBKZKI4qkNqV3IJWyVUwIVOe6isIDvQVpkTwVHkfZhDxB77TkqsTmoBMchbovd
         s5spVjg6F2U06BWrTf28cWdjDCN8lKuBOLhMfx7YeCLw/G7ADH5dbTeI2qwCPEqcAJVg
         L3lqkCIUqE/Gq4HJDUNJ/TS4eideXvbimBXwAMrtnorIl+bBL6Qv1QWyAjxQHdhTPdEa
         XUwz2TQmWr5LkqzfFJaf9/OjZUL3Hnq7gSiMbViZ+u5WgLdpQeWUdJEN1zFb25imfWSQ
         mebg==
X-Gm-Message-State: AOAM532Y4U3tKpo+a5XXInrXi+BiJejkJvfiZixu3WbIZcXATrJmEGuQ
        4+Kdb02okOtx1JFNOgFfoldR7A==
X-Google-Smtp-Source: ABdhPJwTrV9IwmKmRBnKVQO7gRMlGilJ1uboOjBOvBcKnpbfihh4TyP1ZT2JTuxGxFUj5QnB2IEKIw==
X-Received: by 2002:a62:5483:0:b029:2e9:ff82:95e3 with SMTP id i125-20020a6254830000b02902e9ff8295e3mr2427343pfb.29.1622538835175;
        Tue, 01 Jun 2021 02:13:55 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id hk15sm1581632pjb.53.2021.06.01.02.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:13:54 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:43:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <20210601091352.7tthvv6hygtisprm@vireshk-i7>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
 <20210528050934.muji5bv7ed4k4t6j@vireshk-i7>
 <20210601084725.GA223449@e120877-lin.cambridge.arm.com>
 <20210601085628.75atoc4e34uttqqw@vireshk-i7>
 <YLX43QT+5r/4zHoP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLX43QT+5r/4zHoP@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-21, 09:07, Quentin Perret wrote:
> Just to reiterate here what was discussed on IRC the other day, I still
> feel that the choice of an efficient OPP or not is a policy decision,
> and should be left to the governor.

I agree. cpufreq core shouldn't always do this.

> It's not obvious to me that the userspace govenor for instance wants any
> of this. Same thing with e.g. the powersave governor if the lowest OPPs
> are inefficient (yes skipping them will not impact energy, but it will
> impact instantaneous power).

Yes, these governors shouldn't end up using the efficient only stuff.

> So if we're going to move that logic to the cpufreq core, then we'll
> probably want two separate APIs and make sure to use the effiency-aware
> one is used only from the places where that makes sense.

Yeah, we need another API or parameter "bool efficient" or something.

-- 
viresh
