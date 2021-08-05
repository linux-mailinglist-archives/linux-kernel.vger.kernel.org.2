Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C43E0C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 03:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbhHEBXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 21:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhHEBXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 21:23:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9CD560F58;
        Thu,  5 Aug 2021 01:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628126572;
        bh=gTjIpI1FpLUDK6STnG9eLGnDt1bnnSC4qvZu+spsCTs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FqDX/iFs6JQffpoQiyezVvMibM4g4RFdK6AbbAVdadlxIHIIt0ehOep8DnM8XEVY7
         pIwZZPJ0MGWr6SpReTO/3fKvNNnonCWNHkigqLrUZ+txxmqtjN33JZNVBlfT+l7GTs
         6cgaS5iKzy8fDHdr+tnlBDypRaRvEuR5kLf801BVatBsee8SVfXayd0EhyWPAk1Whi
         58jrf7iZmz6/Q/b+akO2BBDUcN7LOzTGaoHkc7BWaK/JK8juAxmDoRLZdkZ9GUI/Xm
         SCc5x6X1D8LzCJ1KH3GCbIBmeK8g2k9OBtcgCo+/Cw+unmGEv9W3YydizJayGcPiU8
         5yDXIJHyNuGiQ==
Subject: Re: [PATCH] f2fs: introduce nosmall_discard mount option
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210730100530.4401-1-chao@kernel.org>
 <YQqbhMtVZvCF30r9@infradead.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1204887a-7724-7891-2db5-6f710b595781@kernel.org>
Date:   Thu, 5 Aug 2021 09:22:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQqbhMtVZvCF30r9@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/4 21:52, Christoph Hellwig wrote:
> On Fri, Jul 30, 2021 at 06:05:30PM +0800, Chao Yu wrote:
>> This patch introduces a new mountoption "nosmall_discard" to support
>> disabling small discard functionality, note that the mountoption can not
>> be removed by remount() due to related metadata should always be
>> initialized during mount().
> 
> Why does this need an option?  It should be enable IFF and only IFF a
> SMR drive is detected.
> 

We've updated this patch as below:

@@ -1961,10 +1998,13 @@ static void default_options(struct f2fs_sb_info *sbi)
  	sbi->sb->s_flags |= SB_LAZYTIME;
  	set_opt(sbi, FLUSH_MERGE);
  	set_opt(sbi, DISCARD);
-	if (f2fs_sb_has_blkzoned(sbi))
+	if (f2fs_sb_has_blkzoned(sbi)) {
  		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
-	else
+		F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_SECTION;
+	} else {
  		F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
+		F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_BLOCK;
+	}

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=dev&id=4f993264fe2965c344f223d854ccbb549b16ed71

For blkzoned device, section unit based discard will be enabled by default.

For other type of devices, IMO, this is a tradeoff in between small-sized
discard support and memory overhead, so I proposed to add such mount option
to support selection from different benefit point.

Thanks,
