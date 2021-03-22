Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E30A344006
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCVLjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhCVLjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:39:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B0CC061574;
        Mon, 22 Mar 2021 04:39:12 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B461E22235;
        Mon, 22 Mar 2021 12:39:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616413150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zXIdiOZ+u1eSnhElfcpPGQjBHuUV/GsmWU43M1JHSDw=;
        b=kwrNYJs+xjQ162w/fJgDT2TBnMDzOrLV2iMBZ9o1xAJPOvmeR7KO3XQnUjUsxrZhrXNq8O
        sA2FHNfDaJAlIFYI0d0GtiW5U8GO/FdO9YYmO+2xYPYL+BdA3DSeW1rIaoIv7SKb2/n8xh
        Z5Ac27ObVqlNRQX3UuInL2jq/45aMOw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Mar 2021 12:39:10 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sahil Malhotra <sahil.malhotra@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix optee node
In-Reply-To: <DB7PR04MB53222C26DD58E81FEAE4A27982659@DB7PR04MB5322.eurprd04.prod.outlook.com>
References: <DB7PR04MB53222C26DD58E81FEAE4A27982659@DB7PR04MB5322.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f3afa2197eefad9bc60be61f64ee5155@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahil,

Am 2021-03-22 12:33, schrieb Sahil Malhotra:
> Thanks for the fix, and currently we support optee only on ls1028a-rdb 
> boards.
> Does enabling the optee node this way, solves the issue ?

What do you mean? Please note, that Shawn already reverted your commit.
Therefore, I suggest you make a new commit where you enable optee only
for the ls1028a-rdb board.

-michael
