Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B142596D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbhJGR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:29:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:60403 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233695AbhJGR3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:29:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="225089216"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="225089216"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:27:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="440347800"
Received: from klmutolo-mobl.amr.corp.intel.com (HELO [10.212.1.203]) ([10.212.1.203])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:27:16 -0700
Subject: Re: [PATCH v2 1/3] ASoC: soc-acpi: add comp_ids field for machine
 driver matching
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
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
References: <20211007133516.1464655-1-brent.lu@intel.com>
 <20211007133516.1464655-2-brent.lu@intel.com>
 <7e6cf92f-b889-aed9-b13a-615d4d5f9b93@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2ae5e8ef-76cb-8335-e250-64b0246175f3@linux.intel.com>
Date:   Thu, 7 Oct 2021 12:27:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7e6cf92f-b889-aed9-b13a-615d4d5f9b93@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   struct snd_soc_acpi_mach *
>>   snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>>   {
>>       struct snd_soc_acpi_mach *mach;
>>       struct snd_soc_acpi_mach *mach_alt;
>>   -    for (mach = machines; mach->id[0]; mach++) {
>> -        if (acpi_dev_present(mach->id, NULL, -1)) {
>> +    for (mach = machines; mach->id[0] || mach->comp_ids; mach++) {
> 
> Such loops are hard to maintain i.e. 'comp_ids' acts here like a flex
> array that follows 'id'. Removal of 'id' field and streamlining code to
> only use 'comp_ids' should make this loop more intuitive.

Changing all the tables adds more noise IMHO. There are 15 files and
about 100 ids.

This patch provides an opportunity to reduce duplication, that's good,
but let's leave all the existing unique table entries alone, shall we?
