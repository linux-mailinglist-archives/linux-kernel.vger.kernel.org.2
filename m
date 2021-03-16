Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E38633DD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbhCPT2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbhCPT15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:27:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F57C06174A;
        Tue, 16 Mar 2021 12:27:56 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9DC8522238;
        Tue, 16 Mar 2021 20:27:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615922871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9oTzvmR9m08GcJX5x4Qj7U6037F+XpGCNpETFyhQBY=;
        b=QeWpVQNkO+k1G5Jtvp/UlCGLokXMw8tBA4kcpE2dwkb/TWx9sClKBQQu0qlQXS8maK5cJ1
        JQjses3PkZIxY/mmMs2kC4Vstz1MQsBv3TlB/opvR2HGfgJSgGHVAHE9JgHV8EVUEyzAMW
        BYsWT+YEmbp1UOMmp2h07AGxkcAnp44=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Mar 2021 20:27:51 +0100
From:   Michael Walle <michael@walle.cc>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, kernelci-results@groups.io,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: next/master bisection: baseline.login on kontron-kbox-a-230-ls
In-Reply-To: <38c31f5c-4400-eed7-d561-8f45e261ab01@collabora.com>
References: <6050bf47.1c69fb81.59c4d.85f2@mx.google.com>
 <38c31f5c-4400-eed7-d561-8f45e261ab01@collabora.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <edcb6c52f754935341ee8711f30062c4@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-16 19:33, schrieb Guillaume Tucker:
> Hi Sahil,
> 
> Please see the bisection report below about a boot failure on
> kontron-kbox-a-230-ls on linux-next.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.

nice! Thanks.

[..]

>> commit 48787485f8de44915016d4583e898b62bb2d5753
>> Author: Sahil Malhotra <sahil.malhotra@nxp.com>
>> Date:   Fri Mar 5 14:03:51 2021 +0530
>> 
>>     arm64: dts: ls1028a: enable optee node
>> 
>>     optee node was disabled in ls1028a.dtsi, enabling it by default.

Please enable this per board. As it is also indicated by my original
commit f90931aeefe3 ("arm64: dts: ls1028a: add optee node") message:

   Add the optee node which can either be enabled by a specific board or 
by
   the bootloader.

-michael
