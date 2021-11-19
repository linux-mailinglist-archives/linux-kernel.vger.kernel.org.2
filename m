Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3404569ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 07:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhKSGOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 01:14:09 -0500
Received: from verein.lst.de ([213.95.11.211]:49944 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhKSGOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 01:14:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B41E168AFE; Fri, 19 Nov 2021 07:11:03 +0100 (CET)
Date:   Fri, 19 Nov 2021 07:11:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: drivers/of/unittest.c:910:1: warning: the frame size of 1424
 bytes is larger than 1024 bytes
Message-ID: <20211119061103.GC15001@lst.de>
References: <202111190545.G3a209mT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111190545.G3a209mT-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we'll need to dynamically allocate the fake struct device here.
Jim, can you look into that?
