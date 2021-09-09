Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5599B405964
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbhIIOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbhIIOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:44:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AA4C03401D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 07:22:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e16so1904703pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mmDZBoTTeVmcu2MNjIuYoDXjVbPZ93NgbYjESxx1lEg=;
        b=ItEATCRbsQHj6O1BwwWXuh+hTlb+pOyU6mpdNk93gmFgC8fzl+JGXgemdPmgtUpj8B
         2dVIXdYA54/NCB1WQ2ePGPtYrs/iWAqsVdcccIUf3frPwIg+MJDCwQswgxLJUkK8OMtd
         tlK7zvoEUiG0rhc9ERUogZ3gxnBn2uPtBP69GlGiNKJaMbRwkls6n3Ke0WIemL9ToIF6
         uHDwEJC7Y+n4epvV10hqt6uClD2y4Aq+jVrUJONuqVPQcXcYN/QR6J8IED2mTZJW69On
         DFg29bDo9wy39mJmiQu2rCly2dkBduWhfI6rclldlTDYQWsni6y+3lG8R8Vu2RWNiaLl
         Hx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mmDZBoTTeVmcu2MNjIuYoDXjVbPZ93NgbYjESxx1lEg=;
        b=ec++PYvpxZHqnPA2r2hyQctvU/jBHeqTeUhSwU4KLGsyvgPffII7eskS5KnsVf2ahb
         w+eEy07zIyzgvtKyD6b5ldMX014rANNFREWivwTjBsAbNEv29Yb2xVbKLyhTYid7pmnB
         AfIxElOSSNbvIb+QjexYECDeUZcWbviHFZgEOogcpyl1paKhGKWJiP8Lf7liSIqKFt7o
         HGmg4leDTc23E+bo7n0EEKiKqRymMw0lYaKJBkZO65kOPwkLIyeqOrjMdLbN7frhcEDt
         PUhjdVkz5oPf0IIffNSlzMB7+uZdzmX0LxhhqLDoAcfy1PPWQR79z9sge851s0GvUw9B
         XQRQ==
X-Gm-Message-State: AOAM532S7zjmMKT7va5gInoC3yhAwZidbTnwkcPP6jKB//2yWDh6fTzf
        PAO8alxt6cXaECIHbMWX7lk=
X-Google-Smtp-Source: ABdhPJwZ0XARViSKV+rRGwN8UO7ot41i1bi5BM1sXdUIerEnBeTtWyFJws7b8ICqcs2T6K53kif40A==
X-Received: by 2002:a63:ed47:: with SMTP id m7mr2995547pgk.194.1631197345495;
        Thu, 09 Sep 2021 07:22:25 -0700 (PDT)
Received: from [192.168.1.40] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id r4sm2544784pjm.50.2021.09.09.07.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 07:22:25 -0700 (PDT)
Message-ID: <a7b29ad9-c25b-00e2-4cb8-48800a39528a@gmail.com>
Date:   Thu, 9 Sep 2021 07:22:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: drivers/scsi/lpfc/lpfc_init.c:7788:35: error: 'struct
 lpfc_sli4_hba' has no member named 'c_stat'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Justin Tee <justin.tee@broadcom.com>
References: <202109091332.dJpqI2Qe-lkp@intel.com>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <202109091332.dJpqI2Qe-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/2021 10:13 PM, kernel test robot wrote:
> Hi James,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a3fa7a101dcff93791d1b1bdb3affcad1410c8c1
> commit: 02243836ad6f384284f10302e6b820b893960d1c scsi: lpfc: Add support for the CM framework
> date:   2 weeks ago
> config: powerpc-skiroot_defconfig (attached as .config)
> compiler: powerpc64le-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=02243836ad6f384284f10302e6b820b893960d1c
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 02243836ad6f384284f10302e6b820b893960d1c
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/scsi/lpfc/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 

Fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=5.15/scsi-staging&id=4d568aeb6d71e5bec477c7c1884f7bd7ac0f4438

-- james

