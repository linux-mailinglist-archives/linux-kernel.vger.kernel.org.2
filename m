Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77E3D4FE1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhGYTtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 15:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhGYTtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 15:49:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99360C061757;
        Sun, 25 Jul 2021 13:30:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5CB9B2E5;
        Sun, 25 Jul 2021 20:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5CB9B2E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627245020; bh=sciQDYakJkM1BiUcLYbSMQWKlgXDxDCQuKAN3fTk9N0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FKEe7LE4COndB3wpURFSpe3vZWLBCn/zH0fSSVIgmUddfSWhOgEPeth40j9Fl8Udl
         u6Cn1BpP3pdctVFnsy0XhhU86rkGM1tKx+CLMcpSsTTvxnjvbXMbN/NHHVoryp2YGy
         Xh4ZCtv0me3YfNH2CtOyPDssOthBby95Hh9Z7zDZNGMZr4/WEijsl8KRlxgnjbDdnK
         Vjgsqn6pDMpdoFHhhgqg0uqBcRqYWvCm6xH/zoWUdg1Ifr49/vIIxYks8blyTvFLJN
         nsNE53bKk3N3busd1vTdWqdn4sN5VzNx57tgkclpHg6EE0KEtanEZeUOZcUJ81ICXw
         jXBsoe+wHX0xw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     cgel.zte@gmail.com, sterlingteng@gmail.com
Cc:     alexs@kernel.org, yang.yang29@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] docs/zh_CN: Add zh_CN/accounting/psi.rst
In-Reply-To: <20210723011430.404813-1-yang.yang29@zte.com.cn>
References: <20210723011430.404813-1-yang.yang29@zte.com.cn>
Date:   Sun, 25 Jul 2021 14:30:19 -0600
Message-ID: <87sg02uof8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:

> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Add translation zh_CN/accounting/psi.rst and zh_CN/accounting/index.rst.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  .../translations/zh_CN/accounting/index.rst   |  23 +++
>  .../translations/zh_CN/accounting/psi.rst     | 154 ++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/accounting/index.rst
>  create mode 100644 Documentation/translations/zh_CN/accounting/psi.rst

So what is your role in this patch?  If you are passing on somebody
else's work, it needs your signoff too.

Thanks,

jon
