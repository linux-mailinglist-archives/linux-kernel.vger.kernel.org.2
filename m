Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA0940EB01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhIPTqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhIPTqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:46:35 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403CC061574;
        Thu, 16 Sep 2021 12:45:14 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso9821544otu.0;
        Thu, 16 Sep 2021 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZcmUx7XdmCPkdGO1AKL5I0Bz1i/a7ehtmDKaflW5syo=;
        b=FxZ8LBsHGS4XO0UxnDWpTvBYx34qTRb0bDohqTQ4fuKF/u/ONUMbQWkOJ6YCgrOXSy
         +1pFkWVySOog2jhqt3P3OMri+Jdnavo1gQcaJuHD5+k1vIPz3RW87Zir06V9DE7+f3LV
         XYl03C0caEdUbu9u5D2Vpq+5U5J2d9QwDr8dhQyu9197Srph0iP/heUPwQ7bDsq3fkBC
         IgrvesQlA/Lg41HvonGLGlm1Et12vhPCpnGmr8qnP+xcj3Ju2MLxtEUNP1ADwPqYcROA
         SdmpvPT+BBYwaIhEp/upbCPeKYZ+KkqNzNUPrdpzZECrJ4bvCcshuJFh24O0V0u5Uy/f
         Tqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZcmUx7XdmCPkdGO1AKL5I0Bz1i/a7ehtmDKaflW5syo=;
        b=2TcqfeLiyr76pLw0PgbjfVwSczCAWvR/w3SdOkFsdWySNh/zA11xFsuFHOOp/1dTg6
         +F5YRxXPCjdSBqlN1MXH2IQtlKnajBNUaTRVd5havGi+k1feOMoP53LDwT2ffim8Tkox
         g45q8pPJ9Y7CeVTc/+WtENSDKj9ZqN8aVTCDcwpfYY7ut2vk58DIK54zIfveD4dwVVIv
         78Mnbo4dl+Ujd+sQiFn8Cm7HTThiEvWzyA+k9+gzPpKlZ519wTkvAmVyZYaWljTHnZh/
         StBnf2iSUZ7DrkTCKiQUOdxyAob/2TVnTzx7LVa20iDFP2Emj5JzDanlnE3KtUyxOmrl
         SNqA==
X-Gm-Message-State: AOAM533G5o6hgDUiA6YFLJuO/4qmz7f0/jPAW0e4rNXKcq2j5aLMO+mX
        DtRgWps7OJZrz0jQEmaM9Wc=
X-Google-Smtp-Source: ABdhPJwo6Ah9op2xylXAoj11A2Rwc8xJes3PJGxyPzCYCEL3ssafgCZQAggUTnI2kD/Q79FQ06Z5Vg==
X-Received: by 2002:a05:6830:411d:: with SMTP id w29mr3005282ott.83.1631821513895;
        Thu, 16 Sep 2021 12:45:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v2sm888773ooh.28.2021.09.16.12.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 12:45:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <YUNi6hTcS8nUrrpF@ls3530>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [GIT PULL] parisc architecture warning fix for kernel v5.15-rc2
Message-ID: <b3d13e4f-c9cd-495b-5df2-1080ca4d3aa3@roeck-us.net>
Date:   Thu, 16 Sep 2021 12:45:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUNi6hTcS8nUrrpF@ls3530>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 8:29 AM, Helge Deller wrote:
> Hi Linus,
> 
> please pull one parisc architecture warning fix for kernel 5.15-rc2 from:
> 
>    http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-4
> 
> One patch which fixes a build warning when using the PAGE0 pointer.
> 

Grumble:

Building parisc:allmodconfig ... failed
--------------
Error log:
In file included from drivers/net/phy/dp83640.c:23:
drivers/net/phy/dp83640_reg.h:8: error: "PAGE0" redefined [-Werror]
     8 | #define PAGE0                     0x0000

No, I didn't see that coming either. It _was_ there before, I just didn't notice.

Looks like that define isn't even used anywhere.
I'll send a patch to remove it.

Guenter
