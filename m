Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A42440224
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhJ2SiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhJ2SiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:38:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7EFC061193
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:35:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k2-20020a17090ac50200b001a218b956aaso7967655pjt.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OLq+ET5R+A3DjUYbgPc27FplW5aMkm/jkqz5GrjfXc8=;
        b=JXjpPFbH6HiCzc8IWFuCSPzuKBUJAqIBoGAvXZO2s5XeKSn4nqZ1gsE3qXiIIRw6MJ
         v2BcVlpVnfAZRm2IFNC5mOOuL84abOpDmrWPcH4hvBi0jAGDvTSAM1OBeLAAB+ttPY+N
         4yBBs+qGUjzgbq3Wczf8HVSViQBwV3rXkkKtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OLq+ET5R+A3DjUYbgPc27FplW5aMkm/jkqz5GrjfXc8=;
        b=AiLKDlX2JUBnTRs1bCxQ3UoBgvGdbzJuDmCtYCVTzOeOuk6wvpRIkOqMq5/N9zHFJA
         r+kYMOIDuKm5AI8Q/EBRG9Wr1HDJwLBXqZjcORFbcLN9UgWXy3XnzBBNx0nCTbcJUBas
         1gamxg9me6FtYdUoqjsjgRZ19znR5tUSIKz9QDROOyRwtWG0hQyTVT1tGVznh16lgwQH
         cfhSO65mgxHIlm/Xq+B+mZDLgsWUkB7aZ5lwKR13p6MB7m5U27OHcettjDvPeJZ1yE10
         2uX9lR/HIKvtzN2MEqNp2KKoZt5auYtN0L5l/weG/j3UO4BSxUj4pjnwYpcqncAaIOvZ
         PPLQ==
X-Gm-Message-State: AOAM533zBoAKdwE4KM/prvGS3DKYufAZx0xQAbtrI0sta5qWMnugeO5O
        MfSq935gNu0gw7IY+Dyhfvxsrw==
X-Google-Smtp-Source: ABdhPJytryGkRWqTdtcqvFyyzQZj6mozxET1Nz8RJNYLVd9tsETsGKPQ03VNK6rsFsmZht46XVtoyg==
X-Received: by 2002:a17:903:31ce:b0:13e:a6e6:9a53 with SMTP id v14-20020a17090331ce00b0013ea6e69a53mr6746115ple.4.1635532523157;
        Fri, 29 Oct 2021 11:35:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e16c:3cc5:ae05:5dbe])
        by smtp.gmail.com with UTF8SMTPSA id a20sm7349017pff.57.2021.10.29.11.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:35:22 -0700 (PDT)
Date:   Fri, 29 Oct 2021 11:35:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     tjiang@codeaurora.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: Re: [PATCH v16] Bluetooth: btusb: Add support using different nvm
 for variant WCN6855 controller
Message-ID: <YXw+6aBO+77O2S+w@google.com>
References: <4c12452739c0d7fa1c6a4f5998515767@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c12452739c0d7fa1c6a4f5998515767@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 11:21:21AM +0800, tjiang@codeaurora.org wrote:
> the RF performance of wcn6855 soc chip from different foundries will be
> difference, so we should use different nvm to configure them.
> 
> Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
> ---
>  drivers/bluetooth/btusb.c | 54
> +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 87b71740fad8..16bb5de3ce2f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3195,6 +3195,9 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev
> *hdev,
>  #define QCA_DFU_TIMEOUT		3000
>  #define QCA_FLAG_MULTI_NVM      0x80
> 
> +#define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
> +#define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
> +
>  struct qca_version {
>  	__le32	rom_version;
>  	__le32	patch_version;
> @@ -3226,6 +3229,7 @@ static const struct qca_device_info
> qca_devices_table[] = {
>  	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
>  	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
>  	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
> +	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
>  };
> 
>  static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
> @@ -3380,6 +3384,41 @@ static int btusb_setup_qca_load_rampatch(struct
> hci_dev *hdev,
>  	return err;
>  }
> 
> +static void btusb_generate_qca_nvm_name(char *fwname,
> +					size_t max_size,
> +					const struct qca_version *ver)
> +{
> +	u32 rom_version = le32_to_cpu(ver->rom_version);
> +	u16 flag = le16_to_cpu(ver->flag);
> +
> +	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
> +		u16 board_id = le16_to_cpu(ver->board_id);
> +		const char *variant ;

Remove blank before the semicolon.

Besides that:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
