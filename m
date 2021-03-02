Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3E32A251
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837148AbhCBHey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349316AbhCBHQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:16:25 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD93C061794;
        Mon,  1 Mar 2021 23:14:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so14701832edx.1;
        Mon, 01 Mar 2021 23:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vwbv3+RIeGnp+Qm+N740tpu/JEP5WHksMGMUdFIRhJc=;
        b=jUKP8s1sarYU4xlbJaaZ00DQEEQvcYj+Om1m+33Zs5h8rSl5Y7bKYs11hGCIDMIO3C
         Y66hFgY0HkmLgQxKU8Jq8UbjWkJMYCvq44rL4RoefWc5O2ZZq1RhCiHyhNG3Cm9rF0UB
         M3tzoV8rvGAPlC2dqtGYVpFsssQCTrpmR5hWU5BGlKvxspl+1T0N0uAwMTqDpac8rOdl
         ypc9SBjqLmXcacNE4ExiPFjdPXRsfOX97t3IUj87ST36sAqTyEOEY8OPdOy7HlrQusst
         F9jrflEaRQF0ICYotrVTfWQnfftsBAxYRP9WgOG2KLk15tPBuKCKLb31L4kWuIZv83Oq
         gNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=Vwbv3+RIeGnp+Qm+N740tpu/JEP5WHksMGMUdFIRhJc=;
        b=PFlMSpfJVWeEiczdnB5heD3l9iUcOio8TQQqH4RiUH1pEuC6rHeVBMpC5vOwhiKaUG
         skC+C3A2JdnTEFiHYnYruynvUaPwEEmJu66IvUCfq5xAKLcbTgPnh4s9NJqINi/zrW35
         ehCGpKy2be8MjXN8h1ZkEZ7VojyAajCCjC/kPLPHHkzfzEiZT5jyI8bF4ZlPfIqerInB
         ZzTck0AK+cnlp+MSO2tRA74umrfZi9bTpho/SMMQ+67qz/4W61hoAwBTe37jwzonhQCX
         2C1FL+dIukzMcR5N0Xlt2Kfcsd9FttZSSW+RE5Sg8K8cYrx0qIA93c1IpXO+4t1P7uW4
         cRXA==
X-Gm-Message-State: AOAM533rTJLu0N4mwoz4voFCtXTejNPty9x0WctoOEDfBFRZWxyqivAw
        NAk4IYRxBrsTu612erSqSlQ=
X-Google-Smtp-Source: ABdhPJwdfu1EOMlB2kYFyjgDmJH0n2894BrgXz6mft2zGdaNW4xunkGTWnubQit28Wf0La17ye3A2w==
X-Received: by 2002:aa7:ce8a:: with SMTP id y10mr10613979edv.66.1614669245354;
        Mon, 01 Mar 2021 23:14:05 -0800 (PST)
Received: from gmail.com (20014C4E1C864000F9B8756A94F10216.dsl.pool.telekom.hu. [2001:4c4e:1c86:4000:f9b8:756a:94f1:216])
        by smtp.gmail.com with ESMTPSA id y12sm10708502ejb.104.2021.03.01.23.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 23:14:03 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Mar 2021 08:14:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@kernel.org, mhocko@suse.com,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <20210302071401.GA2257965@gmail.com>
References: <20210301101336.7797-1-jgross@suse.com>
 <20210301101336.7797-4-jgross@suse.com>
 <YD0fTLnQTQ7/M7fx@hirez.programming.kicks-ass.net>
 <c7c1eeb5-21b3-339b-4b25-a6c8df820146@suse.com>
 <YD1SJNDeGcNOO00s@hirez.programming.kicks-ass.net>
 <20210302070559.GB2809110@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302070559.GB2809110@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Mar 01, 2021 at 08:16:12PM +0100, Jürgen Groß wrote:
> > > >    https://lkml.kernel.org/r/20210220231712.2475218-2-namit@vmware.com
> > > 
> > > They are already in tip locking/core (Ingo applied them).
> > 
> > I'm very tempted to undo that :-(
> 
> Sorry about that - I'm sorting out the conflicts with the concurrent TLB 
> flush series.

I've resolved them in:

  8dbac5da2796: ("Merge branch 'locking/core' into x86/mm, to resolve conflicts")

Will push it out after a bit of testing.

Thanks,

	Ingo
