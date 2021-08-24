Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908353F6C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhHXXag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:30:36 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:43676 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhHXXaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:30:35 -0400
Received: by mail-pg1-f172.google.com with SMTP id r2so21293274pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXDjyaDqZxldrpcIumldUcAJSeCe0e2EnINf377QXQc=;
        b=sstei1+wCJXTtuj71i89+Ju4+QhPTRkZYIACZtuh7WL6cXdH52wK6YHj2LvPyv4P47
         pKcdB71M3mcwTuE1lMvJ+3ybG2EWgqOuoCRFb/1ViFVmQao6TJhnt7pnCCpUF19LUim2
         hbzB6zLydBv1SyHHEgbgK7uhfE040a6BknSFKrIl8FSDtoRS8Ik835cZcPTYrYXsv2Mq
         5fF2aSl70s5SZfhuEY0eYg+KCOMF8/SE50SGF0MWeOXKkYN5gT0ADEqUYyHO4W9KLbdk
         /yPUqsNRk+GE7ZaYqt2Ej3NJ9uhVNnUMI4AbqWJf3lstw/w8KaWKgLz1bqDIexHpVHgT
         4d7w==
X-Gm-Message-State: AOAM530/fbTNT1qvyexMFo3EMssq/EUn75XeILRQLV1eypl5E/pEzIW0
        UlmThRF+qXGewTmFTv7Zl5s=
X-Google-Smtp-Source: ABdhPJyTYViFCFQbYYRe/VEFWhMF25kWjpPmyUeftifa0DyfbrvBUYcTdY5lHP8WcIPW2StGBkvLKw==
X-Received: by 2002:a05:6a00:884:b0:3ef:69c7:1264 with SMTP id q4-20020a056a00088400b003ef69c71264mr795192pfj.4.1629847790580;
        Tue, 24 Aug 2021 16:29:50 -0700 (PDT)
Received: from ?IPv6:2620:0:1000:2514:2b8a:1ad4:744d:e9a5? ([2620:0:1000:2514:2b8a:1ad4:744d:e9a5])
        by smtp.gmail.com with ESMTPSA id b6sm20594166pfr.158.2021.08.24.16.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 16:29:49 -0700 (PDT)
Subject: Re: [mkp-scsi:for-next 276/292] drivers/scsi/ufs/ufshcd.c:7965
 ufshcd_request_sense_async() warn: possible memory leak of 'buffer'
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <202108241754.681GIVPd-lkp@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ca323347-22bd-201d-b809-64a3388e6682@acm.org>
Date:   Tue, 24 Aug 2021 16:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202108241754.681GIVPd-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 2:58 AM, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
> head:   d09224115cf67bdce4eef2ca3533f86ab1ea1942
> commit: c6b2e1373c89c4ecf2b379720b3eb24cf99844f4 [276/292] scsi: ufs: Fix ufshcd_request_sense_async() for Samsung KLUFG8RHDA-B2D1
> config: i386-randconfig-m021-20210824 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/scsi/ufs/ufshcd.c:7965 ufshcd_request_sense_async() warn: possible memory leak of 'buffer'

Hi Adrian,

Since this patch has been queued on Martin's for-next branch, do you plan to post a fix?

Thanks,

Bart.
