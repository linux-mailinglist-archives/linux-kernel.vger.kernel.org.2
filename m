Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F273C7C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbhGNDOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 23:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbhGNDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 23:14:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F94DC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:11:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p36so713837pfw.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 20:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y32N12/p7rYvyE6mcJmofWmxNn37x1C8lHiGzfpcDok=;
        b=DeFMaEcPh/x9l9lVtTPLvhlA8gtRSZKF6n9B8YlvECOQWt920NwOeKZcFbhCVZoUbu
         lpXJvKbeKE3FHE94ersL1EM7AxkF+agXm/RYTVZ3wpoaj1NGGcUvwe5ih9VzB/gDaCC8
         Vo/Bxa5TexycaW9MF4AAqQSuS3OK+kbiArbEjnRUj87pACa6crdatSWXF0wEH/lc1pGM
         RI8D6qjtm4AIxpLdGpuOhO/lamfpuDFeB384HyrNr6lN0MSaSGzMVpH1+GdJAeocoOiR
         1WulySQeY8iGHeB+YeCQzrW1ckwAQef51iCvDwgUWnIivJiaiNpdlwKODdsMSwxPbnPf
         J1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y32N12/p7rYvyE6mcJmofWmxNn37x1C8lHiGzfpcDok=;
        b=M1CycTEtxAL8NF/PUzLPSTq0hXmbVfsq2ZeEKQUlWVZs7PaaT0KktDUyNIxh+uRw4A
         c5vtdoJh8USMY5MyEQGfjrcsZmaDNMrtrL3bWR+2VemPZOGt3y4Ab7ZrFLJnZPR8CpBa
         DcnAPDiN8qaD8vu8QGrUdbkxeDt4QmLT0G+IQ9BwmHL3MBQ6ho+wdP6pvtfTaQog6RIm
         S6tzy94iW+P1oBBn/YFZ+ODe7HABUuqrR5K/xzklU2g4tua+XipVaNyEmvwLNbB63SqC
         rE0TCkpGAbqHnzjPBOnZrgWCHkWsWo1BRnrWL1HOj+g9bU84u4YYrxcos4QmgiuqQkJT
         xqeA==
X-Gm-Message-State: AOAM532bMJHKti9x+Wab3t1kXEVmzDOtgkE9MrWorMblX3SSD0qbsdAG
        H1xKjIa+r5GDcZzgxUrz46kJWA==
X-Google-Smtp-Source: ABdhPJxMZ89BXc4PFH+vkrTJipAkgntgGpFsQ67Ki7NzSqG6NFzmhrCIoGs+gil4b/9GdxS1x1aiQQ==
X-Received: by 2002:a05:6a00:214a:b029:323:3c6e:a24a with SMTP id o10-20020a056a00214ab02903233c6ea24amr7865235pfk.4.1626232287003;
        Tue, 13 Jul 2021 20:11:27 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id u9sm4151244pjm.34.2021.07.13.20.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 20:11:26 -0700 (PDT)
Date:   Wed, 14 Jul 2021 08:41:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/5] virtio_mmio: Bind virtio device to device-tree node
Message-ID: <20210714031124.ubbd2fy4omyt7pez@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <26ba6941fa01eee88c99ecdd611d235c22bd6e3c.1626173013.git.viresh.kumar@linaro.org>
 <CAK8P3a3Sf6CaPKTKEodX_=hGxwoEXiD=UoNOtX6kPOeA9GrjTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Sf6CaPKTKEodX_=hGxwoEXiD=UoNOtX6kPOeA9GrjTw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-21, 14:26, Arnd Bergmann wrote:
> On Tue, Jul 13, 2021 at 12:51 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Bind the virtio device with its device protocol's sub-node. This will
> > help users of the virtio device to mention their dependencies on the
> > device in the DT file itself. Like GPIO pin users can use the phandle of
> > the device node, or the node may contain more subnodes to add i2c or spi
> > eeproms and other users.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/virtio/virtio_mmio.c | 44 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> 
> Hi Viresh,
> 
> I don't see anything in this patch that is specific to virtio-mmio, as
> opposed to
> virtio-pci. It would be better to move this into the virtio core code so it can
> be called independently of the transport that is used for virtio.
> 
> The PCI code has similar code that will set vdev->dev.parent->of_node
> for a virtio-pci device, as long as that node is present.

Sure.
-- 
viresh
