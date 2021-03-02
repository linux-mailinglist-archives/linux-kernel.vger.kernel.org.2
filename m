Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E118332AE52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838146AbhCBXFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360743AbhCBWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:25:04 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E6C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:24:23 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 752A32223E;
        Tue,  2 Mar 2021 23:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614723862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3BXk5OjeZ5be3liNaRPLwWtNWLtlvE8ZWsXsaChkDQ=;
        b=E61EL1rWt50NIZLzNwkFK0QggdDHNrhLl7CjmsyBUfcNPgYaxpxn07wPOKyLLgEgI8GSVX
        FMNZXdFVhnzijgm97NkWU9yvrRtKqmNC/luJypQhwztlz774U+h9GC5cEbJx0KW7PBCt8B
        f1O63gUZ7yS/iqiJhUd/sfNtue2u7KY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Mar 2021 23:24:21 +0100
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
In-Reply-To: <20210302211133.2244281-1-saravanak@google.com>
References: <20210302211133.2244281-1-saravanak@google.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b2dd44c2720fb96093fc4feeb64f0f4e@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-02 22:11, schrieb Saravana Kannan:
> I think Patch 1 should fix [4] without [5]. Can you test the series 
> please?

Mh, I'm on latest linux-next (next-20210302) and I've applied patch 3/3 
and
reverted commit 7007b745a508 ("PCI: layerscape: Convert to
builtin_platform_driver()"). I'd assumed that PCIe shouldn't be working,
right? But it is. Did I miss something?

Anyway, I've also applied Patch 1/3 and 2/3 and it still works. But I
guess that doesn't say much.

-michael
