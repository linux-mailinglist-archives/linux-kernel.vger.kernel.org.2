Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAC40B1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhINOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:47:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:61010 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234311AbhINOqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:46:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="222055181"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="222055181"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 07:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="609651680"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Sep 2021 07:45:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Sep 2021 17:45:18 +0300
Date:   Tue, 14 Sep 2021 17:45:18 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 11/29] ABI: sysfs-class-typec: fix a bad What field
Message-ID: <YUC1fp24ssnVxNCx@kuha.fi.intel.com>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
 <3284da746c7f2bf7c120913a35db51cc5650e2ea.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3284da746c7f2bf7c120913a35db51cc5650e2ea.1631629496.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 04:32:26PM +0200, Mauro Carvalho Chehab wrote:
> The <partner> wildcard is missing the '<' character. Fix it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-class-typec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 40122d915ae1..c09add32e596 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -200,7 +200,7 @@ Description:	USB Power Delivery Specification defines a set of product types
>  		amc			Alternate Mode Controller
>  		======================  ==========================
>  
> -What:		/sys/class/typec/<port>-partner>/identity/
> +What:		/sys/class/typec/<port>-<partner>/identity/
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:

It's just a typo. It should be <port>-partner, not <port>-<partner>.

thanks,

-- 
heikki
