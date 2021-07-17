Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7963CC3BC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhGQOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhGQOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:07:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B02BC06175F;
        Sat, 17 Jul 2021 07:04:51 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z25so9356043qto.12;
        Sat, 17 Jul 2021 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uU5y8nZLYxaj4LFOjlhepM5vk5aGA4uqxvcznWYEcEs=;
        b=iPGfR4aSARgZaiD+uKa5Puk+ePyZOfJv2BgBIUl2qE9ECUY27fxoTuGAYSlgGKLsH9
         aLmDiqVtaA0ntxH1krwzV85QekRTpFewEoLn/Xtr+GOR0cnboK8ZunGndeVLg/1/p4Kc
         d1HoEwujKR3J9VSOox7GyieV1FsQUlsXnp0pxEiuzcuqZFLwBgsnV9irz5TLFUS/nWbf
         wm5M29buQpGhar+bQz3lmfuRJI2msMpjRlAQ95we9A7QdOtawf4kjdk5Q6opvWAmsHz+
         m5biKT+ba8hZrPowK3ft23/uk77WtdPStWy3tb/oqhn8DEKty7PrVPhf7C3mMoToSfe7
         yIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uU5y8nZLYxaj4LFOjlhepM5vk5aGA4uqxvcznWYEcEs=;
        b=BqQ9JMQq4aas1385b1z5Ie3Mj2b+9/nWcEpY4a8jtPjV+J/UvIckFAEQ2/zAf1fIeL
         hkUN0kbCMcvZGaQg2RNP4XhCFrY5x8s5h7Sekn5aphGnUKpcgd/NZSbveek1VZfUkb+H
         SxAc+wRzMfJxXHoxiN3bjgWYUz9BrHcZYAgwbur2CO/tG0lsjDq8EIBMEbA1eAa7t+rW
         ywp5KGAWJ91JVbkCQhTU5ZuVymTEJUM7Z+l8A1gwuva4TT1ctDhJtaOEBwK8Y4TxEuS+
         MXosv83aRLSfw814gUCF1YlP1/Ilx8D6iApEjFgbKvk1B5d4/yeC76FW68V/LtlbybzZ
         NZEg==
X-Gm-Message-State: AOAM533KfCFs3FGHZzBIi7GNhlQBArZq4tUIm2w1JqjwecRt2fUANu0G
        ddMQ3GCVLpLGIIWgFaI/dOc=
X-Google-Smtp-Source: ABdhPJwFYvuuuB/a5eqzYMYHCMb8XXye+hKtya8vbdNjK7AbGw3b4zv8g0xbDCtnV+R6yoHmsHd/qg==
X-Received: by 2002:ac8:7087:: with SMTP id y7mr5979528qto.91.1626530690440;
        Sat, 17 Jul 2021 07:04:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 67sm5192911qkm.134.2021.07.17.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:04:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jul 2021 07:04:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, jdelvare@suse.com, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] hwmon: (occ) Remove sequence numbering and checksum
 calculation
Message-ID: <20210717140448.GA800975@roeck-us.net>
References: <20210716151850.28973-1-eajames@linux.ibm.com>
 <20210716151850.28973-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716151850.28973-3-eajames@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 10:18:49AM -0500, Eddie James wrote:
> Checksumming of the request and sequence numbering is now done in the
> OCC interface driver in order to keep unique sequence numbers. So
> remove those in the hwmon driver.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/occ/common.c | 30 ++++++++++++------------------
>  drivers/hwmon/occ/common.h |  3 +--
>  drivers/hwmon/occ/p8_i2c.c | 15 +++++++++------
>  drivers/hwmon/occ/p9_sbe.c |  4 ++--
>  4 files changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 0d68a78be980..fc298268c89e 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -132,22 +132,20 @@ struct extended_sensor {
>  static int occ_poll(struct occ *occ)
>  {
>  	int rc;
> -	u16 checksum = occ->poll_cmd_data + occ->seq_no + 1;
> -	u8 cmd[8];
> +	u8 cmd[7];
>  	struct occ_poll_response_header *header;
>  
>  	/* big endian */
> -	cmd[0] = occ->seq_no++;		/* sequence number */
> +	cmd[0] = 0;			/* sequence number */
>  	cmd[1] = 0;			/* cmd type */
>  	cmd[2] = 0;			/* data length msb */
>  	cmd[3] = 1;			/* data length lsb */
>  	cmd[4] = occ->poll_cmd_data;	/* data */
> -	cmd[5] = checksum >> 8;		/* checksum msb */
> -	cmd[6] = checksum & 0xFF;	/* checksum lsb */
> -	cmd[7] = 0;
> +	cmd[5] = 0;			/* checksum msb */
> +	cmd[6] = 0;			/* checksum lsb */
>  
>  	/* mutex should already be locked if necessary */
> -	rc = occ->send_cmd(occ, cmd);
> +	rc = occ->send_cmd(occ, cmd, sizeof(cmd));
>  	if (rc) {
>  		occ->last_error = rc;
>  		if (occ->error_count++ > OCC_ERROR_COUNT_THRESHOLD)
> @@ -184,25 +182,23 @@ static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
>  {
>  	int rc;
>  	u8 cmd[8];
> -	u16 checksum = 0x24;
>  	__be16 user_power_cap_be = cpu_to_be16(user_power_cap);
>  
> -	cmd[0] = 0;
> -	cmd[1] = 0x22;
> -	cmd[2] = 0;
> -	cmd[3] = 2;
> +	cmd[0] = 0;	/* sequence number */
> +	cmd[1] = 0x22;	/* cmd type */
> +	cmd[2] = 0;	/* data length msb */
> +	cmd[3] = 2;	/* data length lsb */
>  
>  	memcpy(&cmd[4], &user_power_cap_be, 2);
>  
> -	checksum += cmd[4] + cmd[5];
> -	cmd[6] = checksum >> 8;
> -	cmd[7] = checksum & 0xFF;
> +	cmd[6] = 0;	/* checksum msb */
> +	cmd[7] = 0;	/* checksum lsb */
>  
>  	rc = mutex_lock_interruptible(&occ->lock);
>  	if (rc)
>  		return rc;
>  
> -	rc = occ->send_cmd(occ, cmd);
> +	rc = occ->send_cmd(occ, cmd, sizeof(cmd));
>  
>  	mutex_unlock(&occ->lock);
>  
> @@ -1151,8 +1147,6 @@ int occ_setup(struct occ *occ, const char *name)
>  {
>  	int rc;
>  
> -	/* start with 1 to avoid false match with zero-initialized SRAM buffer */
> -	occ->seq_no = 1;
>  	mutex_init(&occ->lock);
>  	occ->groups[0] = &occ->group;
>  
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index e6df719770e8..5020117be740 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -95,9 +95,8 @@ struct occ {
>  	struct occ_sensors sensors;
>  
>  	int powr_sample_time_us;	/* average power sample time */
> -	u8 seq_no;
>  	u8 poll_cmd_data;		/* to perform OCC poll command */
> -	int (*send_cmd)(struct occ *occ, u8 *cmd);
> +	int (*send_cmd)(struct occ *occ, u8 *cmd, size_t len);
>  
>  	unsigned long next_update;
>  	struct mutex lock;		/* lock OCC access */
> diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
> index 0cf8588be35a..22af189eafa6 100644
> --- a/drivers/hwmon/occ/p8_i2c.c
> +++ b/drivers/hwmon/occ/p8_i2c.c
> @@ -97,18 +97,21 @@ static int p8_i2c_occ_putscom_u32(struct i2c_client *client, u32 address,
>  }
>  
>  static int p8_i2c_occ_putscom_be(struct i2c_client *client, u32 address,
> -				 u8 *data)
> +				 u8 *data, size_t len)
>  {
> -	__be32 data0, data1;
> +	__be32 data0 = 0, data1 = 0;
>  
> -	memcpy(&data0, data, 4);
> -	memcpy(&data1, data + 4, 4);
> +	memcpy(&data0, data, min(len, 4UL));
> +	if (len > 4UL) {
> +		len -= 4;
> +		memcpy(&data1, data + 4, min(len, 4UL));
> +	}
>  
>  	return p8_i2c_occ_putscom_u32(client, address, be32_to_cpu(data0),
>  				      be32_to_cpu(data1));
>  }
>  
> -static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd)
> +static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  {
>  	int i, rc;
>  	unsigned long start;
> @@ -127,7 +130,7 @@ static int p8_i2c_occ_send_cmd(struct occ *occ, u8 *cmd)
>  		return rc;
>  
>  	/* write command (expected to already be BE), we need bus-endian... */
> -	rc = p8_i2c_occ_putscom_be(client, OCB_DATA3, cmd);
> +	rc = p8_i2c_occ_putscom_be(client, OCB_DATA3, cmd, len);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index f6387cc0b754..9709f2b9c052 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -16,14 +16,14 @@ struct p9_sbe_occ {
>  
>  #define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ, occ)
>  
> -static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd)
> +static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>  {
>  	struct occ_response *resp = &occ->resp;
>  	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>  	size_t resp_len = sizeof(*resp);
>  	int rc;
>  
> -	rc = fsi_occ_submit(ctx->sbe, cmd, 8, resp, &resp_len);
> +	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
>  	if (rc < 0)
>  		return rc;
>  
