Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1CD3244DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhBXUFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:05:52 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43861 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235274AbhBXUE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:04:57 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A87738A2;
        Wed, 24 Feb 2021 15:04:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Feb 2021 15:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=drnd.me; h=
        content-type:mime-version:subject:from:in-reply-to:date:cc
        :content-transfer-encoding:message-id:references:to; s=fm2; bh=H
        r0neFGYwNuWTRB7wbGeKgttlJ7X7Po/GMt76x5UnWM=; b=ZDBEXUY6IcBek3JlW
        Kw/N0Ph52AEW4/FqbSWaKZPDAlY//0dAdpFnfMrcY47TBWsE/EFd+Bu4dRk+nm+r
        FNWYUR0gv5YHVNEkotm6ynAe/4B7fMHqjlllIAdN6y0A1s34ajMaJtj+9cs5XdRM
        v+SIWxUGG84214Hx7hWXtVdcI6Gj22lLrR2L+Qqq/RxRP2X6CQC5wzLeW5sgW/MS
        Uj8ZPh9FDqwdOC1EDkpKtsbTTUPXD/tBSp0MMfQYErbdp4nitTxZ5ta7ZIyFnqRa
        XeNZkT+jTqLQHFYwxiE+mgmOxON6aCQcAcFUzH1pawqufw+5+Nxg+4sg7z1wakdr
        5d7ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Hr0neFGYwNuWTRB7wbGeKgttlJ7X7Po/GMt76x5Un
        WM=; b=ZAWoVQjQGqwInPJ+G9WXj8t8TvokAcww1PSDDvXim5d5KlmgvpVNupYry
        ePjrIaBFjmx07oS54xOE/tAKAnFFRczUHf6MbFKSzbIGdrpNmdJX6PgK/c6CdKgJ
        IQCOEU7TeBo8zCLQVPte2PrbRKhUmo9O4JaYMwkJ9qBNDYrAxlDOATv3XLbIVoJm
        G6vs1x6TadlOW1O4iHa/gkdF++u8FZL9FrcYuHB+0YbL8Y2FPM9uhc1PMKM6XHqc
        XJ9NXj99DAWipdsWxYiK8K2fzbNYhnvpgsnqNoCLafzJsQcpXb4KyKRE0qae6pw/
        S+J/nZzZbkMENNixoEMLDR5gT7F3A==
X-ME-Sender: <xms:MrE2YA15ZODl8OwWngtZLMkvdZP65askR2QeDYykFvzmbtZFIvWA5w>
    <xme:MrE2YLFUe_U05N-1SlXTQeU9s_SZIHh4rXzDTTW9JsU5KngaznvwMup7ySPYUFjS7
    aeVz9yXLz_SwGwTeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffgffkfhfvofesthejmhdthhdtvdenucfhrhhomhephghilhhl
    ihgrmhcuffhurhgrnhguuceofihilhhlodhgihhtsegurhhnugdrmhgvqeenucggtffrrg
    htthgvrhhnpeejjeeutdekhfekfffffeegteelgfeuteetheffieeitdehleettefhjeej
    feelveenucfkphepvddujedrvdefkedrvddtkedrjeegnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfihilhhlodhgihhtsegurhhnugdrmhgv
X-ME-Proxy: <xmx:MrE2YI5tJtxFWobTyiKIlKNa-KBDiqy7eZ57ZE3EMkJp-2gQ2aQHJA>
    <xmx:MrE2YJ2llarlITfEkZN0800lEStoDsWKfezqhfZ7poyAMHoyazmHDQ>
    <xmx:MrE2YDFWgiPmpPcCe9tnPud3IxuW6dLKSIeLCXvxzh1mw9-ZHMQgBQ>
    <xmx:M7E2YJPnLn3FE11B7Pe6Vju7Q0ihUYp1ec78CR7jKF8g_EncIm4N_g>
Received: from [192.168.88.38] (pd9eed04a.dip0.t-ipconnect.de [217.238.208.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2064024005D;
        Wed, 24 Feb 2021 15:04:02 -0500 (EST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH 01/13] staging: rtl8192e: remove blank line in bss_ht
 struct
From:   William Durand <will+git@drnd.me>
In-Reply-To: <20210224074117.GR2087@kadam>
Date:   Wed, 24 Feb 2021 21:04:00 +0100
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <489DBEEB-9F5C-423A-A6D4-4464E67F80E0@drnd.me>
References: <20210220155418.12282-1-will+git@drnd.me>
 <20210220155418.12282-2-will+git@drnd.me> <20210224074117.GR2087@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> All these patches have the same vague commit message.  It's okay if the
> commit message basically restates the commit one line summary.  It
> should say something like:
> 
> Fix a checkpatch warning about a blank line after an open curly brace.
> 
> Rename FooBar to foo_bar to silence a checkpatch warning about
> CamelCase.

Thanks, I'll update the patchset!
