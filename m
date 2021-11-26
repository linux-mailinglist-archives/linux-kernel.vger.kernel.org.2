Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1E45EB9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbhKZKde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376874AbhKZKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:31:20 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D1EC061A12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:17:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i12so8499569pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xMgOp7lbYkwgl7D+YMk4FsWl75ZCyIN6+KuA/rtaF/I=;
        b=LBWGHLBRsRzhoMj3EqgNJCHjvF8Omp+lFltj4q3PZ2eTjzxauxbrZCw7VbA2RptFHn
         9JO/dvgYGwWp4DfxLeQ87M9rBFpS5DkINqTqchCLy+3yNbuIofGIjth24f7bfe8aKXFT
         EglCS4q/j7GP5uJ4lMjPtOb2gbX0j0DUHXDzZXyTF8mmC7crt2z6WMYg92igq2kFgHOQ
         EkDVWvXJ9BG6UYNazP6na42UVuE1dJn4OPLcOrN4d9Cxu4OOcaCKeaRAkFHhej6oMlSi
         Zu30smqSUDtulrTke8JXTTjnTRyYDBkyb2lMv6lTqM1BVNgwNV2dvLtMbFd8ZVIpNeUC
         g5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xMgOp7lbYkwgl7D+YMk4FsWl75ZCyIN6+KuA/rtaF/I=;
        b=vU82635LrbaXw6g8uaxP7peSZeAMuWYydGEKLAKw7d4mU0KL7wsrVxuZ7nOeUQpFvx
         9vlqzu8h/z5LsxpVG9FiBFJE27qN5WIIrACPJHrD4z+37QJkYgSl9ViEeAXMxBi9lHI+
         Ktn2qCxVPIvM7FgmNHqCgjabpZ8HRxFY2aN21efdJvROdcavYfPB+PBXtNPFvxWjRl5e
         Z40isboxTHGCovGtHO4zzFlkrXiIeeb8nLUHxV0xM5ugyqQg32YjVBVu6fSyPgzJfuUJ
         qFje4XzamIeDgOUinka5/97gHcK7StQeawFmAhL1mhU8oIjobQReWgFeMx8HgG3Z70+F
         C6jA==
X-Gm-Message-State: AOAM5301eeyhToHnGq0xoeDUYIcnz8BQ9fO91+zGD7UceJiRWv00Kv5/
        R7njrKFDGd6hr0rrGsAm0ZyCmA==
X-Google-Smtp-Source: ABdhPJy9F/ggoPbCVgIvZMQl0QH1RDypskEwFasKoD+ufuypgX8T72E/Pcuk/nqiUvcMw6OeB5Z0yw==
X-Received: by 2002:a05:6a00:24cd:b0:49f:bf3f:c42c with SMTP id d13-20020a056a0024cd00b0049fbf3fc42cmr19995895pfv.54.1637921863703;
        Fri, 26 Nov 2021 02:17:43 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:5eda:d984:1426:91ca])
        by smtp.gmail.com with ESMTPSA id f185sm6281835pfg.39.2021.11.26.02.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 02:17:43 -0800 (PST)
Date:   Fri, 26 Nov 2021 18:17:39 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, cujomalainey@google.com,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v6 3/3] mailbox: mediatek: add support for adsp mailbox
 controller
Message-ID: <YaC0Q2Qo4UJc+f3A@google.com>
References: <20211126093021.25462-1-allen-kh.cheng@mediatek.com>
 <20211126093021.25462-4-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126093021.25462-4-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 05:30:21PM +0800, allen-kh.cheng wrote:
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

With a minor comment:
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index c9fc06c7e685..c44a0102585d 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -226,6 +226,13 @@ config STM32_IPCC
>  	  with hardware for Inter-Processor Communication Controller (IPCC)
>  	  between processors. Say Y here if you want to have this support.
>  
> +config MTK_ADSP_IPC_MBOX
> +	tristate "MediaTek ADSP Mailbox Controller"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  Say yes here to add support for MediaTek ADSP IPC mailbox controller
> +	  driver. It is used to send short messages between processors with dsp.
> +
>  config MTK_CMDQ_MBOX
>  	tristate "MediaTek CMDQ Mailbox Support"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index c2089f04887e..13d5c81852ca 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -49,6 +49,8 @@ obj-$(CONFIG_TEGRA_HSP_MBOX)	+= tegra-hsp.o
>  
>  obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
>  
> +obj-$(CONFIG_MTK_ADSP_IPC_MBOX)	+= mtk-adsp-mailbox.o
> +
>  obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o

To be neat, Kconfig name should be aligned to the file name.

That is, either:
- s/MTK_ADSP_IPC_MBOX/MTK_ADSP_MBOX/
- s/mtk-adsp-mailbox.o/mtk-adsp-ipc-mailbox.o/
