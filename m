Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621883C7307
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbhGMPWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbhGMPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:22:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C369C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:19:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cu14so7030857pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xGIQduPCYxV/aV0Im0h8RYp+cXt3nip3dY+ixFjG0D4=;
        b=TcfsG1prt2Xidr8tuUjPWsPhlRzTO3DKhno3TFVuwtzY0fb1xG+Fc3/m8YIRlCuiVf
         oKVuLfYy5WNx1P00HB39kWvNz6MRdodUsCmfs3KY3Oshys5KW7VYr4LKqEqSt8g2dRLz
         2k2gCvZ1SbwdjahCGjwcz2r22XKwG+TLbvbRDNAiJv9iyBZ4Z7EQLTMoeOXOWqqiefGu
         h8Gidj4xog9mjT8MjuLFZQ3O6aJZKjQDc3qsRiiEWlsSdhwNmUkM+vhgplVoixMCZcuj
         ukaXAZemTefe3j49itOLtTT7SvSi8NdSw1n61/P+wT3CrRvOw2wEe0mF1OsTi71AdzA+
         u9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xGIQduPCYxV/aV0Im0h8RYp+cXt3nip3dY+ixFjG0D4=;
        b=KigQP+onjEMhyM7uiLuugnlmJy8rEX6k7WA9OVH6VfzHY71+Au1r8wMDejYJxFrtzs
         qM1xOrRaFPnfp0BFc2msYbqP0/ocqfTMRyGcX9URQ9lPVd4uQMRjFga3jZrfEqrQ9ms0
         Zl+rZbXfZ8OiiF+VTTistQoXySV2U/EXJ8v3c0Lo613MIW0rEeFJzmlLk9i7R0YfKuE4
         f9bFyeZN8xJcq26R/aRgwqcN0W1tiWBm/UjIPtdhRZXwLpR95yvAmmrYERtfNmCqiAFO
         CPRfJAmHBnHMwps/VALLc0tEmaOtTbH626XQ4NHoo9l9yHRDUV91h4H1cpIWanwJrgVS
         eWeA==
X-Gm-Message-State: AOAM531C8lsw5eOm45zUC47AcMS3O6M1dou72iVptDy/qsAlgCZ08FDX
        aIlN98WDLVa8pFjSgGkETWLwcA==
X-Google-Smtp-Source: ABdhPJxbLam7vtpNtCrczB072jPUmk6y+dzP8PaT041Mn/LNIJ4bURMAkxfbGDobFRrrCcwzsL94/Q==
X-Received: by 2002:a17:902:6b42:b029:11d:a147:bb7b with SMTP id g2-20020a1709026b42b029011da147bb7bmr4067789plt.9.1626189559780;
        Tue, 13 Jul 2021 08:19:19 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id n6sm14172937pgb.60.2021.07.13.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:19:19 -0700 (PDT)
Date:   Tue, 13 Jul 2021 20:49:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210713151917.zouwfckidnjxvohn@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-21, 08:43, Rob Herring wrote:
> On Tue, Jul 13, 2021 at 4:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Allow virtio,mmio nodes to contain device specific subnodes. Since each
> > virtio,mmio node can represent a single virtio device, each virtio node
> > is allowed to contain a maximum of one device specific subnode.
> 
> Doesn't sound like we need 2 nodes here. Just add I2C devices as child
> nodes. You could add a more specific compatible string, but the
> protocol is discoverable, so that shouldn't be necessary.

I am not sure if it will be a problem, but you can clarify it better.

The parent node (virtio,mmio) is used to create a platform device,
virtio-mmio, (and so assigned as its of_node) and we create the
virtio-device from probe() of this virtio-mmio device.

Is it going to be a problem if two devices in kernel use the same
of_node ? Are there cases where we would need to get the device
pointer from the of_node ? Then we will have two here.

> BTW, what's the usecase for these protocols? A standard interface to
> firmware controlled I2C, GPIO, etc.?

Right now we are looking to control devices in the host machine from
guests. That's what Linaro's project stratos is doing. There are other
people who want to use this for other kind of remote control stuff,
maybe from firmware.

> > diff --git a/include/dt-bindings/virtio/virtio_ids.h b/include/dt-bindings/virtio/virtio_ids.h
> > new file mode 120000
> > index 000000000000..6e59ba332216
> > --- /dev/null
> > +++ b/include/dt-bindings/virtio/virtio_ids.h
> > @@ -0,0 +1 @@
> > +../../uapi/linux/virtio_ids.h
> 
> This will break the devicetree-rebasing tree I think. DT files
> shouldn't reference kernel files.

We already do this for linux-event-codes.h and so I thought it is the
right way of doing it :)

Else we can create a new copy, which will be a mess, or use hardcoded
values.

-- 
viresh
