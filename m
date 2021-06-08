Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226DC39F10B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFHIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623141391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Eh2tbzQy0I6sGObsp+EH5kZsIqpt+v1Z/Z8bPq4YTw=;
        b=GoNSOrRmrf5qicnViszQ+zRxNo4q226iCJW0SV5PQsS6Sv4qi2H7xcubiT9YvphLupvzIl
        8pK4iVTPR7oOLf2N5hqc/wh2Y5LvIMnOmpwzEpjDGPu7ngJIeM5vxZH202ntB5lcEk2Mkz
        ggi8kKFRKpqDtQxmGsPG1l8U62xEz+A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-fV0g-dzTMgObMEZ_mc3x1g-1; Tue, 08 Jun 2021 04:36:30 -0400
X-MC-Unique: fV0g-dzTMgObMEZ_mc3x1g-1
Received: by mail-ej1-f71.google.com with SMTP id ji22-20020a1709079816b0290414bdf5da11so2026045ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 01:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Eh2tbzQy0I6sGObsp+EH5kZsIqpt+v1Z/Z8bPq4YTw=;
        b=ZaGRExw3cniWNqVKdOTR9kf/7UijgcaczIGq55pQPyocLd7hY7KYwN6O2dpic8Gw69
         s/OcpLXELz/nwtz3OWE9WD6xrp0L9+fSmUHL8o/OYvOLWbJehHrQ7oXYFiEcPd9sedCQ
         h8NL3Fi4MxH/BKsJ7ttG7j50eisg97FaO10fkaLskrxKodFcrCfDgxpWVnM1ZxRtT7e3
         YTaRF8KX752yxnJ5ii+SgFHXRZkrlzXxNMjCZNQiOxJJN/AyTfoDQ8If1F92fsLKdyFY
         uSAF6DNH2g5nTgWXDnOwsr7luVwO8hqVqHwsso51o6g2pNsLjS+co7l7v9LmNLdUGQp+
         dPxg==
X-Gm-Message-State: AOAM531iXUxUHauhd6/AyD/mbni7axYeMpkR90JlddSTDepgTdJ97h0f
        tPcRCtUvU+TodQGMZlyyIFoj6urK8ccMTlQXK0srKXkkkMwPfz2YZV+4oo/+sPhjMoVFfGpJ9SN
        TJ0c4+XwsFdHn1WCRLImeLzSfaAvp3ITDMk8/ocbCUN4Tzvk6GlOHRckgw5/Hma1KNubSpx6mmr
        aC
X-Received: by 2002:a17:906:2459:: with SMTP id a25mr21706701ejb.306.1623141388724;
        Tue, 08 Jun 2021 01:36:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIx+1j1fAS8gaQEhCqojQJfbyd7ILv45M0JXn8kluuHDw4hD27NLm1IjXEW1SszvcvmDRHMg==
X-Received: by 2002:a17:906:2459:: with SMTP id a25mr21706683ejb.306.1623141388509;
        Tue, 08 Jun 2021 01:36:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cz14sm8599951edb.84.2021.06.08.01.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 01:36:28 -0700 (PDT)
Subject: Re: drivers/platform/x86/dell/dell-smbios-smm.c:27:35: warning:
 unused variable 'dell_device_table'
To:     kernel test robot <lkp@intel.com>,
        Mario Limonciello <mario.limonciello@outlook.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <202106080633.CrTbLIPD-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e706a5d6-fabb-4506-1192-d8b40d1c2cf2@redhat.com>
Date:   Tue, 8 Jun 2021 10:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <202106080633.CrTbLIPD-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<replaced Mario's old Dell email address which one which works>

Hi all,

On 6/8/21 12:41 AM, kernel test robot wrote:
> Hi Mario,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   614124bea77e452aa6df7a8714e8bc820b489922
> commit: f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28 platform/x86: Move all dell drivers to their own subdirectory
> date:   4 months ago
> config: x86_64-randconfig-r023-20210608 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project ae973380c5f6be77ce395022be40350942260be9)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/platform/x86/dell/dell-smbios-smm.c:27:35: warning: unused variable 'dell_device_table' [-Wunused-const-variable]
>    static const struct dmi_system_id dell_device_table[] __initconst = {
>                                      ^
>    1 warning generated.
> 
> 
> vim +/dell_device_table +27 drivers/platform/x86/dell/dell-smbios-smm.c
> 
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  26  
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01 @27  static const struct dmi_system_id dell_device_table[] __initconst = {
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  28  	{
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  29  		.ident = "Dell laptop",
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  30  		.matches = {
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  31  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  32  			DMI_MATCH(DMI_CHASSIS_TYPE, "8"),
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  33  		},
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  34  	},
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  35  	{
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  36  		.matches = {
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  37  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  38  			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /*Laptop*/
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  39  		},
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  40  	},
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  41  	{
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  42  		.matches = {
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  43  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  44  			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /*Notebook*/
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  45  		},
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  46  	},
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  47  	{
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  48  		.ident = "Dell Computer Corporation",
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  49  		.matches = {
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  50  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  51  			DMI_MATCH(DMI_CHASSIS_TYPE, "8"),
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  52  		},
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  53  	},
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  54  	{ }
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  55  };
> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  56  MODULE_DEVICE_TABLE(dmi, dell_device_table);

Note the MODULE_DEVICE_TABLE() here; and I checked and CONFIG_DMI=y in the config used
here as expected, so this seems like a false-positive warnings, with that said I was
still a bit surprised about the presence of this table since dell-smbios is depended
on by dell-laptop and that has this same table + same extra entries for chassis-type
30, 31 and 32.

Since dell-laptop will already auto-load based on the DMI table in there (which also is
more complete) and since dell-laptop will then bring in the dell-smbios module, the only
scenario I can think of where this DMI table inside dell-smbios-smm.c is useful is if
users have the dell-laptop module disabled and they want to use the sysfs interface
offered by dell-smbios-smm.c. But that seems such a corner case that I believe it
would be fair to tell users to do a modprobe themselves in this case ?

This would allow removing the dupplicate table from dell-smbios-smm.c, which would be
a good thing, because as the differences between the 2 copies which have accumulated
over time show, having the same table in 2 places seems like a bad idea.

Mario, even though you are no longer at Dell, I would still very much appreciate your
thoughts on this.

Regards,

Hans



> 549b4930f05765 drivers/platform/x86/dell-smbios-smm.c Mario Limonciello 2017-11-01  57  
> 
> :::::: The code at line 27 was first introduced by commit
> :::::: 549b4930f057658dc50d8010e66219233119a4d8 platform/x86: dell-smbios: Introduce dispatcher for SMM calls
> 
> :::::: TO: Mario Limonciello <mario.limonciello@dell.com>
> :::::: CC: Darren Hart (VMware) <dvhart@infradead.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

