Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C031EDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBRSG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:06:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:18621 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232542AbhBRPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:34:00 -0500
IronPort-SDR: TYH1bw/ke9QgGSz/ZoIBv+22EiVWqgEgUDUeHJuNym9V4oOyFg4f3xFq1HDFPmewzfbHJlSQTD
 pi5gQAw+mdsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171205920"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="171205920"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 07:31:56 -0800
IronPort-SDR: OouBEYarPuLAOdmgvJYlFPhxnKNIZH9nHQGGiQmc7dbK12MVbrWm8kF8ENYlPbTu8HmlXwGg1r
 AZ2p00thMFwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="385998262"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga008.fm.intel.com with SMTP; 18 Feb 2021 07:31:51 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 18 Feb 2021 17:31:51 +0200
Date:   Thu, 18 Feb 2021 17:31:51 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     lyude@redhat.com, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, greg.depoire@gmail.com,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [Intel-gfx] [RFC v4 10/11] drm/dp: Extract i915's eDP backlight
 code into DRM helpers
Message-ID: <YC6IZ+BUcA5uDCej@intel.com>
References: <20210208233902.1289693-1-lyude@redhat.com>
 <20210208233902.1289693-11-lyude@redhat.com>
 <20210211041540.GI82362@intel.com>
 <355ce12ec69a9b5f20b4a856a40c8abf413be5c0.camel@redhat.com>
 <87mtw1ai4m.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtw1ai4m.fsf@intel.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:35:05AM +0200, Jani Nikula wrote:
> On Fri, 12 Feb 2021, Lyude Paul <lyude@redhat.com> wrote:
> > I think it wouldn't be a bad idea to just address this with a followup series
> > instead and use the old DRM_DEBUG_* macros in the mean time.
> 
> aux->dev is there, could also use dev_dbg et al. in the mean time. They
> handle NULL dev gracefully too if the driver didn't set that.

Last I looked aux->dev was random. Some drivers point it at the
connector vs. some at the the pci/platform device.

-- 
Ville Syrjälä
Intel
