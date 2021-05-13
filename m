Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDCA37F7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhEMMPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhEMMOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:14:43 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:13:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i13so778219edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mWa4cuYWdnztuy24dOOTWOUUVMnygod3WyEh9Qf00zU=;
        b=We+LLYKoGiersTt6WqDPrcSK51Lc6MXgFTbkzGhFN/ocD0ZXIOw+P17DyD3q67ui5T
         tqdkSL1/4jjpJArLE4IZ2Oiyx38YYDZd6h1TaDRuqQWCIXYTVLF7AItVBf1albiE7K7D
         oz+uPCG/JMHz4d9/Is7IPo68AvO7xNtdc5GkTEA3w/fUAjrTSIDocapiUEIL2Mq+nM1C
         FPPHmdmJoq0fbgPBswCzn44B/OSfkovhqHJ4bSJkYF/XDCZqjBK7c+piSr1G2UGEcJu/
         dNmdVOg8ItSd2UdZoE7CGn9Z46gb+xu8lEg6H+943QRn5afJPphnDj6jQa8JClOD+a9W
         eRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mWa4cuYWdnztuy24dOOTWOUUVMnygod3WyEh9Qf00zU=;
        b=rkUUu72au98pPdq9250KL/dAHV4bj0axglA85DA23mmuqp8iZZNy4ZkNZdm9QB6K5t
         BSBnRU8v3ZvdJPipYr9muO//h2JMOuH4uFnQnEfwkF/1kn+SUbnBjSb0DXGUlXBZgpIZ
         +oP1TG2jtKt0lLN/s+rBfa5ikUsQvoXOpBhm5TLF3KSo7YuPdyB2WuMQmz/ZxWWxDt6+
         IsQBrdcUXqIRgaV9acvF/dwIxxy3u0F+Vs3CgNb3osPEDhmZXKgprlUmiANeIbb9TIVh
         Z+Yd35/pP8VrmiDCRYwJZo/q+4A0YydTmplsWKpNV0SuEaDM/eA7oE64Rw4aUBYHFFZP
         Pi/w==
X-Gm-Message-State: AOAM530Y8O+1auOJtfJ9Go3ma8Z5K5ikc5PdotuRUWTkCJXoegpdXfTx
        fPWoj8WmlF5IzmAcFSP+iTg=
X-Google-Smtp-Source: ABdhPJxAXb2XVYGGSJAAHk6LSo55xCB6vcCI08ADzgATBULwVJ1JBo2q18zAC2ct+yBtfSsyJPBzdA==
X-Received: by 2002:aa7:cd0c:: with SMTP id b12mr49659263edw.236.1620908010610;
        Thu, 13 May 2021 05:13:30 -0700 (PDT)
Received: from gmail.com (0526E777.dsl.pool.telekom.hu. [5.38.231.119])
        by smtp.gmail.com with ESMTPSA id bn5sm1728174ejb.97.2021.05.13.05.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:13:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 13 May 2021 14:13:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched/isolation: reconcile rcu_nocbs= and nohz_full=
Message-ID: <YJ0X6MciAc36TMJc@gmail.com>
References: <20210419042659.1134916-1-paul.gortmaker@windriver.com>
 <20210422212448.GJ975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422212448.GJ975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> On Mon, Apr 19, 2021 at 12:26:59AM -0400, Paul Gortmaker wrote:
> > We have a mismatch between RCU and isolation -- in relation to what is
> > considered the maximum valid CPU number.
> > 
> > This matters because nohz_full= and rcu_nocbs= are joined at the hip; in
> > fact the former will enforce the latter.  So we don't want a CPU mask to
> > be valid for one and denied for the other.
> > 
> > The difference 1st appeared as of v4.15; further details are below.
> 
> I pulled this into -rcu for testing and further review.
> 
> If it should instead go through some other tree:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Thanks - added this fix to tip:sched/core.

Thanks,

	Ingo
