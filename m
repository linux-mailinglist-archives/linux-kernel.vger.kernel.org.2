Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA45365AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhDTOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:08:38 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33742 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhDTOIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:08:35 -0400
Received: by mail-oi1-f172.google.com with SMTP id u80so5470399oia.0;
        Tue, 20 Apr 2021 07:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fyaFnlJqNpsxlknmsqUUlJe/44lYYi+AnMDNj4dn7jg=;
        b=rgzarrOqZcyuOSsBRBsoefYGaRcGNrr7O3/bBouyX/1PQLuhZU3fFjQG893wjKiq/H
         K42pegQlzJJevn5aAhgE5EaLDLvbBJYM3pppIBoD6tMvdzvjsWchLvHyAON1mmCxgfdy
         F09SDe+ykZ1lcElVu+NO+Q9bPkmS0f3Ca4JBoyVWzwf/7D4Kp+MyMnfF05pCDgxNcVh+
         LFi5pih412jbOZ5m/WleFuhwYy9eFiYBbngS1rbuDGU6jfzNnYytQSwZe1/PIRLeF24H
         KK/cSlo1qzZgdzNFdI2LQIRAyDpKNnKRIzFidS3+vBeQox7xMqMQZYvZ1VL4PYHCttfF
         Wivg==
X-Gm-Message-State: AOAM532x4aYhdtW8cncsVFpI0fmi/5B4WKWM3bpXAf+i5PXCc4Tl5ri2
        VexbJND/Pu6s7sv6NLld/pIeQxSq5w==
X-Google-Smtp-Source: ABdhPJz6/CknfnN6Q3VBghczUhAjlWM2IZtaX/wH8Dkg8jaU3WB/LzVuy+BrhZfjXxsgCt7cRsn2rw==
X-Received: by 2002:aca:309:: with SMTP id 9mr3191301oid.12.1618927683893;
        Tue, 20 Apr 2021 07:08:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u195sm1659221oif.55.2021.04.20.07.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 07:08:03 -0700 (PDT)
Received: (nullmailer pid 3247646 invoked by uid 1000);
        Tue, 20 Apr 2021 14:08:01 -0000
Date:   Tue, 20 Apr 2021 09:08:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/5] mtd: core: OTP nvmem provider support
Message-ID: <20210420140801.GA3240688@robh.at.kernel.org>
References: <20210416114928.27758-1-michael@walle.cc>
 <20210416184423.GA3715339@robh.at.kernel.org>
 <9f33229a8fe83b49210289fc93a8554e@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f33229a8fe83b49210289fc93a8554e@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 09:26:03PM +0200, Michael Walle wrote:
> Hi Rob,
> 
> Am 2021-04-16 20:44, schrieb Rob Herring:
> > On Fri, Apr 16, 2021 at 01:49:23PM +0200, Michael Walle wrote:
> > > The goal is to fetch a (base) MAC address from the OTP region of a
> > > SPI NOR
> > > flash.
> > > 
> > > This is the first part, where I try to add the nvmem provider
> > > support to
> > > the MTD core.
> > > 
> > > I'm not sure about the device tree bindings. Consider the following
> > > two
> > > variants:
> > > 
> > > (1)
> > >     flash@0 {
> > >         ..
> > > 
> > >         otp {
> > >             compatible = "mtd-user-otp";
> > 
> > mtd is a linuxism. Why not just 'nvmem-cells' here or as a fallback if
> > we come up with a better name?
> 
> There are two different compatibles: "mtd-user-otp" and "mtd-factory-otp"
> to differentiate what kind of OTP should be used (and both are possible
> at the same time). Thus nvmem-cells alone won't be enough. We could drop
> the "mtd-" prefix though.
> 
> Is there a benefit of having the following?
>   compatible = "user-otp", "nvmem-cells";

Yes. I assume 'user-otp' tells you something about the region and 
'nvmem-cells' tells you that there are child nodes of nvmem data. Of 
course 'user-otp' could imply 'nvmem-cells' as you did. I'm fine with 
either way.

Rob
