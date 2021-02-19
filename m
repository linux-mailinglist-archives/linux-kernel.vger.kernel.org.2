Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56F31FEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBSSoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBSSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:43:57 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117CDC061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:43:17 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 75so5276915pgf.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+RaWaFyQSNsA+BxQXW757bzb1+DDQjnWqIXCvU1FnZg=;
        b=IB29ZKHRAnXgcgKwwmK3w5ghZp9HfMsnWzT6RFS62Y6zWIwZ7CCJoSrSE7Lg9NrBWc
         w3M5BI+zftcVbIRviRSOQBzakRnjADebkJudOi7J3tUkw1XQX3LOPRrE+ySS2IkAoqAl
         LUXX/GGA03GCbGSfve4PsfyrSVEQIP9s5eo7qx+yK893mNAI4xECCPr+aKwY06NXsvws
         mNnSAM7s9OHQ39a9jjq5hjMhTp5AuXx4HVRwmHUNnFYhFuiNdD03FkH+f3h5YjY9k+mJ
         6kzbUdNXnlDEVviIN6uWtNGf4MQjaStZ6k4IhvGguZypfVl+wHWN9z4ndGnhdjCEIbZv
         NaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RaWaFyQSNsA+BxQXW757bzb1+DDQjnWqIXCvU1FnZg=;
        b=RBAKMck0PovjJvLMbTv3oztt5VMJsAmOziv+oYuBjrtFCfIyafXcKY9ct+og1MeS7h
         ry+A1dYQed8C23p9gMgefFkf2QfkrinkXRfreRJQ7S4aJZGSLrY0sgHan1VazVkogbFz
         FFnJz4TONG0XG6HiyWBM7sBnO+q8Z0PS7SMRzDk/QdGw3dL0qN8S/UyBKvS0OeN6kSWL
         OANMe27vbP3e88EUUc8x19ebVA8GayT1BcPdx41i8apRGe6ivvv5JR6G/yK3jwGiuW8T
         1Q1RpY6iNCvXZGHDt9mm6T1UYsgx5nXwYQXvrw5COLCae0KP6S82TVxhgwYPxunnHo/A
         JTgQ==
X-Gm-Message-State: AOAM532oluztqSTRRE4A6FF/zYFG3aBJP305OBNUI9gXwiFyTW+rHUs5
        xwvSsh4zOiOB3Z2LAs+bqxF1JgfGYLYbCA==
X-Google-Smtp-Source: ABdhPJzN3Ygk8eCkB5+wa7JUByPcyaxHt1dR5NpZBx7GgeX6f5K0ZJD27MStvkvvMK9kb4CZFXlcxA==
X-Received: by 2002:a63:545f:: with SMTP id e31mr9763184pgm.212.1613760196381;
        Fri, 19 Feb 2021 10:43:16 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w128sm3601162pfw.86.2021.02.19.10.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:43:15 -0800 (PST)
Date:   Fri, 19 Feb 2021 11:43:13 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] coresight: syscfg: Add registration and feature
 loading for cs devices
Message-ID: <20210219184313.GA3065106@xps15>
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-3-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128170936.9222-3-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> +/**
> + * List entry for Coresight devices that are registered as supporting complex
> + * config operations.
> + *
> + * @csdev:	The registered device.
> + * @match_info: The matching type information.
> + * @ops:	Operations supported by the registered device.
> + * @item:	list entry.
> + */
> +struct cscfg_csdev_register {
> +	struct coresight_device *csdev;
> +	struct cscfg_match_desc match_info;
> +	struct cscfg_csdev_feat_ops ops;
> +	struct list_head item;
> +};

I would call this structure cscfg_registered_csdev and move it to
coresight-config.h.  That way it is consistent with cscfg_config_csdev and
cscfg_feature_csdev and located all in the same file.

I may have to come back to this patch but for now it holds together.

More comments to come on Monday.

Thanks,
Mathieu

> +
>  /* internal core operations for cscfg */
>  int __init cscfg_init(void);
>  void __exit cscfg_exit(void);
> @@ -33,6 +49,10 @@ void __exit cscfg_exit(void);
>  /* syscfg manager external API */
>  int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
>  			   struct cscfg_feature_desc **feat_descs);
> +int cscfg_register_csdev(struct coresight_device *csdev,
> +			 struct cscfg_match_desc *info,
> +			 struct cscfg_csdev_feat_ops *ops);
> +void cscfg_unregister_csdev(struct coresight_device *csdev);
>  
>  /**
>   * System configuration manager device.
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 976ec2697610..d0126ed326a6 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -219,6 +219,8 @@ struct coresight_sysfs_link {
>   * @nr_links:   number of sysfs links created to other components from this
>   *		device. These will appear in the "connections" group.
>   * @has_conns_grp: Have added a "connections" group for sysfs links.
> + * @feature_csdev_list: List of complex feature programming added to the device.
> + * @config_csdev_list:  List of system configurations added to the device.
>   */
>  struct coresight_device {
>  	struct coresight_platform_data *pdata;
> @@ -240,6 +242,9 @@ struct coresight_device {
>  	int nr_links;
>  	bool has_conns_grp;
>  	bool ect_enabled; /* true only if associated ect device is enabled */
> +	/* system configuration and feature lists */
> +	struct list_head feature_csdev_list;
> +	struct list_head config_csdev_list;
>  };
>  
>  /*
> -- 
> 2.17.1
> 
