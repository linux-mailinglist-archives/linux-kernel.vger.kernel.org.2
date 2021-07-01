Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E223B908A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhGAKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:36:47 -0400
Received: from foss.arm.com ([217.140.110.172]:50958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235300AbhGAKgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:36:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79C9AD6E;
        Thu,  1 Jul 2021 03:34:16 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7B223F718;
        Thu,  1 Jul 2021 03:34:12 -0700 (PDT)
Date:   Thu, 1 Jul 2021 11:34:06 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v4 14/16] firmware: arm_scmi: Add virtio transport
Message-ID: <20210701103406.GE17807@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-15-cristian.marussi@arm.com>
 <ccc64935-08fa-d1a3-fc21-227c9d05fe24@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccc64935-08fa-d1a3-fc21-227c9d05fe24@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 01, 2021 at 10:43:07AM +0200, Peter Hilber wrote:
> On 11.06.21 18:59, Cristian Marussi wrote:
> 
> <snip>
> 
> > +static struct virtio_driver virtio_scmi_driver = {
> > +	.driver.name = "scmi-virtio",
> > +	.driver.owner = THIS_MODULE,
> > +	.feature_table = features,
> > +	.feature_table_size = ARRAY_SIZE(features),
> > +	.id_table = id_table,
> > +	.probe = scmi_vio_probe,
> > +	.remove = scmi_vio_remove,
> > +};
> > +
> 
> It might be good to also check for the VIRTIO_F_VERSION_1 feature bit in the
> optional .validate op (not yet implemented above), as some other devices do
> (quoting virtio-snd in the following):
> 

Ah, thanks for pointing that out, I'll do because indeed in my hackish
emulation test-setup I forgot to emulate that bit and everything fall
flat.

> > /**
> >  * virtsnd_validate() - Validate if the device can be started.
> >  * @vdev: VirtIO parent device.
> >  *
> >  * Context: Any context.
> >  * Return: 0 on success, -EINVAL on failure.
> >  */
> > static int virtsnd_validate(struct virtio_device *vdev)
> > {
> 
> <snip>
> 
> > 
> > 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > 		dev_err(&vdev->dev,
> > 			"device does not comply with spec version 1.x\n");
> > 		return -EINVAL;
> > 	}
> > 
> 
> <snip>
> 
> > 
> > static struct virtio_driver virtsnd_driver = {
> > 	.driver.name = KBUILD_MODNAME,
> > 	.driver.owner = THIS_MODULE,
> > 	.id_table = id_table,
> > 	.validate = virtsnd_validate,
> 
> (end of virtio-snd quote)

Thanks,
Cristian

