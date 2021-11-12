Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5095B44EB23
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhKLQPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhKLQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:15:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B01C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:12:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o14so8777476plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m4WCCMspvNjRC6nIdqnK16n30l59WOu2CFv/bRu8y5Q=;
        b=WIvkFVYEyw+TQvLA0ThdqO8Zk0FL6osNVX6HzbvQtSi8gFYQbbhIelBsV34M4Qb5Iv
         1IXTxMwjK8UyilhCEE3L+Y0M7RmkXCYh7Z78mshOi6sfTxWS4WF8UdqCbowLoItDI1HR
         LY+P65AAXV8r/6tBGN+rDpYSmjo+bWiUWSX6bQmHNE+I4Ueoox58QA4hxsJVTv6Q4cYS
         15JbXGMQRt7ucqMMGyiXHEwsCIew1XBsYFr08B6YSO71rKv+KYj8kuXQFxzMehUiF+T4
         DtFboXIRBwOnHZd5wMQ/ADRrD2IgWDzyiocE4j3Xud0dfN8ofvjxpsHh5atZZFd/AD2b
         stzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4WCCMspvNjRC6nIdqnK16n30l59WOu2CFv/bRu8y5Q=;
        b=VrBLFK2VG/jEXhZjwyOaQ1EaaCF2WeDglU2rBdJP0AKlmtmhyXwgjBgKts9dxmIcTs
         a+AKCnOITjrVpeLKDLVwisjWMu/7PXbxYAln/OG4M23ADrMrEcaJTZ30YcLBYvM3SlPr
         qr+JwB9MJd//9jRJ5LTib0Lrb7Ufm7yBxblVsfs48ThbddEozaEoLErn7o9bw1Gf+0UL
         HWb0vVhkPW7gkTFyMVhTBVTEJynVpTzsDxdqlBqUG6ViUJxVjs2LzQV9CeDGvomNoh5A
         LKu2hHWJH+S6nB5dynBUdZXAZKdQW2aCgv5Lv8uQ3hdLkXN3aUtKefnWJ6y6iL9W9VOh
         C5lw==
X-Gm-Message-State: AOAM532TwZV4uduimq0KtBsedBeQV3IB+YSAZUBZ7t83SHX3VFnCeZb4
        ye/9tJ082G+161750GMB3C36xw==
X-Google-Smtp-Source: ABdhPJxf041ftoF/r8/MJkRNKMTG0NiyyumPAZFwNXFQdD4qr3LnrxtigCCy6PFDWgghbzLJ8DuU3Q==
X-Received: by 2002:a17:902:a50f:b0:143:7dec:567 with SMTP id s15-20020a170902a50f00b001437dec0567mr9198234plq.18.1636733567298;
        Fri, 12 Nov 2021 08:12:47 -0800 (PST)
Received: from hermes.local (204-195-33-123.wavecable.com. [204.195.33.123])
        by smtp.gmail.com with ESMTPSA id v10sm7203472pfg.162.2021.11.12.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:12:47 -0800 (PST)
Date:   Fri, 12 Nov 2021 08:12:44 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangyingliang@huawei.com
Subject: Re: [PATCH] net: sched: sch_netem: Refactor code in 4-state loss
 generator
Message-ID: <20211112081244.52218572@hermes.local>
In-Reply-To: <20211112071447.19498-1-harshit.m.mogalapalli@oracle.com>
References: <20211112071447.19498-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 23:14:47 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Fixed comments to match description with variable names and
> refactored code to match the convention as per [1].
> [1] S. Salsano, F. Ludovici, A. Ordine, "Definition of a general
> and intuitive loss model for packet networks and its implementation
> in the Netem module in the Linux kernel"
> 
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

I wonder if this was changed accidently by this commit
Commit: a6e2fe17eba4 ("sch_netem: replace magic numbers with enumerate")
 
