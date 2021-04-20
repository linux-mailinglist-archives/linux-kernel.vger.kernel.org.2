Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71941366041
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhDTTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhDTTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:33:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 12:32:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g17so45799883edm.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CeykSAZI90ujQ36EqZV5t9vjKLz3qOJxleoK2VZMDEQ=;
        b=h7ND65/2bTQV5sECygtsgHLlJLV6CmUcPs5PTFxMtc5gX0SgwqTfEoqiedHIt0PmaL
         VQL94Ost3SRLMDK71qcFPng5iVODZivCqLDGx8Cd+ylWX9slFJknB1Ijaz171uj1OHCu
         pIW9WhLsEPkYdDKaSs/LA4ZhyriN8Raan3BlYsRuk0qBxZEJabHxBqi+W/2cX1SKvVY8
         DyYYfziamSk0hUO64IbrT3cLjLdYrUaNa5UsGfqosGEo0BTCUPVW1h3wUr4qRafdqffj
         +KadtNdwcrceKfLLopkaXWiBtJzEnuazKo9hNpRiZrZwsBvxCxA3bF3Me7Lb7jB7E6UW
         nzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeykSAZI90ujQ36EqZV5t9vjKLz3qOJxleoK2VZMDEQ=;
        b=cnBPmKNe2i30gOwqOfKseKGnHG7XxsjiLUN7cbgb5RbmzbiXBuChsy4GLxaXGWRCVG
         ini1h831f6lkfgzngX9cx0EdaWgVTur5ntvj9Lp/9g/ZDt8qM/RmVhl7Z8CATVsfA/3c
         tJg5sljhDKFx61uhaC5NKf4yeqYTE1rRkC3KNnh1POtsW7qgL9i8AEc9+hbGj35SCrEh
         4caXe86ublLCcHO5t1noE4xtCIuFIjtF5aM7losOU04ABDkO8sp9v9/UraALFFPqk6ym
         2xYiNHAJY1hdY9VAxwyPyTscc4AQSDOkMRNlkT/+ziSDh941xl8uIE9WZW/aoLReM8xS
         13gg==
X-Gm-Message-State: AOAM5301g2RQagvizB4qtwnxFKme5l1wOakzZbVIOESd/2tKXSWydzzj
        FKm7Wvd33ksFyDoFwWXNVmXFMRgQi6ORZcgOmwdobA==
X-Google-Smtp-Source: ABdhPJwoHDKggO51DoyBf4DW1dLBL0p5lO7dSdRN5XmLDceKbF7ENZxcl1MKXX+InaL/b6kc++73caSq3OlYa/fsdSc=
X-Received: by 2002:a05:6402:35c8:: with SMTP id z8mr9829147edc.210.1618947172905;
 Tue, 20 Apr 2021 12:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210419112725.42145-1-wanjiabing@vivo.com> <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
 <874kg1yt0o.fsf@fossix.org>
In-Reply-To: <874kg1yt0o.fsf@fossix.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Apr 2021 12:32:43 -0700
Message-ID: <CAPcyv4hD8gGdT6LABSBHRG2Bb59Zp1MycdQjB-CF9QHY-VHepQ@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm.h: Remove duplicate struct declaration
To:     Santosh Sivaraj <santosh@fossix.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, Wan Jiabing <wanjiabing@vivo.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 6:39 AM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> Hi Ira,
>
> Ira Weiny <ira.weiny@intel.com> writes:
>
> > On Mon, Apr 19, 2021 at 07:27:25PM +0800, Wan Jiabing wrote:
> >> struct device is declared at 133rd line.
> >> The declaration here is unnecessary. Remove it.
> >>
> >> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> >> ---
> >>  include/linux/libnvdimm.h | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> >> index 01f251b6e36c..89b69e645ac7 100644
> >> --- a/include/linux/libnvdimm.h
> >> +++ b/include/linux/libnvdimm.h
> >> @@ -141,7 +141,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
> >>
> >>  struct nvdimm_bus;
> >>  struct module;
> >> -struct device;
> >>  struct nd_blk_region;
> >
> > What is the coding style preference for pre-declarations like this?  Should
> > they be placed at the top of the file?
> >
> > The patch is reasonable but if the intent is to declare right before use for
> > clarity, both devm_nvdimm_memremap() and nd_blk_region_desc() use struct
> > device.  So perhaps this duplicate is on purpose?
>
> There are other struct device usage much later in the file, which doesn't have
> any pre-declarations for struct device. So I assume this might not be on
> purpose :-)

Yeah, I believe it was just code movement and the duplicate was
inadvertently introduced. Patch looks ok to me.

>
> On a side note, types.h can also be removed, since it's already included in
> kernel.h.

That I don't necessarily agree with, it just makes future header
reworks more fraught for not much benefit.
