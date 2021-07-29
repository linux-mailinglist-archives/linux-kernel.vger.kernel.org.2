Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F13D9A23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhG2Ahc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhG2Aha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:37:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95B616103B;
        Thu, 29 Jul 2021 00:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627519047;
        bh=HKuJ/sGTGEoDM22RJYLhczo7YamW8A07HkBki046ZPs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W+nFlplcDkxPtR6FK3U73kf6y7ker+0HsuiHS9wyd/pPFKIAJmkEnT2usx4ttscK8
         Ut3KSQ8XWplcwRZeWCg6WVpxygCU8Dgeo6jDQrieKEQdD5bZ7f5wAMFC/dW+X/GTqP
         AkgWoL7GBpUMLLea8K7BEcXRi4Yd+VGM6SvAa3QKqDwcKDQ2JNvtSODKHGx6tAkaQ+
         GcEGdb7MTtemveefybubjMWR64Z70a6DPAJcRoiD49FBaeRC/3oSx46fTUFUkWQqXg
         a6LTP74Rr2/fCfDKtu94/BMf6+4Mjc/10Pn8PBIBVmA/+RyTKo0CU+j+9MrSus0zQl
         J1lZhmK8hjtvA==
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: change fiemap way in printing
 compression chunk
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>
References: <20210726041819.2059593-1-daeho43@gmail.com>
 <f9555521-8878-2d46-36f1-3032bb8bbc0a@kernel.org>
 <CACOAw_zvFcV-5ePrFOr-bo2DxXyFzjDTSo-7aPcXG6jtNweEbA@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <66d9419d-5ce6-626c-7ac8-d0592f34ec31@kernel.org>
Date:   Thu, 29 Jul 2021 08:37:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_zvFcV-5ePrFOr-bo2DxXyFzjDTSo-7aPcXG6jtNweEbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/28 0:41, Daeho Jeong wrote:
> How about adding this?
> 
> skip_fill:
> 
>          if (map.m_pblk == COMPRESS_ADDR) {
> 
>                  if (start_blk & (cluster_size - 1)) {
> 
>                          ret = -EFSCORRUPTED;
> 
>                          goto out;
> 
>                  }
> 
>                  compr_cluster = true;
> 
>                  count_in_cluster = 1;
> 
>          } else if (compr_appended) {

It seems we can add a separate patch to cover all cases that cluster metadata is
going to be accessed rather than just fixing fiemap() case here?

>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> Tested-by: Eric Biggers <ebiggers@google.com>

Anyway, this patch looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
