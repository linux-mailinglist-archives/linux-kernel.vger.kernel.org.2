Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98B40A700
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhINHCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240419AbhINHCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:02:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C8E2610E6;
        Tue, 14 Sep 2021 07:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631602851;
        bh=yVMhOyi2NlCerH8Ao+NJSMjK/cz1/pt+EzZEoLHb3fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRdFaAlw/wmN3zMMzuRHAzJ4Ugc+65HAcdDPhWpYqEeKQ/15VVDORRhB7rrvToXms
         iUxFSvrG9oPpKrTuXx6pL3WWHJ2MzaldMlZL9sFJTT+M7AOaX16qSejenwgpCZ/RsP
         jYDXfFic+NpIVtIr8IzrDRE+wzgmOAtkUSzei3mI=
Date:   Tue, 14 Sep 2021 09:00:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Li <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [PATCH v4 2/2] virt: acrn: Introduce interfaces for virtual
 device creating/destroying
Message-ID: <YUBIoEYPP7e5+CR0@kroah.com>
References: <20210914062627.16431-1-fei1.li@intel.com>
 <20210914062627.16431-3-fei1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914062627.16431-3-fei1.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 02:26:27PM +0800, Fei Li wrote:
> +struct acrn_vdev {
> +	/*
> +	 * the identifier of the device, the low 32 bits represent the vendor
> +	 * id and device id of PCI device and the high 32 bits represent the
> +	 * device number of the legacy device
> +	 */
> +	union {
> +		__u64 value;
> +		struct {
> +			__u16 vendor;
> +			__u16 device;
> +			__u32 legacy_id;

What is the endian of these fields?

Please always specify them.

thanks,

greg k-h
