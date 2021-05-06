Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10337522F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhEFKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:22:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:61189 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234255AbhEFKWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:22:15 -0400
IronPort-SDR: FSFa3PgHD7EGpT+4FlVQXZbpYEJ0kmC1fhTDqdn5HGs36qPi7UtgGTFzKhPigevB7qJdLUsRLn
 BWl8Lr7tys+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="185898700"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="185898700"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 03:21:16 -0700
IronPort-SDR: GgolOtDyPmHA/AIXB+KiwHGt5NW9QGzfa9aW81ZjEibtnyclbuj615P6XnszvPQ32QQ1hregfS
 LUCS18Prlk6Q==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="430465859"
Received: from tchrzano-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.214])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 03:21:11 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Werner Sembach <wse@tuxedocomputers.com>, wse@tuxedocomputers.com,
        ville.syrjala@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH 1/3] New function to avoid duplicate code in upcomming commits
In-Reply-To: <20210505172401.1453178-2-wse@tuxedocomputers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210505172401.1453178-1-wse@tuxedocomputers.com> <20210505172401.1453178-2-wse@tuxedocomputers.com>
Date:   Thu, 06 May 2021 13:21:08 +0300
Message-ID: <87pmy4w4bv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 May 2021, Werner Sembach <wse@tuxedocomputers.com> wrote:
> Subject: [PATCH 1/3] New function to avoid duplicate code in upcomming commits

Also, the subject should have a prefix, such as "drm/i915/hdmi: "
etc. depending on what you're changing. See git log on the files for
examples.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
