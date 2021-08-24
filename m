Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0561C3F557E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 03:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhHXBcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 21:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhHXBcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 21:32:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2452613B1;
        Tue, 24 Aug 2021 01:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629768708;
        bh=3ypYGUhqc1Arh9dmrLMyzzsqCNrdZMllCVgunLULrzk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qnRlTkiMe2IQ+BM060szoD41+CMcBT7Ex3asL4USZCC/hyA4p61EwmxvdHBFBk2JK
         JQR/rs23nz/G2zFr3bdibs8jrq6JpQ8TTW2f2zIQUj0epyjItxTFD2DSHRrMVnaJSA
         IFI7fq4MLrFH1bYM3AMAxXXj4kr/0eplIWe19ZRRh6u6RcH1A0kkR/FtL4NoxsrOMN
         3M7hEql4/iu73Tr8JbRZO6Lkbw1fqcZ4UmyKheORqUnkPu81ytmJIlTg7q/1m47E08
         5x1Kwh0Nn5gWx7nGv2ygZNJ526iJzspHwslll9XF53Q1iIdgp1fbJdKnPQ2ZU49icu
         IsxpttNHxiz4A==
Subject: Re: [PATCH] f2fs: fix wrong option name printed by parse_options()
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210824011948.15408-1-chao@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <eadccf3a-057f-4d79-895d-140927167b69@kernel.org>
Date:   Tue, 24 Aug 2021 09:31:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824011948.15408-1-chao@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/24 9:19, Chao Yu wrote:
> It prints below kernel message during mounting w/ checkpoint=disable
> option:
> 
> "F2FS-fs (pmem0): checkpoint=merge cannot be used with checkpoint=disable"

Oops, this message should have been removed by

"f2fs: rename checkpoint=merge mount option to checkpoint_merge"

I may used old f2fs module, please ignore this...
