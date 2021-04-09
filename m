Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32C335994D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhDIJfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:35:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:48868 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDIJfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:35:22 -0400
IronPort-SDR: 5HJNt/p6ERzA1nXiZEH5FEsm/t0s7RUYW9TfE4EINLuEYZP6Jys9/4uQXD+lP2w8Gs2CrLFe/f
 P82uhbO2evEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="181261032"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="181261032"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 02:35:09 -0700
IronPort-SDR: Fw42pGcnaUcO+mqRGnPxwsl+pILV7+edI7hDYr2eg1Iyt+tjJ8waOtSH9+zYjMne7kG13BrW43
 uKzK6PSAzvbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="520224195"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 09 Apr 2021 02:35:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 09 Apr 2021 12:35:06 +0300
Date:   Fri, 9 Apr 2021 12:35:06 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: remove useless variable
Message-ID: <YHAfyg8SVB9KPXwB@kuha.fi.intel.com>
References: <1617960136-95131-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617960136-95131-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 05:22:16PM +0800, Jiapeng Chong wrote:
> Fix the following gcc warning:
> 
> drivers/usb/typec/tcpm/tcpm.c:2107:39: warning: ‘tcpm_altmode_ops’
> defined but not used [-Wunused-const-variable=].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ce7af39..4585785 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2104,12 +2104,6 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
>  	return 0;
>  }
>  
> -static const struct typec_altmode_ops tcpm_altmode_ops = {
> -	.enter = tcpm_altmode_enter,
> -	.exit = tcpm_altmode_exit,
> -	.vdm = tcpm_altmode_vdm,
> -};

You remove that but leave the functions. That should create even more
warnings for you, because now there are no users for those functions.

There is another, more complete patch for this, but I don't think we
should take either of these now. We about to get a user for
tcpm_altmode_ops.

Br,

-- 
heikki
