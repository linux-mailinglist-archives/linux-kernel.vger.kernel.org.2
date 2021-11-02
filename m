Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7C442637
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhKBDzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:55:09 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:56456 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhKBDzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:55:08 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mhkqf-0004pf-9E; Tue, 02 Nov 2021 11:52:33 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mhkqd-00066A-UR; Tue, 02 Nov 2021 11:52:31 +0800
Date:   Tue, 2 Nov 2021 11:52:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "yekai(A)" <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH v3 0/6] crypto: hisilicon - supports hash algorithm for
 SEC engine
Message-ID: <20211102035231.GA23420@gondor.apana.org.au>
References: <20211022091055.15369-1-yekai13@huawei.com>
 <f0f54c23-dec3-f3eb-3283-3ef6478efe33@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f54c23-dec3-f3eb-3283-3ef6478efe33@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 09:06:15AM +0800, yekai(A) wrote:
>
> Could you help to take this patchset?

I'm still evaluating the import/export code so please be patient.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
