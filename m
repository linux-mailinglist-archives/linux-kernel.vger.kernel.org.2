Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3C36BA95
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbhDZUK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbhDZUKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:10:55 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15AAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AE0mY6Tahzy3s212z3qIjhJx3BZdiskA2UVQtuuLlmw=; b=O0dnpd+3yDPBhtaHZCT7GnJ2Eh
        ZF/ObymHgT9tuYDAM1gaQCG8Z6kUihlDl13pTHYpz3FsHwNkJhoZ92n5nKAxK/Oh96HAK5UntzM+Z
        ZielMYTJxvyOSaLw+mkQN/nT5fO1pl9csxeSQA9urGCtnFZa/O0CjTa3rpNexwxxoR3hjsdgDzRJ6
        8MznPICQpa96wPbpTvbGJs4cPFGycQ7h06+7UEfe1UBZL6ohKwKAHyW+H0581oGrZiD2Bsv8HorXg
        sJPfdcPX8qRlxI70mVLRuUzOp5eNdp274Yi4lU5rbB30aYPYheY4IoNc7g2wxCzAbJVaDManlciii
        QEJ1zjbA==;
Received: from [2a01:79c:cebf:7fb0::17] (port=39830)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1lb7YZ-0006i5-BY; Mon, 26 Apr 2021 22:10:11 +0200
Subject: Re: [BISECTED] 5.12 hangs at reboot
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     johannes.berg@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
 <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <28e21004-13ff-9d5f-0c5d-4c1e79cf628a@skogtun.org>
Date:   Mon, 26 Apr 2021 22:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [26.04.2021 20:59]:

> There's a lockdep assertion there, but you don't seem to have lockdep
> enabled. So it be interesting to see what happens if you
> 
>  (a) enable lockdep

At the risk of sounding stupid: where is this config option?
-- 
Hilsen Harald
