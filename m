Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D235744299D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhKBIj5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Nov 2021 04:39:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:39397 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhKBIjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:39:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="211264970"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="211264970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 01:37:20 -0700
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="500425503"
Received: from sohamdas-mobl.gar.corp.intel.com (HELO localhost) ([10.249.32.13])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 01:37:17 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     He Ying <heying24@huawei.com>, mripard@kernel.org, wens@csie.org,
        airlied@linux.ie, daniel@ffwll.ch, jernej.skrabec@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm: Grab reference of connector before return connector from sun4i_tcon_get_connector
In-Reply-To: <33e01d45-c9f9-0e8c-6871-868ecd198368@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211101062906.231518-1-heying24@huawei.com> <87cznkdo6p.fsf@intel.com> <33e01d45-c9f9-0e8c-6871-868ecd198368@huawei.com>
Date:   Tue, 02 Nov 2021 10:37:14 +0200
Message-ID: <871r3zdkcl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2021, He Ying <heying24@huawei.com> wrote:
> 在 2021/11/1 21:02, Jani Nikula 写道:
>> On Mon, 01 Nov 2021, He Ying <heying24@huawei.com> wrote:
>>>  From the comments of drm_for_each_connector_iter(), we know
>>> that "connector is only valid within the list body, if you
>>> want to use connector after calling drm_connector_list_iter_end()
>>> then you need to grab your own reference first using
>>> drm_connector_get()". So fix the wrong use of connector
>>> according to the comments and then call drm_connector_put()
>>> after using connector finishes.
>>>
>>> Signed-off-by: He Ying <heying24@huawei.com>
>> Please use "drm/sun4i:" subject prefix for sun4i patches.
>
> OK. I'll send a V2 later. By the way, may I have your suggestions about
> this patch's content.

Sorry, I only looked here because of the subject prefix, and would have
skipped it completely with a drm/sun4i prefix. ;)

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
