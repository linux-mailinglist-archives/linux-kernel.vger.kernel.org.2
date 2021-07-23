Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438803D3BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhGWNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhGWNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:43:46 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6475C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 07:24:18 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 19-20020a9d08930000b02904b98d90c82cso2208736otf.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TFOUkgVe/De3oymeenLBuNPer+TUmPN7lpMy3blENNw=;
        b=kMYc3VLcZ8HQkeGDP4GCj08ozIhO820sv8drLzH/p0tt+jnIl+jqN4ig75T2p0lKw/
         GbMiV85J/nc0wqsoDrAy0FBoq8f4oWdxggAf3+1YZZPlqb/CIQw5PVwLqx2g1fKTU/xJ
         2zCvCUTIqjmHIwMlzDo3Cq42Eirw6Z6bccTo6dTdRcjCoYtQKxDXrejsuVsuSV7LCRQR
         tuD974zCr28piclys4fQ7Y+lvwA+YYLmvDQ7giWULxqVOoa7Wshd7pAgkk+NcwkU53VM
         XgANK5fQb4M+ZZKMo9j6bpevRaDl4Dkyn+6PvhDQZiXVmnZmgWeY7qgorQkOPqWuAEcY
         HFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TFOUkgVe/De3oymeenLBuNPer+TUmPN7lpMy3blENNw=;
        b=Q0Q/N3n9UJsugGQGwoTDG2+8q4fYkEEcfILTTEWwEnTVyH1KgskYLF70jtKbW07/UL
         feCFkgEgFUeEkquWMTU2y9xsBzo1IqBFJwrbvfKSoqk3WKjzxCuVLo3rFDNbSJiiZkCc
         WWYMqBzESlWcAHxfRdU/762aFuZAo7QZsEB+6V0vGdjFPOAHLVRs9g3INaPTnYXoCR1b
         7nCzVSB1qPa9eidP39+5SDnEp+7PlaBD6BEqrOF/ZEcsBGgX2OqB9+wz7Rf6q8tE6Z/v
         OeoOem2n0iTuW8Ej6BJzi3qrLPBFmmPLD2jVzNH3pPyRsLAAtB5Pv2r5ly+wat2BKwPN
         yLlg==
X-Gm-Message-State: AOAM532oZz2i5r/CouNckylKuM3kBQPowUJLdCZbX0K9hgYtIwNCg7Kr
        uJtQWUt9LwykeSQTbM6GP5B5Uw==
X-Google-Smtp-Source: ABdhPJz+8ZHqxxjGU86tyolNaSdy9VlLyxBEJo+yDX15pPrPdOO0ZWJWGxlkjLP/OhHNkko5BhKtfA==
X-Received: by 2002:a9d:2c61:: with SMTP id f88mr3251914otb.62.1627050257958;
        Fri, 23 Jul 2021 07:24:17 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s7sm3420836ool.14.2021.07.23.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 07:24:17 -0700 (PDT)
Date:   Fri, 23 Jul 2021 09:24:14 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Todd Kjos <tkjos@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
Message-ID: <YPrRDrmlmF4ws4DQ@yoga>
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com>
 <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
 <CAGETcx91URbHCYMoGt_cCgvMXNkVyJb4Ek-ng8jwR+eQhvZN1A@mail.gmail.com>
 <YPiCSOys6zEH6Kfg@yoga>
 <CAGETcx8Yw2QDYBYNpqVt_kPHnokFR+qinr5GAJ1byVWMuc3PLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8Yw2QDYBYNpqVt_kPHnokFR+qinr5GAJ1byVWMuc3PLQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21 Jul 16:07 CDT 2021, Saravana Kannan wrote:

> On Wed, Jul 21, 2021 at 1:23 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Wed 21 Jul 13:00 CDT 2021, Saravana Kannan wrote:
> >
> > > On Wed, Jul 21, 2021 at 10:24 AM John Stultz <john.stultz@linaro.org> wrote:
> > > >
> > > > On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > > > > > Allow the qcom_scm driver to be loadable as a permenent module.
> > > > >
> > > > > This feels like a regression, it should be allowed to be a module.
> > > >
> > > > I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
> > > > to enable the driver to be able to be loaded as a module.
> > >
> > > I think the mix up might be that Greg mentally read "permanent module"
> > > as "builtin"?
> > >
> > > "permanent module" is just something that can't be unloaded once it's
> > > loaded. It's not "builtin".
> > >
> >
> > Afaict there's nothing in this patch that makes it more or less
> > permanent.
> 
> The lack of a module_exit() makes it a permanent module. If you do
> lsmod, it'll mark this as "[permanent]".
> 

Cool, I didn't know that.

Thanks,
Bjorn
