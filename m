Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1E419389
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhI0Lqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:46:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:13398 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhI0Lqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:46:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="221257834"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="221257834"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 04:45:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="553159862"
Received: from susuale1-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.36.178])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 04:45:02 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?utf-8?B?U3ly?= =?utf-8?B?asOkbMOk?= 
        <ville.syrjala@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/audio: Use BIOS provided value for RKL HDA link
In-Reply-To: <alpine.DEB.2.22.394.2109061031450.3554566@eliteleevi.tm.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210906041300.508458-1-kai.heng.feng@canonical.com> <alpine.DEB.2.22.394.2109061031450.3554566@eliteleevi.tm.intel.com>
Date:   Mon, 27 Sep 2021 14:44:59 +0300
Message-ID: <875yums0n8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Sep 2021, Kai Vehmanen <kai.vehmanen@linux.intel.com> wrote:
> Hi,
>
> On Mon, 6 Sep 2021, Kai-Heng Feng wrote:
>
>> Commit 989634fb49ad ("drm/i915/audio: set HDA link parameters in
>> driver") makes HDMI audio on Lenovo P350 disappear.
>> 
>> So in addition to TGL, extend the logic to RKL to use BIOS provided
>> value to fix the regression.
>
> thanks Kai-Heng! We were not aware of commercial RKL systems following the
> old BIOS guidance, but given you just hit one, then this definitely is
> needed:
>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>          

This had fallen between the cracks, pushed now. Thanks for the patch and
review.

BR,
Jani.

>
> Br, Kai

-- 
Jani Nikula, Intel Open Source Graphics Center
