Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD544626D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhKEK6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhKEK6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:58:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AFAC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 03:55:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p18so10782084plf.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7fdsM52daXciJqnyU5/OzVCaVhDKnkuUr417/ZYsvNw=;
        b=EFNE6b2w+3luKQ+85xyK/0sEBmwzOUa7Vv/yzXOCuyMM+atPYW4qW18bcKfqFUct38
         P7fjJPzHA2fblddnmcuJCjTHn+yrLSk2tgPRRg7axeQ0wcS/yhzxV+smfQI3wRzP9EOd
         VmB9G17c2IpvCQYT9NzttCjp42sdLKog7sNIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7fdsM52daXciJqnyU5/OzVCaVhDKnkuUr417/ZYsvNw=;
        b=Tm30QM5TFkaLYbLJWMi0Ab4a18SGZJ+FXGTgAD+1VsmpZBrDGStvXAqxiiFjjO3CxU
         PEXwp2Vqw+4hx8qzHeG2R9fKrCad3nrdTgtty2Zmb/GxdHjUsviYkk5qDeazIUTdnh5u
         93IooFxOk4ESt3PGpXM6fpEBzBRRlC9g/mXJ08LGka4Qxcz3VU/xNmnlsAERlHdggTvx
         A6IAit9bRECZstTcQHL6nYrWLdDy1yTcmsprwuoKX4Arp7LeaOzIe96ZG34zirQ6O+33
         A8EtbU65KxjciAOZ6yc4L6ifuFZ/2PN8vjg1pLnkufc5CW3TqJqa7n/WnPYLxuOAk6lL
         qg1Q==
X-Gm-Message-State: AOAM533nQeCo1u9FBFGuRNXk4jbvpJY5U39ZYhhxxsyxOQZexh1WRnYY
        9DeOdU5pCJ6C0MGmidessCLc6A==
X-Google-Smtp-Source: ABdhPJwCTOEks/HqEB3MsjkY3hl6kqZcTdp01TkyVsdwZ6RzuTp6/FHOriFqQpl7OvwI6sbG3UD4OA==
X-Received: by 2002:a17:90a:bb14:: with SMTP id u20mr20557433pjr.139.1636109756579;
        Fri, 05 Nov 2021 03:55:56 -0700 (PDT)
Received: from localhost ([2001:4479:e000:e400:c94c:529e:ffcd:fff0])
        by smtp.gmail.com with ESMTPSA id q6sm7423217pfk.115.2021.11.05.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 03:55:56 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Michal Suchanek <msuchanek@suse.de>, keyrings@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 0/3] KEXEC_SIG with appended signature
In-Reply-To: <cover.1635948742.git.msuchanek@suse.de>
References: <cover.1635948742.git.msuchanek@suse.de>
Date:   Fri, 05 Nov 2021 21:55:52 +1100
Message-ID: <87czneeurr.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Suchanek <msuchanek@suse.de> writes:

> S390 uses appended signature for kernel but implements the check
> separately from module loader.
>
> Support for secure boot on powerpc with appended signature is planned -
> grub patches submitted upstream but not yet merged.

Power Non-Virtualised / OpenPower already supports secure boot via kexec
with signature verification via IMA. I think you have now sent a
follow-up series that merges some of the IMA implementation, I just
wanted to make sure it was clear that we actually already have support
for this in the kernel, it's just grub that is getting new support.

> This is an attempt at unified appended signature verification.

I am always in favour of fewer reimplementations of the same feature in
the kernel :)

Regards,
Daniel

>
> Thanks
>
> Michal
>
> Michal Suchanek (3):
>   s390/kexec_file: Don't opencode appended signature verification.
>   module: strip the signature marker in the verification function.
>   powerpc/kexec_file: Add KEXEC_SIG support.
>
>  arch/powerpc/Kconfig                  | 11 +++++++
>  arch/powerpc/kexec/elf_64.c           | 14 +++++++++
>  arch/s390/kernel/machine_kexec_file.c | 42 +++------------------------
>  include/linux/verification.h          |  3 ++
>  kernel/module-internal.h              |  2 --
>  kernel/module.c                       | 11 +++----
>  kernel/module_signing.c               | 32 ++++++++++++++------
>  7 files changed, 59 insertions(+), 56 deletions(-)
>
> -- 
> 2.31.1
