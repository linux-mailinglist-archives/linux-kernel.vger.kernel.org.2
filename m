Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C1030AC0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhBAPxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhBAPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:51:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06795C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:51:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j18so13052438wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i8SSWQkh0zibtdmIQx4/MVlmjgE4oTGxCuh2hS6Ocs8=;
        b=LXNkK8kwS8I5EYdGd7Oqp4ltpd/3evnlQ9pODT/h+yVwWkFHNuIhMNhNTFGw5egXWJ
         ZQGrUs6qt700Yx7YMsLTpZoEbIeFpm6dshhsv9+8OcvLUtJkYwogAGqJO/N6ftIR2psT
         eVkHu39yqNiJH1yonF3G9Hz/xhiE5afc2Yq5FJBzBO5CyeDJoZWGh86RPetubs69yzT/
         Pxk93n+LMdMMLgEfN0xX9gzAda36Q+KWgeZfL4sfabRWxvB3Ij1C0Zs/Ea8qnMi5Rffw
         tSScHgfzWfMWORkU2DAz4Rr3SQswUtHFFiW06I1KdN75wHzvDx/CXKaDgnZV4PdHV2D5
         mTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i8SSWQkh0zibtdmIQx4/MVlmjgE4oTGxCuh2hS6Ocs8=;
        b=CM9KaDBDKC2+xYUGqSl1qUlgP1gQYOpYMDoI9AeBc5BTb5SDhaez/D+KHv5LdmTPDi
         NDBQEJ32YMioe2Pv0Nr/dgGK1MG8wE25PQ/URQGng0y/N+hWHurL7w7N8eoUqss0QxZg
         fMF268ry7jeC/nnKyfSo6z4D7CesFNtXnlK4+yMNGSklIMohnx6ija7rASe7rECwBb+Y
         VA3dzBmCX/vATN7czqopOuHhZ0fAvTGjPRGQ2Yf9WxlM8Yl/jBNOHbV43lcJbfyp+mDS
         fh8pJcFSqLbSgd+jbSPBxXFZK7FAO5m6tTIJwsfGAVgU33ja9iirRVfHvay7pxj91mu6
         Y0Tw==
X-Gm-Message-State: AOAM533r6aF1aR/+ZtQ6ZkIkatV1VJJmDskmMMWKz93m7W01en47AGu0
        rnZH4/s8VuJ+vMZXfE+0hI/z0A==
X-Google-Smtp-Source: ABdhPJxVwcj/Tzs67NWgjWLOxFNI8hXNwGk/OlY4fTw0XWnFUmQzw1ruGX7vri5Fn1bpsdnnea+9Tw==
X-Received: by 2002:a1c:acc9:: with SMTP id v192mr10609384wme.22.1612194674792;
        Mon, 01 Feb 2021 07:51:14 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id p15sm27327790wrt.15.2021.02.01.07.51.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:51:14 -0800 (PST)
Subject: Re: [PATCH 6/6] soundwire: qcom: add support to new interrupts
To:     Vinod Koul <vkoul@kernel.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-7-srinivas.kandagatla@linaro.org>
 <20210201143116.GE2771@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5275b56b-bc6b-8e75-5407-d9be77ec5a34@linaro.org>
Date:   Mon, 1 Feb 2021 15:51:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210201143116.GE2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 14:31, Vinod Koul wrote:
> On 29-01-21, 17:32, Srinivas Kandagatla wrote:
>> Add support to new interrupts and update irq routine in a way
>> to deal with multiple pending interrupts with in a single interrupt!
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 191 ++++++++++++++++++++++++++++++---------
>>   1 file changed, 146 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index d61b204dc284..c699bd51d29a 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -28,10 +28,21 @@
>>   #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
>>   #define SWRM_INTERRUPT_STATUS					0x200
>>   #define SWRM_INTERRUPT_STATUS_RMSK				GENMASK(16, 0)
>> +#define SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ			BIT(0)
>>   #define SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED		BIT(1)
>>   #define SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS		BIT(2)
>> +#define SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET			BIT(3)
>> +#define SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW			BIT(4)
>> +#define SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW			BIT(5)
>> +#define SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW		BIT(6)
>>   #define SWRM_INTERRUPT_STATUS_CMD_ERROR				BIT(7)
>> +#define SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION		BIT(8)
>> +#define SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH		BIT(9)
>>   #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
>> +#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2             BIT(13)
>> +#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2              BIT(14)
>> +#define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP               BIT(16)
>> +#define SWRM_INTERRUPT_MAX					17
>>   #define SWRM_INTERRUPT_MASK_ADDR				0x204
>>   #define SWRM_INTERRUPT_CLEAR					0x208
>>   #define SWRM_INTERRUPT_CPU_EN					0x210
>> @@ -105,11 +116,8 @@ struct qcom_swrm_ctrl {
>>   	struct device *dev;
>>   	struct regmap *regmap;
>>   	void __iomem *mmio;
>> -	struct completion *comp;
>>   	struct completion broadcast;
>>   	struct work_struct slave_work;
>> -	/* read/write lock */
>> -	spinlock_t comp_lock;
>>   	/* Port alloc/free lock */
>>   	struct mutex port_lock;
>>   	struct mutex io_lock;
>> @@ -126,6 +134,7 @@ struct qcom_swrm_ctrl {
>>   	int rows_index;
>>   	unsigned long dout_port_mask;
>>   	unsigned long din_port_mask;
>> +	u32 intr_mask;
>>   	u8 rcmd_id;
>>   	u8 wcmd_id;
>>   	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
>> @@ -315,6 +324,27 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
>>   	return ret;
>>   }
>>   
>> +static int qcom_swrm_get_alert_slave(struct qcom_swrm_ctrl *ctrl)
>> +{
>> +	u32 val;
>> +	int i;
>> +
>> +	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>> +
>> +	for (i = 0; i < SDW_MAX_DEVICES; i++) {
>> +		u32 s;
> 
> define at top of the function pls, also maybe better name status?
Sure,
> 
>> +
>> +		s = (val >> (i * 2));
> 
> why * 2 ? Maybe add a comment for this logic

This is status mask of 2 bits! Will clarify this in next version!

> 
>> +
>> +		if ((s & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
>> +			ctrl->status[i] = s;
>> +			return i;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>>   static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
>>   {
>>   	u32 val;
>> @@ -333,40 +363,122 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
>>   
>>   static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>>   {
>> -	struct qcom_swrm_ctrl *ctrl = dev_id;
>> -	u32 sts, value;
>> -	unsigned long flags;
>> -
>> -	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
>> -
>> -	if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
>> -		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
>> -		dev_err_ratelimited(ctrl->dev,
>> -				    "CMD error, fifo status 0x%x\n",
>> -				     value);
>> -		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>> -	}
>> +	struct qcom_swrm_ctrl *swrm = dev_id;
>> +	u32 value, intr_sts, intr_sts_masked;
>> +	u32 i;
>> +	u8 devnum = 0;
>> +	int ret = IRQ_HANDLED;
>> +
>> +
>> +	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
>> +	intr_sts_masked = intr_sts & swrm->intr_mask;
>> +
>> +handle_irq:
> 
> maybe move this into a fn and avoid a goto for non err path?
> 
Makes sense!


--srini
