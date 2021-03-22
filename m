Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF303445E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCVNgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCVNfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:35:42 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8146C061574;
        Mon, 22 Mar 2021 06:35:41 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DAF4822235;
        Mon, 22 Mar 2021 14:35:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616420138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdrwpwjkxDvmN/k2EwAzpVJ5LncVuKiDHXlGqrlAre4=;
        b=iLkJTIm37wQgoyMh/3Mzt2ZmIu3BjzXUib8BdmFS3G1FD/WA7j7a/YtSWHE0GN2/Oyuhl5
        I/kvRBUH7ONIpFbxwf57zfbRc/1Fw8v2lBmG9tcpaj10nDZv+p5aJuGD18l7HKHryQBACJ
        Ai5EAG/unMhUc4gk4+rdcZzyyR6xo2Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Mar 2021 14:35:37 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sahil Malhotra <sahil.malhotra@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Sahil Malhotra (OSS)" <sahil.malhotra@oss.nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix optee node
In-Reply-To: <DB7PR04MB53223015C17DCD6DBCCACE5382659@DB7PR04MB5322.eurprd04.prod.outlook.com>
References: <DB7PR04MB53223015C17DCD6DBCCACE5382659@DB7PR04MB5322.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <515d3c1f20a3511c80e2dc059d427e3f@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-22 14:04, schrieb Sahil Malhotra:
>> Sahil, if you like you can pick it up to enable the nodes for your 
>> ls1028a boards.
> Michael, If we enable the optee node like this, will this gets resolved 
> ?

I don't know what you mean. This was a fix for the initial patch. So,
I guess the answer is yes it will not break my board if you don't
enable optee globally, but just for your board.

-michael
