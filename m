Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A4E31AF9C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 08:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhBNHju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 02:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBNHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 02:39:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B096FC061574;
        Sat, 13 Feb 2021 23:39:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u14so4898115wmq.4;
        Sat, 13 Feb 2021 23:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=+/pCeKCEbExGMfLFUD/YBkzoItJszt+z4ktzhK357i0=;
        b=Xcd2rPEEyrg1/VUMWDm/Xai04wqVMfZKoBE1CK3hg0/8WuMlKxJlSDUgRkk2N66Q3A
         CBsAypqJXxg3+Ntr4J/2s+v0n/UNJMOysKu2i1BDUqHkHPZ9p4sEWD4ISqac9Y5rxKEw
         4uWQxkyglhbEgA9XsuUKJZdrXRrefXnA/NVf67GpbPCTAf/KnaeMEHrwnGUAt9qmYSSa
         LtsPKbwE0Sf2KPiqGf1xncbXOEweX/p9413G25tu2IvDkgjFh/6LOOl4AuN2D94ZhCb0
         J3Puv3TzyrK/wop9f6+SMqcVty0j5eQfmuxla4i87Anpyfjvpf9uzuyY3iRqllY6g6yp
         B0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=+/pCeKCEbExGMfLFUD/YBkzoItJszt+z4ktzhK357i0=;
        b=Thkjh1bQMIdibU3rObbmw9NkiqcI8OCJQxhbTgy4dPItd9udGq1uBhJRlNr2jKftcY
         l8KC4OoUCn69kSw3zHJ3n4NeEvT7CRH/3tD1hM9OUlGPxoyPFfCz6b1/bstVmnYyGFD7
         jFBpcpO4gZCJJ2GGmvkvO8HfD++RJ9XRkZZTRyrbfjiWzR5tlVEthqmnAadVR6pa17BD
         g/w6bVvQwdIGk1c8oeSU+GukbWREMh1oE7RxvpgrdRcVTBbWTSP3rhsMAnVU7DNZilfW
         4ICupuCJeL2wtSjjeiQNJFIYRxH1N3fM5cVbH9+GCXOeF4bnacR7aD/i1sfepk/yEpXi
         5g6A==
X-Gm-Message-State: AOAM53135+YBBMtKbQgu1sHxM84Xy7UemY5V8NOrHDpEcHON43djL9Y8
        it6Ikg9POPfPRSkzRJfgkAsl3FzX6BoWQQjzFlY=
X-Google-Smtp-Source: ABdhPJx5Hl7NUn40mJtrDk4E2H4d8NUbk6yqsbZDMe9LVyeiTVjWZna+Tuio2gPct4edXIbFMZiXFA==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr9248266wmy.120.1613288345041;
        Sat, 13 Feb 2021 23:39:05 -0800 (PST)
Received: from [0.0.0.0] ([2a01:4f8:c17:e10a::1])
        by smtp.gmail.com with ESMTPSA id m131sm24031705wmf.41.2021.02.13.23.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 23:39:04 -0800 (PST)
Subject: Re: [PATCH v3 2/3] x86/platform/dell-privacy-wmi: add document for
 dell privacy driver
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Yuan, Perry" <Perry.Yuan@dell.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20210112171755.14408-1-Perry_Yuan@Dell.com>
 <BY3PR19MB49137D1D7508190AF87655FEFAAA0@BY3PR19MB4913.namprd19.prod.outlook.com>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <42f4d67f-56b5-94f8-5373-4e1dd2353c79@gmail.com>
Date:   Sun, 14 Feb 2021 15:38:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <BY3PR19MB49137D1D7508190AF87655FEFAAA0@BY3PR19MB4913.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario:
Thanks for the review.
On 2021/1/13 1:54, Limonciello, Mario wrote:
>> -----Original Message-----
>> From: Yuan, Perry <Perry_Yuan@Dell.com>
>> Sent: Tuesday, January 12, 2021 11:18
>> To: oder_chiou@realtek.com; perex@perex.cz; tiwai@suse.com;
>> hdegoede@redhat.com; mgross@linux.intel.com
>> Cc: lgirdwood@gmail.com; broonie@kernel.org; alsa-devel@alsa-project.org;
>> linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; Yuan,
>> Perry; Limonciello, Mario
>> Subject: [PATCH v3 2/3] x86/platform/dell-privacy-wmi: add document for dell
>> privacy driver
>>
>> From: Perry Yuan <perry_yuan@dell.com>
>>
>> Describe the Dell Privacy feature capabilities and devices
>> state class exposed by BIOS
>>
>> Signed-off-by: Perry Yuan <perry_yuan@dell.com>
>> ---
>>   .../testing/sysfs-platform-dell-privacy-wmi   | 31 +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
> 
> I don't see a reason that the documentation needs to come in it's own commit.
> In v4, I would think this can collapse as part of:
> "Add support for Dell hardware privacy"
Merged this commit PR to privacy PR in V4.
> 
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
>> b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
>> new file mode 100644
>> index 000000000000..3dbc2d25b60e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
>> @@ -0,0 +1,31 @@
>> +What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-
>> D3AB0A901919/devices_supported
>> +Date:		Jan 2021
>> +KernelVersion:	5.11
> I think this is 5.12 material now.
> Need to update this to approximate 5.12 date.
Updated KernelVersion and Date in V4.
> 
>> +Contact:	"perry_yuan@dell.com>"
> 
> I think Dell addresses publicly use a period rather than an underscore, no?
> So shouldn't this be perry.yuan@dell.com? (Although I acknowledge it's an
> alias, I don't trust that I/T wouldn't remove that some day).
> 
>> +Description:
>> +		Display which dell hardware level privacy devices are supported
>> +		“Dell Privacy” is a set of HW, FW, and SW features to enhance
>> +		Dell’s commitment to platform privacy for MIC, Camera, and
>> +		ePrivacy screens.
>> +		The supported privacy haredware privacy devices are:
> 
> You have a typo here.
> 
Fixed.
>> +		 * 0x0 - None,
>> +		 * 0x1 - Microphone,
>> +		 * 0x2 - Camera,
>> +		 * 0x4 - ePrivacy Screen
> 
> So this is an bitmap encoded in the integer?  I think that needs to be mentioned
> in the documentation.
will be updated in V4 like this:

                 ePrivacy screens.
                 The supported hardware privacy devices are:
                 - 0 = Not Supported
                 - 1 = Supported
                 - Bit0 -> Microphone
                 - Bit1 -> Camera
                 - Bit2 -> ePrivacy Screen

> 
>> +
>> +What:		/sys/bus/wmi/devices/6932965F-1671-4CEB-B988-
>> D3AB0A901919/current_state
>> +Date:		Jan 2021
>> +KernelVersion:	5.11
>> +Contact:	"perry_yuan@dell.com>"
>> +Description:
>> +		Allow user space to check current dell privacy device state.
>> +		Describes the Device State class exposed by BIOS which can be
>> +		consumed by various applications interested in knowing the Privacy
>> +		feature capabilities
>> +		There are three Bits for available states:
>> +		    * 0 -> Off
>> +		    * 1 -> On
>> +		    * Bit0 -> Microphone
>> +		    * Bit1 -> Camera
>> +		    * Bit2 -> ePrivacyScreen
>> +
>> --
>> 2.25.1
> 



