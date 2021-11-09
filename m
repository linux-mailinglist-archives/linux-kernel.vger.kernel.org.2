Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1094F44A53D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhKIDRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:17:03 -0500
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:51764 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231910AbhKIDRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:17:01 -0500
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8B43F1829B8FD;
        Tue,  9 Nov 2021 03:14:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 5E4A218A60C;
        Tue,  9 Nov 2021 03:14:14 +0000 (UTC)
Message-ID: <cc9807eb594b042ec2cd958f0c70c2f3dd12d58b.camel@perches.com>
Subject: Re: [PATCH 1/2] erofs: add sysfs interface
From:   Joe Perches <joe@perches.com>
To:     Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org
Cc:     guoweichao@oppo.com, guanyuwei@oppo.com, yh@oppo.com,
        zhangshiming@oppo.com, linux-kernel@vger.kernel.org
Date:   Mon, 08 Nov 2021 19:14:13 -0800
In-Reply-To: <20211109025445.12427-1-huangjianan@oppo.com>
References: <20211109025445.12427-1-huangjianan@oppo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5E4A218A60C
X-Spam-Status: No, score=-4.15
X-Stat-Signature: 4k1qequtneuzwq7efx34abfoa48qjm1y
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19tC8M+OVunKUJInFptKz4De5mCUJw4EP8=
X-HE-Tag: 1636427654-852723
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-09 at 10:54 +0800, Huang Jianan wrote:
> Add sysfs interface to configure erofs related parameters in the
> future.
[]
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
[]
> +static ssize_t erofs_attr_show(struct kobject *kobj,
> +				struct attribute *attr, char *buf)
> +{
> +	struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
> +						s_kobj);
> +	struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
> +	unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
> +
> +	switch (a->attr_id) {
> +	case attr_feature:
> +		return snprintf(buf, PAGE_SIZE, "supported\n");
> +	case attr_pointer_ui:
> +		if (!ptr)
> +			return 0;
> +		return snprintf(buf, PAGE_SIZE, "%u\n",
> +				*((unsigned int *) ptr));

Prefer sysfs_emit over snprintf

	case attr_feature:
		return sysfs_emit(buf, "supported\n");
	case attr_pointer_ui:
		...
		return sysfs_emit(buf, "%u\n", *(unsigned int *)ptr);

etc...


