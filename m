Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A73424386
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhJFRAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:00:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:42405 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhJFRAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:00:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223441368"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="223441368"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:53:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439186795"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 09:52:58 -0700
Subject: Re: [PATCH 1/3] ASoC: soc-acpi: add alternative id field for machine
 driver matching
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Bard Liao <bard.liao@intel.com>, Takashi Iwai <tiwai@suse.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Libin Yang <libin.yang@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@chromium.org>
References: <20211006161805.938950-1-brent.lu@intel.com>
 <20211006161805.938950-2-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9067ad51-11e1-a51c-4201-a8f0449dca68@linux.intel.com>
Date:   Wed, 6 Oct 2021 11:50:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006161805.938950-2-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +static bool snd_soc_acpi_id_present(struct snd_soc_acpi_mach *machine)
> +{
> +	struct snd_soc_acpi_codecs *id_alt = machine->id_alt;
> +	int i;
> +
> +	if (acpi_dev_present(machine->id, NULL, -1))
> +		return true;
> +
> +	if (id_alt == NULL)

if (!id_alt)

> +		return false;
> +
> +	for (i = 0; i < id_alt->num_codecs; i++) {
> +		if (acpi_dev_present(id_alt->codecs[i], NULL, -1))
> +			return true;
> +	}
> +
> +	return false;
> +}
