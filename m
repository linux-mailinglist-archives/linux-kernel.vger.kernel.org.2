Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9B427769
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 06:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhJIEqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 00:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhJIEqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 00:46:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46C6160FD7;
        Sat,  9 Oct 2021 04:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633754650;
        bh=/DP0YNGWaWd7IkbhoG4Fi8yCcVeNmnaI1/+O1tyTZi8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jwZCIDoBye/Db5VufJzbIarfc+pif9cRf1j2M4Mnrx5InfLvcMXzyQPV3EemCANUJ
         0KKBPdm3oSzw1oKXkn9Njun5N50wmkIr6CleARVZTVIS+uyEj3FQZ7O/cS29QOPhn1
         RaOSDCuLmU2kOq2VpXADX51Qxxwgc01oWDsMxRJZHBQV+fv42eD9n33bvw9x282iWI
         N3670y6IXzlHy1nt/fOwzJPPyBCgL92Cf4x5mOfMFDNjed7jvNQNvpTU3UBNBPqt21
         VuqQBXGs1UfhktCyEMliLaCGb/lGeLl8UDd+NUPqSXop3nDjSTgW4AgvWyNIQCkQyO
         RuLXWMwiGTC1A==
Subject: Re: [f2fs-dev] [PATCH] f2fs: include non-compressed blocks in
 compr_written_block
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20211006174910.2964885-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
Date:   Sat, 9 Oct 2021 12:44:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211006174910.2964885-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/7 1:49, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Need to include non-compressed blocks in compr_written_block to
> estimate average compression ratio more accurately.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/compress.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index c1bf9ad4c220..9b663eaf4805 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1530,6 +1530,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>   	if (cluster_may_compress(cc)) {
>   		err = f2fs_compress_pages(cc);
>   		if (err == -EAGAIN) {
> +			add_compr_block_stat(cc->inode, cc->cluster_size);

Shouldn't we relocate this after 'write' label?

One more concern, it looks we've changed what compr_block stat indicated,
literally, the block we account should be compressed..., how about accounting
it by introducing .presist_blocks, used_blocks or occupied_blocks.... thoughts?

Thanks,

>   			goto write;
>   		} else if (err) {
>   			f2fs_put_rpages_wbc(cc, wbc, true, 1);
> 
