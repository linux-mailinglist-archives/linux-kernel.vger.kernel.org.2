Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334BC347C94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhCXP2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:28:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:55437 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236498AbhCXP22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:28:28 -0400
IronPort-SDR: Ioafy/68hl+RiQKdKANGBTISRybNjAkuiiwyjSez1kpH/yzejjXKbh2+L8mL/iBQlm2zrCY7eZ
 1XRA93MOU3Ug==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190756286"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190756286"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:28:27 -0700
IronPort-SDR: er4V/IKDDaAmR7rV06PSvxdd4lrYBvh7XsGshGR0sfWHXCMc3L7/x+jYrtpKIvi+b6UuWtryNt
 leyVWupht4Lw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608142641"
Received: from mailunda-mobl.amr.corp.intel.com (HELO [10.209.33.48]) ([10.209.33.48])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 08:28:26 -0700
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
To:     Codrin.Ciubotariu@microchip.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mirq-linux@rere.qmqm.pl,
        gustavoars@kernel.org, tiwai@suse.com
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
 <7364fb08-fe43-167d-a083-db4a6234222c@linux.intel.com>
 <2e9d903f-dd76-5b22-77ea-5fc42be306fd@microchip.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <95d0f1c1-5a89-837f-b1dc-42482a3b1250@linux.intel.com>
Date:   Wed, 24 Mar 2021 10:28:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2e9d903f-dd76-5b22-77ea-5fc42be306fd@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I am using hw_params_fixup, but it's not enough. The first thing I do is
> to not add the BE HW constraint rules in runtime->hw_constraints,
> because this will potentially affect the FE HW params. If the FE does
> sampling rate conversion, for example, applying the sampling rate
> constrain rules from a BE codec on FE is useless. The second thing I do
> is to apply these BE HW constraint rules to the BE HW params. It's true
> that the BE HW params can be fine tuned via hw_params_fixup (topology,
> device-tree or even static parameters) and set in such a way that avoid
> the BE HW constraints, so we could ignore the constraint rules added by
> their drivers. It's not every elegant and running the BE HW constraint
> rules for the fixup BE HW params can be a sanity check. Also, I am
> thinking that if the FE does no conversion (be_hw_params_fixup missing)
> and more than one BEs are available, applying the HW constraint rules on
> the same set of BE HW params could rule out the incompatible BE DAI
> links and start the compatible ones only. I am not sure this is a real
> usecase.

Even after a second cup of coffee I was not able to follow why the 
hw_params_fixup was not enough? That paragraph is rather dense.

And to be frank I don't fully understand the problem statement above: 
"separate the FE HW constraints from the BE HW constraints". We have 
existing solutions with a DSP-based SRC adjusting FE rates to what is 
required by the BE dailink.

Maybe it would help to show examples of what you can do today and what 
you cannot, so that we are on the same wavelength on what the 
limitations are and how to remove them?

