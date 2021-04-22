Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D81368166
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhDVNYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:24:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54883 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhDVNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:24:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8A2CAEB45;
        Thu, 22 Apr 2021 09:23:38 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=IHEioMIcY0x1gzYXzQkbjXJ/piZfbnD+SYraRy
        ofoNA=; b=hXUfreNxW6Ty7yuAcA+43Vf8fxuJzevi1Gjyf8ZYUc3FfCzWhBKLlp
        WvWD+88iYs4F9jfg7W9+hTXRI5bPB+1N8YB2b8U6fst7vAyfAj4SGZgl/6QwL1Bq
        nGKaR4nbFsqxSMp6toZoxkiZr1Y6pI8oAjq2/R6GDK2tNgVqF+rzk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEA08AEB43;
        Thu, 22 Apr 2021 09:23:38 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=IHEioMIcY0x1gzYXzQkbjXJ/piZfbnD+SYraRyofoNA=; b=sm1NRETDPzLjqfAmKJaKz+C0T87Hj7zoxJwfmZaGM9arRAKViU8RpLgl2DuPqZF5+wEH2Pyb6UVYmW736TDVQn0sfcWolWireE8+hJHCooV8FnOXCSVwhA41cStje5Plw3efP0j89WARwskU6fL2sgqD6tY4X79caJUZSfLsA9w=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F421AEB42;
        Thu, 22 Apr 2021 09:23:38 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 1B9F02DA0061;
        Thu, 22 Apr 2021 09:23:37 -0400 (EDT)
Date:   Thu, 22 Apr 2021 09:23:37 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     lizhe <lizhe67@huawei.com>
cc:     linux-kernel@vger.kernel.org, wangfangpeng1@huawei.com,
        zhongjubin@huawei.com
Subject: Re: [PATCH] cramfs: fix potential "unable to mount root fs"
 problem
In-Reply-To: <20210422110619.90196-1-lizhe67@huawei.com>
Message-ID: <p3554720-q5q8-nqo8-n01o-847oq81s6364@syhkavp.arg>
References: <20210422110619.90196-1-lizhe67@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: F2937AF6-A36D-11EB-93A3-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021, lizhe wrote:

> We may encounter panic problem without "rootfstype=" options in
> bootargs. The logs are listed below.
> 
> [0.551962] RAMDISK: squashfs filesystem found at block 0
> [0.551977] RAMDISK: Loading 18117KiB [1 disk] into ram disk...
> [0.719465] done.
> [0.748379] VFS: Cannot open root device "ram0" or unknown-block(1,0): error -92
> [0.748390] Please append a correct "root=" boot option; here are the available partitions:
> [0.748408] 0100           65536 ram0
> [0.748413]  (driver?)
> [0.748430] 0101           65536 ram1
> [0.748434]  (driver?)
> [0.748450] 0102
> [0.748454]  (driver?)
> [0.748470] 0103           65536 ram3
> [0.748475]  (driver?)
> [0.748498] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
> [0.847579] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0 #68
> [0.847598] Call trace:
> [0.847616]  dump_backtrace+0x0/0x1f8
> [0.847627]  show_stack+0x30/0x40
> [0.847638]  dump_stack+0xdc/0x13c
> [0.847650]  panic+0x144/0x35c
> [0.847665]  mount_block_root+0x2c0/0x36c
> [0.847676]  mount_root+0x7c/0x90
> [0.847686]  prepare_namespace+0x178/0x188
> [0.847697]  kernel_init_freeable+0x220/0x28c
> [0.847708]  kernel_init+0x1c/0xf8
> [0.847719]  ret_from_fork+0x10/0x30
> 
> If we set CONFIG_CRAMFS_MTD and CONFIG_CRAMFS_BLOCKDEV to n,
> CONFIG_CRAMFS to y, function cramfs_get_tree return -ENOPROTOOPT,
> which breaks loops in function mount_block_root and we have no
> chance to try other filesystem type. In my opinion, ENOPROTOOPT
> is not an appropriate return value for cramfs mount function, so
> change it to EINVAL.
> 
> Fixes: 99c18ce58 (cramfs: direct memory access support)
> Signed-off-by: lizhe <lizhe67@huawei.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

Please send this to Al Viro for merging.


> ---
>  fs/cramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 2be6526..9942955 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -951,7 +951,7 @@ static const struct super_operations cramfs_ops = {
>  
>  static int cramfs_get_tree(struct fs_context *fc)
>  {
> -	int ret = -ENOPROTOOPT;
> +	int ret = -EINVAL;
>  
>  	if (IS_ENABLED(CONFIG_CRAMFS_MTD)) {
>  		ret = get_tree_mtd(fc, cramfs_mtd_fill_super);
> -- 
> 2.7.4
> 
> 
