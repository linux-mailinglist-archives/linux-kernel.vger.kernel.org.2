Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210573E5C84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 16:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbhHJOF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 10:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241698AbhHJOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628604333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtiTmzY3pIaUti/y98d4Ixo2WE46mGIXl0wbf5FBYy0=;
        b=Nz2ajIvCg06pwVWLnHmSDi+aQnGHrRF0LqEnM/gNB0nECIC/wDX1O9cgCwGQcu2Towlrq7
        QQjNl8J0gDNA3DnsTGpM4C240um1EdXTvlZM/q7CUtLiXfkGr5uZU1uH80iJ3c7kdHepKx
        cZ2TDb1isQeuQVnkaTYi3Ik2ljDcUQQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-TYudZ-UsMcSiwv6ir67adQ-1; Tue, 10 Aug 2021 10:05:32 -0400
X-MC-Unique: TYudZ-UsMcSiwv6ir67adQ-1
Received: by mail-ed1-f72.google.com with SMTP id dh21-20020a0564021d35b02903be0aa37025so8571708edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 07:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtiTmzY3pIaUti/y98d4Ixo2WE46mGIXl0wbf5FBYy0=;
        b=MwSJ0P6OYkc8DUEDBOPRc70tVlKWA/j/gAiXN/x1Q7ySg96gOl6HBAZZzgiNOI6862
         LXPX/ED0XQOuIYR0rv5JNKU5eQQGZeqpcUpn+s0aGKdGw/t+hHyIaVNSbRU4/cTyP5+C
         eHzGKb5oZmm8uNEfaE2UPN5AZdUep9+dFQhOej9JoFhX3JzrG/tKn9VhOEzX76psfZgi
         2e2skGpGaobFljDo2rNkS7Oipv1yfoLn5+RMLs8Alb1O01WbzopPoyhVUnxlB+lI93K0
         RQqz9zoIvfEARjAeZLUloA6ixvN+cJxiE6oTcqLTDuoKaSs0/u8/No8RinTPK5kymnFn
         Iz4g==
X-Gm-Message-State: AOAM530+laTfJyX48WYKy5HMJHQ7p5OPdqDu+ZOjukch65caym7Rnr+f
        X+3fGuJp2Dd+ioE9Wz5By5t2X/5mHyU3A6k0W440ZQeD1uhkeJkbNZthbDqpHmj+HfsvWHBFWCT
        hRTlkPSld8dU2yR++evP663B+
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr5352493edt.194.1628604329711;
        Tue, 10 Aug 2021 07:05:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybam4OK95KbfGTLT4qq0iECd7wk03OvxM2UwWYWGuLqGngIPy8YL2ZVNDIh9/U8JQIo11BzA==
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr5352472edt.194.1628604329536;
        Tue, 10 Aug 2021 07:05:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h8sm7004440ejj.22.2021.08.10.07.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 07:05:29 -0700 (PDT)
Subject: Re: [PATCH 00/20] Move Intel platform drivers to intel directory to
 improve readability.
To:     Kate Hsuan <hpa@redhat.com>, Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org
References: <20210810095832.4234-1-hpa@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3a69ebb0-b27d-e8d5-e219-c6ee388cd628@redhat.com>
Date:   Tue, 10 Aug 2021 16:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810095832.4234-1-hpa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kate,

On 8/10/21 11:58 AM, Kate Hsuan wrote:
> All the intel platform specific drivers are moved to intel/.
> It makes more clear file structure to improve the readability.
> 
> Kate Hsuan (20):
>   Move Intel hid of pdx86 to intel directory to improve readability.
>   Move Intel WMI driver of pdx86 to intel/ directory to improve
>     readability.
>   Move Intel bxtwc driver of pdx86 to intel/ directory to improve
>     readability.
>   Move Intel chtdc_ti driver of pdx86 to improve readability.
>   Move MRFLD power button driver of pdx86 to intel directory to improve
>     readability.
>   Move Intel PMC core of pdx86 to intel/ directory to improve
>     readability.
>   Move Intel PMT driver of pdx86 to intel/ to improve readability.
>   Move Intel P-Unit of pdx86 to intel/ directory to improve readability.
>   Move Intel SCU IPC of pdx86 to intel directory to increase
>     readability.
>   Move Intel SoC telemetry driver to intel directory to improve
>     readability.
>   Move Intel IPS driver of pdx86 to improve readability.
>   Move Intel RST driver of pdx86 to intel directory to improve
>     readability.
>   Move Intel smartconnect driver of pdx86 to intel/ directory to improve
>     readability.
>   Move Intel SST driver to intel/ directory to improve readability.
>   Move Intel turbo max 3 driver to intel/ directory to improve
>     readability.
>   Move Intel uncore freq driver to intel/ directory to improve
>     readability.
>   Move Intel int0002 vgpio driver to intel/ directory to inprove
>     readability.
>   Move Intel thermal driver for menlow platform driver to intel/
>     directory to improve readability.
>   Move OakTrail driver to the intel/ directory to improve readability.
>   Move Intel virtual botton driver to intel/ directory to improve
>     readability.

Thank you for doing this. I have a couple of remarks which I would
like to see addressed for version 2 of this series:

1. The commit messages are currently all one line, so basically
only a Subject and they are missing a Body describing the change
in more detail (as already pointed out by Mika).


2. Kernel patch subjects (the first line of the commit message)
should always be prefixed with the subsystem + component which they
are for, so instead of e.g.

"Move Intel hid of pdx86 to intel directory to improve readability."

you would use:

"platform/x86: intel-hid: Move to intel sub-directory to improve readability."

But that is a bit long; and normally the Subject line is just
a summary while the body explains things like the why, so this should
probably be shorted to:

"platform/x86: intel-hid: Move to intel sub-directory"

For the Subject, with the Body explaining what exactly is being changed
and why.


3. You are using new sub-directories for all drivers which you
are moving, but for drivers which are currently just 1 c-file, this 
means going from 1 c-file to 3 files (c-file + Kconfig + Makefile)
this seems a bit too much. I believe that it would be better for
the single file drivers (e.g. intel-hid.c, intel-vbtn.c) to be moved
directly under drivers/platform/x86/intel and for there Kconfig
and Makefile bits to be moved to the already existing Kconfig
and Makefile files there.


4. As Andy already mentioned when moving a file like
"intel_scu_ipc.c" to drivers/platform/x86/intel/scu then the
whole path becomes:

drivers/platform/x86/intel/scu/intel_scu_ipc.c

Which is quite long / quite a lot to type and repeats
intel + scu twice, so it would be better to drop the intel_scu
prefix from the filenames in this case resulting in:

drivers/platform/x86/intel/scu/ipc.c

in this example's case. This requires some extrea work:

4.1 You will need to adjust private includes to the new
filenames

4.2 If you simply adjust say this Makefile line:

obj-$(CONFIG_INTEL_SCU_PCI)             += intel_scu_pcidrv.o

to:

obj-$(CONFIG_INTEL_SCU_PCI)             += pcidrv.o

a pcidrv.ko will get build, but that is a very generic name
and then we end up with module-name clashes which are not
allowed.

So the Makefile needs to become a bit more complicated like this:

intel_scu_pcidrv-y			:= pcidrv.o
obj-$(CONFIG_INTEL_SCU_PCI)             += intel_scu_pcidrv.o

See for example:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/tree/drivers/platform/x86/intel/pmt/Makefile?h=for-next


5. Some of the files which you are moving are mentioned in the
MAINTAINERS file. For each file which you are moving please check if
it is listed in the MAINTAINERS file, keeping wildcards in mind,
so search e.g. for intel_scu for the intel_scu_* move.

And if the file is listed then update the MAINTAINERS entry to
point to the new location.

Regards,

Hans

