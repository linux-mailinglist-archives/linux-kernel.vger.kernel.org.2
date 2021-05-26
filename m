Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76B63913E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhEZJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhEZJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:40:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:39:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y202so509144pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kz1NBJt3v88ucPdDaIMsLei5Ot59utKDt9VRAfxVdAk=;
        b=WFpxE9k4dZpRpxz8LR8R+dThOLk5Pmj/HWSTWuhqi6kgh8lV5Sjy4XbP2zt/FDVt76
         x1Uph/Q4Pey2vc6Fyo43WluTzipBHuR5ZSDk9dhIytMHfE0pbAg9ACsgdwQh0Ouzwjlh
         +SuiDDuxPcKDDXzMlkGvKrAcE36EUT69PgIRHLrG7WKwfS6oRV8gn+yQ22pMwQdagJkj
         WBhWXiVQJ1mNWgBNNAYYQ9hHkRnL4/dCwnA4k1lr9q4/h2ahwLxyTpJ6hk/tEYNc6C4p
         mMm2txj7Y5L78/EWBfdGzdoz9Z7h0J9VimiSnDUPWk0CDM16OvXIUjX2jZJdIHBzLZN3
         XZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kz1NBJt3v88ucPdDaIMsLei5Ot59utKDt9VRAfxVdAk=;
        b=j1V06xuowFFvmTrd9+8QMZs+TIJmoYa5oEJ+cSeALYaiwj1mXrBsiAwYFk8L+fOFcX
         TynZAjfZ/fUInVB9cEPM9RQ8/s8XP/goL1kFyuAPfiG70CfG9euAaROmU62CQd3WzhDy
         jMl019dO1J/UXl2LjSklGjO091sEenxoJRnUOw2Zh2v4kRrTswc6kmGiqLNUpEdnlUO9
         nWRI1Pz+CUOGuX2KmpnXW3mDJXuTAnIPJ6yWmQhqg4P0j+ZYWJ2vpAcKSu4M9YxKqb+6
         rnNbjWHLybqIb6+A5BVopSuw7uYem2PE6f7r/tQojKj6VZQynZgGQwnC4Gap9WR1ObGW
         vkHg==
X-Gm-Message-State: AOAM531eQzY4qg6ZImIldxA+T7reRGik+fxK2i2JVM1FeOPdTS5L9v+j
        t1nMVzv9gBYqpBvxUdpze+YJsA==
X-Google-Smtp-Source: ABdhPJyLVoQrpevP7Z7hER7btfMGjB0byabKGtxVLa/PGHgTc8fnQ5IPs7aW8CZgQlg5yGxEQma3NA==
X-Received: by 2002:aa7:8a18:0:b029:2dd:42f3:d42f with SMTP id m24-20020aa78a180000b02902dd42f3d42fmr34454257pfa.70.1622021965113;
        Wed, 26 May 2021 02:39:25 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id s12sm3938006pji.5.2021.05.26.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 02:39:24 -0700 (PDT)
Date:   Wed, 26 May 2021 15:09:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
Message-ID: <20210526093922.txvxxgl7yvpz27iu@vireshk-i7>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
 <20210526090141.GA408481@e120877-lin.cambridge.arm.com>
 <20210526093807.sih5y4lgltsz3r74@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526093807.sih5y4lgltsz3r74@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-21, 15:08, Viresh Kumar wrote:
> On 26-05-21, 10:01, Vincent Donnefort wrote:
> > I originally considered to add the inefficient knowledge into the CPUFreq table.
> 
> I wasn't talking about the cpufreq table here in the beginning, but calling
> dev_pm_opp_disable(), which will eventually reflect in cpufreq table as well.
> 
> > But I then gave up the idea for two reasons:
> > 
> >   * The EM depends on having schedutil enabled. I don't think that any
> >     other governor would then manage to rely on the inefficient OPPs. (also I
> >     believe Peter had a plan to keep schedutil as the one and only governor)
> 
> Right, that EM is only there for schedutil.
> 
> I would encourage if this can be done even without the EM dependency, if
> possible. It would be a good thing to do generally for any driver that wants to
> do that.

Another benefit of course is that we will have less work to do in the hotpath,
it was obvious, but I thought of stating it anyway :)

-- 
viresh
