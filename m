Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870F83EEFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbhHQPyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240435AbhHQPun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:50:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A08BC60F58;
        Tue, 17 Aug 2021 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629215407;
        bh=1IIBAHMJBN5VO5cu89rQKLoGYM0saet7zS5ZdtD+TJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WUR5PBE55pZjCT+xY73tIa8PS3Me1qK8WLzxKKtsDtz087m7CNddaGPQklNHndyGS
         OGcl+Mf5Mgj3RlMimcFkC0Ho0nGzucA6BZZMrIfW/xnYeM+MUOOpASF1plmqYoOb/7
         EjI1nESvZuv+JKzTaq8oiQX7o54ndeAS4c50+jJhg+ZJRhVIBFbKXE5uQAXgSa7ls1
         4roxDoLwuSpHlP5Q6LNn5wNtMRGwVv9tK/AEXjtCq0OKv5Fe/zoc9fR82js4Ob/Djc
         9gfX+YDX8GSsvEOMPHwZ+tghsYjXaGAiMBYrI/5+qD8I381DwTbFiTWwz/WFmB1c/r
         JqIAxwldc6vDA==
Date:   Tue, 17 Aug 2021 10:50:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 7/8] um: add PCI over virtio emulation driver
Message-ID: <20210817155006.GA3020013@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301160501.bafdfe225ce2.I21b27d26611ebecd8c918e20728e37b184d817bb@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:07:07PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> To support testing of PCI/PCIe drivers in UML, add a PCI bus
> support driver. This driver uses virtio, which in UML is really
> just vhost-user, to talk to devices, and adds the devices to
> the virtual PCI bus in the system.

Hi Johannes,

The virtio_pcidev_ops kernel-doc below doesn't match the actual enum,
so it generates several warnings:

  include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_RESERVED' not described in enum 'virtio_pcidev_ops'
  include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_MMIO_READ' not described in enum 'virtio_pcidev_ops'
  include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_MMIO_WRITE' not described in enum 'virtio_pcidev_ops'
  include/uapi/linux/virtio_pcidev.h:41: warning: Excess enum value 'VIRTIO_PCIDEV_OP_BAR_READ' description in 'virtio_pcidev_ops'
  include/uapi/linux/virtio_pcidev.h:41: warning: Excess enum value 'VIRTIO_PCIDEV_OP_BAR_WRITE' description in 'virtio_pcidev_ops'

FWIW, here's the command I used to find these:

  $ find include drivers/pci -type f -path "*pci*.[ch]" | xargs scripts/kernel-doc -none

> diff --git a/include/uapi/linux/virtio_pcidev.h b/include/uapi/linux/virtio_pcidev.h
> new file mode 100644
> index 000000000000..89daa88bcfef
> --- /dev/null
> +++ b/include/uapi/linux/virtio_pcidev.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/*
> + * Copyright (C) 2021 Intel Corporation
> + * Author: Johannes Berg <johannes@sipsolutions.net>
> + */
> +#ifndef _UAPI_LINUX_VIRTIO_PCIDEV_H
> +#define _UAPI_LINUX_VIRTIO_PCIDEV_H
> +#include <linux/types.h>
> +
> +/**
> + * enum virtio_pcidev_ops - virtual PCI device operations
> + * @VIRTIO_PCIDEV_OP_CFG_READ: read config space, size is 1, 2, 4 or 8;
> + *	the @data field should be filled in by the device (in little endian).
> + * @VIRTIO_PCIDEV_OP_CFG_WRITE: write config space, size is 1, 2, 4 or 8;
> + *	the @data field contains the data to write (in little endian).
> + * @VIRTIO_PCIDEV_OP_BAR_READ: read BAR mem/pio, size can be variable;
> + *	the @data field should be filled in by the device (in little endian).
> + * @VIRTIO_PCIDEV_OP_BAR_WRITE: write BAR mem/pio, size can be variable;
> + *	the @data field contains the data to write (in little endian).
> + * @VIRTIO_PCIDEV_OP_MMIO_MEMSET: memset MMIO, size is variable but
> + *	the @data field only has one byte (unlike @VIRTIO_PCIDEV_OP_MMIO_WRITE)
> + * @VIRTIO_PCIDEV_OP_INT: legacy INTx# pin interrupt, the addr field is 1-4 for
> + *	the number
> + * @VIRTIO_PCIDEV_OP_MSI: MSI(-X) interrupt, this message basically transports
> + *	the 16- or 32-bit write that would otherwise be done into memory,
> + *	analogous to the write messages (@VIRTIO_PCIDEV_OP_MMIO_WRITE) above
> + * @VIRTIO_PCIDEV_OP_PME: Dummy message whose content is ignored (and should be
> + *	all zeroes) to signal the PME# pin.
> + */
> +enum virtio_pcidev_ops {
> +	VIRTIO_PCIDEV_OP_RESERVED = 0,
> +	VIRTIO_PCIDEV_OP_CFG_READ,
> +	VIRTIO_PCIDEV_OP_CFG_WRITE,
> +	VIRTIO_PCIDEV_OP_MMIO_READ,
> +	VIRTIO_PCIDEV_OP_MMIO_WRITE,
> +	VIRTIO_PCIDEV_OP_MMIO_MEMSET,
> +	VIRTIO_PCIDEV_OP_INT,
> +	VIRTIO_PCIDEV_OP_MSI,
> +	VIRTIO_PCIDEV_OP_PME,
> +};
