Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF63FBF58
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhH3XTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbhH3XTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:19:30 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA230C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:18:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso20521557otv.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kTzowDqyng5SmkZnLnhuOMUmDWL2mTqtBcHA3Ivu0z4=;
        b=He/FZWxVmsQyLQ7aRhloTA3vH0Szv0HLF0mZvneHFfMUAesnPhCZD6yCcycICtTv+P
         QKZdsM4HmRo9Akz23VOwRTxcLmxqo67APSfdL5QI733DuUMwvNYLvDU4I6yBpAsD7Dg+
         BB41kSNPYLFEKBjCZDQFsLpIPinSeklOeexX8cy/s/l2p7t9PEuwsq5l8Cg1yfIwDg1E
         8TgN0M9BC3aJPe2oBf0cx6O65Mt72JZRQCR56prDYsWOGflZE3Dc3uyYTJrRafZ0tchn
         DQmdbFO/+v/+XIzPvbzbvy4ZW62p0W/BFW3Q3qgTPNDxtgLSBY8w30eUi5Wewf/xysEd
         IqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kTzowDqyng5SmkZnLnhuOMUmDWL2mTqtBcHA3Ivu0z4=;
        b=baO1WGU49IFhvTFNhGeNhVI/3dopzUXUqSBYcCeJ2bYYSCLFgPlUrlKL/C4O6/S+b3
         uN8vY7zUi7UQlHcTaWi0xGpr7Nj3xcjVrri9QlaqvpNSY+nJgxPks/r0hKNnjerBJP2d
         TukEasMKntDLsPOXAA8788cI+F9tHEIR1wpNKSAdhHDQkvxg5LLSOKuKVROcclb0ffHv
         yKUl/SgQZ4F63GqCJ7pG7YKkSr9EB2HJHN62CyElpKiDZnJqR9/k0UvsNtUCPakxebJH
         ALozz8DxQuO0f8b9pmjeMd/DBHAWWjPUBq9xHMr285wTOkkcq92Er2eksabixQbVFIXd
         1C9A==
X-Gm-Message-State: AOAM530hnVUtQ33I7SkqM8by65li49bNfEyec2k4uHadfkLx1qBcqBJK
        aGfdMjkylS8na3XCINw5iKy7rF+8tJfTPQ==
X-Google-Smtp-Source: ABdhPJxn75fh8b2zX88QnSZ/3J0FFqK9g4yDu4wwlUr/LxsI3s+Li6R/B5x2U4VAODkFZHglFybEJA==
X-Received: by 2002:a05:6830:25d6:: with SMTP id d22mr21902876otu.50.1630365514934;
        Mon, 30 Aug 2021 16:18:34 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q26sm3444032otf.39.2021.08.30.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 16:18:34 -0700 (PDT)
Date:   Mon, 30 Aug 2021 18:18:32 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Deepak Kumar Singh <deesin@codeaurora.org>
Cc:     swboyd@chromium.org, clew@codeaurora.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V7 2/2] soc: qcom: aoss: Add debugfs entry
Message-ID: <YS1nSP8kziOPaDld@yoga>
References: <1630323451-7160-1-git-send-email-deesin@codeaurora.org>
 <1630323451-7160-3-git-send-email-deesin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630323451-7160-3-git-send-email-deesin@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Aug 06:37 CDT 2021, Deepak Kumar Singh wrote:

> Some user space clients may require to change power states of various
> parts of hardware. Add a debugfs node for qmp so messages can be sent
> to aoss from user space.
> 

I think this could be a useful tool while testing and developing client
drivers or perhaps during bringup of new platforms.

But your new commit message doesn't sound right, given that debugfs
isn't mounted in your production builds.

Regards,
Bjorn

> Signed-off-by: Chris Lew <clew@codeaurora.org>
> Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> ---
>  drivers/soc/qcom/qcom_aoss.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index bf0a6280..4cd8670 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -4,6 +4,7 @@
>   */
>  #include <dt-bindings/power/qcom-aoss-qmp.h>
>  #include <linux/clk-provider.h>
> +#include <linux/debugfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/mailbox_client.h>
> @@ -86,6 +87,7 @@ struct qmp {
>  	struct clk_hw qdss_clk;
>  	struct genpd_onecell_data pd_data;
>  	struct qmp_cooling_device *cooling_devs;
> +	struct dentry *debugfs_file;
>  };
>  
>  struct qmp_pd {
> @@ -566,6 +568,31 @@ void qmp_put(struct qmp *qmp)
>  }
>  EXPORT_SYMBOL(qmp_put);
>  
> +static ssize_t aoss_dbg_write(struct file *file, const char __user *userstr,
> +			      size_t len, loff_t *pos)
> +{
> +	struct qmp *qmp = file->private_data;
> +	char buf[QMP_MSG_LEN] = {};
> +	int ret;
> +
> +	if (!len || len >= QMP_MSG_LEN)
> +		return -EINVAL;
> +
> +	ret  = copy_from_user(buf, userstr, len);
> +	if (ret) {
> +		return -EFAULT;
> +	}
> +
> +	ret = qmp_send(qmp, buf, QMP_MSG_LEN);
> +
> +	return ret ? ret : len;
> +}
> +
> +static const struct file_operations aoss_dbg_fops = {
> +	.open = simple_open,
> +	.write = aoss_dbg_write,
> +};
> +
>  static int qmp_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -620,6 +647,9 @@ static int qmp_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, qmp);
>  
> +	qmp->debugfs_file = debugfs_create_file("aoss_send_message", 0220, NULL,
> +						qmp, &aoss_dbg_fops);
> +
>  	return 0;
>  
>  err_remove_qdss_clk:
> @@ -636,6 +666,8 @@ static int qmp_remove(struct platform_device *pdev)
>  {
>  	struct qmp *qmp = platform_get_drvdata(pdev);
>  
> +	debugfs_remove(qmp->debugfs_file);
> +
>  	qmp_qdss_clk_remove(qmp);
>  	qmp_pd_remove(qmp);
>  	qmp_cooling_devices_remove(qmp);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
