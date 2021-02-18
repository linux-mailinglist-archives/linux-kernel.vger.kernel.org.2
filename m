Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C131E76B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhBRI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhBRHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:25:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE95C061786
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 23:23:50 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z21so615979pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 23:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZ+7cyfIAMa4qybTYJPAFZXKgOwCxm2f1fhL0vcgILs=;
        b=zcxNV4rPUkqxVIFX2+P/FTys8pW1F4mnkWDnGADI+Q7Tis+cADSwa1UOZtgCkKASKK
         CYUn3vaV+t9ey7m29lQ3IsB4A2DAdIigVTKb/iVwLZMZDwyUODjXXkJ9ngm5ghs0xY3n
         Hrn6M0brC/CxGhMw2J0+tgnSCG5rnMjHKzNATniq1eeXwPesUP/8JtoE32bg/LdispEY
         xIB2ie6BKy+aU0LybOt91BZEbGixq1SJzyb/IlT19r5lwNzSyMuQf+pLZU/1pwiHrGmG
         TcgUZJDI0mtF5mBwvpwn1odWmGjrHEKJfYH30+8NhGkcBk8E0lpePdk6+gKwUOPX6IND
         QVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZ+7cyfIAMa4qybTYJPAFZXKgOwCxm2f1fhL0vcgILs=;
        b=VFLTACF5Jz3Gde4W75VqYAVXENsIizsUrtIU7gTGjCr7UsPDFmZ9JcJbUk7hyiEtqL
         p8I8YGiVTMu2c16B4vzbdhMHI0BCVyC6QLLPcN7dhqRjRPD+/ZYGlSjseQej/VsHq/pC
         OQyHEt/stkwQDsQNrzmvJaTybF48lAzjL97jlTqEfOaetJW3l9Deb5HihY+5fZLUE/z0
         j6Ow2rGJJd3GL/TBDDJRxlQ6hClcU3FkDCCsKM3yRTtYY3mT/8APvHF/aYxhZORudIJ0
         emAvjVUvWg5Q4FYVCFz7DzlpQpXswG2mZphvRXlotSysdIX3sHsyTn+pLIKeflgXNzAp
         jOCQ==
X-Gm-Message-State: AOAM532AwVcXTEUpAQrOrvRK8l9gtw97uJIwNytghYVNFptNOmBUO2eI
        6UJOWtuwWvQwPyad058OGNHuxQ==
X-Google-Smtp-Source: ABdhPJyay5kfbTBaholo6asX0wF7iLAKXd37i762FtCcYsP3JZWMTcmGy+pyGz15MHaOgt+sI+Tj4Q==
X-Received: by 2002:a63:1519:: with SMTP id v25mr2932024pgl.217.1613633029702;
        Wed, 17 Feb 2021 23:23:49 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u10sm4580386pjr.27.2021.02.17.23.23.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 23:23:49 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:53:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210218072346.5lvymba35ezuz2do@vireshk-i7>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210217042558.o4anjdkayzgqny55@vireshk-i7>
 <20210217113011.GA22176@arm.com>
 <20210217114027.ashqh67hrfk4hwib@vireshk-i7>
 <20210217115726.GA25441@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217115726.GA25441@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-02-21, 11:57, Ionela Voinescu wrote:
> See a very useful comment someone added recently :) :
> 
> """
> +	/*
> +	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> +	 * counters don't have any dependency on cpufreq driver once we have
> +	 * initialized AMU support and enabled invariance. The AMU counters will
> +	 * keep on working just fine in the absence of the cpufreq driver, and
> +	 * for the CPUs for which there are no counters available, the last set
> +	 * value of freq_scale will remain valid as that is the frequency those
> +	 * CPUs are running at.
> +	 */
> """

Lol... 

-- 
viresh
