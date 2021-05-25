Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF683901AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhEYNId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 09:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhEYNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 09:08:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23234C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 06:07:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q5so32155427wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GT9z17fs4UuOrvxJuPitrFvoK7stjO/aWDgOglZCGAU=;
        b=OMCyaTjLEBYS/wpntvhNT8h9HKcOnCTLoPjR6Tdwj5Geo8G/Txb/kwIg3VhTpZKiua
         bcyXggVZ1CjbixeDzcPin7R6edd9qZx1eDOufP0OKdmJC+UMHXNtP7AOI6ZbThWnMOKF
         MSSqG/OZBDW4CeaYc7rELtoe5C4Ua0nyK8ECSLr4gtbGR8eoODw4IS4Hsz/OBP+9PcZf
         /ejIu33Rg634C5XDAh1YoG9rDSezjysXv1Gb5xZhaPjNV/dpCLsPOsqXcRl60GA5tgbN
         CrQRGmbaMJa4bJogRQtJv2jPR8HcWOpyjympQrC07B4NYNLmhXpuYilCW5CRFRjURejN
         Y+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GT9z17fs4UuOrvxJuPitrFvoK7stjO/aWDgOglZCGAU=;
        b=BwTsEyTghMCG/nQow4GMC9aYNklvG03HYcLf10/YJ3NfGYaqk9Ty+QUFEJUo7dWplV
         +KLZuWMjApkneuOxarxi+nb6jU+qOJiw9uv7BIcWQeLiEg0/HbaVp8JTTheCUv0228kn
         DJvACD21FGUPV5m7bRKJvd8AzxQAYip8C7/olBZIiLGFrH69Bzrjyg/LKw7M1f5QsFGY
         hAPCnqCFetXbAc3JM8ifI+MG3tBW8AV3Se20NURE88WTyZ51jSqYAjKYTh88wZH7ITX4
         29Lq4d4En1v5z8/j02g3pKTUGk80NWoX0qNPTw1S5oGXFcxxxi3vjjvlP5aMXIO79rt4
         Jlyw==
X-Gm-Message-State: AOAM532uXwRJ2A6sC3hQaIOFlR3aHSLOZ+Toq8WkBb2TW4kuQQ72AO0C
        4J//ghe+ZhoWyGgZ8tR2JVIVKw==
X-Google-Smtp-Source: ABdhPJyX77YKNfrrtILKmvBW6rUilqsBR6Lr9vSpjGJhEEVR6MHk8sUOmfAt2JsEkDj/fqa424fULg==
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr26681542wrw.11.1621948018633;
        Tue, 25 May 2021 06:06:58 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id r7sm10607596wmq.18.2021.05.25.06.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 06:06:58 -0700 (PDT)
Date:   Tue, 25 May 2021 13:06:55 +0000
From:   Quentin Perret <qperret@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <YKz2bz6EiLwISOVV@google.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKzETaPD/Flnz+dz@google.com>
 <20210525094601.GB369979@e124901.cambridge.arm.com>
 <f8a2bbde-47c4-bd7d-96fa-228c9d9e2779@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8a2bbde-47c4-bd7d-96fa-228c9d9e2779@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tuesday 25 May 2021 at 12:03:14 (+0100), Lukasz Luba wrote:
> That's a few more instructions to parse the 'flags' filed. I'm not sure
> if that brings speed improvements vs. if we not parse and have bool
> filed with a simple looping. The out-of-order core might even suffer
> from this parsing and loop index manipulations...

I'm not sure what you mean about parsing here? I'm basically suggesting
to do something along the lines of:

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index daaeccfb9d6e..f02de32d2325 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -128,13 +128,11 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,

        for (i = 0; i < pd->nr_perf_states; i++) {
                ps = &pd->table[i];
-               if (ps->flags & EM_PERF_STATE_INEFFICIENT)
-                       continue;
                if (ps->frequency >= freq)
                        break;
        }

-       return ps;
+       return &pd->table[ps->next_efficient_idx];
 }

What would be wrong with that?

Thanks,
Quentin
