Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2302361E18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbhDPKjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhDPKjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:39:37 -0400
Received: from mail.ionic.de (ionic.de [IPv6:2001:41d0:a:588b:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 176A3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:39:13 -0700 (PDT)
Authentication-Results: root24.eu; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=ionic.de 
   (client-ip=217.92.117.31; helo=home.ionic.de; 
   envelope-from=ionic@ionic.de; receiver=<UNKNOWN>)
Received: from [192.168.0.46] (home.ionic.de [217.92.117.31])
        by mail.ionic.de (Postfix) with ESMTPSA id E20D44F00334;
        Fri, 16 Apr 2021 10:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
        t=1618569550; bh=Nl3+uVYN0i0j+iMeYbox7bQdlNUhm27918lmewT153M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NrAC892JVNF44UrcDyfWz9U1Uqta62DWd4jtnJ5Q3QVFQ99xPjj+qYeSwVrNz7Qc1
         ki5+Nu5MUZzqIHGOn8jhRxdy/yhLEAt2mcMCCt2DCRU/lC2Kp35L0nFX+GIPFCHLPx
         5DLR4396MqnmukNqIywb0lc5LKBseiONtEXqVckM=
Subject: Re: [PATCH v3] kconfig: nconf: stop endless search loops
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210327120155.500-1-ionic@ionic.de>
 <20210415072803.16338-1-ionic@ionic.de>
 <CAK7LNATqZxthFKb71OUbq6WKbEi4uWdGy-nExx5wt=Mvb+hnCA@mail.gmail.com>
From:   Mihai Moldovan <ionic@ionic.de>
Message-ID: <11fec3bd-d94b-0a51-762a-99b3409c0481@ionic.de>
Date:   Fri, 16 Apr 2021 12:39:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATqZxthFKb71OUbq6WKbEi4uWdGy-nExx5wt=Mvb+hnCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* On 4/16/21 7:40 AM, Masahiro Yamada wrote:
> Applied to linux-kbuild. Thanks.


Thank you for your review and input. :)



Mihai

