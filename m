Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75B39ED24
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFHDpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:45:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44485 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFHDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:45:09 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lqSe4-00049r-Fx
        for linux-kernel@vger.kernel.org; Tue, 08 Jun 2021 03:43:16 +0000
Received: by mail-ot1-f70.google.com with SMTP id 59-20020a9d0dc10000b02902a57e382ca1so12986598ots.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 20:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2Ko0tSZLsmQ+VBqySLnD9Gc1b13bd1Fim7PgWI85SY=;
        b=C11pjqC3CQP6Ak+DPtbUlyA6cfOm87/ARBPTrmeayqc2bbjJcEzW8GEzbi6Dku44Vt
         d8Nss7HXHTYqVLlGGNcf3qkAko6RYH8ms5KQhb8ncbKeiZCNC8u+kq4CUoGZEtiZUmGq
         BXrJTpjH8r3CLXTd30XbBaYgTnsNp/gL/S1ULCqOE18lWJkIAn9xfM97Uj3hKxmT5PiL
         UpqpVnbm+2v1XiYrRJ0+tj2LYkyTtWHrUA4xr6uGiXCQEX96+YxXQRx2ZKDGriCjS3j4
         3tQJJHdJn7PhI2fkf9J6MjN30/ea6tBFuWiDDwWJCrNn6uwsu0USIp56r7uJPpy7/ziF
         83BQ==
X-Gm-Message-State: AOAM5316F1xQmTyUEQxV/PvlLLSRc7edNXYeW5bsStrU5/GymCg3PWeR
        jwwDqg4HlWSEx6utcvZjv/ftsFlcqFGWsdTtuRyT06TkO22fedWx8wprJpEFdwOyz+1v+AWTCcg
        9NScT6yM2wPpc6+Brtil0xF+XL/0yrwsgHuHexC3tmeWIUHqP28Bl5DOgfw==
X-Received: by 2002:a05:6830:18c2:: with SMTP id v2mr5917984ote.153.1623123795320;
        Mon, 07 Jun 2021 20:43:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkbacz02mLN3UOxo8O7AnLEyI/5zFgoNAZtoM6WMP+CNdEb+bDfRDAe+QVK1z7fTLDa2q63eysbGzx6g1dHTU=
X-Received: by 2002:a05:6830:18c2:: with SMTP id v2mr5917969ote.153.1623123795012;
 Mon, 07 Jun 2021 20:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210607101634.4948-1-ricky_wu@realtek.com>
In-Reply-To: <20210607101634.4948-1-ricky_wu@realtek.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Tue, 8 Jun 2021 11:43:03 +0800
Message-ID: <CABTNMG1yoYPgs0gr1bHsrxCmpNM8fUB+3S5E+HS7c9pPGiFxrQ@mail.gmail.com>
Subject: Re: [PATCH v2] misc: rtsx: separate aspm mode into MODE_REG and MODE_CFG
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ulf.hansson@linaro.org,
        rui_feng@realsil.com.cn, vaibhavgupta40@gmail.com,
        yang.lee@linux.alibaba.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 6:16 PM <ricky_wu@realtek.com> wrote:
>
> From: Ricky Wu <ricky_wu@realtek.com>
>
> aspm (Active State Power Management)
> rtsx_comm_set_aspm: this function is for driver to make sure
> not enter power saving when processing of init and card_detcct
> ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250
> Change back to use original way to control aspm
> ASPM_MODE_REG: 5227A 524A 5250A 5260 5261 5228
> Keep the new way to control aspm
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
Reported-by: Chris Chiu <chris.chiu@canonical.com>

> V2:
> change to use an enum for ASPM_MODE
> describe more description
> ---
>  drivers/misc/cardreader/rtl8411.c  |  1 +
>  drivers/misc/cardreader/rts5209.c  |  1 +
>  drivers/misc/cardreader/rts5227.c  |  2 ++
>  drivers/misc/cardreader/rts5228.c  |  1 +
>  drivers/misc/cardreader/rts5229.c  |  1 +
>  drivers/misc/cardreader/rts5249.c  |  3 ++
>  drivers/misc/cardreader/rts5260.c  |  1 +
>  drivers/misc/cardreader/rts5261.c  |  1 +
>  drivers/misc/cardreader/rtsx_pcr.c | 44 +++++++++++++++++++++---------
>  include/linux/rtsx_pci.h           |  2 ++
>  10 files changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtl8411.c b/drivers/misc/cardreader/rtl8411.c
> index a07674ed0596..4c5621b17a6f 100644
> --- a/drivers/misc/cardreader/rtl8411.c
> +++ b/drivers/misc/cardreader/rtl8411.c
> @@ -468,6 +468,7 @@ static void rtl8411_init_common_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = DRIVER_TYPE_D;
>         pcr->aspm_en = ASPM_L1_EN;
> +       pcr->aspm_mode = ASPM_MODE_CFG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(23, 7, 14);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(4, 3, 10);
>         pcr->ic_version = rtl8411_get_ic_version(pcr);
> diff --git a/drivers/misc/cardreader/rts5209.c b/drivers/misc/cardreader/rts5209.c
> index 39a6a7ecc32e..29f5414072bf 100644
> --- a/drivers/misc/cardreader/rts5209.c
> +++ b/drivers/misc/cardreader/rts5209.c
> @@ -255,6 +255,7 @@ void rts5209_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = DRIVER_TYPE_D;
>         pcr->aspm_en = ASPM_L1_EN;
> +       pcr->aspm_mode = ASPM_MODE_CFG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 16);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
>
> diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
> index 8200af22b529..4bcfbc9afbac 100644
> --- a/drivers/misc/cardreader/rts5227.c
> +++ b/drivers/misc/cardreader/rts5227.c
> @@ -358,6 +358,7 @@ void rts5227_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
>         pcr->aspm_en = ASPM_L1_EN;
> +       pcr->aspm_mode = ASPM_MODE_CFG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 15);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(30, 7, 7);
>
> @@ -483,6 +484,7 @@ void rts522a_init_params(struct rtsx_pcr *pcr)
>
>         rts5227_init_params(pcr);
>         pcr->ops = &rts522a_pcr_ops;
> +       pcr->aspm_mode = ASPM_MODE_REG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 20, 11);
>         pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
>
> diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
> index 781a86def59a..ffc128278613 100644
> --- a/drivers/misc/cardreader/rts5228.c
> +++ b/drivers/misc/cardreader/rts5228.c
> @@ -718,6 +718,7 @@ void rts5228_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
>         pcr->aspm_en = ASPM_L1_EN;
> +       pcr->aspm_mode = ASPM_MODE_REG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(28, 27, 11);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
>
> diff --git a/drivers/misc/cardreader/rts5229.c b/drivers/misc/cardreader/rts5229.c
> index 89e6f124ca5c..c748eaf1ec1f 100644
> --- a/drivers/misc/cardreader/rts5229.c
> +++ b/drivers/misc/cardreader/rts5229.c
> @@ -246,6 +246,7 @@ void rts5229_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = DRIVER_TYPE_D;
>         pcr->aspm_en = ASPM_L1_EN;
> +       pcr->aspm_mode = ASPM_MODE_CFG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 15);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(30, 6, 6);
>
> diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
> index b2676e7f5027..53f3a1f45c4a 100644
> --- a/drivers/misc/cardreader/rts5249.c
> +++ b/drivers/misc/cardreader/rts5249.c
> @@ -566,6 +566,7 @@ void rts5249_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
>         pcr->aspm_en = ASPM_L1_EN;
> +       pcr->aspm_mode = ASPM_MODE_CFG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(1, 29, 16);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
>
> @@ -729,6 +730,7 @@ static const struct pcr_ops rts524a_pcr_ops = {
>  void rts524a_init_params(struct rtsx_pcr *pcr)
>  {
>         rts5249_init_params(pcr);
> +       pcr->aspm_mode = ASPM_MODE_REG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 29, 11);
>         pcr->option.ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
>         pcr->option.ltr_l1off_snooze_sspwrgate =
> @@ -845,6 +847,7 @@ static const struct pcr_ops rts525a_pcr_ops = {
>  void rts525a_init_params(struct rtsx_pcr *pcr)
>  {
>         rts5249_init_params(pcr);
> +       pcr->aspm_mode = ASPM_MODE_REG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(25, 29, 11);
>         pcr->option.ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
>         pcr->option.ltr_l1off_snooze_sspwrgate =
> diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
> index 080a7d67a8e1..9b42b20a3e5a 100644
> --- a/drivers/misc/cardreader/rts5260.c
> +++ b/drivers/misc/cardreader/rts5260.c
> @@ -628,6 +628,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
>         pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
>         pcr->aspm_en = ASPM_L1_EN;
> +       pcr->aspm_mode = ASPM_MODE_REG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 29, 11);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
>
> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> index 6c64dade8e1a..1fd4e0e50730 100644
> --- a/drivers/misc/cardreader/rts5261.c
> +++ b/drivers/misc/cardreader/rts5261.c
> @@ -783,6 +783,7 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
>         pcr->sd30_drive_sel_1v8 = 0x00;
>         pcr->sd30_drive_sel_3v3 = 0x00;
>         pcr->aspm_en = ASPM_L1_EN;
> +       pcr->aspm_mode = ASPM_MODE_REG;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 11);
>         pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 273311184669..baf83594a01d 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -85,12 +85,18 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
>         if (pcr->aspm_enabled == enable)
>                 return;
>
> -       if (pcr->aspm_en & 0x02)
> -               rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
> -                       FORCE_ASPM_CTL1, enable ? 0 : FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
> -       else
> -               rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
> -                       FORCE_ASPM_CTL1, FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
> +       if (pcr->aspm_mode == ASPM_MODE_CFG) {
> +               pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
> +                                               PCI_EXP_LNKCTL_ASPMC,
> +                                               enable ? pcr->aspm_en : 0);
> +       } else if (pcr->aspm_mode == ASPM_MODE_REG) {
> +               if (pcr->aspm_en & 0x02)
> +                       rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
> +                               FORCE_ASPM_CTL1, enable ? 0 : FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
> +               else
> +                       rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
> +                               FORCE_ASPM_CTL1, FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
> +       }
>
>         if (!enable && (pcr->aspm_en & 0x02))
>                 mdelay(10);
> @@ -1394,7 +1400,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
>                         return err;
>         }
>
> -       rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
> +       if (pcr->aspm_mode == ASPM_MODE_REG)
> +               rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
>
>         /* No CD interrupt if probing driver with card inserted.
>          * So we need to initialize pcr->card_exist here.
> @@ -1410,6 +1417,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
>  static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
>  {
>         int err;
> +       u16 cfg_val;
> +       u8 val;
>
>         spin_lock_init(&pcr->lock);
>         mutex_init(&pcr->pcr_mutex);
> @@ -1477,6 +1486,21 @@ static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
>         if (!pcr->slots)
>                 return -ENOMEM;
>
> +       if (pcr->aspm_mode == ASPM_MODE_CFG) {
> +               pcie_capability_read_word(pcr->pci, PCI_EXP_LNKCTL, &cfg_val);
> +               if (cfg_val & PCI_EXP_LNKCTL_ASPM_L1)
> +                       pcr->aspm_enabled = true;
> +               else
> +                       pcr->aspm_enabled = false;
> +
> +       } else if (pcr->aspm_mode == ASPM_MODE_REG) {
> +               rtsx_pci_read_register(pcr, ASPM_FORCE_CTL, &val);
> +               if (val & FORCE_ASPM_CTL0 && val & FORCE_ASPM_CTL1)
> +                       pcr->aspm_enabled = false;
> +               else
> +                       pcr->aspm_enabled = true;
> +       }
> +
>         if (pcr->ops->fetch_vendor_settings)
>                 pcr->ops->fetch_vendor_settings(pcr);
>
> @@ -1506,7 +1530,6 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
>         struct pcr_handle *handle;
>         u32 base, len;
>         int ret, i, bar = 0;
> -       u8 val;
>
>         dev_dbg(&(pcidev->dev),
>                 ": Realtek PCI-E Card Reader found at %s [%04x:%04x] (rev %x)\n",
> @@ -1572,11 +1595,6 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
>         pcr->host_cmds_addr = pcr->rtsx_resv_buf_addr;
>         pcr->host_sg_tbl_ptr = pcr->rtsx_resv_buf + HOST_CMDS_BUF_LEN;
>         pcr->host_sg_tbl_addr = pcr->rtsx_resv_buf_addr + HOST_CMDS_BUF_LEN;
> -       rtsx_pci_read_register(pcr, ASPM_FORCE_CTL, &val);
> -       if (val & FORCE_ASPM_CTL0 && val & FORCE_ASPM_CTL1)
> -               pcr->aspm_enabled = false;
> -       else
> -               pcr->aspm_enabled = true;
>         pcr->card_inserted = 0;
>         pcr->card_removed = 0;
>         INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> index 6f155f99aa16..4ab7bfc675f1 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -1109,6 +1109,7 @@ struct pcr_ops {
>  };
>
>  enum PDEV_STAT  {PDEV_STAT_IDLE, PDEV_STAT_RUN};
> +enum ASPM_MODE  {ASPM_MODE_CFG, ASPM_MODE_REG};
>
>  #define ASPM_L1_1_EN                   BIT(0)
>  #define ASPM_L1_2_EN                   BIT(1)
> @@ -1234,6 +1235,7 @@ struct rtsx_pcr {
>         u8                              card_drive_sel;
>  #define ASPM_L1_EN                     0x02
>         u8                              aspm_en;
> +       enum ASPM_MODE                  aspm_mode;
>         bool                            aspm_enabled;
>
>  #define PCR_MS_PMOS                    (1 << 0)
> --
> 2.17.1
>
