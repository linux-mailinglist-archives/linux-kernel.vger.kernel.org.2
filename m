Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92A40F0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbhIQERO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhIQERM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:17:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 21:15:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso9081369pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 21:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3pM82lKhcRQsMVV6MoQXfkNClfKp21+M4pP/AUo3W4=;
        b=LHMLK26oug1Usz19GuM2xJjQqxdPp3YRqKl2SQhmBk4AW6GfgPoEJThfoBjbB0KnIA
         Ozd4mmKPqxeZntPcynRCWj/5SJV0YdZ+Ka7UVJYIfJsYxyZzwp47OJDlAZ+bKOOh5FQ3
         MKey6HfX59bw5YOwSyoK2ap7pdjePsMPA4D+a+M4KgskmMzbqbRa2G+CGW2m+kIKCqiL
         UiPFrxZGFOFSibgKOUnC1jlKtTxToVoY62SsFFG8vQKZBDF2dEJrVEmoR6W16kXLB9V+
         pypbLrcJleVRLtBS1tB5qUZr3J7UZhO5GwGDGqQIzUQZNj1IlqZMI/ciVLpHw1RBCSQS
         /zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3pM82lKhcRQsMVV6MoQXfkNClfKp21+M4pP/AUo3W4=;
        b=nYi4H7xPKAaR8mP47ZA6hct+b5YQhNoybmqP2JyWNklXvCGxRDFBPfH/uBVzJa2wJm
         u9sNGBbBPinSVVb/MBG7LGfZRBiYpGD0VvYxoywpY51/B4VAt02nK/M4OpNBzTvGzIe0
         LertldFE2eQCrkK+p84XmvGRPkEYHRUB79i2TcoQ6CEET/3PDmWopx+4pmRyPn0oq9OF
         Nax5sXl6te44ewBL9OQLKyknx/PoRGSzALGW76Q8p6kXYmDC/nTSeLGsP4USmmI8YO/R
         v0bPe4t5Nh9UBO5GVww7/g399AOoP6EfuoMWq4XVbVaz/iJlWATIO3KN/jNYR79AaHKv
         QHVg==
X-Gm-Message-State: AOAM532fkUthQkF6pJKm3gk0A1sT2xMZmkgMpOVvYT3BZr7PI2vJiQWE
        cZqIC3c8ooWPxZyMASHiZ0Ey/zWIXlM=
X-Google-Smtp-Source: ABdhPJxTMg7xPXxIy3OQ9m0qm9zPddjKggnDfyKe6tcgRtuy9+CePLq0oXPcbSoJtc1Fz0uX1qPNhA==
X-Received: by 2002:a17:90b:180f:: with SMTP id lw15mr6531828pjb.210.1631852151004;
        Thu, 16 Sep 2021 21:15:51 -0700 (PDT)
Received: from baohua-VirtualBox.localdomain (203-173-222-16.dialup.ihug.co.nz. [203.173.222.16])
        by smtp.gmail.com with ESMTPSA id 141sm4597397pgg.16.2021.09.16.21.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:15:50 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     aubrey.li@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, peterz@infradead.org, song.bao.hua@hisilicon.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        yangyicong@huawei.com
Subject: Re: [PATCH 8/9] sched/fair: select idle cpu from idle cpumask for task wakeup
Date:   Fri, 17 Sep 2021 12:15:39 +0800
Message-Id: <20210917041539.7862-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <125eb98a-241b-078f-1844-b0521425ed1e@linux.intel.com>
References: <125eb98a-241b-078f-1844-b0521425ed1e@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -4965,6 +4965,7 @@ void scheduler_tick(void)
>
>  #ifdef CONFIG_SMP
> 	rq->idle_balance = idle_cpu(cpu);
> +	update_idle_cpumask(cpu, rq->idle_balance);
>  	trigger_load_balance(rq);
>  #endif
> }

might be stupid, a question bothering yicong and me is that why don't we
choose to update_idle_cpumask() while idle task exits and switches to a
normal task?
for example, before tick comes, cpu has exited from idle, but we are only
able to update it in tick. this makes idle_cpus_span inaccurate, thus we
will scan cpu which isn't actually idle in select_idle_sibling.
is it because of the huge update overhead?

Thanks
barry
