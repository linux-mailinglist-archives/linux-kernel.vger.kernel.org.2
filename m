Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29C03B139A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 08:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFWGEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 02:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFWGD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:03:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 23:01:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so3227372pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0eD2NKzR92krNnSCAEqt3EN7AElb1rlw5uXmc6X1m0I=;
        b=m8KQZw6Ur1ZiTHKJ/vEdrdcpgTcd39VYmDcf9nHZVdCmN5oh5mXieYh2xJMKVyzF8B
         6RmHjE+UgMakMuNUE4/0BDh9kz3JMP0am2MFxfi3dDK2MOftOig/MyT31BM4Ji3WpmhM
         QY4Mfjmq1iubygVVb/KNSroMQPQDavBkVmLiw0/XMAjQnFRCVIKqbtFX6JacQo4Tss6m
         YWhubLF7358Jz2ZO6q5lcP/llnus3BrZgge/0UFQ2HW68GZfrphwMyl+16pl1Wv+yiu5
         6+TDJMhhKJO/7snEu8w3R9ISBR496y9OLfWO+682RmQipNOrUjD2RdILXbq39SR1pina
         grOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0eD2NKzR92krNnSCAEqt3EN7AElb1rlw5uXmc6X1m0I=;
        b=PhxJiffD4mG/pIijmlubrKpQ07Q8lJzbn2CH6YeDzBf7tEhqtiQ90y4SzA7Nc6SW+2
         7r/H3QT3H3EtGwtPjloFRjoZdFdqUH42NTB6g9X8ONjKUVJMoWxvKdiBTrQ+58DstuQs
         w1bVZXVOuXyF7VxFukFn7J+LEKy0t84pEYl3m4DZjz8vs4eGmRkUDi/9UWcRkLaAjrda
         U3cENWnwDiP1bz1jICGIiwSccw5O3UCNyRRk7DOpHcyX5sPt7mA8yRbY+9pB33w5Dpd5
         GqJ64C9WfOtGAk2eWPPfp4SipXgF6aYdkj5xB+VZlVn3W8J3iP2b2XfcTmxaJefiMl8W
         hLNA==
X-Gm-Message-State: AOAM532vnlwYI8JYJEoZGppaaG9LbDNTr1x8m5v1tx7/ppDQbDhSuZ/0
        8w50DHAIIhb3PZq79oRbnAeWsw==
X-Google-Smtp-Source: ABdhPJzgZD7Ut0KQSWuTsx2q+526QSQy+cqtMp4zyuBW2ebISqTBxiJGMb+5BE0Iagm05/cmP38YvA==
X-Received: by 2002:a17:90a:17e7:: with SMTP id q94mr7708393pja.117.1624428102352;
        Tue, 22 Jun 2021 23:01:42 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id g18sm1063642pfi.199.2021.06.22.23.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 23:01:41 -0700 (PDT)
Date:   Wed, 23 Jun 2021 11:31:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback
 instead of ->stop_cpu()
Message-ID: <20210623060140.2mtivaxuiemgg7ug@vireshk-i7>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
 <e40e57a97735614941e9ca7fa2f221f8db9a12b2.1624421816.git.viresh.kumar@linaro.org>
 <87v96516d9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96516d9.fsf@mpe.ellerman.id.au>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-21, 15:45, Michael Ellerman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> >
> > Subject: Re: [PATCH V4 3/4] cpufreq: powerenv: Migrate to ->exit() callback instead of ->stop_cpu()
> 
> Typo in subject should be "powernv".

Thanks for noticing it :)

-- 
viresh
