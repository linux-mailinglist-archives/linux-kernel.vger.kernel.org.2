Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561683DBEEC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 21:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhG3TT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 15:19:58 -0400
Received: from ms.lwn.net ([45.79.88.28]:45864 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhG3TT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 15:19:57 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 027DE2A0;
        Fri, 30 Jul 2021 19:19:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 027DE2A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627672792; bh=SIBMUHCxoW2C/GfFGZFJPxhooLbjlyV/6G6GA4QHLOA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dRSZlYUgPsG/a9AE7hhU8czElAKUyPb9FZsOxP6jRXG1VpJxXsL72reKT97gF1FOa
         bzz2LHS3Gpcpyd88wutU0qOZ7MFujZ9ArEQDtfjixEfTVnZw75Ycr92uBZ4kJguoQC
         RGppPjK5vfU46xRpV8Lj+fSyBadqwe7Pn7V/gHLLkkV9+Ci5OzwUJyJRlFhEbYtfVz
         R6xN+a93g/NFWhyMMjoFMUyNX/X7hEs8iDGrtWOoJ85OLzzu4mAoPDHa02hykcZkp1
         VckXtHye1PkX6y8S9cmrUbFetutWUoifuKkhj264rxOoL1X6EuvAZ3FaedFCQXaGBw
         ZrFPK3LNIBEfg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     cgel.zte@gmail.com, siyanteng@loongson.cn, sterlingteng@gmail.com
Cc:     alexs@kernel.org, yang.yang29@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] docs/zh_CN: Add zh_CN/accounting/psi.rst
In-Reply-To: <20210726135832.513115-1-yang.yang29@zte.com.cn>
References: <20210726135832.513115-1-yang.yang29@zte.com.cn>
Date:   Fri, 30 Jul 2021 13:19:51 -0600
Message-ID: <87eebfa9t4.fsf@meer.lwn.net>
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
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> v4: delete wrong Reviewed-by
> v3: add reviewers
> v2: correct wrong format and add translations for code annotations
> ---
>  .../translations/zh_CN/accounting/index.rst   |  25 +++
>  .../translations/zh_CN/accounting/psi.rst     | 155 ++++++++++++++++++
>  2 files changed, 180 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/accounting/index.rst
>  create mode 100644 Documentation/translations/zh_CN/accounting/psi.rst

Almost there ... but you need to link .../accounting/index.rst into the
top-level Chinese index.rst for these new files to be part of the docs
build.  Please be sure you can actually build the docs and view the
result.

Thanks,

jon
