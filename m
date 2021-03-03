Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6652132C2C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353823AbhCDAGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388061AbhCCUsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:48:37 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE69C061760;
        Wed,  3 Mar 2021 12:47:56 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BC9D12223A;
        Wed,  3 Mar 2021 21:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614804474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAQHlS6gYpWsW1jh0ROjDz7dh8e7aK3uynRqpy1F1SM=;
        b=bljYJDrLnSBP+x1H/dcbjGvZO3vB2OI3asaL5Qe/v9AggX7zBceTgjsy7owTKs/mvw9JGO
        udqMqV3u0qsMSdwUzUZhF74sAQTBuhLW/UqUpjkJX4eqAndv1nIEnehsYNNHGZzsrkplbr
        tuCPC9ZWr4/6IPWyPEeF+ZEEqpion0E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Mar 2021 21:47:54 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: add interrupt to Root Complex Event
 Collector
In-Reply-To: <20210209005259.29725-1-michael@walle.cc>
References: <20210209005259.29725-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <da92fd760606934b84521dcc50e75f33@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-02-09 01:52, schrieb Michael Walle:
> The legacy interrupt INT_A is hardwired to the event collector. RCEC is
> bascially supported starting with v5.11. Having a correct interrupt, 
> will
> make RCEC at least probe correctly.
> 
> There are still issues with how RCEC is implemented in the RCiEP on the
> LS1028A. RCEC will report an error, but it cannot find the correct
> subdevice.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Any news on this?

-michael
