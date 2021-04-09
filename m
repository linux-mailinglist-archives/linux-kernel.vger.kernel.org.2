Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748FD359714
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhDIIDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhDIIDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:03:32 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19066C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 01:03:19 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so4914044otr.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RcnuSAPF+vIBDYwH1bGYM7vSW2261mUl9uE0KvCYZjw=;
        b=NEAUjdXg2a+TKl4GYwRxf7ozgFsrPnNOmLwTiz9T6p2wuWKErUfy+wh2ZvKlQReQAT
         9Rhi48Z7/mTF1Cp2xsmKb5QiMNQheK1fD1Sj76wfzjcia8ulJI4ES7LmnMqEuLneym5O
         Ndq1hYWHTV2570BYoTtln3bdOGLZvp8QcvN9lOhI3EvONiHEMljwtHqLDWzVfXliXS95
         evwJth6KamcT5AHN75OdNiMt5gky4XKrUWWjlAaBXIxak4QT967RLab4N+z3FAEZVVSL
         5TBg5jJe50G7rMzleeGrPEiTparpfr1gIXo5DXCzdaApgnOuEJczUNazMr/95goq/G5r
         mjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RcnuSAPF+vIBDYwH1bGYM7vSW2261mUl9uE0KvCYZjw=;
        b=Zm6BeGTfusWIvCtV8q2HSg3GxNm3G0dfgjsdJQgTN9rkscrrQ7DpOlWpxpGX3PGP1h
         l0vYHNXSMkz6Hbftn44OpNiT0yqYQuSAu3k8kOrzq6y1W7qBZd1Sicg619zoOaAKpRI3
         zu8Hn6D0lsk7sTmq/3/bzXos1RGF7/Gf7S0XG/068A3fgseAflAu6B6zLVckYyjMgO0g
         i1Fth2nllamr4eBdEYGilusSJSnhU38Xk3WwkMlCstV4yw7NiVqxZNS8iaRr6hLeY3lh
         2ShFkVfm3BGzLgcUR5oQHDA1kiKGdqZcGkGlkBwYnzPnu9LhEDOKO6K/4TarEpYvr9rc
         1MUw==
X-Gm-Message-State: AOAM5325CIGfOtleH6/tItbfGB/iq5V2rcU8HhqDped3bhF53xCsfkyn
        ShsB0QJnMMswMBwqxTIapa4uqCSfUzNT5maaSc1ftNoRBZ6msA==
X-Google-Smtp-Source: ABdhPJxVSrldOuGBj9uCu5X5bo6WlvUtFrtw9kQFN5g+iPJtNrShkirHrD6ayAUuUGe/Aq98YIWkgl6Ts0kakUs8Yrc=
X-Received: by 2002:a9d:74ca:: with SMTP id a10mr4895531otl.53.1617955398294;
 Fri, 09 Apr 2021 01:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210409080014.25900-1-fmdefrancesco@gmail.com>
In-Reply-To: <20210409080014.25900-1-fmdefrancesco@gmail.com>
From:   FMDF <fmdefrancesco@gmail.com>
Date:   Fri, 9 Apr 2021 10:03:02 +0200
Message-ID: <CAPj211vX0fZ7xd=mG4vW-Hf8Y=LzSKuu1-Qp-54pZZCs=vovkQ@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v6] staging: rtl8723bs: Remove
 camelcase in several files
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong patch again.

Fabio

On Fri, Apr 9, 2021 at 10:00 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> Remove camelcase in bFwCurrentInPSMode, a variable used by code
> of several subdirectories/files of the driver. Issue detected by
> checkpatch.pl. Delete the unnecessary "b" (that stands for "byte") from
> the beginning of the name.
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>
> Changes from v5: Edit against the wrong patch
> Changes from v4: Mention the removal of the initial "b" in log message.
> Changes from v3: Fix errors in the format of the patch.
> Changes from v2: Remove unnecessary comment. Shortened a function name.
> Changes from v1: No changes to the code but only to the subject for the
> purpose to differentiate this patch because other removes of camelcase
> have been made in other files of the same directory.
>
>  drivers/staging/rtl8723bs/core/rtw_cmd.c       |  2 +-
>  drivers/staging/rtl8723bs/core/rtw_mlme.c      |  2 +-
>  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   | 18 +++++++++---------
>  drivers/staging/rtl8723bs/hal/hal_intf.c       |  2 +-
>  drivers/staging/rtl8723bs/hal/rtl8723b_dm.c    |  6 +++---
>  .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  2 +-
>  drivers/staging/rtl8723bs/hal/sdio_ops.c       | 14 +++++++-------
>  .../staging/rtl8723bs/include/rtw_pwrctrl.h    |  2 +-
>  8 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index baf8b1e0f43c..a08f22b53592 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -1510,7 +1510,7 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
>         if (pwrpriv->dtim != dtim)
>                 pwrpriv->dtim = dtim;
>
> -       if ((pwrpriv->bFwCurrentInPSMode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
> +       if ((pwrpriv->b_fw_current_in_ps_mode == true) && (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
>                 u8 ps_mode = pwrpriv->pwr_mode;
>
>                 rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index a7e40aaae2d9..51cea6cf46e7 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -1684,7 +1684,7 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
>         if (adapter->net_closed)
>                 return;
>
> -       if ((adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
> +       if ((adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode)
>                 && !(hal_btcoex_IsBtControlLps(adapter))
>                 ) {
>                 u8 bEnterPS;
> diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> index f7465cf90c46..21e7a847866f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
> @@ -365,7 +365,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
>                         rtw_set_rpwm(padapter, PS_STATE_S4);
>
>                         rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
> -                       pwrpriv->bFwCurrentInPSMode = false;
> +                       pwrpriv->b_fw_current_in_ps_mode = false;
>
>                         hal_btcoex_LpsNotify(padapter, ps_mode);
>                 }
> @@ -377,7 +377,7 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
>
>                         hal_btcoex_LpsNotify(padapter, ps_mode);
>
> -                       pwrpriv->bFwCurrentInPSMode = true;
> +                       pwrpriv->b_fw_current_in_ps_mode = true;
>                         pwrpriv->pwr_mode = ps_mode;
>                         pwrpriv->smart_ps = smart_ps;
>                         pwrpriv->bcn_ant_mode = bcn_ant_mode;
> @@ -734,7 +734,7 @@ s32 rtw_register_task_alive(struct adapter *padapter, u32 task)
>
>         register_task_alive(pwrctrl, task);
>
> -       if (pwrctrl->bFwCurrentInPSMode) {
> +       if (pwrctrl->b_fw_current_in_ps_mode) {
>                 if (pwrctrl->cpwm < pslv) {
>                         if (pwrctrl->cpwm < PS_STATE_S2)
>                                 res = _FAIL;
> @@ -782,7 +782,7 @@ void rtw_unregister_task_alive(struct adapter *padapter, u32 task)
>
>         unregister_task_alive(pwrctrl, task);
>
> -       if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
> +       if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->b_fw_current_in_ps_mode) {
>                 if (pwrctrl->cpwm > pslv)
>                         if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
>                                 rtw_set_rpwm(padapter, pslv);
> @@ -819,7 +819,7 @@ s32 rtw_register_tx_alive(struct adapter *padapter)
>
>         register_task_alive(pwrctrl, XMIT_ALIVE);
>
> -       if (pwrctrl->bFwCurrentInPSMode) {
> +       if (pwrctrl->b_fw_current_in_ps_mode) {
>                 if (pwrctrl->cpwm < pslv) {
>                         if (pwrctrl->cpwm < PS_STATE_S2)
>                                 res = _FAIL;
> @@ -864,7 +864,7 @@ s32 rtw_register_cmd_alive(struct adapter *padapter)
>
>         register_task_alive(pwrctrl, CMD_ALIVE);
>
> -       if (pwrctrl->bFwCurrentInPSMode) {
> +       if (pwrctrl->b_fw_current_in_ps_mode) {
>                 if (pwrctrl->cpwm < pslv) {
>                         if (pwrctrl->cpwm < PS_STATE_S2)
>                                 res = _FAIL;
> @@ -909,7 +909,7 @@ void rtw_unregister_tx_alive(struct adapter *padapter)
>
>         unregister_task_alive(pwrctrl, XMIT_ALIVE);
>
> -       if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
> +       if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->b_fw_current_in_ps_mode) {
>                 if (pwrctrl->cpwm > pslv)
>                         if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
>                                 rtw_set_rpwm(padapter, pslv);
> @@ -945,7 +945,7 @@ void rtw_unregister_cmd_alive(struct adapter *padapter)
>
>         unregister_task_alive(pwrctrl, CMD_ALIVE);
>
> -       if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->bFwCurrentInPSMode) {
> +       if ((pwrctrl->pwr_mode != PS_MODE_ACTIVE) && pwrctrl->b_fw_current_in_ps_mode) {
>                 if (pwrctrl->cpwm > pslv) {
>                         if ((pslv >= PS_STATE_S2) || (pwrctrl->alives == 0))
>                                 rtw_set_rpwm(padapter, pslv);
> @@ -978,7 +978,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
>         pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
>         pwrctrlpriv->bLeisurePs = pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE;
>
> -       pwrctrlpriv->bFwCurrentInPSMode = false;
> +       pwrctrlpriv->b_fw_current_in_ps_mode = false;
>
>         pwrctrlpriv->rpwm = 0;
>         pwrctrlpriv->cpwm = PS_STATE_S4;
> diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
> index bc9ae2088754..a73c2f76628d 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_intf.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
> @@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
>
>  void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
>  {
> -       if (adapter_to_pwrctl(padapter)->bFwCurrentInPSMode == true) {
> +       if (adapter_to_pwrctl(padapter)->b_fw_current_in_ps_mode == true) {
>                 if (padapter->HalFunc.hal_dm_watchdog_in_lps)
>                         padapter->HalFunc.hal_dm_watchdog_in_lps(padapter); /* this function caller is in interrupt context */
>         }
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> index c2e9e4a0be22..265db187b8d5 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
> @@ -141,7 +141,7 @@ void rtl8723b_InitHalDm(struct adapter *Adapter)
>
>  void rtl8723b_HalDmWatchDog(struct adapter *Adapter)
>  {
> -       bool bFwCurrentInPSMode = false;
> +       bool b_fw_current_in_ps_mode = false;
>         bool bFwPSAwake = true;
>         u8 hw_init_completed = false;
>         struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
> @@ -151,12 +151,12 @@ void rtl8723b_HalDmWatchDog(struct adapter *Adapter)
>         if (hw_init_completed == false)
>                 goto skip_dm;
>
> -       bFwCurrentInPSMode = adapter_to_pwrctl(Adapter)->bFwCurrentInPSMode;
> +       b_fw_current_in_ps_mode = adapter_to_pwrctl(Adapter)->b_fw_current_in_ps_mode;
>         rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&bFwPSAwake));
>
>         if (
>                 (hw_init_completed == true) &&
> -               ((!bFwCurrentInPSMode) && bFwPSAwake)
> +               ((!b_fw_current_in_ps_mode) && bFwPSAwake)
>         ) {
>                 /*  */
>                 /*  Calculate Tx/Rx statistics. */
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index e31ad3feed62..7ebc438870fd 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -430,7 +430,7 @@ void rtl8723b_InitializeFirmwareVars(struct adapter *padapter)
>         struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
>
>         /*  Init Fw LPS related. */
> -       adapter_to_pwrctl(padapter)->bFwCurrentInPSMode = false;
> +       adapter_to_pwrctl(padapter)->b_fw_current_in_ps_mode = false;
>
>         /* Init H2C cmd. */
>         rtw_write8(padapter, REG_HMETFR, 0x0f);
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> index af7f846f90fe..c78a6724fc1c 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
> @@ -173,7 +173,7 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
>         if (
>                 ((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
>                 (!mac_pwr_ctrl_on) ||
> -               (adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
> +               (adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode)
>         ) {
>                 err = sd_cmd52_read(intfhdl, ftaddr, 4, (u8 *)&le_tmp);
>  #ifdef SDIO_DEBUG_IO
> @@ -230,7 +230,7 @@ static s32 sdio_readN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf)
>         if (
>                 ((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
>                 (!mac_pwr_ctrl_on) ||
> -               (adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
> +               (adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode)
>         )
>                 return sd_cmd52_read(intfhdl, ftaddr, cnt, buf);
>
> @@ -297,7 +297,7 @@ static s32 sdio_write32(struct intf_hdl *intfhdl, u32 addr, u32 val)
>         if (
>                 ((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
>                 (!mac_pwr_ctrl_on) ||
> -               (adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
> +               (adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode)
>         ) {
>                 le_tmp = cpu_to_le32(val);
>
> @@ -334,7 +334,7 @@ static s32 sdio_writeN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf)
>         if (
>                 ((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
>                 (!mac_pwr_ctrl_on) ||
> -               (adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
> +               (adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode)
>         )
>                 return sd_cmd52_write(intfhdl, ftaddr, cnt, buf);
>
> @@ -565,7 +565,7 @@ s32 sdio_local_read(
>         rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
>         if (
>                 (!mac_pwr_ctrl_on) ||
> -               (adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
> +               (adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode)
>         )
>                 return sd_cmd52_read(intfhdl, addr, cnt, buf);
>
> @@ -611,7 +611,7 @@ s32 sdio_local_write(
>         rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
>         if (
>                 (!mac_pwr_ctrl_on) ||
> -               (adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
> +               (adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode)
>         )
>                 return sd_cmd52_write(intfhdl, addr, cnt, buf);
>
> @@ -660,7 +660,7 @@ static u32 sdio_local_cmd53_read4byte(struct adapter *adapter, u32 addr)
>
>         hal_sdio_get_cmd_addr_8723b(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
>         rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
> -       if (!mac_pwr_ctrl_on || adapter_to_pwrctl(adapter)->bFwCurrentInPSMode) {
> +       if (!mac_pwr_ctrl_on || adapter_to_pwrctl(adapter)->b_fw_current_in_ps_mode) {
>                 sd_cmd52_read(intfhdl, addr, 4, (u8 *)&le_tmp);
>                 val = le32_to_cpu(le_tmp);
>         } else {
> diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> index 2e739a17dd95..fcb06a95fdf6 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> @@ -203,7 +203,7 @@ struct pwrctrl_priv {
>         u8 LpsIdleCount;
>         u8 power_mgnt;
>         u8 org_power_mgnt;
> -       u8 bFwCurrentInPSMode;
> +       u8 b_fw_current_in_ps_mode;
>         unsigned long   DelayLPSLastTimeStamp;
>         s32             pnp_current_pwr_state;
>         u8 pnp_bstop_trx;
> --
> 2.31.1
>
