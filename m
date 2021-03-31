Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86C53505EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhCaSBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234766AbhCaSB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617213688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9TIoYOxwgSa1oTS8+sR3o06KhEyayI82f4/zo2TYwM=;
        b=fXMOpg1u1e3wKgLurD7w82Euef1Pea+DqINGDtUgy5vEqW2xILryGzIcbrciEg0KYYuM87
        mQIz8goxXLv5eN4shPpZvcMmfw0WPomt0cSkwLWJbYrBAnS4UnVW5q46OBWrpue/Ug7kAX
        35OWfTUk9n5gsElFRsHxDkZj4HbmgMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-QUw5xmPbOeiwz7_cEDoPBg-1; Wed, 31 Mar 2021 14:01:24 -0400
X-MC-Unique: QUw5xmPbOeiwz7_cEDoPBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADFAD107ACCA;
        Wed, 31 Mar 2021 18:01:23 +0000 (UTC)
Received: from ovpn-112-207.phx2.redhat.com (ovpn-112-207.phx2.redhat.com [10.3.112.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BBB55D720;
        Wed, 31 Mar 2021 18:01:22 +0000 (UTC)
Message-ID: <7605c89ca672030cb296dc47208b4298ce00b30d.camel@redhat.com>
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 31 Mar 2021 14:01:22 -0400
In-Reply-To: <20210331131228.131118-1-dwagner@suse.de>
References: <20210331131228.131118-1-dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-31 at 15:12 +0200, Daniel Wagner wrote:
> Commit 8c4dfea97f15 ("nvme-fabrics: reject I/O to offline device")
> introduced fast_io_fail_tmo but didn't export the value to sysfs.
> That
> means the value is hard coded during compile time. Export the timeout
> value to user space via sysfs to allow runtime configuration.
> 
> Cc: Victor Gladkov <Victor.Gladkov@kioxia.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> This patch is against nvme-5.13
> 
> BTW, checkpatch complains with
> 
>   WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not
> preferred. Consider using octal permissions '0644'.
> 
> Is this something we want to adapt to?
> 
>  drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..c8de0e37c7d9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3696,6 +3696,36 @@ static ssize_t
> nvme_ctrl_reconnect_delay_store(struct device *dev,
>  static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
>  	nvme_ctrl_reconnect_delay_show,
> nvme_ctrl_reconnect_delay_store);
>  
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	if (ctrl->opts->fast_io_fail_tmo == -1)
> +		return sprintf(buf, "off\n");
> +	return sprintf(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
> +}
> +
> +static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t
> count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	int fast_io_fail_tmo, err;
> +
> +	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
> +	if (err)
> +		return -EINVAL;
> +
> +	else if (fast_io_fail_tmo < 0)
> +		opts->fast_io_fail_tmo = -1;
> +	else
> +		opts->fast_io_fail_tmo = fast_io_fail_tmo;
> +	return count;
> +}
> +static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
> +	nvme_ctrl_fast_io_fail_tmo_show,
> nvme_ctrl_fast_io_fail_tmo_store);
> +
>  static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_reset_controller.attr,
>  	&dev_attr_rescan_controller.attr,
> @@ -3715,6 +3745,7 @@ static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_hostid.attr,
>  	&dev_attr_ctrl_loss_tmo.attr,
>  	&dev_attr_reconnect_delay.attr,
> +	&dev_attr_fast_io_fail_tmo.attr,
>  	NULL
>  };
>  

Thanks.
Reviewed-by: Ewan D. Milne <emilne@redhat.com>


