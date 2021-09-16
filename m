Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C6940D909
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbhIPLso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:48:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:48176 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233746AbhIPLsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:48:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202700800"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="202700800"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 04:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="610617645"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 16 Sep 2021 04:47:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 16 Sep 2021 14:47:18 +0300
Date:   Thu, 16 Sep 2021 14:47:18 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 11/30] ABI: sysfs-class-typec: fix a typo on a What
 field
Message-ID: <YUMuxlSEvJbEJJZl@kuha.fi.intel.com>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
 <bff0e7c137fb4f41ac0b2ed9c5a21c0948203f15.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff0e7c137fb4f41ac0b2ed9c5a21c0948203f15.1631782432.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 10:59:38AM +0200, Mauro Carvalho Chehab wrote:
> This what:
> 	/sys/class/typec/<port>-partner>/identity/
> 
> Contains an extra ">" character. Remove it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  Documentation/ABI/testing/sysfs-class-typec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 40122d915ae1..75088ecad202 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -200,7 +200,7 @@ Description:	USB Power Delivery Specification defines a set of product types
>  		amc			Alternate Mode Controller
>  		======================  ==========================
>  
> -What:		/sys/class/typec/<port>-partner>/identity/
> +What:		/sys/class/typec/<port>-partner/identity/
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
> -- 
> 2.31.1

thanks,

-- 
heikki
