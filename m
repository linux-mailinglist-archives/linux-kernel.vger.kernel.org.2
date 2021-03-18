Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15303401DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCRJVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhCRJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:20:46 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF9AC06174A;
        Thu, 18 Mar 2021 02:20:46 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 177E322234;
        Thu, 18 Mar 2021 10:20:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616059239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YbjBgGxLTNqIr9z+FaZf6hjC3vuBrM/H1mvIkKLukMs=;
        b=ldcpYshYLYmytDFwfW203zEvzd1MAXafF2Ng4ruWX7X8S1MTWdqwvscKxuQ/VSa8+eMNtW
        oTUW71oZarMsy9zzc5zTQOuJLCEVOcNvDcE300Mvd+dAQf/q0gOrnm60h0gKH0uSo5kjrp
        qb8EDJrb4zo88cfPaKtXviaPg/Xw37o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Mar 2021 10:20:38 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix optee node
In-Reply-To: <20210318083438.26536-1-michael@walle.cc>
References: <20210318083438.26536-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b0a6c305e23bc31ba770441e04393925@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-18 09:34, schrieb Michael Walle:
> Don't enable the optee node in the SoC include. It is an optional
> component and actually, if enabled, breaks boards which doesn't have 
> it.
> 
> This reverts commit 48787485f8de ("arm64: dts: ls1028a: enable optee
> node") and enables the node per board, assuming the intend of the
> original author was to enable OPTEE for the LS1028A-RDB and the
> LS1028A-QDS.
> 
> Fixes: 48787485f8de ("arm64: dts: ls1028a: enable optee node")
> Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Tested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Please disregard this patch, because the offending patch was
already dropped:
https://lore.kernel.org/lkml/20210318084029.GY11246@dragon/

Sahil, if you like you can pick it up to enable the nodes for
your ls1028a boards.

-michael
