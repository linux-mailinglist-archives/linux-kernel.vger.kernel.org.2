Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE04733C35E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhCORG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbhCORGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:06:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DDC061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:06:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 205so3848147pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yY3mhIGzvfIcea0oS5vnOF6ZD7eoZRfXqgRluJD6Ksk=;
        b=g6cpgZcwUgiy6sRyLSlM8Fgt+n+NM8QrgLWk7DBpT3nUvsZXTKZ92qpHV47YNnDCgO
         PYHE5t0mhQupKH7qGzopGZ8NKkmyTbwtnqrdM/zrzsnfwfgqaUh1mFjstfeWPvumXAEb
         tF5axhwM9S32tkzLbbnm2KLR9Y5gJZsPOHAug4T41G3Vc/ByVC/lOqzl0ar+BHQzBClD
         IRjskivPKqHZWgEEY789XI4McmHMckuhIsQ6EsLKiH9i+ZEYoie7XKZlIHF0L8bNiTQ3
         mXLtOTGRkIgxF/g4b0TfDZKmIi7rEvY/xsyR59XZVZ7hMUK1LtPJpd1L4m8HNvZKgtqN
         pX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yY3mhIGzvfIcea0oS5vnOF6ZD7eoZRfXqgRluJD6Ksk=;
        b=BwbgX5T8wSohZe7FV08mB9JQtW5NUotcHzmcW7Qe3Bu9mWm/J9xySTbfPSumJhUfaF
         3tDPwaDDhz7NStsABiTwU2cryIcVxwZlidZyfbj65a47h0tauMrALbShzxF0HwwpAX2/
         4ZrkQZv1YBXiEmS4QFX/lkLkJMjDUaW1d9WYmFeMg0jn939M4vmcnOvGjq6byqlXwUgo
         uYd0j8T57zDhzGdUmTPZxfQrTPnuzvw95HlDIBxmtbc9bakpHz2nAp/Xss/i0FuMk7l3
         YeE7OdVN2xp0IQPi9ddATTdLpApu4FphqaCibF4whGkchFzNzdmbcV7s7XBuQlsvAfKJ
         c/oA==
X-Gm-Message-State: AOAM5305dZT/qJArA5hyWLfhrNiPhdcsvWjTa2z9ZazUEI27lhPhWKYh
        feaXqH5Po/KYHuKKTZiiOuqj6A==
X-Google-Smtp-Source: ABdhPJztwsViJzEquhAP1o+/MucyFw8LNEvEwKu1nZeYWRHgNBTFMt11CRG/3FjDjsm7t3+rIaxGJQ==
X-Received: by 2002:a62:92cc:0:b029:1fa:515d:808f with SMTP id o195-20020a6292cc0000b02901fa515d808fmr24978009pfd.43.1615827985438;
        Mon, 15 Mar 2021 10:06:25 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id ge16sm184580pjb.43.2021.03.15.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:06:25 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:06:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: qcom_q6v5_mss: Validate p_filesz in ELF
 loader
Message-ID: <20210315170623.GD1339147@xps15>
References: <20210312232002.3466791-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312232002.3466791-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:20:02PM -0800, Bjorn Andersson wrote:
> Analog to the issue in the common mdt_loader code the MSS ELF loader
> does not validate that p_filesz bytes will fit in the memory region and
> that the loaded segments are not truncated. Fix this in the same way
> as proposed for the mdt_loader.
> 
> Fixes: 135b9e8d1cd8 ("remoteproc: qcom_q6v5_mss: Validate modem blob firmware size before load")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Don't just break the loop, goto release_firmware.
> - Release seg_fw as well.
> 
>  drivers/remoteproc/qcom_q6v5_mss.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 66106ba25ba3..14e0ce5f18f5 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1210,6 +1210,14 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  			goto release_firmware;
>  		}
>  
> +		if (phdr->p_filesz > phdr->p_memsz) {
> +			dev_err(qproc->dev,
> +				"refusing to load segment %d with p_filesz > p_memsz\n",
> +				i);
> +			ret = -EINVAL;
> +			goto release_firmware;
> +		}
> +
>  		ptr = memremap(qproc->mpss_phys + offset, phdr->p_memsz, MEMREMAP_WC);
>  		if (!ptr) {
>  			dev_err(qproc->dev,
> @@ -1241,6 +1249,16 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  				goto release_firmware;
>  			}
>  
> +			if (seg_fw->size != phdr->p_filesz) {
> +				dev_err(qproc->dev,
> +					"failed to load segment %d from truncated file %s\n",
> +					i, fw_name);
> +				ret = -EINVAL;
> +				release_firmware(seg_fw);
> +				memunmap(ptr);
> +				goto release_firmware;
> +			}
> +

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  			release_firmware(seg_fw);
>  		}
>  
> -- 
> 2.29.2
> 
