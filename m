Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A68387A03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349648AbhERNcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238635AbhERNcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:32:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94B75610A1;
        Tue, 18 May 2021 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621344690;
        bh=AQcXbOCQe8U95i8kgKYGNsDmCjZ26eRzhWl2krTizEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r24mnIC/fCRj3RU/MduMgLjB0Yy1ABWNeBIb/VrlLClFsaLRsnICuExoYNB9/mabC
         rt6gM1h4Ipx6ozOM6DRNvFwyntmU2iOe4NU7eQk862vNnE+frpsTOl+vowMnjDCqt8
         lU4aKmeYmXQNF4u5Gb9lquLxCW0NgnoDgJTYIwhY=
Date:   Tue, 18 May 2021 15:31:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v1 2/2] usb: typec: tcpm: Add module parameter to wrap
 around logs
Message-ID: <YKPBsKM70ZLfjx8+@kroah.com>
References: <20210517233609.610248-1-badhri@google.com>
 <20210517233609.610248-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517233609.610248-2-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:36:09PM -0700, Badhri Jagan Sridharan wrote:
> When the buffer is full, TCPM stops logging into the buffer.
> This change adds log_wraparound module parameter which when set
> flushes out the oldest log entries (FIFO) to make way for the
> newer ones.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b79194919b27..a369decade60 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -38,6 +38,10 @@ static bool modparam_log_misc_dev;
>  module_param_named(log_misc_dev, modparam_log_misc_dev, bool, 0444);
>  MODULE_PARM_DESC(log_misc_dev, "Expose tcpm logs through misc device");
>  
> +static bool modparam_log_wraparound;
> +module_param_named(log_wraparound, modparam_log_wraparound, bool, 0444);
> +MODULE_PARM_DESC(log_wraparound, "Wrap around logs");

Again, no, this we know better than to add new module parameters, this
is not ok.

greg k-h
