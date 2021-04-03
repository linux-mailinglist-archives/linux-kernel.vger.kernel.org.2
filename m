Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E51353589
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 23:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbhDCU7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbhDCU7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 16:59:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F255C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 13:59:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g15so5749478pfq.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ug4RNUgPDcbcE3oz3gs7T+fbf7KQAB3B+nCiN7jbxM=;
        b=t96I2XWbnEmcTlGcQ4qzcCUdR/Q3GlkikJRPoTd7w9dRozTXsymRuViM7JEwMHPmCH
         3IgYgTySlFdDSTLgsG/BIJpJOvZDhiMsQet3p9FaN2Ldnz5rGL91RAXwLbRrr9S2/59H
         +ekk44rO1NWg83yQBKglAs144dlKRcA5pWbZW5CBQdiOWRxIiLxB3g58iLMDGSrHSaTi
         4LJ3ixQ/G5PMW7H01MpKMkwr8Kz5O/nbvOp5CftKCRRRTDYLrcYVKNU2OAiFxhK2i8j2
         Qcpja6qM1imvd29cwiZ7dhlHyv6iC4YOPxZwkXgXiP2uxyHltGkKXV6GfHY6Ywi6WR0H
         yhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ug4RNUgPDcbcE3oz3gs7T+fbf7KQAB3B+nCiN7jbxM=;
        b=pL4Nk6wHpm5f5PiciEJjR6c+la/tIQDLad3+TMXKLZ8XbOYmwK0L1oklgjXwg3K/dk
         mGH+U9wfOV4EyTGlkFpDv32ROJM5SUWTaGVEaLTsfArT/vxJVoG3cWqUAEnnMd+RU+gV
         jo3V0XXIlPyM9hSnk+0ZwBmvOD17ubBNLFx/uSt65ei+4rlZjVOVpaq7pG3huER4mb9Z
         ubl6DnEq79xK9ttX/JKgky5zgvmI/TPiniSlvLrlcYI0XAf5rgJl0aq/YHSq/aC5NTFb
         8aJC/9ssc6IwYhl9C3XbW+Jky6VGqSNEAgHV18SqaT0SdNw/Q1S5BEKuKbzayuJ1TLvA
         KNmQ==
X-Gm-Message-State: AOAM531MyqVXbn4Ls3NmYHJoqLqGMOyQSAwBRN6RosiqiJm0NNsz2ZqP
        YmVVU6l5EhE49DP8zIlbH1teH1m16zc=
X-Google-Smtp-Source: ABdhPJz1Dd6oSN1Y4ti+WAYc/kbafzcBix5EVESk5Hf0Xepyrs4R1hVv6yG1LSVnXFXE2XVH19aRYA==
X-Received: by 2002:a05:6a00:170c:b029:225:8851:5b3c with SMTP id h12-20020a056a00170cb029022588515b3cmr17614787pfc.0.1617483579161;
        Sat, 03 Apr 2021 13:59:39 -0700 (PDT)
Received: from localhost (g139.124-45-193.ppp.wakwak.ne.jp. [124.45.193.139])
        by smtp.gmail.com with ESMTPSA id t1sm1926025pjo.45.2021.04.03.13.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 13:59:38 -0700 (PDT)
Date:   Sun, 4 Apr 2021 05:59:36 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: litex: Remove duplicated header file inclusion
Message-ID: <20210403205936.GB3288043@lianli.shorne-pla.net>
References: <20210331130643.2691994-1-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331130643.2691994-1-mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 03:06:43PM +0200, Mateusz Holenko wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> The header file <linux/errno.h> is already included above and can be
> removed here.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>

Thanks, I have staged this.

-Stafford
