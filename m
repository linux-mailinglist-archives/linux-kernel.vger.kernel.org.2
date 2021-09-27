Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4574941A3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbhI0Xyb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Sep 2021 19:54:31 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:48674 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233697AbhI0Xya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:54:30 -0400
X-Greylist: delayed 1834 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Sep 2021 19:54:29 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 18RNF0h6068970;
        Tue, 28 Sep 2021 02:21:55 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 3bb66qgn5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 02:21:54 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 28 Sep 2021 02:21:54 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.023; Tue, 28 Sep 2021 02:21:54 +0300
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] ntfs: disable for 64KB because of stack overflow
 risk
Thread-Topic: [PATCH] [RFC] ntfs: disable for 64KB because of stack overflow
 risk
Thread-Index: AQHXs6qHYs/Euc1JMkm6t/T5zm4oc6u4U0mA
Date:   Mon, 27 Sep 2021 23:21:53 +0000
Message-ID: <1B89CC23-0CB4-4DA3-BA84-3DD628675351@tuxera.com>
References: <20210927141815.1711736-1-arnd@kernel.org>
In-Reply-To: <20210927141815.1711736-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.154.241.177]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7952F7CE8B6D06418105E3B5C0191403@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 7MYH49nf64G0oJGn7B9X-DERhId9usSR
X-Proofpoint-GUID: 7MYH49nf64G0oJGn7B9X-DERhId9usSR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-27_07:2021-09-24,2021-09-27 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109270157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for the patch but what is the problem with the stack usage exceeding 2048 bytes?

I am not aware of any architectures that implements kernel stack size (THREAD_SIZE) less than page size and by default most architectures with 4kiB page size even use two pages to make the stack 8kiB.

Thus on a 64kiB page size system the stack size is minimum 64kiB so using just over 2kiB seems to totally fine to me so why apply your patch?

Seems to me it would be better to fix the warning message you are seeing instead - it is a really stupid warning on a system with 64kiB stack size!

Best regards,

	Anton

> On 27 Sep 2021, at 15:18, Arnd Bergmann <arnd@kernel.org> wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On ARM64 randconfig builds, we occasionally get warnings for NTFS:
> 
> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
> fs/ntfs/aops.c:1328:1: error: the frame size of 2224 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> 
> The problem here is that with 64KB pages, we get two arrays on the
> stack that each have 128 pointers, for a total of 2KB. Before
> the VLA change, this could already happen with 512-byte blocks,
> however in practice NTFS should usually have 4KB blocks and not
> be affected by this (see link).
> 
> Now the stack usage is always > 2KB on any architecture with 64KB
> pages. Since both NTFS and 64KB page support are fairly rare,
> we may get away with just marking the combination as disallowed
> in Kconfig and see if anyone complains before we find a different
> way to address it.
> 
> Fixes: ac4ecf968acb ("ntfs: aops: remove VLA usage")
> Link: https://support.microsoft.com/en-us/help/140365/default-cluster-size-for-ntfs-fat-and-exfat
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> fs/ntfs/Kconfig | 1 +
> fs/ntfs/aops.c  | 3 +++
> 2 files changed, 4 insertions(+)
> 
> diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
> index 1667a7e590d8..b770f0209b9c 100644
> --- a/fs/ntfs/Kconfig
> +++ b/fs/ntfs/Kconfig
> @@ -2,6 +2,7 @@
> config NTFS_FS
> 	tristate "NTFS file system support"
> 	select NLS
> +	depends on !PAGE_SIZE_64KB && !ARM64_64K_PAGES
> 	help
> 	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.
> 
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index bb0a43860ad2..76d59bd4c1eb 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -914,6 +914,9 @@ static int ntfs_write_mst_block(struct page *page,
> 	bool sync, is_mft, page_is_dirty, rec_is_dirty;
> 	unsigned char bh_size_bits;
> 
> +	/* Two arrays of MAX_BUF_PER_PAGE on the stack risks an overrun with 64K pages */
> +	BUILD_BUG_ON(PAGE_SIZE >= 65536);
> +
> 	if (WARN_ON(rec_size < NTFS_BLOCK_SIZE))
> 		return -EINVAL;
> 
> -- 
> 2.29.2
> 

