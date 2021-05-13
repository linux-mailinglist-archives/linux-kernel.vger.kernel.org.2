Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8597637F8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhEMNlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhEMNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:41:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:39:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b21so14428456plz.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:mime-version:content-id:date:message-id;
        bh=53VrDc7yaURaIAvZgMf9bgQZDAm6RoNVwGpY4UD/pBM=;
        b=dKm7K0GZsyoCl0Zl/bWvwIGL7Of4R0n9eBipNSS/17LsbmjHYWBLhXfk6Y0kNu9qWD
         cgk+zhrhanxSey77CTsrVODiQ6rUEWkvaxxrtfkPvAsESaGFUPBkRrn3LZJdV8meN5xf
         Hh0sGe1+xALlDdKpGmcLuisopEgsJpYGpE+oUN2vaAaMUUG0td7msYazg4F4gD7Mqhqw
         iJcHgri20pTlcscRNo4hyqAxSpnGyPcLkIl5IiBgcEID6UdCc+UshL32hHDGsObOKTd5
         Czit2Xcfu+QZlofJUOp/Lg+Ax7LSsx35WMgQJ+qabAwDzWoplhvkt8WbE3F4N7Pszm11
         PrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:content-id:date
         :message-id;
        bh=53VrDc7yaURaIAvZgMf9bgQZDAm6RoNVwGpY4UD/pBM=;
        b=R79Sbu59eUhfK6KwdkpL0ZGC9O+XfgEAEDR2h3ADUMChVkJYC4AQnkqAPbTrHfGvUZ
         xnzVKERN4JoyBN0jm9XLlGmrmb/LCEbgqXUH20EA+LDZR+Yi3ehfH7gK68NuThVpABqo
         rPZFh10oKTBV5fJ1oUaAZ80oWNrYVjK31bVPD9/hy3bJvduw0fARgWN341leK0bP/kGW
         F/cGWClRbHlYno06FXFmiWXx3yiPy9fD9Zws94+0Blhi4IRtEiL6/zjVYCc+evTsmcxL
         YmHwlpkM+qiHmk/pXK4LLghb07CRIO9/NF5gs10v/wRn9VMXnJFuaH4luEoriYechcKa
         lMDw==
X-Gm-Message-State: AOAM532FcIw/OFcg8vp/7dUR4vaD58Z1vSPmX1gu+GsyZA13RjI/UV3v
        LNb0emntswYne0164RKEGjdjTIcuD5I=
X-Google-Smtp-Source: ABdhPJzS5UFIePRVKUA9TKQ8cfvpMfi5AeFwbz7/ulDmO1OX8gQwqVfdrBULQihGbcUubr2Bb6gQrg==
X-Received: by 2002:a17:903:208b:b029:ed:74ad:4c15 with SMTP id d11-20020a170903208bb02900ed74ad4c15mr40630894plc.6.1620913193436;
        Thu, 13 May 2021 06:39:53 -0700 (PDT)
Received: from jrobl (h219-110-108-104.catv02.itscom.jp. [219.110.108.104])
        by smtp.gmail.com with ESMTPSA id t14sm2071701pfg.168.2021.05.13.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 06:39:53 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1lhBZ9-00080i-LW ; Thu, 13 May 2021 22:39:51 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
To:     peterz@infradead.org, penguin-kernel@I-love.SAKURA.ne.jp
Cc:     linux-kernel@vger.kernel.org
Subject: LOCKDEP customizable numbers upper limit
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30794.1620913191.1@jrobl>
Date:   Thu, 13 May 2021 22:39:51 +0900
Message-ID: <30795.1620913191@jrobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

According to the commit in v5.13-rc1,
	5dc33592e9553 2021-04-05 lockdep: Allow tuning tracing capacity constants.
several lockdep numbers have their own range as 10--30.
But if we set all 30s, we got a compilation error.

kernel/locking/lockdep.c:3536:2: note: in expansion of macro 'BUILD_BUG_ON'
  BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));

kernel/locking/lockdep.c
----------------------------------------
static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
	:::
	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
	:::
----------------------------------------

MAX_LOCKDEP_CHAIN_HLOCKS is defined in kernel/locking/lockdep_internal.h
as this.

#define MAX_LOCKDEP_CHAINS_BITS		CONFIG_LOCKDEP_CHAINS_BITS
#define MAX_LOCKDEP_CHAINS		(1UL << MAX_LOCKDEP_CHAINS_BITS)
#define MAX_LOCKDEP_CHAIN_HLOCKS	(MAX_LOCKDEP_CHAINS*5)

I don't know what this 'multiply by 5' means and why
ARRAY_SIZE(chain_hlocks) is limited to (1UL << 24), but setting 30 to
CONFIG_LOCKDEP_CHAINS_BITS obviously causes BUILD_BUG.
'*5' is more than 2 bits shift, so CONFIG_LOCKDEP_CHAINS_BITS has to be
less than (24-2), limited to the range 10--21.

Hmm, I tried.

CONFIG_LOCKDEP_BITS=30
CONFIG_LOCKDEP_CHAINS_BITS=21
CONFIG_LOCKDEP_STACK_TRACE_BITS=30
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=30
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=30

Arg, LD failed.
ld: kernel/locking/lockdep.o: in function `lockdep_hlock_class':
lockdep.c:(.text+0x84f): relocation truncated to fit: R_X86_64_PC32 against `.bss'

I am afraid these LOCKDEP configurations need some sort of balancing.


J. R. Okajima
