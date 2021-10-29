Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B69643FA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhJ2Jj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:39:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:64404 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231504AbhJ2Jj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:39:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="228086548"
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="228086548"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:37:28 -0700
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="598154923"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 02:37:26 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id DAEF7201A7;
        Fri, 29 Oct 2021 12:37:24 +0300 (EEST)
Date:   Fri, 29 Oct 2021 12:37:24 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [sailus-media-tree:master 1/5] max96712.c:undefined reference to
 `v4l2_async_unregister_subdev'
Message-ID: <YXvA1CiYIMX39LyY@paasikivi.fi.intel.com>
References: <202110271818.TcGzSbjQ-lkp@intel.com>
 <YXk5uK9eqMT0dPhE@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXk5uK9eqMT0dPhE@oden.dyn.berto.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hejssan,

On Wed, Oct 27, 2021 at 01:36:24PM +0200, Niklas Söderlund wrote:
> Hi Sakari,
> 
> What would be the best fix for this do you think adding 'depends on 
> VIDEO_DEV' to VIDEO_MAX96712 is the right path? I tested it and it 
> solves this problem but not sure if it's the correct solution.

I think you need VIDEO_V4L2. That includes controls, for instance.

-- 
Sakari Ailus
