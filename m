Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E4424387
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbhJFRAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:00:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:42405 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJFRAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:00:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223441355"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="223441355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:52:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439186776"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:52:54 -0700
Subject: Re: [PATCH 0/3] Multiple headphone codec driver support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <33538866-03a3-4866-2edc-f5fb5928b08f@linux.intel.com>
Date:   Wed, 6 Oct 2021 11:50:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006161805.938950-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 11:18 AM, Brent Lu wrote:
> Support multiple headphone drivers in same machine driver. In this
> case, both rt5682 and rt5682s are supported and enumerated by different
> ACPI HID "10EC5682" and "RTL5682".

Ah, now I get what you're trying to do. I like this a lot!

This is really a 'compatible_id' that the machine driver is capable of
handling.

It would be quite useful indeed to prune some of the tables we have, e.g.

"10EC5640" "10EC5642", "INTCCFFD"
"10EC5645" "10EC5648", etc

In your case you pushed the logic a bit further in that the codec driver
might be different, but the machine driver can deal with it with
run-time autodetection.

Would you mind going through the tables and suggest additional
simplifications with more patches when relevant?

> Brent Lu (3):
>   ASoC: soc-acpi: add alternative id field for machine driver matching
>   ASoC: Intel: sof_rt5682: detect codec variant in probe function
>   ASoC: Intel: sof_rt5682: use id_alt to enumerate rt5682s
> 
>  include/sound/soc-acpi.h                      |  2 ++
>  sound/soc/intel/boards/sof_rt5682.c           | 34 +++----------------
>  .../intel/common/soc-acpi-intel-adl-match.c   |  8 +++++
>  .../intel/common/soc-acpi-intel-byt-match.c   |  6 ++++
>  .../intel/common/soc-acpi-intel-cht-match.c   |  6 ++++
>  .../intel/common/soc-acpi-intel-cml-match.c   |  8 +++++
>  .../intel/common/soc-acpi-intel-icl-match.c   |  6 ++++
>  .../intel/common/soc-acpi-intel-jsl-match.c   | 32 +++++------------
>  .../intel/common/soc-acpi-intel-tgl-match.c   |  8 +++++
>  sound/soc/soc-acpi.c                          | 21 +++++++++++-
>  10 files changed, 76 insertions(+), 55 deletions(-)
> 
