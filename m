Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0F3D42F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 00:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhGWVv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 17:51:57 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:38726 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhGWVv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 17:51:56 -0400
Received: by mail-il1-f179.google.com with SMTP id h18so2927578ilc.5;
        Fri, 23 Jul 2021 15:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3eesqMuQP1L6Akd1AuDIrurUTtoylXIU3N2SAjPaYTs=;
        b=ltYAXTwgU8wH+RfoGUq3i/X/W7DsSsS/WnoYjk+GNU+xiGVB8wrRuKAe2xBOSoNo6y
         3Nv0HKJdivXNeozO5wMrWJ+5O96NujuJ53mWQv5KXEVwdpPGlDg5OhRIxLqulVm2BgE9
         kEQo8w6/SlUyukkv0h890f/t2C1OwJh2e1Zu5LKmL3jphI2nJB4XCOUyOuvowjvwm1El
         D9NwtFawzO5tARrswxQaGrjYGq0BKRFQgBJXzJ0u+luN5ZLPycF1yaNAMo6tQajDr4Fd
         W5PNOR9EnHbaM4hX9YqOHO2fpPX2E/KSDPA6isfpDFjn40em7JEf4AA63movm444yKwZ
         iYRg==
X-Gm-Message-State: AOAM532+hzflhYatx78Z0sbv4gtc1RIh19nZjIDKOKgMV4ofVgp6JbD7
        z5pzqhHRaOVo9eumDSFBjQ==
X-Google-Smtp-Source: ABdhPJxbH0gKa0hBfInqNT8I/XTuZdWiNZcK99zGHm+qyKKwq68KvN4JfximQ/pcHT3d9FVayee2tA==
X-Received: by 2002:a05:6e02:12ab:: with SMTP id f11mr4931696ilr.200.1627079549107;
        Fri, 23 Jul 2021 15:32:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r8sm19059823iov.39.2021.07.23.15.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:32:28 -0700 (PDT)
Received: (nullmailer pid 2721532 invoked by uid 1000);
        Fri, 23 Jul 2021 22:32:25 -0000
Date:   Fri, 23 Jul 2021 16:32:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v15 0/3] Move HiSilicon 6421v600 SPMI and USB drivers out
 of staging
Message-ID: <20210723223225.GB2709437@robh.at.kernel.org>
References: <cover.1627025657.git.mchehab+huawei@kernel.org>
 <YPp6dNuhPiLdgVKf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPp6dNuhPiLdgVKf@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 10:14:44AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 23, 2021 at 09:40:05AM +0200, Mauro Carvalho Chehab wrote:
> > Hi Greg,
> > 
> > Those are the remaining patches needed for USB3 to start working on HiKey 970.
> > 
> > I would prefer to have those merged during this cycle, as the PCIe patchset
> > currently under review depends on patch 1 and 2 of this series.
> > 
> > So, I dropped the cleanup patch from this series, due to a merge conflict with
> > the regulator's tree. I'll re-submit it against the mfd tree after the merge window. 
> > 
> > Mauro Carvalho Chehab (3):
> >   mfd: hi6421-spmi-pmic: move driver from staging
> >   dts: hisilicon: add support for the PMIC found on Hikey 970
> >   dts: hisilicon: add support for USB3 on Hikey 970
> 
> I've applied patch 1 here.
> 
> The other two I need acks from the DT maintainers before I can do
> anything with them.

I only review the bindings (patch 1). I can only deal with 1 firehose. 
The dts files should go thru the HiSilicon maintainers.

Rob
