Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758273E478E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhHIOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:30:43 -0400
Received: from verein.lst.de ([213.95.11.211]:60762 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235063AbhHIOaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:30:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2CAA967357; Mon,  9 Aug 2021 16:29:45 +0200 (CEST)
Date:   Mon, 9 Aug 2021 16:29:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] drm/i915/gvt: move the gvt code into kvmgt.ko
Message-ID: <20210809142945.GA18850@lst.de>
References: <20210721155355.173183-1-hch@lst.de> <20210721155355.173183-5-hch@lst.de> <162850857939.5634.17747219922172884449@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162850857939.5634.17747219922172884449@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 02:29:39PM +0300, Joonas Lahtinen wrote:
> Thanks for putting the work into this. This conversion has been
> requested for a long time. For clarity, should we call the module
> i915_kvmgt?

If this was a new module that would be my preferance.  But the
kvmgt module already exists, so I thought it might be a good idea
to keep the name.

> How far would we be from dynamically modprobing/rmmoding the kvmgt
> module in order to eliminate the enable_gvt parameter?

Hmm.  I suspect it could be done fairly easily, but from what I see
it would still require to disable GUC at i915 module load time.

If you want I could look into that for an incremental patch, but
to unblock the vfio/mdev work I'd like to do that in a separate
stage.
