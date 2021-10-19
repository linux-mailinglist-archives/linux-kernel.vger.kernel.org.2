Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240C7433678
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhJSNBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235517AbhJSNBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:01:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0988461360;
        Tue, 19 Oct 2021 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634648332;
        bh=caXBS3UB21RWBsaDUtaoarJP8pbeCJWQLJy/YJFswPQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Ea+0+2X3myMrrl1AckG3XgkgqEABOqBxDmZcneYwUggaXTI2ns+2BL5upaUXcE3+7
         B//H3a2uueir36sY0Dm5ITDoneULhDra81xX689DVk1e0JbwQ97EFXu/MAhyXGeopy
         zGRzBqo4+LYhpLfMVP0rUAoXWJFLj+As0GRvqkhSLEk8hhQyHkFjLVbEXQNxwuf1j9
         Jg/TaYF6F8Cgvft72uLW8UWITTD5XFx0yaUNxHTpdqHMk9d13rL+vF365bCuaFLZsh
         abyLmDUOQlJqb9RFLngWHn1XfyqmUYv11VIg3vg/h5FNaBc6YO+ryvOVoUtP6aT+FK
         7Bv5GE5VjPCdw==
Message-ID: <f0d5ccd4-56c0-5212-dc13-fccff9d36e5d@kernel.org>
Date:   Tue, 19 Oct 2021 20:58:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] erofs: introduce readmore decompression strategy
Content-Language: en-US
To:     Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211008200839.24541-1-xiang@kernel.org>
 <20211008200839.24541-4-xiang@kernel.org>
 <8e39e5d1-285d-52b6-8fea-8bb9ff10bf5a@kernel.org>
 <20211017154253.GB4054@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211017154253.GB4054@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/17 23:42, Gao Xiang wrote:
> On Sun, Oct 17, 2021 at 11:34:22PM +0800, Chao Yu wrote:
>> On 2021/10/9 4:08, Gao Xiang wrote:
>>> From: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>
>>> Previously, the readahead window was strictly followed by EROFS
>>> decompression strategy in order to minimize extra memory footprint.
>>> However, it could become inefficient if just reading the partial
>>> requested data for much big LZ4 pclusters and the upcoming LZMA
>>> implementation.
>>>
>>> Let's try to request the leading data in a pcluster without
>>> triggering memory reclaiming instead for the LZ4 approach first
>>> to boost up 100% randread of large big pclusters, and it has no real
>>> impact on low memory scenarios.
>>>
>>> It also introduces a way to expand read lengths in order to decompress
>>> the whole pcluster, which is useful for LZMA since the algorithm
>>> itself is relatively slow and causes CPU bound, but LZ4 is not.
>>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Looks fine to me now.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
