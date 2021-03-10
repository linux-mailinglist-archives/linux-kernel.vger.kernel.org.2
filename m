Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081D9333752
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhCJIcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhCJIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:31:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69527C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 00:31:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id w7so6445257wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 00:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sj8e5MiwjfbaNO1hl9TtGhsrboFs9HRB7VfyvIwePCc=;
        b=nU/IKuSFzdwd+QmYYXkZZ+vN81pfA34gPWij+EI8KMXiGbxpisdi7TY/wjTX+oAe7z
         XVZFV0xmSjVfcnng+k1eQ37DGyGkkldAiAmePRD4epCryl1wmRBBC3LMWce6VF42Yx7U
         t4YHlyJSvf073ot4niqgaCHzTg79l41JrTzF0/lhOJUsj4b7iXNI24if9ozVUcsLhoP8
         esiTbeOo13WHxwlpAbHPwXMcIugiiUhD05T4MKw+UP3vR3NDjtDx5LNhH8UZqcYeCynA
         9mSxpTZb52CUB4fVI9uxE6eKzjYHf0XjbJJbOjYYum/pEPjZjgwkLphjum3G55UB54OD
         A6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sj8e5MiwjfbaNO1hl9TtGhsrboFs9HRB7VfyvIwePCc=;
        b=GzNcnYqhkrhwyXx6YyPfOimlTV8tLVPdw7IDt+FhKXQCNJctBsdRMzwUU6I63Mn0Nk
         C6qQgzG4ElEoNMsC/HYKBbZPkiWKnw8kEsUoXhf9ESWn1rf+9vGYm3Zh3RkspJ0UMQZJ
         +iOgN8qqEKk37KqLqZoxwMJZQLjuFCVCMbY4l6UKx4AHYouMu/yqzfb2Ceu3m/1Mq4HX
         ry9R0xATZVLjoteo1oJsGsTANHOYNj3mq5ebJOj6AFSDAmzfNOSMQ82Jz0CufF/zhvbb
         eUYBPm6yB8SKEoTx+iNXIfn59+k5e1aHCdyzpEZs0esWFu5dMMka0EeuPV3nkyKNQTs9
         fe9g==
X-Gm-Message-State: AOAM531ag8S3kUfYyhJXME1Bl06rPU6bOWMdjWfQcdzB3jnw2iMuL9BX
        QdXE0r5PJS5Cd98agjgXyhdO6A==
X-Google-Smtp-Source: ABdhPJwtfr/HY+Yr7xTL22dXUEFQlv4E4LXAbzMP2MXghITjri7+9344u+8IFT8AgE+jhAEgi0RqZg==
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr2130506wmh.15.1615365110143;
        Wed, 10 Mar 2021 00:31:50 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id l15sm7950290wme.43.2021.03.10.00.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 00:31:49 -0800 (PST)
Date:   Wed, 10 Mar 2021 08:31:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Li, Meng" <Meng.Li@windriver.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Hao, Kexin" <Kexin.Hao@windriver.com>
Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
 regmap_config"
Message-ID: <20210310083148.GD4931@dell>
References: <20210115015050.26657-1-meng.li@windriver.com>
 <CO1PR11MB48497CB7B11EDA65A3941FDCF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <36cc2d810d90237947ad953ebd6b9fb7@kernel.org>
 <20210222092114.GE376568@dell>
 <CO1PR11MB48499549EB56C7EE119E175DF1819@CO1PR11MB4849.namprd11.prod.outlook.com>
 <20210309094310.GO4931@dell>
 <PH0PR11MB5191EA634E57B8A5FF0DE991F1929@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20210309181524.GW4931@dell>
 <PH0PR11MB5191FEF69470B3DD61504DCEF1919@PH0PR11MB5191.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB5191FEF69470B3DD61504DCEF1919@PH0PR11MB5191.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021, Li, Meng wrote:

> 
> 
> > -----Original Message-----
> > From: Lee Jones <lee.jones@linaro.org>
> > Sent: Wednesday, March 10, 2021 2:15 AM
> > To: Li, Meng <Meng.Li@windriver.com>
> > Cc: Marc Zyngier <maz@kernel.org>; linux-kernel@vger.kernel.org;
> > arnd@arndb.de; Hao, Kexin <Kexin.Hao@windriver.com>
> > Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated name for
> > regmap_config"
> > 
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > 
> > On Tue, 09 Mar 2021, Li, Meng wrote:
> > 
> > >
> > >
> > > > -----Original Message-----
> > > > From: Lee Jones <lee.jones@linaro.org>
> > > > Sent: Tuesday, March 9, 2021 5:43 PM
> > > > To: Li, Meng <Meng.Li@windriver.com>
> > > > Cc: Marc Zyngier <maz@kernel.org>; linux-kernel@vger.kernel.org;
> > > > arnd@arndb.de; Hao, Kexin <Kexin.Hao@windriver.com>
> > > > Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free allocated
> > > > name for regmap_config"
> > > >
> > > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > >
> > > > On Mon, 22 Feb 2021, Li, Meng wrote:
> > > > > > -----Original Message-----
> > > > > > From: Lee Jones <lee.jones@linaro.org>
> > > > > > Sent: Monday, February 22, 2021 5:21 PM
> > > > > > To: Marc Zyngier <maz@kernel.org>
> > > > > > Cc: Li, Meng <Meng.Li@windriver.com>;
> > > > > > linux-kernel@vger.kernel.org; arnd@arndb.de; Hao, Kexin
> > > > > > <Kexin.Hao@windriver.com>
> > > > > > Subject: Re: [v2][PATCH] Revert "mfd: syscon: Don't free
> > > > > > allocated name for regmap_config"
> > > > > >
> > > > > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > > > >
> > > > > > On Mon, 22 Feb 2021, Marc Zyngier wrote:
> > > > > >
> > > > > > > Hi Limeng,
> > > > > > >
> > > > > > > On 2021-02-22 03:45, Li, Meng wrote:
> > > > > > > > Hi Marc&Lee,
> > > > > > > >
> > > > > > > > Is there any comment on this patch?
> > > > > > > > Could you please help to review this patch so that I can
> > > > > > > > improve it if it still has weakness?
> > > > > > >
> > > > > > > If you are confident that the root issue has been fixed, no
> > > > > > > objection from me, but I'm not in a position to test it at the
> > > > > > > moment (the board I found the problem on is in a bit of a state).
> > > > > >
> > > > > > I'm not keen on flip-flopping this patch in and out of the kernel.
> > > > > > Someone really needs to spend some time to map out the full
> > > > > > life-cycle and propose a (possibly cross-subsystem) solution.
> > > > > >
> > > > > Thanks for all of your comments.
> > > >
> > > > Have you looked into this further at all?
> > > >
> > >
> > > No.
> > > Maintainer expects better solution to solve this issue from frame level, and
> > consider cross-subsystem.
> > 
> > Yes, I do.  Does that mean you're going to drop it?
> > 
> 
> Thanks for fixing this issue. 
> Please discard my patch, I will not do further effort and drop it.

For the record, this has not been fixed.

Someone still needs to work on a suitable fix for this issue.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
