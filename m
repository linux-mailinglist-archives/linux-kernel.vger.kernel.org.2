Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD173333D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhCJNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:22:28 -0500
Received: from verein.lst.de ([213.95.11.211]:36338 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhCJNV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:21:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0FC3A68B05; Wed, 10 Mar 2021 14:21:57 +0100 (CET)
Date:   Wed, 10 Mar 2021 14:21:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210310132156.GA12145@lst.de>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try this patch instead?

http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html

On Wed, Mar 10, 2021 at 02:51:16PM +0300, Dmitry Monakhov wrote:
> This adds a quirk for Samsung PM1725a drive which fixes timeouts and
> I/O errors due to the fact that the controller does not properly
> handle the Write Zeroes command, dmesg log:
> 
> nvme nvme0: I/O 528 QID 10 timeout, aborting
> nvme nvme0: I/O 529 QID 10 timeout, aborting
> nvme nvme0: I/O 530 QID 10 timeout, aborting
> nvme nvme0: I/O 531 QID 10 timeout, aborting
> nvme nvme0: I/O 532 QID 10 timeout, aborting
> nvme nvme0: I/O 533 QID 10 timeout, aborting
> nvme nvme0: I/O 534 QID 10 timeout, aborting
> nvme nvme0: I/O 535 QID 10 timeout, aborting
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: Abort status: 0x0
> nvme nvme0: I/O 528 QID 10 timeout, reset controller
> nvme nvme0: controller is down; will reset: CSTS=0x3, PCI_STATUS=0x10
> nvme nvme0: Device not ready; aborting reset, CSTS=0x3
> nvme nvme0: Device not ready; aborting reset, CSTS=0x3
> nvme nvme0: Removing after probe failure status: -19
> nvme0n1: detected capacity change from 6251233968 to 0
> blk_update_request: I/O error, dev nvme0n1, sector 32776 op 0x1:(WRITE) flags 0x3000 phys_seg 6 prio class 0
> blk_update_request: I/O error, dev nvme0n1, sector 113319936 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 1, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113319680 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 2, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113319424 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 3, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113319168 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 4, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113318912 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 5, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113318656 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> Buffer I/O error on dev nvme0n1p2, logical block 6, lost async page write
> blk_update_request: I/O error, dev nvme0n1, sector 113318400 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> blk_update_request: I/O error, dev nvme0n1, sector 113318144 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> blk_update_request: I/O error, dev nvme0n1, sector 113317888 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> 
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
>  drivers/nvme/host/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 17ab332..7249ae7 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3246,6 +3246,7 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
>  	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
>  		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
> +				NVME_QUIRK_DISABLE_WRITE_ZEROES|
>  				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
>  		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> -- 
> 2.7.4
---end quoted text---
