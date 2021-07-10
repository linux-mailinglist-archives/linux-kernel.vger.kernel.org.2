Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF843C35B4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhGJRHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 13:07:37 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:36890 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229490AbhGJRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 13:07:37 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3AF3E837F253;
        Sat, 10 Jul 2021 17:04:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 3852D2448BF;
        Sat, 10 Jul 2021 17:04:50 +0000 (UTC)
Message-ID: <10621e048f62018432c42a3fccc1a5fd9a6d71d7.camel@perches.com>
Subject: Re: [PATCH] dax: replace sprintf() by scnprintf()
From:   Joe Perches <joe@perches.com>
To:     Salah Triki <salah.triki@gmail.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 10 Jul 2021 10:04:48 -0700
In-Reply-To: <20210710164615.GA690067@pc>
References: <20210710164615.GA690067@pc>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.60
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3852D2448BF
X-Stat-Signature: r9mp75uipcc9qgr86rf8isradagw5869
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19qjiJ4bEM3l7ZhvAJzq+B4x7oGaQz405Y=
X-HE-Tag: 1625936690-706479
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-07-10 at 17:46 +0100, Salah Triki wrote:
> Replace sprintf() by scnprintf() in order to avoid buffer overflows.

OK but also not strictly necessary.  DAX_NAME_LEN is 30.

Are you finding and changing these manually or with a script?

> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
[]
> @@ -76,7 +76,7 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
>  	fields = sscanf(buf, "dax%d.%d", &region_id, &id);
>  	if (fields != 2)
>  		return -EINVAL;
> -	sprintf(devname, "dax%d.%d", region_id, id);
> +	scnprintf(devname, DAX_NAME_LEN, "dax%d.%d", region_id, id);
>  	if (!sysfs_streq(buf, devname))
>  		return -EINVAL;
>  
> 


