Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0021B452EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhKPK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:27:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhKPK0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637058233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqYiObSXGPXWR6NuE2CwM3ifjdym9ke+lZHPUSttryw=;
        b=LMFsGbi8dFv2FCM/AKcggCCxMku7/gbl3rPS3pjsl0kPYjUvMouRVAhbag+ja6GrS8hMuA
        ZLv077cf2wTtVdftWOKtK8QoxDOk0zmnhdWmch4h9holeE8YnvcKbQ1sLv8XYx6y5E7eLr
        yFJJJ5Bi/2TE9jWBt/eDiktDpRxTDr4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-lhs5ny3xPZWdiEQK44cIpA-1; Tue, 16 Nov 2021 05:23:51 -0500
X-MC-Unique: lhs5ny3xPZWdiEQK44cIpA-1
Received: by mail-ed1-f69.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso16823298edj.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=bqYiObSXGPXWR6NuE2CwM3ifjdym9ke+lZHPUSttryw=;
        b=baAw8BEc3VjhOSfJtNcEc1+Jc6zHlIEScCnHE6YLkR69nVs0bKGRpG8wmGdgVk/3tx
         OcgZu6Se40a+Y9amHAoqWLtwW439sbm3ehq9Z1e9bjNEmyT71dO0tD7nQj8ZdEFLzdCM
         YS4e2SPTOq6QZyUb70cVc43V7Tnp8j3rQo5H+spj0QVSxUYKJcYtqwu2AUlCaf0J8wCD
         7xnglDgdpkVav/zIapxm2nVO4ZGtdyPfgwdtuVx3AvQn3K0kfFCq+1bH3qMTVmo3SfnG
         sx3+jPWcR7dqSY4SbtosoO20S5L9hS4SH9XQCK47BBQI3s+Ft90cP+/cjPoyGOIYz8hV
         gfGw==
X-Gm-Message-State: AOAM532Qj1Y+z+bR02sLMXxb0lakFOUr7rdx87dGnzUZdqI/uVDJiMcF
        j5gJIDeFjynN7eKb/sJYEi/uyWwVZBLE8jUcafOqWxotHCqQHn/wg7+xwknEq7TUtLMg+UMiLS6
        9ZGSDr7DfBjgzJK18ELKFy3Hr
X-Received: by 2002:a17:906:9744:: with SMTP id o4mr8528981ejy.322.1637058229889;
        Tue, 16 Nov 2021 02:23:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzX2KsnJZSoQG+b+bHMUFGqmmSAeQqitIwEu9Qv5jNXoFwoM0aiQrM+WQxFLtuHfEHiAcyZMQ==
X-Received: by 2002:a17:906:9744:: with SMTP id o4mr8528949ejy.322.1637058229701;
        Tue, 16 Nov 2021 02:23:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f17sm5957609edf.21.2021.11.16.02.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:23:49 -0800 (PST)
Message-ID: <0e8ed818-7f09-bc1f-f292-8b1a441df0b4@redhat.com>
Date:   Tue, 16 Nov 2021 11:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: drivers/platform/x86/thinkpad_acpi.c:918:30: error: unused
 variable 'dispatch_proc_ops'
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <202111140045.CyDFTOZZ-lkp@intel.com>
 <5b2c4f59-deaf-a084-e9fa-d63ffa316452@redhat.com>
In-Reply-To: <5b2c4f59-deaf-a084-e9fa-d63ffa316452@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/16/21 11:17, Hans de Goede wrote:
> Hi,
> 
> On 11/13/21 17:44, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   66f4beaa6c1d28161f534471484b2daa2de1dce0
>> commit: fd96e35ea7b95f1e216277805be89d66e4ae962d platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
>> date:   4 weeks ago
>> config: i386-buildonly-randconfig-r002-20211109 (attached as .config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 63ef0e17e28827eae53133b3467bdac7d9729318)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fd96e35ea7b95f1e216277805be89d66e4ae962d
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout fd96e35ea7b95f1e216277805be89d66e4ae962d
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/platform/x86/thinkpad_acpi.c:918:30: error: unused variable 'dispatch_proc_ops' [-Werror,-Wunused-const-variable]
>>    static const struct proc_ops dispatch_proc_ops = {
>>                                 ^
>>    1 error generated.
> 
> So this has absolutely nothing to do with the:
> 
> "platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning"
> 
> commit, the problem is that:
> 
> 1. the .config does not have CONFIG_PROC_FS set; combined with:
> 2. include/linux/proc_fs.h using a #define instead of a
>    static inline for proc_create_data() when this is the case
> 3. This is a clang WERROR build
> 
> The thinkpad_acpi code cannot really function without procfs
> support anyways (it will error out on probe if proc_create_data()
> returns NULL) so I will shortly submit a fix adding a
> depends on PROC_FS to fix this.

Thinking more about this I'm going to fix this in a more generic
way by changing the #define for proc_create_data() to a
static inline, which should help other drivers in the same
boat too.

Regards,

Hans



> 
> I must say that as a maintainer I'm unhappy about the amount
> of noise being generated by clang WERROR builds here though,
> is it really necessary for the kernel test robot to do builds
> of this type ?
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>>
>>
>> vim +/dispatch_proc_ops +918 drivers/platform/x86/thinkpad_acpi.c
>>
>> ^1da177e4c3f41 drivers/acpi/ibm_acpi.c              Linus Torvalds  2005-04-16  917  
>> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03 @918  static const struct proc_ops dispatch_proc_ops = {
>> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  919  	.proc_open	= dispatch_proc_open,
>> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  920  	.proc_read	= seq_read,
>> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  921  	.proc_lseek	= seq_lseek,
>> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  922  	.proc_release	= single_release,
>> 97a32539b9568b drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2020-02-03  923  	.proc_write	= dispatch_proc_write,
>> 887965e6576a78 drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2009-12-15  924  };
>> 887965e6576a78 drivers/platform/x86/thinkpad_acpi.c Alexey Dobriyan 2009-12-15  925  
>>
>> :::::: The code at line 918 was first introduced by commit
>> :::::: 97a32539b9568bb653683349e5a76d02ff3c3e2c proc: convert everything to "struct proc_ops"
>>
>> :::::: TO: Alexey Dobriyan <adobriyan@gmail.com>
>> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>

