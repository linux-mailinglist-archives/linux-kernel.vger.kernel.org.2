Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443B635E321
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345966AbhDMPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:48:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:16036 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237575AbhDMPss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:48:48 -0400
IronPort-SDR: NJZepWQAXnR/X7nL+dAu9jGEYVdU9ZRRa/qrbwC9liX7+9bHem9xtU0Fi+7F2jntAxX1jOOiDM
 2eqjKs6AlZhA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194005229"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="194005229"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 08:47:53 -0700
IronPort-SDR: LK2OLSsjsiHBU0LfKcBf95yfTe7ynkpXltGI5HC8lHIdPRgGwScwZSvvZRZcDAObJXvgdxBJx8
 GAizSA1uYd1A==
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="460627823"
Received: from kmartin1-mobl1.amr.corp.intel.com (HELO [10.212.30.204]) ([10.212.30.204])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 08:47:52 -0700
Subject: Re: [PATCH] ASoC: Intel: Handle device properties with software node
 API
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
 <786795eb-6832-fd7d-4674-65be394c083d@linux.intel.com>
 <YFm0u9k/DNy5URsR@kuha.fi.intel.com>
 <39e2ab87-3b70-8659-6282-5b03d30f901b@linux.intel.com>
 <YHWMmR5gBvlpd7rl@kuha.fi.intel.com> <YHWlQooPtrTjyq+i@kuha.fi.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4c7aa8d0-8660-b545-4b40-c6965e667a93@linux.intel.com>
Date:   Tue, 13 Apr 2021 10:47:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YHWlQooPtrTjyq+i@kuha.fi.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/21 9:05 AM, Heikki Krogerus wrote:
> On Tue, Apr 13, 2021 at 03:20:45PM +0300, Heikki Krogerus wrote:
>> On Mon, Apr 12, 2021 at 03:36:20PM -0500, Pierre-Louis Bossart wrote:
>>> I took the code and split it in two for BYT/CHT (modified to remove devm_)
>>> and SoundWire parts (added as is).
>>>
>>> https://github.com/thesofproject/linux/pull/2810
>>>
>>> Both cases result in a refcount error on device_remove_sof when removing the
>>> platform device. I don't understand the code well enough to figure out what
>>> happens, but it's likely a case of the software node being removed twice?
>>
>> Right. Because you are injecting the node to an already existing
>> device, the node does not get linked with the device in sysfs. That
>> would increment the reference count in a normal case. It all happens
>> in the function software_node_notify(). Driver core calls it when a
>> device is added and also when it's removed. In this case it is only
>> called when it's removed.
>>
>> I think the best way to handle this now is to simply not decrementing
>> the ref count when you add the properties, so don't call
>> fwnode_handle_put() there (but add a comment explaining why you are
>> not calling it).
> 
> No, sorry... That's just too hacky. Let's not do that after all.
> 
> We can also fix this in the software node code. I'm attaching a patch
> that should make it possible to inject the software nodes also
> afterwards safely. This is definitely also not without its problems,
> but we can go with that if it works. Let me know.

I tested manually on bytcr w/ RT5640 and used the SOF CI farm to test 
the SoundWire cases, I don't see any issues with your patch. The 
refcount issue is gone and the module load/unload cycles don't report 
any problems.

Would you queue it for 5.13-rc1, or is this too late already?

>> For a better solution you would call device_reprobe() after you have
>> injected the software node, but before that you need to modify
>> device_reprobe() so it calls device_platform_notify() (which it really
>> should call in any case). But this should probable be done later,
>> separately.
>>
>> thanks,
>>
>> P.S.
>>
>> Have you guys considered the possibility of describing the connections
>> between all these components by using one of the methods that we now
>> have for that in kernel, for example device graph? It can now be
>> used also with software nodes (OF graph and ACPI device graph are of
>> course already fully supported).

I must admit I've never heard of a 'device graph'. Any pointers or APIs 
you can think of?
It's a good comment since we are planning to rework the SOF clients and 
machine driver handling.
