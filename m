Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A859315C31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhBJB0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:26:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:15679 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234824AbhBIXLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:11:37 -0500
IronPort-SDR: Yq8K1IXHHu/P6mCAvEDC2BqIN40tfYrwnykZdJeUyQcx9HTVQkh41ZTfZf4I4VY3wDUmPiJCm9
 486U6ndPofIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="246041830"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="246041830"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 15:05:18 -0800
IronPort-SDR: a6arwtBDVlPnid9+/2ah9wjbZszzK/zJLS0ONW6THj5ne4QAa+B8fBY/tZKS6ShOMB874XtM2k
 fczV6phvdBYw==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="510117583"
Received: from muncuer-mobl1.amr.corp.intel.com (HELO [10.209.127.55]) ([10.209.127.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 15:05:17 -0800
Subject: Re: [PATCH] ASoC: soc-pcm: change error message to debug message
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <1612771965-5776-1-git-send-email-shengjiu.wang@nxp.com>
 <b7f5442d-ad21-eb8a-7d90-7a8207320541@linux.intel.com>
 <20210209222331.GD4916@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a3cac294-4562-3042-7118-f013d6e4300b@linux.intel.com>
Date:   Tue, 9 Feb 2021 17:05:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209222331.GD4916@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/21 4:23 PM, Mark Brown wrote:
> On Mon, Feb 08, 2021 at 09:06:44AM -0600, Pierre-Louis Bossart wrote:
> 
>> If you demote this to dev_dbg, we'll have to ask every single user who
>> reports 'sound is broken' to enable dynamic debug traces. I really don't see
>> the benefit, this is a clear case of 'fail big and fail early', partly
>> concealing the problem doesn't make it go away but harder to diagnose.
> 
> Don't you also get the same information out of the DAPM debugfs or did
> I misread where the error is generated from?

I re-checked and I will back-pedal on my comment. I confused this error 
message with the classic "ASoC: no backend DAIs enabled for %s".

I didn't find a single occurrence of this "ASoC: no BE found for %s" in 
any bug report or Google search.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


