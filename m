Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F57435B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhJUHKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:10:46 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:54952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231158AbhJUHKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:10:44 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0533A180E07B8;
        Thu, 21 Oct 2021 07:08:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 95407D1514;
        Thu, 21 Oct 2021 07:08:24 +0000 (UTC)
Message-ID: <b85fee5ff20d2b398948a6bccf1bcc5eb22b49ff.camel@perches.com>
Subject: Re: [PATCH] virtio-blk: fixup coccinelle warnings
From:   Joe Perches <joe@perches.com>
To:     cgel.zte@gmail.com, mst@redhat.com,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@inria.fr
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Thu, 21 Oct 2021 00:08:23 -0700
In-Reply-To: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
References: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 95407D1514
X-Spam-Status: No, score=-0.04
X-Stat-Signature: w1k1cs1tg45sjhxa5ai68tet591rgwep
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18GuLItoKjGI2brebfiEvCynGxVYaDHZyo=
X-HE-Tag: 1634800104-276374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-10-21 at 06:51 +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING  use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
[]
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
[]
> @@ -624,7 +624,7 @@ cache_type_show(struct device *dev, struct device_attribute *attr, char *buf)
> -	return snprintf(buf, 40, "%s\n", virtblk_cache_types[writeback]);
> +	return sysfs_emit(buf, "%s\n", virtblk_cache_types[writeback]);

Perhaps scripts/coccinelle/api/device_attr_show.cocci should be updated
to be more like the script used in commit 1c7fd72687d6

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	return
-	strcpy(buf, chr);
+	sysfs_emit(buf, chr);
	...>
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	sprintf(buf,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	snprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
	len =
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_emit(buf,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
identifier len;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	<...
-	len += scnprintf(buf + len, PAGE_SIZE - len,
+	len += sysfs_emit_at(buf, len,
	...);
	...>
	return len;
}

@@
identifier d_show;
identifier dev, attr, buf;
expression chr;
@@

ssize_t d_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	...
-	strcpy(buf, chr);
-	return strlen(buf);
+	return sysfs_emit(buf, chr);
}


