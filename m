Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB643A67CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhFNN2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:28:06 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:38564 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhFNN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:28:04 -0400
Received: by mail-lf1-f47.google.com with SMTP id r5so21139728lfr.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xltRc6v0RYzP2GYCLquSH6jOzZUqizX4njH8fTXxQ8U=;
        b=BUxPBTkFwZSeaUFSb0ogjPS8sVETik0sAKjL2T3mRTIF/6LU9JTiVFEVPBzNcVasid
         tKE6xCy0ROIQjV1+EK9I5obP9Vh2jC573aLmG0NXBQ8ZscvC3Rb0BR7+EsqRNESFX9Dl
         6ZsEW+JlbtEG7obEeUoJrzwkm5PAuohU1OpBtQBG8pkbpKU66n1Q+ciEDPE2BMF4Kwda
         u+CIQ6gNLKiJX1lqZyTFwZ3BYQi03NkSxRbhqpDM3Lvdde1nNbA3RzeYu5DkH4gIv7yY
         JcpX3Sjbap1xDib3abHgKBqkw6fU2LOV8h91Ij0Tn56DSd0JPXwBDFOdV3/Af6OjRhHD
         EuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xltRc6v0RYzP2GYCLquSH6jOzZUqizX4njH8fTXxQ8U=;
        b=DWc1vY8uU28n1Kx2xu2Ra0+GPXDmPcq8tfn6OJNs5jGpYlqs09kAAOkaICQJieu6Hd
         mvYkrnPd6PckIIYeYtuBRC3Q4447gPSRoSttI2c9xH6X4POFj74LTEkA9wj+RHD2rHbL
         PcCfrAgn5heXgoS/RNXO96WCRtySJG9BEUJnUt5BxtqRr252TQuUBP7q6fNdzl57Rv5n
         8JXlxcieweCHsbw/NPpUP+cXv0LCBSfoXFA5vSSW0nTGTXgDcbNcjD9cfCRXZuBU79Vo
         xW6/4+o2Olbz+z7Q9UxMSH7+OtZlrWS1HT6Ev5ogYKflkXyjkTpgckJMRAINva6+yGX3
         HLHQ==
X-Gm-Message-State: AOAM5322TIEGjPufQfUlBAVi3uABA033JvxfduIn8TowQZ8wNLR/HyLH
        nST/QHZQNMBAOxicq23XcE8vmodais9jwZGqkHv0dQ==
X-Google-Smtp-Source: ABdhPJzxu/bbJj/tjk+9kiZjUXBMExtN/SoD6He5VyGix4LZaxl4y/uFjPI1E/gacHMwLVvWATmzF1kDDEcSkKoCPoM=
X-Received: by 2002:a05:6512:3483:: with SMTP id v3mr12270789lfr.154.1623677088786;
 Mon, 14 Jun 2021 06:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623326176.git.viresh.kumar@linaro.org> <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CAK8P3a11YhcEOjauWc872BQv+SO-E5+gnz7Lk6UK42iVw7Oyfg@mail.gmail.com>
 <20210614102119.qifm5sj7fpg54iqo@vireshk-i7> <CAK8P3a10yObfX_dFMSsqW_fGugdtz0nutJFwDB_OY0DebdGjXQ@mail.gmail.com>
 <0100017a0a9264cc-57668c56-fdbf-412a-9f82-9bf95f5c653e-000000@email.amazonses.com>
 <CAK8P3a0-cVF=n1OxURZM8yXLKCPAAgBnZNXZVUzxA8m2ZzjP1A@mail.gmail.com>
In-Reply-To: <CAK8P3a0-cVF=n1OxURZM8yXLKCPAAgBnZNXZVUzxA8m2ZzjP1A@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Jun 2021 15:24:37 +0200
Message-ID: <CAKfTPtDya2gY5nxvEA7mFQN2myQEocVz2Ugc4Of4rkNiUtpgiw@mail.gmail.com>
Subject: Re: [Stratos-dev] [PATCH V3 1/3] gpio: Add virtio-gpio driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stratos Mailing List <stratos-dev@op-lists.linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 at 15:00, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Jun 14, 2021 at 2:50 PM Vincent Guittot via Stratos-dev
> <stratos-dev@op-lists.linaro.org> wrote:>
> > On Mon, 14 Jun 2021 at 14:33, Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Mon, Jun 14, 2021 at 12:23 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > I think most importantly we need a DT binding to describe what device
> > > nodes are supposed to look like underneath a virtio-mmio or
> > > virtio-pci device in order for a hypervisor to pass down the
> > > information to a guest OS in a generic way. We can probably borrow
> > > the USB naming, and replace compatible="usbVID,PID" with
> > > compatible="virtioDID", with the device ID in hexadecimal digits,
> > > such as "virtio22" for I2C (virtio device ID 34 == 0x22) if we decide
> > > to have a sub-node under the device, or we just point dev->of_node
> > > of the virtio device to the platform/pci device that is its parent
> > > in Linux.
> > >
> > > Adding the Linux guest code to the virtio layer should be fairly
> > > straightforward, and I suppose it could be mostly copied from the
> > > corresponding code that added this for mmc in commit 25185f3f31c9
> > > ("mmc: Add SDIO function devicetree subnode parsing") and for USB
> > > in commit 69bec7259853 ("USB: core: let USB device know device
> > > node") and 1a7e3948cb9f ("USB: add device-tree support for
> > > interfaces").
> >
> > And something similar is also done with SCMI protocols which are
> > defined in a SCMI node. A  typical example:
> >
> >     cpu@0 {
> >         ...
> >         clocks = <&scmi_dvfs 0>;
> >         ...
> >     };
> >
> >     deviceX: deviceX@YYYYYYY {
> >         ...
> >         clocks = <&scmi_clk 0>;
> >         ...
> >     };
> >
> >     scmi: scmi {
> >         compatible = "arm,scmi-virtio";
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >
> >         scmi_devpd: protocol@11 {
> >             reg = <0x11>;
> >             #power-domain-cells = <1>;
> >         };
> >
> >         scmi_clk: protocol@14 {
> >             reg = <0x14>;
> >             #clock-cells = <1>;
> >         };
> >
> >         scmi_sensors: protocol@15 {
> >             reg = <0x15>;
> >             #thermal-sensor-cells = <1>;
> >         };
> >
> >         scmi_dvfs: protocol@13 {
> >             reg = <0x13>;
> >             #clock-cells = <1>;
> >         };
> >     };
>
> But this example seem to be completely different from the ones I mentioned:
> The scmi node that you have here looks like it shows up under the root of the
> device tree, not below the virtio device that implements the scmi transport.

I was thinking of something like below:

    deviceX: deviceX@YYYYYYY {
        ...
        gpio = <&virtio_gpio 0>;
        ...
    };

    virtio_mmio@a000000 {
        dma-coherent;
        interrupts = <0x0 0x10 0x1>;
        reg = <0x0 0xa000000 0x0 0x200>;
        compatible = "virtio,mmio";

        virtio_gpio: protocol@22 {
            reg = <0x22>;
        };
    };

>
>          Arnd
