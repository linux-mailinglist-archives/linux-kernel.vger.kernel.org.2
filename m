Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3935D40425B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348791AbhIIAnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhIIAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:43:45 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6256C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 17:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=UyZp0+zAOHeNysC0aX+TXmqkFvNwx4DwRQjTipWMm38=; b=TYQdbYheGkCpzn06LKNWV+Ujo4
        XYuzzuyznYl5EdNWdfx4ujOtPdY6jqbwhcooezcqYAYdzX/QoxNXIqmItl4txwWENj+CXMVbSjJnd
        6hJxSQWLP3uuwqdaZZTvJ1f0nB6j4l6umMrxZdZZ4HQccZbL/X0kCy91NqGxuImlSGVyZtLQICAzz
        cfJrRTSrLqtO5JLcCdc0y+qsnqp4gJADQF2Ad04RT3DY+SrIzWc3nSFRqQ0D0KneQqgPAupSC5Cps
        XYSEyE2CXn/YSa07Hk1Ohn9fmrFgWEaWQZKdOVKyE89j38q1PFvfxAF+qrGq7eJVXFQCtLi+qppOR
        ZUwzc/og==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mO899-007ryW-F2; Thu, 09 Sep 2021 00:42:31 +0000
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
To:     Phillip Potter <phil@philpotter.co.uk>, hch@infradead.org
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org, lumip@lumip.de
References: <YTcILRYw/AKen0X4@infradead.org>
 <20210909001721.2030-1-phil@philpotter.co.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
Date:   Wed, 8 Sep 2021 17:42:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909001721.2030-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 5:17 PM, Phillip Potter wrote:
>>> +static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
>>> +		unsigned long arg)
>>> +{
>>> +	int ret;
>>> +	struct cdrom_timed_media_change_info __user *info;
>>> +	struct cdrom_timed_media_change_info tmp_info;
>>> +
>>> +	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
>>> +		return -ENOSYS;
>>> +
>>> +	info = (struct cdrom_timed_media_change_info __user *)arg;
>>> +	cd_dbg(CD_DO_IOCTL, "entering CDROM_TIMED_MEDIA_CHANGE\n");
>>> +
>>> +	ret = cdrom_ioctl_media_changed(cdi, CDSL_CURRENT);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	if (copy_from_user(&tmp_info, info, sizeof(tmp_info)) != 0)
>>> +		return -EFAULT;
>>> +
>>> +	tmp_info.has_changed = ((tmp_info.last_media_change - cdi->last_media_change_ms) < 0);
>>
> Dear Christoph,
> 
> Sorry didn't see this e-mail before I replied to Lukas, so I hope you
> don't think I was ignoring you :-)
> 
>> Overly long line here, but more importantly this is much cleaner with
>> a good old if:
>>
>>
>> 	if (tmp_info.last_media_change - cdi->last_media_change_ms) < 0)
>> 		tmp_info.has_changed = 1;
>>
> 
> Whilst I don't disagree this is technically cleaner, the existing style
> certainly read well to me. In terms of line length, checkpatch doesn't
> complain about it, so I guess you mean purely from a visual perspective?

Documentation/process/coding-style.rst says:

   The preferred limit on the length of a single line is 80 columns.

checkpatch only checks lines > 100 columns since that is OK in a few
cases, like a long quoted string.

So try to limit line lengths to 80 columns unless there is some
other reason not to do that.

>>> +{
>>> +	__s64	last_media_change;	/* Timestamp of the last detected media
>>> +					 * change in ms. May be set by caller, updated
>>> +					 * upon successful return of ioctl.
>>> +					 */
>>> +	__u64	has_changed;		/* Set to 1 by ioctl if last detected media
>>
>> More overly long lines.  Also why is has_changed a u64 if it is used as
>> a boolean flag?

Might as well be explicit about it and also make it obvious that there
is some space available for other fields.

thanks.
-- 
~Randy

