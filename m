Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E954A3DFAF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhHDFOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbhHDFOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:14:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82875C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 22:14:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c16so1741617plh.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 22:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QuJ/DSgDGn0JlMMJQHxu7ihQz9wjd0GmZ+lCLjhFct4=;
        b=OiIpX8UaAcRZdo72FpN9duyjItlWATx3iEX6M2+EgThDjf90KrCQoB8A/UIGf23Djv
         C3hfXE6XYCcuMioHL91Vxw8945xlO7E2a3nINqCzoeKdPohaswaa89GLPjPDeoKtO6Dd
         DlrqcsjNWxR+v+TpeVsty09l84drfWyY+Fz2CaMEmvN3KsAmBJ0+K5gQCE3IOwVvW7tc
         BMBB5e/ggUXPJXAglralmVCd/EbGi5F1XQdK1XuU7b+lpn+22Q67yhDcPaKFhctvkl+/
         t72+pWNq/NQ0dRoQtpIJdl6w7T+voDWLyDbI/fQCFthZeNDfWDxDG5hGI55+1mSsz12n
         YkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QuJ/DSgDGn0JlMMJQHxu7ihQz9wjd0GmZ+lCLjhFct4=;
        b=AI19vtNn9JsnYeUBik7eWrGFZtgYqsavZWrDHJxFaUyK/yOaDE/Yax6W/7Ph1hf2yI
         mL75A7hyTclyQ/pdvCNf2XtYH6G1KIWI6kPRNxPYUxjDaDED7icy7eoFkrvw/gGHHvGM
         1h3CdqRnPhDGg67fBzYHAJZP24ObUPDoM/ni9EblKeuI48qMchxFpRqU4DLYFBQH+PZP
         iPhj/li8gdBG/gJ698VmbhkPLfHnskRWXnSNF1OdCIUgCb89hgJkuqOnLtCqAZVLd2vr
         WO9vgzi1TV1Q2T3mTHY/waT1wqj5uLzQZHy3QDxg33Ye9EvqT4ERtoyiaDGIRwy6sv5E
         ZiDQ==
X-Gm-Message-State: AOAM531+KrxULTCf4btfBNak69x+Xdlffvdgi2X1EojkY+c2NREXhUhJ
        3hN/sukX/W9tZVOdnuNNjZpZ3A==
X-Google-Smtp-Source: ABdhPJytoWTQUBCl4vFgy0Xbp2cMHVqzyHGt/l5Ixy1g0Ti4uEzBniEzsIbU1B43UtIZFPH2WyMnmg==
X-Received: by 2002:a63:1352:: with SMTP id 18mr1302291pgt.348.1628054066921;
        Tue, 03 Aug 2021 22:14:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c2sm253954pfi.80.2021.08.03.22.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:14:26 -0700 (PDT)
Date:   Tue, 03 Aug 2021 22:14:26 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Aug 2021 21:37:34 PDT (-0700)
Subject:     Re: [PATCH] riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is enabled
In-Reply-To: <mhng-1b892781-2ee8-476b-90b8-44b5cca45cf9@palmerdabbelt-glaptop>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-5b3c9fa7-2e28-4788-9013-3a988ac5280d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 17:58:13 PDT (-0700), Palmer Dabbelt wrote:
> On Tue, 06 Jul 2021 09:26:21 PDT (-0700), linux@roeck-us.net wrote:
>> riscv uses the value of TSK_STACK_CANARY to set
>> stack-protector-guard-offset. With GCC_PLUGIN_RANDSTRUCT enabled, that
>> value is non-deterministic, and with riscv:allmodconfig often results
>> in build errors such as
>>
>> cc1: error: '8120' is not a valid offset in '-mstack-protector-guard-offset='
>>
>> Enable STACKPROTECTOR_PER_TASK only if GCC_PLUGIN_RANDSTRUCT is disabled
>> to fix the problem.
>>
>> Fixes: fea2fed201ee5 ("riscv: Enable per-task stack canaries")
>> Cc: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  arch/riscv/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 469a70bd8da6..3afb84fa2190 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -486,6 +486,7 @@ config CC_HAVE_STACKPROTECTOR_TLS
>>
>>  config STACKPROTECTOR_PER_TASK
>>  	def_bool y
>> +	depends on !GCC_PLUGIN_RANDSTRUCT
>>  	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
>>
>>  config PHYS_RAM_BASE_FIXED
>
> Thanks, this is on fixes.  I do an allmodconfig build and haven't seen
> these failures, is there something special I need to do to get this
> working?  I know nothing about GCC plugins...

Sorry, looks like I screwed something up and I didn't actually merge 
this onto fixes.  Not sure what happened, but this time it should 
actually be on fixes.
