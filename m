Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCFA34EA54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhC3OXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:23:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:15630 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232141AbhC3OXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:23:04 -0400
IronPort-SDR: nR9NUb2xROaGigpRtLMVCWocP4gFQkAs+ZJa/oOMWceOvnUrLLST15azimzX1uJsSGg8+b8l8k
 g3lOOSZei8rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191874655"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191874655"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 07:23:00 -0700
IronPort-SDR: ghwn0ifiJw8J7fxvJoWtadsdpQs8QxU/11b4VnX/XZukEvV1bDWcHn9gPakWimqSBwy6MTEMIl
 2J8X0rYuD8Cw==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="393626944"
Received: from feifeich-mobl1.amr.corp.intel.com (HELO [10.212.41.240]) ([10.212.41.240])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 07:22:58 -0700
Subject: Re: [PATCH] ASoC: amd: Add support for ALC1015P codec in acp3x
 machine driver
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     shumingf@realtek.com, flove@realtek.com, kent_chen@realtek.com,
        jack.yu@realtek.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1617095628-8324-1-git-send-email-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <82817878-a30d-2b0c-07f8-48bcca3ebc80@linux.intel.com>
Date:   Tue, 30 Mar 2021 09:22:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1617095628-8324-1-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   static const struct acpi_device_id acp3x_audio_acpi_match[] = {
>   	{ "AMDI5682", (unsigned long)&acp3x_5682},
>   	{ "AMDI1015", (unsigned long)&acp3x_1015},
> +	{ "AMDP1015", (unsigned long)&acp3x_1015p},

This isn't a valid ACPI ID. AMDP does not exist in
https://uefi.org/acpi_id_list

There was a similar issue with Intel platforms using this part, we had 
to use a different HID.


