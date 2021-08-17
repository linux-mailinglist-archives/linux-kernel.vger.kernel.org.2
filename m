Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B63EEFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbhHQP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbhHQPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:52:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A8FC0612E7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kYHKeCcwpsADO9qzbroKLsbDGY/pJpmXS65y9af/do8=;
        t=1629215495; x=1630425095; b=U1PCgGO4c2R72pZQ70PqXGMCHuWWSPcOOjAibJWGow5HiY4
        XmI/S2laNrM+eeBck5ioJQx6FicNNfEXKgtZ6oDNHc83Ndk3oEN2bcA2jFOJagp84sjkd8XHGUKjB
        Jg57MqGj8NJBnnU7IKIdqClbotmgZkCXyMQERVjqb5tAtpqTVSAnm7HWN5CnvfQwuzYJEZ+7s+kD3
        cIZVEwLKdoqrA5SjjyuDduXN/Vbh1peLUY96ZF/XLaJGUL0mxLq3aPuDz2KqdidhRu9+ZOafKTs+y
        Ddgq/hL2c8/EfL/4AMzDFTZt6PAWGO66lXvevQkElKqy95iv9K4/VI+CGhzvBFYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mG1NA-00CKWn-He; Tue, 17 Aug 2021 17:51:28 +0200
Message-ID: <46d3c77cb6fcc686d3f3110eb2412f3fd2e682dc.camel@sipsolutions.net>
Subject: Re: [PATCH v2 7/8] um: add PCI over virtio emulation driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-um@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 17:51:27 +0200
In-Reply-To: <20210817155006.GA3020013@bjorn-Precision-5520>
References: <20210817155006.GA3020013@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The virtio_pcidev_ops kernel-doc below doesn't match the actual enum,
> so it generates several warnings:
> 
>   include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_RESERVED' not described in enum 'virtio_pcidev_ops'
>   include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_MMIO_READ' not described in enum 'virtio_pcidev_ops'
>   include/uapi/linux/virtio_pcidev.h:41: warning: Enum value 'VIRTIO_PCIDEV_OP_MMIO_WRITE' not described in enum 'virtio_pcidev_ops'
>   include/uapi/linux/virtio_pcidev.h:41: warning: Excess enum value 'VIRTIO_PCIDEV_OP_BAR_READ' description in 'virtio_pcidev_ops'
>   include/uapi/linux/virtio_pcidev.h:41: warning: Excess enum value 'VIRTIO_PCIDEV_OP_BAR_WRITE' description in 'virtio_pcidev_ops'
> 
> FWIW, here's the command I used to find these:
> 
>   $ find include drivers/pci -type f -path "*pci*.[ch]" | xargs scripts/kernel-doc -none

Oops. It didn't get tied to any real doc creation so I guess the bots
didn't find it, but I'll send a patch to fix it, thanks!

johannes

