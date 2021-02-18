Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961FD31E85B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBRJw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:52:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:25393 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhBRIkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:40:45 -0500
IronPort-SDR: Pf9omYLpZCmuPxENbQj2NP0m8pI4Lwxk0CWFm3OXjaB+1s/FeZVsjWQjYVc7+XpDWL9ol2xJ+g
 nSP/FW48Dghg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183561541"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="183561541"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 00:35:15 -0800
IronPort-SDR: uwBmf4yGcSmtx7h+yFIaOUYqETNcs87WxE3iddYstACQozLswauYt27Nd7xgxrensaeXIaOJgF
 PRAzgaJt9KCQ==
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400405752"
Received: from cklinger-mobl.ger.corp.intel.com (HELO localhost) ([10.249.38.13])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 00:35:09 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     lyude@redhat.com, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>, greg.depoire@gmail.com,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [Intel-gfx] [RFC v4 10/11] drm/dp: Extract i915's eDP backlight code into DRM helpers
In-Reply-To: <355ce12ec69a9b5f20b4a856a40c8abf413be5c0.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210208233902.1289693-1-lyude@redhat.com> <20210208233902.1289693-11-lyude@redhat.com> <20210211041540.GI82362@intel.com> <355ce12ec69a9b5f20b4a856a40c8abf413be5c0.camel@redhat.com>
Date:   Thu, 18 Feb 2021 10:35:05 +0200
Message-ID: <87mtw1ai4m.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021, Lyude Paul <lyude@redhat.com> wrote:
> I think it wouldn't be a bad idea to just address this with a followup series
> instead and use the old DRM_DEBUG_* macros in the mean time.

aux->dev is there, could also use dev_dbg et al. in the mean time. They
handle NULL dev gracefully too if the driver didn't set that.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
