Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACA13374F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhCKOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbhCKOEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:04:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FE6C061574;
        Thu, 11 Mar 2021 06:04:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id v9so39979423lfa.1;
        Thu, 11 Mar 2021 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2UesuILRMkJp+y650j/Dw0uM34OpGLZWWhm2dKKedNQ=;
        b=UFMbxZOZED8Bchitddb1CJ9fL8l6YKL401dy/6N1Dthp5O4IhZrywTARWyMH45gIVY
         gODDAX1amriEQ1Nc6fSZucwE/+mrrbB+WMgB4MRoR3Nw7hqwKxjzSJNkZjpd5r1aXAD8
         27wC+1wXaLvCmByvmDVxeNHbA4owoWM2WGaTvoXhEjQEHuMWPP2slX4lcev3qUIrbhqx
         EiF3UO1ItI5qXrvXEFer7O3vCn1AIDgKnwPEQysbhoyURPqZJnxS7uAF/9oHy0z5NAeu
         czkRcDVdXnOKWhuwFVhZ2mnOAefIOeBosT7n7PQ2e2l/ddtAwgDujEAbI+Z8KH6yJ4jf
         HgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2UesuILRMkJp+y650j/Dw0uM34OpGLZWWhm2dKKedNQ=;
        b=JPKPWvz+iGBuI/HwdDop81/L4b0VZ4J7CQogAwNcZwdrJv2fiJPpUqUoO6RmXsidV2
         auKV//veeHF5fG/XkPOeewPWc08CCPKp4Os7K1zIpjHuEzCvUCI42kWVdyDR5xG6V7e7
         XuwDJlwo53ZNqwhdcbPBr7CE/xwjDi/XOXwZFblXHe/z0sD1b6CjVOhe5nVAFKLbz/XJ
         yxPjpeEfA9YqrvILugGVOUMIlp0O8hkioUPko/aX+KuYn9WHWVGrmYVE90dLjrenX12b
         5adzbLy6ynLwIG7PZ52t5lmB5NU1bshkfniCYTIXQQnRUDIYGJJMSrYOlKS+pwYdfAUw
         6vPg==
X-Gm-Message-State: AOAM530izbpZ7G0E6o9U0pmtsT8Z3spU1tZDfTI19hyFbJ9a002MPlqS
        FD1c4d140OUwQ1PNuicKvSqaIU+1wJk=
X-Google-Smtp-Source: ABdhPJx7rWrfxe+wQBUJ1aOKDv4Dtqhyz/wJAmnzjCKqA/kXqTJLW+hcKBUSEJmdM9Lg0gtq6AvdHQ==
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr2307855lfk.574.1615471447614;
        Thu, 11 Mar 2021 06:04:07 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id f8sm874153lfs.143.2021.03.11.06.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:04:07 -0800 (PST)
Subject: Re: [PATCH v2] iommu/tegra-smmu: Add pagetable mappings to debugfs
To:     Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
        thierry.reding@gmail.com, will@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210310033614.16772-1-nicoleotsuka@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <abcedfa6-fbad-b34d-fba1-d3a778fbf5b4@gmail.com>
Date:   Thu, 11 Mar 2021 17:04:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210310033614.16772-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.03.2021 06:36, Nicolin Chen пишет:
...
> +static int tegra_smmu_mappings_show(struct seq_file *s, void *data)
> +{
> +	struct tegra_smmu_group_debug *group_debug = s->private;
> +	const struct tegra_smmu_swgroup *group;
> +	struct tegra_smmu_as *as;
> +	struct tegra_smmu *smmu;
> +	int pd_index, pt_index;

> +DEFINE_SHOW_ATTRIBUTE(tegra_smmu_mappings);
> +
>  static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
>  {
> +	const struct tegra_smmu_soc *soc = smmu->soc;
> +	struct tegra_smmu_group_debug *group_debug;
> +	struct device *dev = smmu->dev;
> +	struct dentry *d;
> +	int i;

You should use unsigned types for everything that isn't signed.
