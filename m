Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF234EDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC3QW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhC3QWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:22:35 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A758C061574;
        Tue, 30 Mar 2021 09:22:35 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F290822236;
        Tue, 30 Mar 2021 18:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1617121352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIwyUqAzhM7ee/BMrStN5FihbwtRnVcp/Mxe/o3tK2M=;
        b=UwBRS535zGojtGnONljafly4b0WcMpThXNFFgKqbwZVtJvV+u6fXBZz2lTTwsOXsjCTDzc
        iJDA5j/hcMmwHOqC2YElCQya1gqZbo7mHIbdmlg7HTdhPa6Qgktqt36+bdWhBR0DAw6EW0
        9xyxktWlMkYoeBjTj1GXyBJpahQc5qo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Mar 2021 18:22:31 +0200
From:   Michael Walle <michael@walle.cc>
To:     Sahil Malhotra <sahil.malhotra@nxp.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sahil Malhotra (OSS)" <sahil.malhotra@oss.nxp.com>,
        kernelci-results@groups.io, linux-kernel@vger.kernel.org,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: next/master bisection: baseline.login on kontron-kbox-a-230-ls
In-Reply-To: <DB7PR04MB5322273BD92BE06417F0A46D827D9@DB7PR04MB5322.eurprd04.prod.outlook.com>
References: <DB7PR04MB5322273BD92BE06417F0A46D827D9@DB7PR04MB5322.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ceed3682b72b048ceaa72daf6fe629e4@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahil,

Am 2021-03-30 16:42, schrieb Sahil Malhotra:
> I tried the same on LS1028A-RDB board with 5.11 kernel and my
> submitted patch applied.
> Board booted up successfully:  https://pastebin.com/15D91K5k
> 
> I used OP-TEE from OP-TEE github repo:
> https://github.com/OP-TEE/optee_os with commit
> https://github.com/OP-TEE/optee_os/commit/d1447353d3f80ae49053b54f525a0a4cf5e4cde7
> Which OP-TEE version you used for CI ?

| Re: next/master bisection: baseline.login on kontron-kbox-a-230-ls

That would be my board, which isn't a LS1028A-RDB and doesn't use optee 
at all.
Hope this helps, to understand why this board crashed ;)

-michael
