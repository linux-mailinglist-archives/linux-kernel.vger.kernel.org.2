Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F5379521
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhEJRNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232170AbhEJRNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620666754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CIW2YCfIyemvqkNlDrF54CSJZHkshL2bUv5uy7OmnQ=;
        b=gKpZeuWymEV2+L4c6jPrm3/ZtlrKOZBMZDaeRBm2ykzGM/6ciujq/0JHdtcuSBBbOYfcQd
        zT2GeTdqM3CQb8gqjomfyt0XiuP+c8th5o+Ug9noCWjctj4o5kDwRonlDVG7/nf95gPG/o
        qpDFql2XVtXIKWRadjJSOFT5ArYed5M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-ZEkxYI8fOHyEYBRHJUTC6w-1; Mon, 10 May 2021 13:12:33 -0400
X-MC-Unique: ZEkxYI8fOHyEYBRHJUTC6w-1
Received: by mail-qk1-f199.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so12046282qkj.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/CIW2YCfIyemvqkNlDrF54CSJZHkshL2bUv5uy7OmnQ=;
        b=Gb3jSVoDELLgSGl6rrB09UkzXamVKEp+Dde6xUdytAaaj4OmNsF3fYXCyhr9C2IoOq
         tajodstSjfPFo91RSwXFnZ2P19d3m9HY9TVmzu1t/D0bmYgOCaqd2+IitU1kwy7PpX0c
         apDHZkQAzGo2Zs2HfEc/G2jIpMuTspGzPhkdjhTGYZ+2WXUgOqOMsTFxyKmz6E571lkV
         /21VkQigiSsHUmg1mfEReqL5nhh4xp6y/mD4WLNZ9/dSaZOy/SK2oKg5/M7mu9/4iK0f
         +OdwcYSykidRaL2ovq2jMmWpdYlL5yJh5bQ1fb2Z73fb3URYATygiGjRjXIXVxo4iMNP
         DFPA==
X-Gm-Message-State: AOAM533TyzOzOXTakRemtWcsLO0bL8cHhv6b4OUj+RgUyl4FvlvLCw1t
        tF3UgOieW2dchHT3+oAtA1bYXPOF0oEV9aLmUzoGaNPlGJtYKdiw4wD8gsMGG0zGHwjDh8Plhrh
        MXnxQowALz54qqu6eGfXAP4aa
X-Received: by 2002:a05:622a:30f:: with SMTP id q15mr11898527qtw.257.1620666752679;
        Mon, 10 May 2021 10:12:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyc6C7/diGU6s8/6mxi8LzwJ6RGcfL0bThVSbL9h3YFSM+LmOFIdaOMw68anpi6NdkCsXwnA==
X-Received: by 2002:a05:622a:30f:: with SMTP id q15mr11898502qtw.257.1620666752493;
        Mon, 10 May 2021 10:12:32 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p10sm11666764qkg.74.2021.05.10.10.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 10:12:32 -0700 (PDT)
Subject: Re: [PATCH v12 5/5] fpga: m10bmc-sec: add max10 get_hw_errinfo
 callback func
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210503214042.316836-1-russell.h.weight@intel.com>
 <20210503214042.316836-6-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bcbf399d-4384-4731-f768-93793a5311b6@redhat.com>
Date:   Mon, 10 May 2021 10:12:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210503214042.316836-6-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/3/21 2:40 PM, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to include
> a function that returns 64 bits of additional HW specific
> data for errors that require additional information.
> This callback function enables the hw_errinfo sysfs
> node in the Intel Security Manager class driver.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
> v12:
>    - No change
> v11:
>    - No change
> v10:
>    - No change
> v9:
>    - No change
> v8:
>    - Previously patch 6/6, otherwise no change
> v7:
>    - No change
> v6:
>    - Initialized auth_result and doorbell to HW_ERRINFO_POISON
>      in m10bmc_sec_hw_errinfo() and removed unnecessary if statements.
> v5:
>    - No change
> v4:
>    - No change
> v3:
>    - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>    - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>      driver"
> v2:
>    - Implemented HW_ERRINFO_POISON for m10bmc_sec_hw_errinfo() to
>      ensure that corresponding bits are set to 1 if we are unable
>      to read the doorbell or auth_result registers.
>    - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>   drivers/fpga/intel-m10-bmc-secure.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 9d45312001a3..bdf87ec125fe 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -483,11 +483,33 @@ static enum fpga_sec_err m10bmc_sec_cancel(struct fpga_sec_mgr *smgr)
>   	return ret ? FPGA_SEC_ERR_RW_ERROR : FPGA_SEC_ERR_NONE;
>   }
>   
> +#define HW_ERRINFO_POISON	GENMASK(31, 0)
> +static u64 m10bmc_sec_hw_errinfo(struct fpga_sec_mgr *smgr)
> +{
> +	struct m10bmc_sec *sec = smgr->priv;
> +	u32 auth_result = HW_ERRINFO_POISON;
> +	u32 doorbell = HW_ERRINFO_POISON;
> +
> +	switch (smgr->err_code) {
> +	case FPGA_SEC_ERR_HW_ERROR:
> +	case FPGA_SEC_ERR_TIMEOUT:
> +	case FPGA_SEC_ERR_BUSY:
> +	case FPGA_SEC_ERR_WEAROUT:
> +		m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +		m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result);
> +
> +		return (u64)doorbell << 32 | (u64)auth_result;
> +	default:
> +		return 0;
> +	}
> +}
> +
>   static const struct fpga_sec_mgr_ops m10bmc_sops = {
>   	.prepare = m10bmc_sec_prepare,
>   	.write_blk = m10bmc_sec_write_blk,
>   	.poll_complete = m10bmc_sec_poll_complete,
>   	.cancel = m10bmc_sec_cancel,
> +	.get_hw_errinfo = m10bmc_sec_hw_errinfo,
>   };
>   
>   static int m10bmc_secure_probe(struct platform_device *pdev)

