Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3D3427C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhCSV3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:29:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:16022 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhCSV2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:28:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616189308; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=V4DohGqkLH+ThnxbbHP85pcztAz/L6jPjmdDX4Xlh5CY24N0sIrbVBITnr8XL/Yv9A
    43A/it2bwcp6Zk+mKQAA4ZJBwAsKQViIW3uzUTIAU26vkNPT3dTAofCCHfaSWLlwCJiT
    FPT/88PG6Woj5pzo8OxmIi8NbCYXpFr8dyi0AEn+a/zkEwMDF4CDXz8yew57HXFJ4vrm
    6wZjKQ7o6caKVaNQetoWDR9SA+sp/owyp714NTJ1+WXA3efnG7D2KEF1XYEUdEbNyqcG
    /o7pzhedCy+jqnzpM/yyqMNtreOYuwMrLnM9hRiw98a+9b+1rsx1uuuah17bUilPEz3W
    7w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616189308;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=16Drd7t8u40zth4HwRr2NXt1vIZ0aDm0OZJNVB+5Blo=;
    b=pf+2iFngNRq+CG66a4Gz2Kr+BO4ws+i902zzN+k+tjSwKpJjD/Ibv4nH4j7j9QQtRo
    ZGaQZaY8LQ/9LPJkFcu15IlQ5nd5NeU+120/uZhMbV6orZtJsR35PdlOJnuD6vBUiOzp
    z4NgRZerP65K1X9C4uPWu2zYM0h6FqgvM6yaAlUjj5HuKXTXwDBDS5bIhIMDvpmg1lHu
    attcGjztqdBEH5s+TfaiDBeoPeCAWMKhTCJxhp9r1SnP88wlD9vn4e8UCv67Z5oSvDXS
    4RdY8K0tzbMNrfs+W45m0rSUD/myyDQ8XL5Fsd0VJWQCUSEAYVUumC/Vt+NVi7BQ9e/p
    pwUA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616189308;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=16Drd7t8u40zth4HwRr2NXt1vIZ0aDm0OZJNVB+5Blo=;
    b=Ubj2XSzkXqEEgC7riEtIwDCmKvC4xTxMdieFyFXZyU+qv2W/p01DQke+9pJEvB/sC3
    t20Fv0geSuiWIragSd03/RtiuBtQtX4PV98anAcl7831LEvzazC2QWxMEu9sR4+59AOr
    HBYja/KjsI1OY8vIz4pETcMlHEkRPCo4pSu7NaYpI83Oyv5zHJhK3uK7b8ZU8hOmAIf2
    kDpXJijklJ3OWbKUbnehjMnZHvHh6PKGsjsviphGWHUV10wZbjRO6hC0yHuH1qEN1bTk
    3RqlNBYONy5rGLxJIpUjteuBdDM7CXnkJhdhj7lDVgAGnEfsILEGW+4AdpdAemS2fibe
    wbiQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGX8h8mSA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2JLSS76N
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 Mar 2021 22:28:28 +0100 (CET)
Subject: Re: include/linux/compiler_types.h:315:38: error: call to
 '__compiletime_assert_511' declared with attribute error: BUILD_BUG_ON
 failed: offsetof(struct can_frame, len) != offsetof(struct canfd_frame, len)
 || offsetof(struct can_frame, data) != offsetof(struc...
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <202103191620.D0ngZ5BO-lkp@intel.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <afffeb73-ba4c-ca2c-75d0-9e7899e5cbe1@hartkopp.net>
Date:   Fri, 19 Mar 2021 22:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202103191620.D0ngZ5BO-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.03.21 09:06, kernel test robot wrote:
> Hi Oliver,
> 
> FYI, the error/warning still remains.
> 

Hm - I have no clue either.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8b12a62a4e3ed4ae99c715034f557eb391d6b196
> commit: c7b74967799b1af52b3045d69d4c26836b2d41de can: replace can_dlc as variable/element for payload length

The patch which introduced the union I suspected to be the problem is 
some commits earlier ...

>     net/can/af_can.c:891:2: note: in expansion of macro 'BUILD_BUG_ON'
>       891 |  BUILD_BUG_ON(offsetof(struct can_frame, len) !=
>           |  ^~~~~~~~~~~~

The only idea which does not change the functionality but may help the 
macro expansion is to revert the change from "can_dlc" -> "len" in 
af_can.c :

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/net/can/af_can.c?id=c7b74967799b1af52b3045d69d4c26836b2d41de

Is it possible for you to revert that single line for a test?

diff --git a/net/can/af_can.c b/net/can/af_can.c
index cce2af10eb3e..1c95ede2c9a6 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -865,11 +865,11 @@ static struct pernet_operations can_pernet_ops 
__read_mostly = {
  static __init int can_init(void)
  {
         int err;

         /* check for correct padding to be able to use the structs 
similarly */
-       BUILD_BUG_ON(offsetof(struct can_frame, len) !=
+       BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
                      offsetof(struct canfd_frame, len) ||
                      offsetof(struct can_frame, data) !=
                      offsetof(struct canfd_frame, data));

         pr_info("can: controller area network core\n");

Unfortunately I was not able to reproduce the issue here.

Best regards,
Oliver



> 
> 
> vim +/__compiletime_assert_511 +315 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  301
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  302  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  303  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  304
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  305  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  306   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  307   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  308   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  309   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  310   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  311   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  312   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  313   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @315  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  316
> 
> :::::: The code at line 315 was first introduced by commit
> :::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
> 
> :::::: TO: Will Deacon <will@kernel.org>
> :::::: CC: Will Deacon <will@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
