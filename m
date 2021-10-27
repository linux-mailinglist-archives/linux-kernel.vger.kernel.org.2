Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18CE43BEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhJ0BDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:03:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56512 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236388AbhJ0BDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:03:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635296442; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ACdGNtGl5teNBEXUOcFYOMF8OhNAHfEGI143nwXmy+Y=; b=Q+1l+hM2FkKMt2hm5Ig26nH2aGspXjNeLrmlrf6jlPWRPjYZUOjZVKZTbLxusbUHu0pzBmdj
 1NQmQwWrxJmh2yDMGAH/8WJ9cJRtKeiN+Mb09gSxfGhrqVwCB8OvbRVVDNWbN/RhJWe8oasK
 zskkg70y/ZQmjoLf/tCjtU4sPJs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6178a4b914914866fa797d9c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 01:00:41
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1211C43460; Wed, 27 Oct 2021 01:00:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C73DC4338F;
        Wed, 27 Oct 2021 01:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5C73DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Date:   Tue, 26 Oct 2021 18:00:35 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] usb: typec: ucsi: Add support for PD cdev
Message-ID: <20211027010035.GA13345@jackp-linux.qualcomm.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
 <20211026143352.78387-4-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026143352.78387-4-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 05:33:51PM +0300, Heikki Krogerus wrote:
>
> -static int ucsi_get_src_pdos(struct ucsi_connector *con)
> +int ucsi_read_pdos(struct ucsi_connector *con, int partner, int source, u32 *pdos)
>  {
> +	u32 pdo[PDO_MAX_OBJECTS];
> +	int num_pdos;
>  	int ret;
>  
>  	/* UCSI max payload means only getting at most 4 PDOs at a time */
> -	ret = ucsi_get_pdos(con, 1, con->src_pdos, 0, UCSI_MAX_PDOS);
> +	ret = ucsi_get_pdos(con, partner, source, pdo, 0, UCSI_MAX_PDOS);
>  	if (ret < 0)
>  		return ret;
>  
> -	con->num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
> -	if (con->num_pdos < UCSI_MAX_PDOS)
> -		return 0;
> +	num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
> +	if (num_pdos < UCSI_MAX_PDOS)
> +		goto done;
>  
>  	/* get the remaining PDOs, if any */
> -	ret = ucsi_get_pdos(con, 1, con->src_pdos, UCSI_MAX_PDOS,
> +	ret = ucsi_get_pdos(con, partner, source, pdo, UCSI_MAX_PDOS,
>  			    PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
>  	if (ret < 0)
>  		return ret;
>  
> -	con->num_pdos += ret / sizeof(u32);
> +	num_pdos += ret / sizeof(u32);
> +done:
> +	memcpy(pdos, pdo, num_pdos * sizeof(pdo));
> +
> +	return num_pdos;
> +}
> +
> +static int ucsi_get_src_pdos(struct ucsi_connector *con)
> +{
> +	int ret;
> +
> +	ret = ucsi_read_pdos(con, 0, 1, con->src_pdos);

Second parameter should be 1 right?  Original intent of get_src_pdos()
is to retrieve the partner's source capabilities in order to populate
the power_supply.  Passing 0 as the partner param here changes the
behavior to retrieve the source PDOs of the port.

(BTW I'm going to send a quick patch for this to since this assumes that
port is sink and partner is source; when it's the other way around we
end up calling GET_PDOS on the sink partner when it might not even be
source capable).

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
