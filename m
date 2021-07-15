Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C103C959A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhGOBdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:33:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:24419 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhGOBdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:33:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190829872"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190829872"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 18:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="494835756"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2021 18:30:27 -0700
Date:   Thu, 15 Jul 2021 09:30:17 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuo.a.liu@intel.com,
        fei1.li@intel.com
Subject: Re: [PATCH] MAINTAINERS: Change ACRN HSM driver maintainer
Message-ID: <20210715013017.GA13195@louislifei-OptiPlex-7050>
References: <20210714082614.88560-1-shuo.a.liu@intel.com>
 <YO6sv1zUxljRRcdN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO6sv1zUxljRRcdN@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 11:22:07AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 14, 2021 at 04:26:14PM +0800, Shuo Liu wrote:
> > Shuo steps down, Fei will take over.
> > 
> > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>

Acked-by: Fei Li <fei1.li@intel.com>

Thanks.

> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> We need an ack from the person you are assigning this to :)
> 
> thanks,
> 
> greg k-h
