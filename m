Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1703242CDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhJMWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhJMWSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:18:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD5C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:16:38 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id w11so1351253ilv.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GF/XXkjPXvEgKs4g1A5s991twcUkvkUaUKmbFgsBBI8=;
        b=VWlhqDclteXwnS/wCk7OMJ4IF0eeUt59VOGq66zYhij02i4wuueiRykJF/kQXmu0ue
         7AJOAnpdS0XOqPUpdJnKkFoF1DPgWiWNqZt9skoyVthKgtBZ/XGkOZ7CwHvnRW5Zv9/k
         gmOD8T8A2MgTWXIDQoZUh8bDgNCz652qQlmrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GF/XXkjPXvEgKs4g1A5s991twcUkvkUaUKmbFgsBBI8=;
        b=zX9y/yWeBqlczn6tFTpckl7coefMEfoKhYiH0z/rvLz6k/cSjDKgEC0ghd3N5R22o/
         HykmBknkGpI5EFJqRSlywEFyvdFVkEezZx4r0BysgAFfvSTa9MbE7sMVxmxT3xjUjgKX
         GT73eYjHsXf+uXvydL6bT6+7noS0utY2arN2HWLwH+qc0FJoCXPxMPJEOPi1t60mAhfG
         khRtgIsOho44COkZPmTxOGClIq3whcHWqOHPy41PIecDyFfetcHLKHdFdruZzd7oAuzj
         uOx3FTyew1vKB10y78SYBhLt5NSg+3HLRZgqBDBGfvn4ntPjiLQbbNhdFuOghZZQUd7k
         kfYg==
X-Gm-Message-State: AOAM530AMN4w5zT5fHWzK9joOhPPNZpHR+Znq1vZiE2wp/oUdZwMoBjt
        z/lhc2wiAjdh/mCSlunzn6kuIPHXZVoeAg==
X-Google-Smtp-Source: ABdhPJxT5yvGWSeLtHUEKkvIPnj+x6c5EEtnJizDBiS30hWQP5PF64bEZVRmNV0Mwm/ReRUtcpGTsw==
X-Received: by 2002:a05:6e02:156b:: with SMTP id k11mr1345867ilu.115.1634163397189;
        Wed, 13 Oct 2021 15:16:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g1sm350691ild.86.2021.10.13.15.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 15:16:36 -0700 (PDT)
Subject: Re: [mcgrof:modules-next 1/1] include/linux/kern_levels.h:5:18:
 warning: format '%llu' expects argument of type 'long long unsigned int', but
 argument 3 has type 'Elf32_Off' {aka 'unsigned int'}
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202110140056.Fb6aizTM-lkp@intel.com>
 <c4be5b17-3071-0d99-f896-40040c81d9d3@linuxfoundation.org>
 <YWdNL8m5A3qtIm24@bombadil.infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5a482ade-7e73-ba6f-457e-75dfdb80a2c8@linuxfoundation.org>
Date:   Wed, 13 Oct 2021 16:16:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YWdNL8m5A3qtIm24@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 3:18 PM, Luis Chamberlain wrote:
> On Wed, Oct 13, 2021 at 11:09:15AM -0600, Shuah Khan wrote:
>> Hi Luis,
>> We can introduce arch specific header print routine. Easy option is not
>> printing any info., which we know isn't very useful.
>>
>> Let me know your thoughts.
> 
> You found an issue without the debug prints, and so you'd know better if
> the effort is worth the trouble, so I'll let you decide.
> 

Right the issue with validate_section_offset() is separate from the debug.
I will fix the pr_err warns first by tweaking the messages to not print
the variables that cause problems.

I will send a separate patch for validate_section_offset() which needs to
be arch specific similar to elf_check_arch().

Let me know if this plan sounds good.

thanks,
-- Shuah
