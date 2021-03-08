Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E0E3312F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhCHQJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:09:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:55326 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhCHQId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:08:33 -0500
IronPort-SDR: gFb1jV6gJMry50dm84CLCqOcLhfCIMlF8nr2ZYaRw/Z0qTew5dBhEHOsojnNigenYiiNTTx4CW
 ieH3EC7jrUpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="175670091"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="175670091"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:08:32 -0800
IronPort-SDR: 7xvXDaBmiRvJYe8eucLvrGEutIsDjhWs721psE+w0KtQcP+foNbzbNi3+dKN+SxV2UKfPdlkAt
 84ncFQ9wuRqg==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="430418999"
Received: from dbdavenp-mobl1.amr.corp.intel.com (HELO [10.212.234.206]) ([10.212.234.206])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:08:31 -0800
Subject: Re: [PATCH v3 3/4] ALSA: hda/cirrus: Add jack detect interrupt
 support from CS42L42 companion codec.
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
 <20210306111934.4832-4-vitalyr@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3ddc27d5-7d6d-e244-51fa-6ac17ee9779a@linux.intel.com>
Date:   Mon, 8 Mar 2021 09:35:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306111934.4832-4-vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> @@ -38,6 +39,15 @@ struct cs_spec {
>   	/* for MBP SPDIF control */
>   	int (*spdif_sw_put)(struct snd_kcontrol *kcontrol,
>   			    struct snd_ctl_elem_value *ucontrol);
> +
> +	unsigned int cs42l42_hp_jack_in:1;
> +	unsigned int cs42l42_mic_jack_in:1;
> +
> +	struct mutex cs8409_i2c_mux;

what does this protect? there isn't any comment or explanations in the 
commit message.


