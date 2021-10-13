Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80642C74E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhJMRLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhJMRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:11:20 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26081C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:09:17 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id g2so487600ild.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tf8zICDQnaorc4GXZyr5flJ8qEvwzI/29GgBOK0hk88=;
        b=bCxSke29AD2PwOHjZAR6Fxpsza7wk0K3yau19ow6+epjopRdXnRw3PCI8aqw19ki8v
         BmuloHXj0hWPdeKY87hSrE8dTARJggHDSxANaRlxi94aC7OWTaI/PDPZWbsDv1z6WmUI
         1M+YSj1apHL6dXh2n32qHi4eLWHL2qBboQ71s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tf8zICDQnaorc4GXZyr5flJ8qEvwzI/29GgBOK0hk88=;
        b=JUSjVn7GPPcB7fQpVXFXK8prkTSHk/VtNaR1Y7hhOzZrQrx4kSoNtcAyjGLV38bhGc
         bLMpQYkPqXtfRXqkgESZdfhdpx8OmIDNpvo7TVKXz5g5g9AXU5c4QVxfKd7WFAa59wDq
         FCXoK1H3yyW+dhOab+YxXv6HAY+I5V/ZsKdZVX59bQuYy54AZr8S+hH+T/1lay3sF3ve
         92kuNbM82Y623Ng6chOJZ+cdo2dgTYWubvduHAlpcfEalWGa3pmmw5yX/URpRZ9rfrDX
         9emzUd3eFKILYamt/tqY54wGr7O0/td5QlfqGq1qmVXKqUkKuSctwzLyVjogVIXEHTnJ
         fwYw==
X-Gm-Message-State: AOAM530xS5cIKqTruW+ow+yefDoCi4B4JxOzPIfiWn+7ibx2s+aUiihq
        uByAW0AB/Qxo+ch+Yyiq8tyzmQ==
X-Google-Smtp-Source: ABdhPJzwgvsxRRhMZQ3zCvH9dgtucC40uhD8+B9u6cOEf4rC05Dj+JOzfT3ree5V+d4Hg3xs6LqLCQ==
X-Received: by 2002:a05:6e02:1607:: with SMTP id t7mr208651ilu.232.1634144956514;
        Wed, 13 Oct 2021 10:09:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b4sm86574iot.45.2021.10.13.10.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 10:09:16 -0700 (PDT)
Subject: Re: [mcgrof:modules-next 1/1] include/linux/kern_levels.h:5:18:
 warning: format '%llu' expects argument of type 'long long unsigned int', but
 argument 3 has type 'Elf32_Off' {aka 'unsigned int'}
To:     kernel test robot <lkp@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202110140056.Fb6aizTM-lkp@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c4be5b17-3071-0d99-f896-40040c81d9d3@linuxfoundation.org>
Date:   Wed, 13 Oct 2021 11:09:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202110140056.Fb6aizTM-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 10/13/21 10:42 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
> head:   8b1185a4427b772b9f02376a08272c3019777581
> commit: 8b1185a4427b772b9f02376a08272c3019777581 [1/1] module: change to print useful messages from elf_validity_check()
> config: um-i386_defconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>          # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=8b1185a4427b772b9f02376a08272c3019777581
>          git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
>          git fetch --no-tags mcgrof modules-next
>          git checkout 8b1185a4427b772b9f02376a08272c3019777581
>          # save the attached .config to linux build tree
>          make W=1 ARCH=um SUBARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 

All of these warnings can be fixed easily by leaving out the fields that
are the problem. I can send a patch for that.

This one is real issue though;

static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
{
         unsigned long secend; /* too short when sh_offset is Elf64_Off */

         /*
          * Check for both overflow and offset/size being
          * too large.
          */
         secend = shdr->sh_offset + shdr->sh_size;


secend is unsigned long which is too short when sh_offset is Elf64_Off

It appears to me that some sections of this elf validation code probably
needs to be arch specific. validate_section_offset() is one with this
potential for secend overflow.

We can introduce arch specific header print routine. Easy option is not
printing any info., which we know isn't very useful.

Let me know your thoughts.

thanks,
-- Shuah
