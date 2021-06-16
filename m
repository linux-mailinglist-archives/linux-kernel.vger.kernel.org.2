Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCFF3AA0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhFPQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhFPQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:00:37 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D38FC0617A8;
        Wed, 16 Jun 2021 08:58:30 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EEDB722205;
        Wed, 16 Jun 2021 17:58:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623859109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WWZ9Aqs3etDmaHBiKikC0++8so2FJWXOgjB33RqcPk=;
        b=mVmzM63cDOCI7xMhDRYfDsU2QIkKbsfzTnkLurn63WtJwcFFvjMi/dvcSDt6Vn30R03Lb7
        uQtC7ZCsjNPKXewGMEjnculttkeqjH/bDbmN8hcY7uShQySAcwNo4jLer3p1Af2gYUrr8H
        mKGrx8UMNfQGdKU61Gl85D/7lsU4bw0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Jun 2021 17:58:28 +0200
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] ARM: add NAND support to Ebang EBAZ4205 board
In-Reply-To: <20210616155437.27378-1-michael@walle.cc>
References: <20210616155437.27378-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <409ac89fa0ebdff66d7c40573d2d2454@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-06-16 17:54, schrieb Michael Walle:
> Thanks to Miguel,

Sorry for the typo, its Miquel!

-michael
