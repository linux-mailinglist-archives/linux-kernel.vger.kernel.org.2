Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1456E3D246D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhGVMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 08:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhGVMfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:35:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3188261003;
        Thu, 22 Jul 2021 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626959780;
        bh=CrztZNaKVjON/d/4c724HSYw6X0K63o+ecpeTn4t92Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twohJJ8smdG94+ivCw6JHpWyxc/qnlszhBccWg+IT0PNCF6RLAbwgvtAb4DN2qECG
         1blRjx5cbIoNeAlvlElPmqUE78cShdo48RyrAA0wLts+zAOpVLveOXrx4KpCvFVSMQ
         02DnOiltWrfxfI2rKpgeeftVW5Yy+cB37A0sQmus=
Date:   Thu, 22 Jul 2021 15:16:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: refactor the i915 GVT support
Message-ID: <YPlvoa4lZzfXXmvE@kroah.com>
References: <20210721155355.173183-1-hch@lst.de>
 <DM4PR11MB55496531B246A4604FC86998CAE49@DM4PR11MB5549.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB55496531B246A4604FC86998CAE49@DM4PR11MB5549.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 10:49:47AM +0000, Wang, Zhi A wrote:
> But it's hard for some customers to contribute their own "hypervisor"
> module to the upstream Linux kernel.

What prevents them from doing this?  We will take any code that meets
our standards, what format is this external code in?

> I am thinking what would be a
> better solution here? The MPT layer in the kernel helps a lot for
> customers, but only one open-source "hypervisor" module is there in
> the kernel. That can confuse people which don't know the story. One
> thing I was thinking is to put a document about the background and
> more description in the MPT headers. So it won't confuse more people. 

If no one is using it in the kernel, it needs to be removed.  No
abstractions should be added that are not required by the in-tree code.

So this series should be accepted, _or_ the external code needs to be
submitted for inclusion.

thanks,

greg k-h
