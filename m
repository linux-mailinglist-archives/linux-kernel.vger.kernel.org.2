Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09E643710E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 06:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhJVEvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 00:51:55 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:33918 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229573AbhJVEvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 00:51:54 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E7B03348D0;
        Fri, 22 Oct 2021 04:49:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 5D98213DA5;
        Fri, 22 Oct 2021 04:49:35 +0000 (UTC)
Message-ID: <ccb3ab4d533de55260b98c7168bfa4460c5f3fcc.camel@perches.com>
Subject: Re: [PATCH] fsi: master: replace snprintf in show functions with
 sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     cgel.zte@gmail.com, jk@ozlabs.org
Cc:     joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Thu, 21 Oct 2021 21:49:34 -0700
In-Reply-To: <20211022025052.1063370-1-ye.guojin@zte.com.cn>
References: <20211022025052.1063370-1-ye.guojin@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5D98213DA5
X-Spam-Status: No, score=0.82
X-Stat-Signature: ymjw5ge6ktceiujnhptfd1wabueiigp6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Tcwve9/9BDkDcczrk+P14/BX6aHFStB0=
X-HE-Tag: 1634878175-286183
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-22 at 02:50 +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING  use scnprintf or sprintf
[]
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
[]
> @@ -1083,8 +1083,7 @@ static ssize_t external_mode_show(struct device *dev,
>  {
>  	struct fsi_master_acf *master = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
> -			master->external_mode ? 1 : 0);
> +	return sysfs_emit(buf, "%u\n", master->external_mode ? 1 : 0);

external_mode is already bool so this ?: isn't necessary.

> diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
[]
> @@ -718,8 +718,7 @@ static ssize_t external_mode_show(struct device *dev,
>  {
>  	struct fsi_master_gpio *master = dev_get_drvdata(dev);
>  
> -	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
> -			master->external_mode ? 1 : 0);
> +	return sysfs_emit(buf, "%u\n", master->external_mode ? 1 : 0);

here too

