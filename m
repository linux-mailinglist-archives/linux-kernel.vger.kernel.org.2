Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1851938C97D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhEUOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhEUOuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:50:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A2C061574;
        Fri, 21 May 2021 07:48:33 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so7687827oty.7;
        Fri, 21 May 2021 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SzSRHDi7TTu8uQAEs3v7mitDdO8Fjp2gleseCafPGMs=;
        b=iBbb/fIRCtWOUwU9wqsKcgqeCRjZI9d397Mkvd9INozux7153eCIEb/0unqyfatK/I
         itX2J7ZcSJjN319jXVgo9J0zMeTT2GrlQbcdW+5TzyrzQ0hMR66LnwqXv6IdwXkPBYUn
         55dS+cRZylllXEDguAOF4N6QayQ4L/vFUauZwIGkKCGgg4J/ZokYd1xAPFvnos4RlaN0
         mddVIlFPkmE8lsjQPinvqGX2WmZYF6QFUHJR9m4ueou7Zq3i4u5884fIaa23U7WDvS+7
         atJ2ooVvR5wfD/0TT0c7SnEcD297V0/Zhp/tBN8Zb2U/a1y6tcgtKWY/irrDFmWIpF2b
         MZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SzSRHDi7TTu8uQAEs3v7mitDdO8Fjp2gleseCafPGMs=;
        b=ZufePuNtaNC1eQx7B1ZJ52HmXKZWXIdiZYw+Yn8+mbCwghnJVqVtKxWIVG3r3WTAUt
         sR3vcVCkaMznUMmj7/PjQtL4KYTOEbnOPqzw9Tvgwo1ewEFLJhFiGCEUglX94SiJzvdy
         DHW7gy2j3YVuutV26K4PQovmzSSxpFNs85Uw0LOjM9lJeShd+bk/sIZBdSgs2UxWVtUL
         uTKQ9Aai65CeHRor4TBImUK0Hib9D+VEyoMYc537SOoigpDYKvwe/ZDm8/XoVzIsF27g
         ukgMiaph6cnjdOO/y2chh9U6QSa62OshB3rJNM57nvKj2s1PwO5lJmJeQBJiNvY6NMpG
         d8Kg==
X-Gm-Message-State: AOAM5312Hh8IRaSG4Ysv42aKl+VX9sPLQGnGKhWmlS3JMBgd7bK6A5q/
        MuOfCpF/i19/xxFdCU7aThvf3b8II1U=
X-Google-Smtp-Source: ABdhPJyxzkPkqsOO8Ne2+490pogVkdDmvtmNUeLmVy1w4oU76k93ynN3PscP3syy9vZFm63xJaz6Xw==
X-Received: by 2002:a9d:63d3:: with SMTP id e19mr8507065otl.64.1621608512512;
        Fri, 21 May 2021 07:48:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y44sm1245153ooi.0.2021.05.21.07.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 07:48:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] usb: typec: tcpm: Properly interrupt VDM AMS
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210521130121.1470334-1-kyletso@google.com>
 <20210521130121.1470334-2-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6872a037-c036-fd1c-608a-c33e4ef22923@roeck-us.net>
Date:   Fri, 21 May 2021 07:48:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521130121.1470334-2-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 6:01 AM, Kyle Tso wrote:
> When a VDM AMS is interrupted by Messages other than VDM, the AMS needs
> to be finished properly. Also start a VDM AMS if receiving SVDM Commands
> from the port partner to complement the functionality of tcpm_vdm_ams().
> 
> Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 64133e586c64..deb8a9d01f73 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1550,6 +1550,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>   			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
>   				typec_partner_set_svdm_version(port->partner,
>   							       PD_VDO_SVDM_VER(p[0]));
> +
> +			tcpm_ams_start(port, DISCOVER_IDENTITY);
>   			/* 6.4.4.3.1: Only respond as UFP (device) */
>   			if (port->data_role == TYPEC_DEVICE &&
>   			    port->nr_snk_vdo) {
> @@ -1568,14 +1570,19 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>   			}
>   			break;
>   		case CMD_DISCOVER_SVID:
> +			tcpm_ams_start(port, DISCOVER_SVIDS);
>   			break;
>   		case CMD_DISCOVER_MODES:
> +			tcpm_ams_start(port, DISCOVER_MODES);
>   			break;
>   		case CMD_ENTER_MODE:
> +			tcpm_ams_start(port, DFP_TO_UFP_ENTER_MODE);
>   			break;
>   		case CMD_EXIT_MODE:
> +			tcpm_ams_start(port, DFP_TO_UFP_EXIT_MODE);
>   			break;
>   		case CMD_ATTENTION:
> +			tcpm_ams_start(port, ATTENTION);
>   			/* Attention command does not have response */
>   			*adev_action = ADEV_ATTENTION;
>   			return 0;
> @@ -2287,6 +2294,12 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>   	bool frs_enable;
>   	int ret;
>   
> +	if (tcpm_vdm_ams(port) && type != PD_DATA_VENDOR_DEF) {
> +		port->vdm_state == VDM_STATE_ERR_BUSY;
> +		tcpm_ams_finish(port);
> +		mod_vdm_delayed_work(port, 0);
> +	}
> +
>   	switch (type) {
>   	case PD_DATA_SOURCE_CAP:
>   		for (i = 0; i < cnt; i++)
> @@ -2459,6 +2472,16 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>   	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
>   	enum tcpm_state next_state;
>   
> +	/*
> +	 * Stop VDM state machine if interrupted by other Messages while NOT_SUPP is allowed in
> +	 * VDM AMS if waiting for VDM responses and will be handled later.
> +	 */
> +	if (tcpm_vdm_ams(port) && type != PD_CTRL_NOT_SUPP && type != PD_CTRL_GOOD_CRC) {
> +		port->vdm_state = VDM_STATE_ERR_BUSY;
> +		tcpm_ams_finish(port);
> +		mod_vdm_delayed_work(port, 0);
> +	}
> +
>   	switch (type) {
>   	case PD_CTRL_GOOD_CRC:
>   	case PD_CTRL_PING:
> @@ -2717,6 +2740,13 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>   	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
>   	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
>   
> +	/* stopping VDM state machine if interrupted by other Messages */
> +	if (tcpm_vdm_ams(port)) {
> +		port->vdm_state = VDM_STATE_ERR_BUSY;
> +		tcpm_ams_finish(port);
> +		mod_vdm_delayed_work(port, 0);
> +	}
> +
>   	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
>   		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
>   		tcpm_log(port, "Unchunked extended messages unsupported");
> 

