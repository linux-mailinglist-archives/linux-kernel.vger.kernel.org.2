Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6B140173B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhIFHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:40:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:14969 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239974AbhIFHk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:40:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10098"; a="305469643"
X-IronPort-AV: E=Sophos;i="5.85,271,1624345200"; 
   d="scan'208";a="305469643"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 00:39:04 -0700
X-IronPort-AV: E=Sophos;i="5.85,271,1624345200"; 
   d="scan'208";a="536560328"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 00:39:01 -0700
Date:   Mon, 6 Sep 2021 10:32:32 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/audio: Use BIOS provided value for RKL HDA
 link
In-Reply-To: <20210906041300.508458-1-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2109061031450.3554566@eliteleevi.tm.intel.com>
References: <20210906041300.508458-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 Sep 2021, Kai-Heng Feng wrote:

> Commit 989634fb49ad ("drm/i915/audio: set HDA link parameters in
> driver") makes HDMI audio on Lenovo P350 disappear.
> 
> So in addition to TGL, extend the logic to RKL to use BIOS provided
> value to fix the regression.

thanks Kai-Heng! We were not aware of commercial RKL systems following the
old BIOS guidance, but given you just hit one, then this definitely is
needed:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>          

Br, Kai
