Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD95432AB4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836569AbhCBUUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446568AbhCBRaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:30:05 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E6C06121E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:53:55 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id f33so20585660otf.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F7NOrHOLrccy/SQYMTkigwceK69ASy8V14Aa+3j99bQ=;
        b=HaGDtAiGBkHeEySoib/HgAjObyaLvIEO+kyFZlxNnfM6m0FBX22R0B9bn4t0of4Xpu
         M6akWjJXtNhTuq3H3Jxtubj2nkG+d2BoYJL1N7Nzd9pZxj2r3VDBXdRqXf9YTSJ0LFmm
         amxrP2tLQH7iFCvGPSwuXS5PGpc2sug7Tb/wtelrn3b4WND32n4MCYhFmbwQUg3tTmeJ
         3eWCIhXJ19+7kSVVuMrU0zZVeruzc/XRz7OJFHNj2bPByAmoa6RhPMZjCJ2t385vbk01
         G9oq1HHzIW+qu853DujxiVTv0/dY/2bB1lhRU/d9Dfjbj3lUerqLE57aJMBTXuV9LUTW
         AScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F7NOrHOLrccy/SQYMTkigwceK69ASy8V14Aa+3j99bQ=;
        b=luNoMQHqusuC0wos15+YlxtI/J8wLjpoBQ9/ET0dYUmsdHto2rym5PIQL3Dt0w9PC2
         lzw8Q8BsvY/qktfgyhWmdhxKV2Nr2cn0u+ZW0feLOcfxka922MGMz1ws2g9CywG2E2Uw
         LIYt2CxPM+BVyVvLRoSHU9p6NWQkd3DZoElJrUtaS1qt1qX4k5GUna1ZzKiIB4+HmNW+
         wCxZ2aataV4RtKSZB5jThWf1200mneJLxVO01BNzr0VcDXVzf+ylj68o+xt0tULcrWcx
         79bxmwu360yyZbLIW7O8pbKHRhQXtZ25p0FIKaEr2zSsdGNS8xSZe62BKCzWgitGTcey
         oYzg==
X-Gm-Message-State: AOAM530Z3TKGx2cyViHvvmh6myQSkfqW46m0aaBMeEddMKjoSPOiSSyo
        brp2eAB4w51SeI4YDUT7TBIs9w==
X-Google-Smtp-Source: ABdhPJwanh1Ukx8/FCiG0K/XEaIcouQScmaD5Vtqgr/fJqX/Fp9weERJKzABkE6PIyLpg39iwlbRag==
X-Received: by 2002:a05:6830:1682:: with SMTP id k2mr18829829otr.154.1614704034746;
        Tue, 02 Mar 2021 08:53:54 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g3sm4032647ooi.28.2021.03.02.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 08:53:54 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:53:52 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kbuild@lists.01.org, kbuild test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set()
 error: uninitialized symbol 'strength'.
Message-ID: <YD5toMl9VehxrIaU@builder.lan>
References: <20210227092152.GC2087@kadam>
 <CACRpkdbWtBA-ptCF7prizoP1D9cshWgpt8r4CGRRfxwcXiX61g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbWtBA-ptCF7prizoP1D9cshWgpt8r4CGRRfxwcXiX61g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02 Mar 09:47 CST 2021, Linus Walleij wrote:

> On Sat, Feb 27, 2021 at 10:22 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > New smatch warnings:
> > drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:458 lpi_config_set() error: uninitialized symbol 'strength'.
> >
> > Old smatch warnings:
> > drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:457 lpi_config_set() error: uninitialized symbol 'pullup'.
> 
> I don't think these are real problems, but maybe there is some way to explicitly
> express that so that smatch knows as well?
> 

Perhaps I'm reading it wrong, but wouldn't a state that doesn't specify
drive-strength or bias cause these properties to be written out as some
undefined/uninitialized value? (I.e. isn't the report correct?)

Regards,
Bjorn
