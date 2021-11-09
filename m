Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA344A815
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbhKIIEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:04:32 -0500
Received: from verein.lst.de ([213.95.11.211]:48954 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236699AbhKIIE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:04:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EA08867373; Tue,  9 Nov 2021 09:01:39 +0100 (CET)
Date:   Tue, 9 Nov 2021 09:01:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: refactor the i915 GVT support and move to the modern mdev API
 v2
Message-ID: <20211109080139.GD27339@lst.de>
References: <20211102070601.155501-1-hch@lst.de> <163603075885.4807.880888219859400958@jlahtine-mobl.ger.corp.intel.com> <DM4PR11MB554905AC416FBD055251DE43CA8D9@DM4PR11MB5549.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR11MB554905AC416FBD055251DE43CA8D9@DM4PR11MB5549.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:51:28PM +0000, Wang, Zhi A wrote:
> Is it possible to separate the refactor part from the using new mdev API stuff? So that the design opens in the re-factor patches wouldn’t block the process of mdev API improvement?

Jason had an early patch for it, but it looks so horrible that I'd much
rather sort out the underlying issues first.
