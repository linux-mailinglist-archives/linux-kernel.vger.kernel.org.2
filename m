Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367EF3D23EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhGVMOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 08:14:51 -0400
Received: from verein.lst.de ([213.95.11.211]:33958 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232075AbhGVMOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 08:14:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C05767373; Thu, 22 Jul 2021 14:55:19 +0200 (CEST)
Date:   Thu, 22 Jul 2021 14:55:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: refactor the i915 GVT support
Message-ID: <20210722125519.GA25887@lst.de>
References: <20210721155355.173183-1-hch@lst.de> <20210722094516.GQ13928@zhen-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722094516.GQ13928@zhen-hp.sh.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 05:45:16PM +0800, Zhenyu Wang wrote:
> The reason we isolated hypervisor specific code from core vgpu
> emulation is to make multiple hypervisor support possible. Yes, we do
> have Xen support but never got way into upstream...And we also have
> third party hypervisors which leverage gvt function through current
> hypervisor interface.

Out of tree stuff simply does not matter for the upstream kernel,
especially when it creates such a huge burden.

As a background:  I started this refactoring as a lot of the code did
not make much sense when reviewing the mdev integration in preparation
to switching them to the new mdev interface from Jason.
