Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E12447F16
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbhKHLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:45:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:59429 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239303AbhKHLpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:45:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="232456713"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232456713"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 03:43:06 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="491185072"
Received: from mschuett-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.33.194])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 03:43:04 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Artem S. Tashkinov" <aros@gmx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using bugzilla.kernel.org
In-Reply-To: <6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210110121033.130504-1-linux@leemhuis.info> <6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com>
Date:   Mon, 08 Nov 2021 13:43:01 +0200
Message-ID: <87mtme98l6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Nov 2021, "Artem S. Tashkinov" <aros@gmx.com> wrote:
> Let me continue.
>
> Here's something which is really bad for bugzilla.kernel.org:
>
> People _continue_ to file bug reports for graphics drivers in Linux and
> we don't even have proper components for it, only
>
> Video (AGP) - What? AGP has been dead for a decade.
> Video (DRI - Non Intel)  - what? Isn't it an X.org's feature, not kernel's?
> Video (Other)
>
> This is a complete and total clusterjoy.

FWIW, for Intel graphics (i915) we don't want any bug reports at
bugzilla.kernel.org. We've migrated away more than five years ago. The
"Video (DRI - Intel)" component was closed for new bugs around that
time, the description points at freedesktop.org as does MAINTAINERS:

INTEL DRM DRIVERS (excluding Poulsbo, Moorestown and derivative chipsets)
B:	https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
