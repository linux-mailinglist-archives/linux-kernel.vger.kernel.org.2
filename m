Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A28D422034
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhJEIND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhJEINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:13:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8AC06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 01:11:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so2233373wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 01:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bta05v7vW8t+S5VqKO1o8XaZo4sZ8MCHIv5cOVkrBw0=;
        b=e/s6nRIJMACVqo1o+32h+rSQ6eo3hynaXqga4ZkjA4bK9Nk1P92YeN3T3lRo2HVoBA
         9e6ckZEeX7TkA0o43HjijXjf/RzlOOh/fr0kLmI89kVdn/FU8hE7mZy9WgzaeHL++6CJ
         4w0fDiH2JqvQIyiEwkrE8lAD+232TOdy4GxCNS6WKPze1HINX7xrIvDLNw+1v6bZJUF8
         9wZz1lxp6j6gYtr9LD7aPKKSDznuc73iuHiwCxAzID4LMJQ8zPxVlQ/Z+qb88w6klo4O
         MMkh1CQN0M33JjrEj2SBvpBu8WqM5f5dMhQ0MM8TNbqoV1B/bZ+kudbHyLSQGJteiM7v
         pSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bta05v7vW8t+S5VqKO1o8XaZo4sZ8MCHIv5cOVkrBw0=;
        b=zHtVO8k7dX6gwmJUWFQWpV9fw3BtJyi9YOorfttAlx9XLBj6m/wcqY6hh562TlUW6B
         N+SG6G1Z2PSazp3Cd1CquLw+zXf+W/2Xp2OQOY+penaFeBP0rXuaOrpUaivcfyLPDfSp
         SNZEGOcLno3K2+2PDWrUhEE6k03ddOvQ71rSaydG5huvo4Z2UK2cnz6agwVTeZvtJzns
         2SVqD+HzyNg1ApdFGGxoS97/zdJ9SKKyJAAZRBVTr96DojNqcCH1RWYhl/qLt4/6T0Sg
         QxMceEY2LSi4PuEkM8DgTSb9Y894KzZSpZ7XT9EwocPdA2B/3UfJ+TxXj7rQ1SgmAOcg
         Bpnw==
X-Gm-Message-State: AOAM532kd6ESz0/0M/1LcuqQOu5gd02ATOzTIIkbxZsUIfHET6WGTWRp
        qxE3SivoiP+0BnySt9GUM7GG3w==
X-Google-Smtp-Source: ABdhPJzs52tiM9/HGepdoOu43VqNtetWhPVHT8GdSTkY3A/gVZ+ezaPREGdSW5DXoiG4QNcsZav+EQ==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr1958361wmc.108.1633421468827;
        Tue, 05 Oct 2021 01:11:08 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id g1sm1784750wmk.2.2021.10.05.01.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 01:11:08 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:11:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YVwImlQYPhc3/nhi@google.com>
References: <b6102d6db357ebb5c937f460a564c6f26281e403.1631709890.git.mchehab+huawei@kernel.org>
 <YVwD2sPZMCtwP9yf@google.com>
 <20211005095603.0e204776@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005095603.0e204776@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2021, Mauro Carvalho Chehab wrote:

> Em Tue, 5 Oct 2021 08:50:50 +0100
> Lee Jones <lee.jones@linaro.org> escreveu:
> 
> > On Wed, 15 Sep 2021, Mauro Carvalho Chehab wrote:
> > 
> > > There are lots of fields at struct hi6421_spmi_pmic that aren't
> > > used. In a matter of fact, only regmap is needed.
> > > 
> > > So, drop the struct as a hole, and set just the regmap as
> > > the drvdata.
> > > 
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  drivers/mfd/hi6421-spmi-pmic.c           | 16 +++++----------
> > >  drivers/misc/hi6421v600-irq.c            |  9 ++++-----
> > >  drivers/regulator/hi6421v600-regulator.c | 10 +++++-----
> > >  include/linux/mfd/hi6421-spmi-pmic.h     | 25 ------------------------
> > >  4 files changed, 14 insertions(+), 46 deletions(-)
> > >  delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h  
> > 
> > For my own reference (apply this as-is to your sign-off block):
> > 
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > I intend to take this with a Misc Ack.
> 
> Hi Lee,
> 
> Greg already gave you:
> 
> 	https://lore.kernel.org/all/YVLA14jbwqXjNM2f@kroah.com/

Yes, I found that after I replied to this one.

I was having some trouble applying it with `b4` just as you replied:

  https://lore.kernel.org/tools/CAF2Aj3icJtU+wacosM-LO2aqMChWL69T6bf7dK3xqPMSk6Ux3w@mail.gmail.com/T/#u

I fixed the spelling/grammar mistakes and applied the patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
