Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E48404257
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348793AbhIIAgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:36:00 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:40604 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348667AbhIIAf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:35:59 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 1890Ylo0023182; Thu, 9 Sep 2021 09:34:47 +0900
X-Iguazu-Qid: 34trdvrI7KvP7CKIiI
X-Iguazu-QSIG: v=2; s=0; t=1631147687; q=34trdvrI7KvP7CKIiI; m=CyzV1qIZKztYHQ9GIK/nIMB7x/HSAUAdpa3UJXTbfnc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1511) id 1890Yk5s004413
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 9 Sep 2021 09:34:47 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id BF1B210014D;
        Thu,  9 Sep 2021 09:34:46 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 1890YkRo021786;
        Thu, 9 Sep 2021 09:34:46 +0900
Date:   Thu, 9 Sep 2021 09:34:43 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     linux-arm-kernel@lists.infradead.org
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Visconti: Enable PCIe host controller
X-TSB-HOP: ON
Message-ID: <20210909003443.szwvuzonvytmj4gl@toshiba.co.jp>
References: <20210907042340.1525711-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907042340.1525711-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 07, 2021 at 01:23:40PM +0900, Nobuhiro Iwamatsu wrote:
> Enable Visconti's PCIe host controller in the ARM64 defconfig.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Best regards,
  Nobuhiro

> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 156d96afbbfc..5085777eb6c9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -237,6 +237,7 @@ CONFIG_PCIE_ARMADA_8K=y
>  CONFIG_PCIE_KIRIN=y
>  CONFIG_PCIE_HISI_STB=y
>  CONFIG_PCIE_TEGRA194_HOST=m
> +CONFIG_PCIE_VISCONTI_HOST=y
>  CONFIG_PCI_ENDPOINT=y
>  CONFIG_PCI_ENDPOINT_CONFIGFS=y
>  CONFIG_PCI_EPF_TEST=m
> -- 
> 2.32.0
> 
> 

