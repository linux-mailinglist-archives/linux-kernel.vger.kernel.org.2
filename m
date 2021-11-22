Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4455458E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhKVM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:29:11 -0500
Received: from mail.loongson.cn ([114.242.206.163]:57704 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233840AbhKVM3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:29:10 -0500
Received: from [10.180.13.93] (unknown [10.180.13.93])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx1tNWjJthJiYAAA--.766S2;
        Mon, 22 Nov 2021 20:25:58 +0800 (CST)
Subject: Re: [PATCH v3] usb: xhci: add LWP quirk for ensuring uPD720201 into
 D3 state after S5
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo@loongson.cn, linux-kernel@vger.kernel.org
References: <1636612118-32481-1-git-send-email-zhuyinbo@loongson.cn>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <c330c58f-bb73-d439-d6fa-63eb9cba4313@loongson.cn>
Date:   Mon, 22 Nov 2021 20:25:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1636612118-32481-1-git-send-email-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9Dx1tNWjJthJiYAAA--.766S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF15Ar47Aw4rtrWUur1kuFg_yoW5XF17pF
        s5ZaySkrs5tr4Iq3sxZr18ZF95GwnrAryUKry7G34jgrZ0yrs5KFyUGFW3CrZxW3ykJr1a
        gF1vgr15W3y7CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUywZ7UUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/11/11 ÏÂÎç2:28, Yinbo Zhu Ð´µÀ:
> After S5, any pci device should into D3 state that if supported, but the
> uPD720201 was not and cause OSPM power consumption is more higher that
> S5 than S4. Due to that uPD720201 firmware behavior was unknown and the
> _PS3 method wasn't implemented in ACPI table which can make device into
> D3, I think xhci HCD can add a quirk ensure it into D3 state after S5
> that is appropriate and this patch was to add the XHCI_LWP_QURIK and set
> PCI_D3hot to uPD720201 pmsc register in xhci_pci_shutdown and
> xhci_pci_remove to fix xhci power consumption issue.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v3:
> 		Add D3 set in xhci_pci_remove function.
>
>   drivers/usb/host/xhci-pci.c | 9 +++++++++
>   drivers/usb/host/xhci.h     | 1 +
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 2c9f25c..6258a5a 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -265,6 +265,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   	    pdev->device == 0x0014) {
>   		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>   		xhci->quirks |= XHCI_ZERO_64B_REGS;
> +		xhci->quirks |= XHCI_LWP_QUIRK;
>   	}
>   	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
>   	    pdev->device == 0x0015) {
> @@ -466,6 +467,10 @@ static void xhci_pci_remove(struct pci_dev *dev)
>   		pci_set_power_state(dev, PCI_D3hot);
>   
>   	usb_hcd_pci_remove(dev);
> +
> +	/* Workaround for decreasing power consumption after S5 */
> +	if (xhci->quirks & XHCI_LWP_QUIRK)
> +		pci_set_power_state(dev, PCI_D3hot);
>   }
>   
>   #ifdef CONFIG_PM
> @@ -610,6 +615,10 @@ static void xhci_pci_shutdown(struct usb_hcd *hcd)
>   	/* Yet another workaround for spurious wakeups at shutdown with HSW */
>   	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
>   		pci_set_power_state(pdev, PCI_D3hot);
> +
> +	/* Workaround for decreasing power consumption after S5 */
> +	if (xhci->quirks & XHCI_LWP_QUIRK)
> +		pci_set_power_state(pdev, PCI_D3hot);
>   }
>   #endif /* CONFIG_PM */
>   
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index dca6181..bcd70d1 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1899,6 +1899,7 @@ struct xhci_hcd {
>   #define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
>   #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
>   #define XHCI_BROKEN_D3COLD	BIT_ULL(41)
> +#define XHCI_LWP_QUIRK		BIT_ULL(42)
>   
>   	unsigned int		num_active_eps;
>   	unsigned int		limit_active_eps;

Hi all,


Do you have any advice about my patch, if no any question, please you 
help me merge this patch to upstream.


Thanks,

BRs,

Yinbo Zhu.

