Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F010339B80
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 04:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhCMDMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 22:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMDMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 22:12:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 19:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3HZ6/kTS4DEqCevNiVaV+YXPpM1yzu/4v32/WHRBUS4=; b=CRtW5DqkqMcxuNSQ3zrp/Ge1tM
        wyVCHZ30MKUdKr96OolHSWEbkyooayYXI2TRMuQfjrQkJui+vwWAgq95HaFd1BVuFUXyd8JFJR9Wl
        W4GUOqEayZPzv5n8iHzZvfB9quIfUkFwgSjPINXioHqdF1qDxb6PmzE/h7c4+d24tmjlZt8D6heNV
        Y9tg7sSVJERfv5rnN/HyJ5rPkcG5ACQ5AAP5q34JTN/5eT2iO1iO80FHqeVy7XLZLAG91SXD1v69g
        pm5o6TgRzYt8F5QGdXlIIT5qAgEF2LoAwoVGkZFaHHAdwLNaxrC70Hdm7e4i9nx7GnO6uDN7Xqbw8
        pAGI7mvQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKugy-0017Dk-KH; Sat, 13 Mar 2021 03:11:56 +0000
Subject: Re: [PATCH] mailbox: fix various typos in comments
To:     Tom Saeger <tom.saeger@oracle.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, trivial@kernel.org
References: <bf837fae33814695e4dbe80e88529518061a0dd4.1615601744.git.tom.saeger@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <39dfa78c-3fcf-1de4-a790-856423909fd7@infradead.org>
Date:   Fri, 12 Mar 2021 19:11:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <bf837fae33814695e4dbe80e88529518061a0dd4.1615601744.git.tom.saeger@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 6:31 PM, Tom Saeger wrote:
> 
> Fix trivial typos in mailbox driver comments.
> 
> s/Intergrated/Integrated/
> s/extenstion/extension/
> s/atleast/at least/
> s/commnunication/communication/
> s/assgined/assigned/
> s/commnunication/communication/
> s/recevied/received/
> s/succeded/succeeded/
> s/implmentation/implementation/
> s/definiation/definition/
> s/traget/target/
> s/wont/won't/
> 
> Cc: trivial@kernel.org
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/mailbox/Kconfig                 |  2 +-
>  drivers/mailbox/bcm-flexrm-mailbox.c    |  4 ++--
>  drivers/mailbox/mailbox-xgene-slimpro.c |  6 +++---
>  drivers/mailbox/mailbox.h               |  2 +-
>  drivers/mailbox/pcc.c                   |  2 +-
>  drivers/mailbox/pl320-ipc.c             |  2 +-
>  drivers/mailbox/sprd-mailbox.c          | 12 ++++++------
>  drivers/mailbox/ti-msgmgr.c             |  2 +-
>  8 files changed, 16 insertions(+), 16 deletions(-)


-- 
~Randy

