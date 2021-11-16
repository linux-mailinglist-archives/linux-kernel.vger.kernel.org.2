Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28EA452EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhKPKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:20:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233917AbhKPKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637057843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHDw3qbaHSdo+my0Y7JfI4dnG9qTgWZ7WAXsbYKfhUk=;
        b=a9sTBexYmq2uamtxgqtOASw1hfhNPK8h2fdmaMDjKvZqy3eNlzt4X1lYpZmJcJjw1QE/i6
        JC9uwVvG2xFZ+iYBLoQc2SG1bMX13+LrC5HD1IY+kQueAjJVyU59m7sSnTPQdr6eif9oR0
        n2nWORJK7nk4lAQE50WQfT59IjrwSHE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-p8c8l305NN2BAIHjasnJqw-1; Tue, 16 Nov 2021 05:17:22 -0500
X-MC-Unique: p8c8l305NN2BAIHjasnJqw-1
Received: by mail-ed1-f70.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso4246558edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wHDw3qbaHSdo+my0Y7JfI4dnG9qTgWZ7WAXsbYKfhUk=;
        b=thVdxrH6AArWZ75OWwc2QxGHeAIDRfemJ6R+3bob8RuteVmonPvAHrdEwXKp2msSZV
         HIPm+chM9Myt27Jl1F6qSJp70M/6x4E6u2xj+36Fll4VZWrufcK/4GWixDo5wiRaW/LL
         XNvURH91wotd656AnMGV/8yRFEtN2x/N2EdyvBQfmDbMTIl89c4t42noZQcHsu9cnANQ
         BVqkC3S41r4rTdtOA6lxdAEsbxrOsiXHI2zCcuwR9n9pTOPeuzyfXQ0BKyBbVNAjksXT
         /00ToszR0Ecfve5HjaXU+naVsN5y8+6/cqV5JvJPuCxatQqutRIONcRh2UbgHsFBU6pi
         N7hw==
X-Gm-Message-State: AOAM533OiF8PC+1hoCAeB1KepuaIY6XQxyXkWCMhBxsztkPbRYc4rny3
        3XeGLhBuwCJkCYgXI0iFwskwHYIHprrPRQM2J/MYijzu9GopStwmh5Q7qOR4Wx/j/b9BewHaN7U
        HsZMDbXkTfZxHLPvcMcwkFibV
X-Received: by 2002:a17:906:489a:: with SMTP id v26mr8366245ejq.305.1637057840768;
        Tue, 16 Nov 2021 02:17:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxh2xl7BPwc9XZiVht4ez681MUFWegeEqdXpxCbhK6FrTWxsBfmETytBnfoIVqhakSOuDDylQ==
X-Received: by 2002:a17:906:489a:: with SMTP id v26mr8366225ejq.305.1637057840606;
        Tue, 16 Nov 2021 02:17:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cs12sm7897172ejc.15.2021.11.16.02.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:17:20 -0800 (PST)
Message-ID: <5b2c4f59-deaf-a084-e9fa-d63ffa316452@redhat.com>
Date:   Tue, 16 Nov 2021 11:17:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: drivers/platform/x86/thinkpad_acpi.c:918:30: error: unused
 variable 'dispatch_proc_ops'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <202111140045.CyDFTOZZ-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202111140045.CyDFTOZZ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/13/21 17:44, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   66f4beaa6c1d28161f534471484b2daa2de1dce0
> commit: fd96e35ea7b95f1e216277805be89d66e4ae962d platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
> date:   4 weeks ago
> config: i386-buildonly-randconfig-r002-20211109 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 63ef0e17e28827eae53133b3467bdac7d9729318)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd96e35ea7b95f1e216277805be89d66e4ae962d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout fd96e35ea7b95f1e216277805be89d66e4ae962d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/platform/x86/thinkpad_acpi.c:918:30: error: unused variable 'dispatch_proc_ops' [-Werror,-Wunused-const-variable]
>    static const struct proc_ops dispatch_proc_ops = {
>                                 ^
>    1 error generated.

So this has absolutely nothing to do with the:

"platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning"

commit, the problem is that:

1. the .config does not have CONFIG_PROC_FS set; combined with:
2. include/linux/proc_fs.h using a #define instead of a
   static inline for proc_create_data() when this is the case
3. This is a clang WERROR build

The thinkpad_acpi code cannot really function without procfs
support anyways (it will error out on probe if proc_create_data()
returns NULL) so I will shortly submit a fix adding a
depends on PROC_FS to fix this.

I must say that as a maintainer I'm unhappy about the amount
of noise being generated by clang WERROR builds here though,
is it really necessary for the kernel test robot to do builds
of this type ?

Regards,

Hans





> 
> 
> vim +/dispatch_proc_ops +918 drivers/platform/x86/thinkpad_acpi.c
> 
> ^1da177e4c3f41 drivers/acpi/ibm_acpi.c              Linus Torvalds  2005-04-16  917  
> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03 @918  static const struct proc_ops dispatch_proc_ops = {
> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  919  	.proc_open	= dispatch_proc_open,
> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  920  	.proc_read	= seq_read,
> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  921  	.proc_lseek	= seq_lseek,
> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  922  	.proc_release	= single_release,
> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  923  	.proc_write	= dispatch_proc_write,
> 887965e6576a78 drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2009-12-15  924  };
> 887965e6576a78 drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2009-12-15  925  
> 
> :::::: The code at line 918 was first introduced by commit
> :::::: 97a32539b9568bb653683349e5a76d02ff3c3e2c proc: convert everything to "struct proc_ops"
> 
> :::::: TO: Alexey Dobriyan <adobriyan@gmail.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

