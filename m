Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E776E3D01E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhGTSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:07:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:2800 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231745AbhGTSG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:06:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="296869504"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="296869504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:47:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="462146686"
Received: from aremenni-mobl.amr.corp.intel.com (HELO [10.209.130.10]) ([10.209.130.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 11:47:32 -0700
Subject: Re: [PATCH v4 12/12] ASoC: amd: enable vangogh acp5x driver build
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
 <20210720163732.23003-13-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <76ac28ba-8965-f757-974e-1e70729207da@linux.intel.com>
Date:   Tue, 20 Jul 2021 13:31:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720163732.23003-13-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +config SND_SOC_AMD_ACP5x
> +	tristate "AMD Audio Coprocessor-v5.x I2S support"
> +	depends on X86 && PCI
> +	help
> +	 This option enables ACP v5.x support on AMD platform
> +
> +	 By enabling this flag build will trigger for ACP PCI driver,
> +	 ACP DMA drvier, CPU DAI driver.

typo: driver
 
