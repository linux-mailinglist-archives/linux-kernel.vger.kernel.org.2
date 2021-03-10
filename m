Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D04C334108
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhCJPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhCJPCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:02:41 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7296C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:02:40 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id j22so10807785otp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V8MdSufFebVYdwZ9bJ2B65DK6UPMIuWYUYAtyL3ptqI=;
        b=F+YVSxMDtCjcsX/C/BHwBZmb+eYHR2QWLZAjG+D0LiF3HBGdI/ytvKqseZa5g9JWfI
         i+VbqYitgYYfKieC/UlXiUCd0WCMDRN1pHe5h+cNIDG6vTFGcEVb6y3mrayLH5kQSWHp
         a4KS0XNyex3qFf/dkWyiAcMlrPuB7m4KkCylsNEHUYfcWf4Ce2igwPlO3P8ujKQ/CgdZ
         UEiBztIeyKLQNHDe0wIN3I9KlnkO0K1rndnsUZiRMoiG+Xc64oxEaGViIfM8ECyCMoq+
         w6JlBHTeOXxgbgoyX1LTdNSZB9sn+pixis3URnu/TrWBvdq2RnqvjGaRYWjY53gdTGPb
         M3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V8MdSufFebVYdwZ9bJ2B65DK6UPMIuWYUYAtyL3ptqI=;
        b=R3+ivmD+8rvrl7+5cPnuTMHgv/vn0H2FP3PdvfETBdG4qwFXcYn8cDljud92W8LNl3
         bctLHt5TtMUvD3I8Kv1NRQ0xsgP4xxCyGaJQiitHNTZDkf/fqSmx+CFLGk7ne1ogdZRu
         ghRR9t0loYvGIt9ypx2Xr8tMLXk3az+l5yu3fZXt4cA8LM1zWUtkFSiZKU43tcQgG1Aa
         HttfkI40eAjIk4kSU9u/77nJDa7FdjPQ5o+pwUiIY3h6IgsrKO/4KMi/1Fy8S5ApMFjA
         4NlhbMkiA23YbNv1NZoJgRnwYxRgq0GA3xAtT01No43HMClkO/VN6wAaz+//APqmXwn2
         kIgA==
X-Gm-Message-State: AOAM5304zMo5xxvZNv3OtEjrI0mpKV/FVYuk3Vul8dtbNOcrpjQE1kwz
        NKCpsJCYDe8yEzGoam/PyAUTlw==
X-Google-Smtp-Source: ABdhPJx2EYjBgSUu7ghYrUt6m1N18uEVMg8G1l1Bl+SD4GmhZqV671WyXY+ENzhAwQDQIl3JcgtzKA==
X-Received: by 2002:a9d:20c6:: with SMTP id x64mr2866325ota.262.1615388560274;
        Wed, 10 Mar 2021 07:02:40 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c20sm3626337oiw.18.2021.03.10.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 07:02:39 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:02:37 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org
Subject: Re: [RFC PATCH v1] Bluetooth: hci_qca: Add device_may_wakeup support
Message-ID: <YEjfjZ/5y+Z0r63Z@builder.lan>
References: <1615376496-13577-1-git-send-email-gubbaven@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615376496-13577-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Mar 05:41 CST 2021, Venkata Lakshmi Narayana Gubba wrote:

> Added device_may_wakeup() support.

This would be an excellent place to describe _why_ this is necessary,
instead of just repeating $subject.

Something along the lines of the comment in the patch.

Regards,
Bjorn

> 
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
>  drivers/bluetooth/hci_qca.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index de36af6..73af901 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1571,6 +1571,20 @@ static void qca_cmd_timeout(struct hci_dev *hdev)
>  	mutex_unlock(&qca->hci_memdump_lock);
>  }
>  
> +static bool qca_prevent_wake(struct hci_dev *hdev)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	bool wakeup;
> +
> +	/* UART driver handles the interrupt from BT SoC.So we need to use
> +	 * device handle of UART driver to get the status of device may wakeup.
> +	 */
> +	wakeup = device_may_wakeup(hu->serdev->ctrl->dev.parent);
> +	bt_dev_dbg(hu->hdev, "wakeup status : %d", wakeup);
> +
> +	return !wakeup;
> +}
> +
>  static int qca_wcn3990_init(struct hci_uart *hu)
>  {
>  	struct qca_serdev *qcadev;
> @@ -1721,6 +1735,7 @@ static int qca_setup(struct hci_uart *hu)
>  		qca_debugfs_init(hdev);
>  		hu->hdev->hw_error = qca_hw_error;
>  		hu->hdev->cmd_timeout = qca_cmd_timeout;
> +		hu->hdev->prevent_wake = qca_prevent_wake;
>  	} else if (ret == -ENOENT) {
>  		/* No patch/nvm-config found, run with original fw/config */
>  		set_bit(QCA_ROM_FW, &qca->flags);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
