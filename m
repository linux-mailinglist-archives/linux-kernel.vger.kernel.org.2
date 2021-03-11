Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8779F336D66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhCKH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:59:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:46483 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhCKH7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:59:05 -0500
IronPort-SDR: PwbI0/dgTnbif/nTFDP2AETXHc0yDeLXRZ2GkJgLxZq4vZMKmjJWelo8hgC/vT02jczNt0746U
 +Zin77lG/xIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="208447090"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="208447090"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:59:04 -0800
IronPort-SDR: qbDtCL6QXRic/IwLLzR2J8V5sbdWEIsD85pctovP/O4bsXSjIxuEQm+sCvhyNGg3yvCoIbPvJt
 2uA8Mjb+Po7Q==
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="448203759"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.16.216]) ([10.213.16.216])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 23:59:00 -0800
Subject: Re: No sound cards detected on Kabylake laptops after upgrade to
 kernel 5.8
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <CABTNMG31sH99P0F7EKhpFwJf99x4U-VjFWrwXVe1wkra6owFLw@mail.gmail.com>
 <dba864a6-1442-1ebc-9de0-8c1511682b70@intel.com>
 <CABTNMG1bO2AJLY0o58TX2=1QZPnPsZXabtYZA01QyqDS40JORg@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <4ec526eb-cb2e-e0e3-8f23-6f7a25b9919b@intel.com>
Date:   Thu, 11 Mar 2021 08:58:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CABTNMG1bO2AJLY0o58TX2=1QZPnPsZXabtYZA01QyqDS40JORg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-11 6:50 AM, Chris Chiu wrote:
> On Tue, Mar 9, 2021 at 11:29 PM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
>>

...

>> Topologies for most common skylake driver configurations:
>> - skl/kbl with i2s rt286
>> - apl/glk with i2s rt298
>> - <any> with hda dsp
>> can be found in alsa-topology-conf [2].
>>
>> Standard, official tool called 'alsatplg' is capable of compiling these
>> into binary form which, after being transferred to /lib/firmware/ may be
>> consumed by the driver during runtime.
>> I have no problem with providing precompiled binaries to linux-firmware,
>> if that's what community wants.

...

> 
> I think the guild [1] is too complicated for normal users to fix the problem.
> Given it's not only the internal microphone being affected, it's no sound
> devices being created at all so no audio functions can work after kernel 5.8.
> 
> Is there any potential problem to built-in the "<any> with hda dsp" precompiled
> binary in linux-firmware?

In general, linux-firmware is not the place to put driver-specific 
configuration files. It'd best to have standard UCM/topology files being 
build and honored during disto image creation.

In regard to the guide, thanks for checking it out. What do you think 
could be improved so that normal user has easier time with it? Feedback 
is much appreciated.

Regards,
Czarek
