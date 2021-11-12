Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0328844EF06
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhKLWIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhKLWIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:08:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB2C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:05:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n26so4983252pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uXsV0Y7/ouKh8DE96udNFYUZH1O8QGKdmM3wivH7yE=;
        b=NmrI848FlHK8ykeU/eFhvy4SnWkaLfDcatW234qleUJ+6uHz43F3SAAY0OhVKwFI0p
         83f+Q50rXxQ1iGMZRdEnMSQUcBgJruRvxJxPUkGf5mjr4ON0ElN6sDhudgjfzgdnrxYR
         ke7UgLZpYimsYlNnHm7CshPV02Z3myWkAXfXgrmz693IuDkofJ8sn8h1h3sfC1khBLPm
         drGF9iWORaq08I2Vk5F+MuNR0yqv1nFZnCWY81bjTqvNnNXnm6MUTpbR3n8/V4+XsP0S
         odS9px+X57297sIoRPDjRKbKmxwvKi9rtlc2RYs4NSdkva125vmhk9EjIFy71hXn0xg5
         1jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uXsV0Y7/ouKh8DE96udNFYUZH1O8QGKdmM3wivH7yE=;
        b=iG3/AYGjP5Hlo7fGZ9wE0r+9xOoCF1aSbufPe+NyuO+XKKxPXCYQmT5AZpt1fvc7WJ
         lY7QSiRC5hhwYCaTenANr3TB9+86MG1ClyHZroytdZMfeD+2DZCIqWPHRBH0oeEhZuSn
         fEVrmYk4jQTsVtPGf+qrQ2uMGVVMAKbxlWd3glQAhowwwnNIYh6yhid5XWBFb6yyI1X1
         XC9RFtNOQ7UOxCYoRFZ1IYqKrKC83VrND1Ma+gtgWaCUQlzz8csg6L2AAkRBtZigIM3Y
         NYqTMfI37Bt89as/UWKyB3ZC+x9qIKjYc3XNn/++dMu9tbr9CfDGBE2Do4qnpS4UF0YW
         pADg==
X-Gm-Message-State: AOAM532CyNGBdSkJDsFJpwFL/wax0yyVVeUmOBvTbrEA49t5rQAARCYf
        TGEXZjm9iUX9ei89USUl26fA0A==
X-Google-Smtp-Source: ABdhPJxK04S8K2uqYWZRYq0qdlRC8CknexufW/8ci5fywSi9cBB3FXBVdzZd6GER81lwnv33h3+iQg==
X-Received: by 2002:a63:4618:: with SMTP id t24mr11992696pga.430.1636754728264;
        Fri, 12 Nov 2021 14:05:28 -0800 (PST)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id f130sm7460976pfa.81.2021.11.12.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:05:28 -0800 (PST)
Date:   Fri, 12 Nov 2021 14:05:25 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: sched: sch_netem: Refactor code in 4-state loss
 generator
Message-ID: <20211112140525.056a215b@hermes.local>
In-Reply-To: <20211112213647.18062-1-harshit.m.mogalapalli@oracle.com>
References: <20211112213647.18062-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 13:36:47 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Fixed comments to match description with variable names and
> refactored code to match the convention as per [1].
> 
> To match the convention mapping is done as follows:
> State 3 - LOST_IN_BURST_PERIOD
> State 4 - LOST_IN_GAP_PERIOD
> 
> [1] S. Salsano, F. Ludovici, A. Ordine, "Definition of a general
> and intuitive loss model for packet networks and its implementation
> in the Netem module in the Linux kernel"
> 
> Fixes: a6e2fe17eba4 ("sch_netem: replace magic numbers with enumerate")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
