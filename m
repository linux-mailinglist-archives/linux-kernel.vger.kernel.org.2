Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031B5332243
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCIJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCIJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:43:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97617C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 01:43:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e10so14424737wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 01:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UK9zC5QVIhBwcaQtLtSSOCV/46q0x44C7QG7fffNjNM=;
        b=yaf9AlfTQIgwy+WeGQr8t+Iv1qO91Pe6WHKyT0Wj0ddnyFD6Sdj6dtbUqPhQDwwVqm
         yEZcvRp07OnHIZLMHVloMHcynESz8kqygKCa2RoTSlHE0Czwhyqpr98JQXu5RSJCMSpZ
         bK4DoOXlS/r9Zew3poT/NNOjVxDxy+kK3qC/keG0t0EGqjSPzCmqf9A40put0/je6+Dh
         387u3ER4GeUcB5niHwM8QznVPj2Im1DQ/nJw8DintJQPNVqZ3s+kkBp7oZcfLa9V812u
         TFQpHFwptXLLFyAdSeH0CwwUBgDa65Uyv/tFYsihQcPptGDxBDsO5IAaC9eWiU44YsuW
         fzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UK9zC5QVIhBwcaQtLtSSOCV/46q0x44C7QG7fffNjNM=;
        b=nbsOJrY6FBjqf2evL4sOuql7aeS2b7KnEm7oNKVjJzH1Sx5EI51c+60v2IJTKHCf8W
         daC+inhI3meXfb1fu01oVIZbWUS7QcwWXYtysiFJog1VZeH/8GCCUaEiYJ3pk8AZliep
         oiKUCQguisKwSkgWonRbylpTU27a4mEZwxWxhf6f82SQMgOR1dt7t6+tQp70xkHI8+vy
         9nSp1PfSX98Fli6LTb/4jVw/qBWub0sgbTzDPcom6K/IGIgL6+oKxaTYMcIf5NSNgZaw
         6OUZIEvvK8ItN/VSnxMftIrhyK635llgCvZuKbdtJxi7gIPxMAkwIejlyQuHtKpeSRyu
         mpkw==
X-Gm-Message-State: AOAM5333kE2NhvRjrleuZ9654GxfREEQC6k2dF0ZfFcUAWPvv20382Is
        usx4zaHds2oqojxYgzQcNyXwwIf6PfvhYw==
X-Google-Smtp-Source: ABdhPJztpLDF3SE5LQyvfg9jA7Y7eLxc5d5mD9ud/Ik7uADaxtyVZVkB62HF9pu3p4zV8OXGggnp0Q==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr27459033wrr.104.1615282993361;
        Tue, 09 Mar 2021 01:43:13 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id i4sm2968243wmq.12.2021.03.09.01.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 01:43:12 -0800 (PST)
Date:   Tue, 9 Mar 2021 09:43:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Message-ID: <20210309094310.GO4931@dell>
References: <20210115015050.26657-1-meng.li@windriver.com>
 <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <36cc2d810d90237947ad953ebd6b9fb7@kernel.org>
 <20210222092114.GE376568@dell>
 <CO1PR11MB48499549EB56C7EE119E175DF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CO1PR11MB48499549EB56C7EE119E175DF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021, Li, Meng wrote:
> > -----Original Message-----
> > From: Lee Jones <lee.jones@linaro.org>
> > Sent: Monday, February 22, 2021 5:21 PM
> > To: Marc Zyngier <maz@kernel.org>
> > Cc: Li, Meng <Meng.Li@windriver.com>; linux-kernel@vger.kernel.org;
> > arnd@arndb.de; Hao, Kexin <Kexin.Hao@windriver.com>
> > Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
> > regmap_config"
> > 
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Mon, 22 Feb 2021, Marc Zyngier wrote:
> > 
> > > Hi Limeng,
> > >
> > > On 2021-02-22 03:45, Li, Meng wrote:
> > > > Hi Marc&Lee,
> > > >
> > > > Is there any comment on this patch?
> > > > Could you please help to review this patch so that I can improve it
> > > > if it still has weakness?
> > >
> > > If you are confident that the root issue has been fixed, no objection
> > > from me, but I'm not in a position to test it at the moment (the board
> > > I found the problem on is in a bit of a state).
> > 
> > I'm not keen on flip-flopping this patch in and out of the kernel.
> > Someone really needs to spend some time to map out the full life-cycle and
> > propose a (possibly cross-subsystem) solution.
> > 
> Thanks for all of your comments.

Have you looked into this further at all?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
