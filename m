Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C05331990A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhBLETd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhBLETa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:19:30 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD2C061574;
        Thu, 11 Feb 2021 20:18:50 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id l5so1807214ooj.7;
        Thu, 11 Feb 2021 20:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JSbc++y6KFWtkwyTb8lDaBGwO/g+jHAvspH06AOE7Lk=;
        b=d8w2isgRQCGnZo9Qc/OfA4Eao613BsvjzPQi0iIqK9PtGgZMKUJ/iSLY4gmWxa6gRo
         y0RnHYGS+HS69BuZ3vyLk6ex0sIONH994KlpWJpIz+DIDQNovbtPE+OGh6xfLNHn7nQK
         GtyvuRVxU4+cL6RyFurOEadpGbzLUx5gQKVi0r9sF8BD0O+XXWhmdosg9cHIZQDMg6tQ
         KjIskK1O+FoZFm80KzafJvXqCPWMxAdvb14ncvQ4SYNTcgYsxAABbVIBwjJ32GRgc4p2
         a8OijttZOQTzsTJQCRFh7eXP5vsNFvQwjHTwe0hr8yoka7qW9nqiSxrwreyaI7jzUYqt
         l/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JSbc++y6KFWtkwyTb8lDaBGwO/g+jHAvspH06AOE7Lk=;
        b=cuh5RT9aGlSaTlzu3EDrV1woVOARh5ckZNuQ7AlX7O+pdWJaWnVe6POUb6DvCgnlkM
         3YOjqxvbq+jA9Ygprwl0sw1tN+AOaSqphiG5+6m3OzgjR+ucb0To8PZAC//kLszNJEEq
         M4cd5V3NzuvaNizbIonpIk3xivwpXM9M41AtJCQtrVvyj3YN+LrIqAf55ADh6KpYwuCl
         MtnUq+pmJAWRzEgocgtnu4/WRTlEWif6tdEPwWTCxRXrD/FkYsMuy13AbgY69wvmvJTr
         CxLcDii49vs57BIrKCKpImFNqD4xzZgXtTvfd2GVE9CWYGxTWuV3yFvPmZTOjW/xhkM2
         aDMw==
X-Gm-Message-State: AOAM532CKr0Wm9cDC1NpFE/T+uYH07miAl2K91cu5DG1NIYxZkXZBeBI
        jEnVxC6ZHUQResoohwAblmU=
X-Google-Smtp-Source: ABdhPJx3/bQm/epBizwOvAUCothqvzqu9LqDXsYviwMKTVvHJzFDodtreyjxYu5lqufQoxNCtvEtqg==
X-Received: by 2002:a4a:c29a:: with SMTP id b26mr739340ooq.53.1613103530061;
        Thu, 11 Feb 2021 20:18:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3sm1432048otb.36.2021.02.11.20.18.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:18:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:18:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/7] usb: typec: ucsi: Determine common SVDM Version
Message-ID: <20210212041848.GD103223@roeck-us.net>
References: <20210205033415.3320439-1-kyletso@google.com>
 <20210205033415.3320439-5-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205033415.3320439-5-kyletso@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:34:12AM +0800, Kyle Tso wrote:
> This patch implements the following requirement in the Spec.
> 
> PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
>   6.4.4.2.3 Structured VDM Version
>   "The Structured VDM Version field of the Discover Identity Command
>   sent and received during VDM discovery Shall be used to determine the
>   lowest common Structured VDM Version supported by the Port Partners or
>   Cable Plug and Shall continue to operate using this Specification
>   Revision until they are Detached."
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v5:
> - follow the changes of "usb: typec: Manage SVDM version"
> - remove the "reset to default". Now the default SVDM version will be
>   set when calling to typec_register_partner
> 
>  drivers/usb/typec/ucsi/displayport.c | 32 +++++++++++++++++++++++++---
>  drivers/usb/typec/ucsi/ucsi.c        |  1 +
>  2 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
> index 1d387bddefb9..73cd5bf35047 100644
> --- a/drivers/usb/typec/ucsi/displayport.c
> +++ b/drivers/usb/typec/ucsi/displayport.c
> @@ -49,6 +49,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  {
>  	struct ucsi_dp *dp = typec_altmode_get_drvdata(alt);
>  	struct ucsi *ucsi = dp->con->ucsi;
> +	int svdm_version;
>  	u64 command;
>  	u8 cur = 0;
>  	int ret;
> @@ -83,7 +84,13 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  	 * mode, and letting the alt mode driver continue.
>  	 */
>  
> -	dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, CMD_ENTER_MODE);
> +	svdm_version = typec_altmode_get_svdm_version(alt);
> +	if (svdm_version < 0) {
> +		ret = svdm_version;
> +		goto err_unlock;
> +	}
> +
> +	dp->header = VDO(USB_TYPEC_DP_SID, 1, svdm_version, CMD_ENTER_MODE);
>  	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
>  
> @@ -101,6 +108,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
>  static int ucsi_displayport_exit(struct typec_altmode *alt)
>  {
>  	struct ucsi_dp *dp = typec_altmode_get_drvdata(alt);
> +	int svdm_version;
>  	u64 command;
>  	int ret = 0;
>  
> @@ -120,7 +128,13 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -	dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, CMD_EXIT_MODE);
> +	svdm_version = typec_altmode_get_svdm_version(alt);
> +	if (svdm_version < 0) {
> +		ret = svdm_version;
> +		goto out_unlock;
> +	}
> +
> +	dp->header = VDO(USB_TYPEC_DP_SID, 1, svdm_version, CMD_EXIT_MODE);
>  	dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  	dp->header |= VDO_CMDT(CMDT_RSP_ACK);
>  
> @@ -186,6 +200,7 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
>  	struct ucsi_dp *dp = typec_altmode_get_drvdata(alt);
>  	int cmd_type = PD_VDO_CMDT(header);
>  	int cmd = PD_VDO_CMD(header);
> +	int svdm_version;
>  
>  	mutex_lock(&dp->con->lock);
>  
> @@ -198,9 +213,20 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	svdm_version = typec_altmode_get_svdm_version(alt);
> +	if (svdm_version < 0) {
> +		mutex_unlock(&dp->con->lock);
> +		return svdm_version;
> +	}
> +
>  	switch (cmd_type) {
>  	case CMDT_INIT:
> -		dp->header = VDO(USB_TYPEC_DP_SID, 1, SVDM_VER_1_0, cmd);
> +		if (PD_VDO_SVDM_VER(header) < svdm_version) {
> +			typec_partner_set_svdm_version(dp->con->partner, PD_VDO_SVDM_VER(header));
> +			svdm_version = PD_VDO_SVDM_VER(header);
> +		}
> +
> +		dp->header = VDO(USB_TYPEC_DP_SID, 1, svdm_version, cmd);
>  		dp->header |= VDO_OPOS(USB_TYPEC_DP_MODE);
>  
>  		switch (cmd) {
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index ca3f4194ad90..244270755ae6 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1052,6 +1052,7 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  
>  	cap->revision = ucsi->cap.typec_version;
>  	cap->pd_revision = ucsi->cap.pd_version;
> +	cap->svdm_version = SVDM_VER_2_0;
>  	cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
>  
>  	if (con->cap.op_mode & UCSI_CONCAP_OPMODE_AUDIO_ACCESSORY)
> -- 
> 2.30.0.365.g02bc693789-goog
> 
