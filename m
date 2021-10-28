Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D15943E3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhJ1OeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:34:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:54352 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhJ1OeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:34:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10151"; a="230683239"
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="230683239"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 07:31:45 -0700
X-IronPort-AV: E=Sophos;i="5.87,190,1631602800"; 
   d="scan'208";a="573767285"
Received: from sjsanghv-mobl.amr.corp.intel.com (HELO [10.212.61.51]) ([10.212.61.51])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 07:31:43 -0700
Subject: Re: [PATCH v2] ASoc: Intel: glk_rt5682_max98357a: support ALC5682I-VS
 codec
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Julian Braha <julianbraha@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
References: <20211028140909.496022-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5a69b8e0-b602-a6bf-e98d-0593e500973e@linux.intel.com>
Date:   Thu, 28 Oct 2021 09:31:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028140909.496022-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/21 9:09 AM, Brent Lu wrote:
> Detect the codec variant in probe function and update DAI link
> accordingly. Also add an new entry in enumeration table for machine
> driver enumeration.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
