Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD8405C96
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbhIISId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:08:33 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.100]:12430 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhIISIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:08:32 -0400
Received: from [87.92.210.171] (helo=lumip-notebook.fritz.box)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <lumip@lumip.de>)
        id 1mOOS6-0006Fa-1U; Thu, 09 Sep 2021 20:07:10 +0200
From:   Lukas Prediger <lumip@lumip.de>
To:     rdunlap@infradead.org
Cc:     axboe@kernel.dk, hch@infradead.org, linux-kernel@vger.kernel.org,
        lumip@lumip.de, phil@philpotter.co.uk
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change detection
Date:   Thu,  9 Sep 2021 21:05:54 +0300
Message-Id: <20210909180553.8299-1-lumip@lumip.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
References: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: bHVrYXMucHJlZGlnZXJAbHVtaXAuZGU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christoph, Phillip and Randy,

thanks to you all for your comments!

>>>> +static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
>>>> +		unsigned long arg)
>>>> +{
>>>> +	int ret;
>>>> +	struct cdrom_timed_media_change_info __user *info;
>>>> +	struct cdrom_timed_media_change_info tmp_info;
>>>> +
>>>> +	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
>>>> +		return -ENOSYS;
>>>> +
>>>> +	info = (struct cdrom_timed_media_change_info __user *)arg;
>>>> +	cd_dbg(CD_DO_IOCTL, "entering CDROM_TIMED_MEDIA_CHANGE\n");
>>>> +
>>>> +	ret = cdrom_ioctl_media_changed(cdi, CDSL_CURRENT);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	if (copy_from_user(&tmp_info, info, sizeof(tmp_info)) != 0)
>>>> +		return -EFAULT;
>>>> +
>>>> +	tmp_info.has_changed = ((tmp_info.last_media_change - cdi->last_media_change_ms) < 0);
>>>
>>> Overly long line here, but more importantly this is much cleaner with
>>> a good old if:
>>>
>>>
>>> 	if (tmp_info.last_media_change - cdi->last_media_change_ms) < 0)
>>> 		tmp_info.has_changed = 1;
>>>
>> 
>> Whilst I don't disagree this is technically cleaner, the existing style
>> certainly read well to me. 

The if would additionally require to explicitly initialise .has_changed to
zero for the else case, so I favored the single assignment that covers
all cases. I don't have a strong opinion on this, though, so if the if variant
is generally favored, I can change this. (And I will definitely fix the overlength).

>> In terms of line length, checkpatch doesn't
>> complain about it, so I guess you mean purely from a visual perspective?
>
> Documentation/process/coding-style.rst says:
>
>    The preferred limit on the length of a single line is 80 columns.
>
> checkpatch only checks lines > 100 columns since that is OK in a few
> cases, like a long quoted string.
>
> So try to limit line lengths to 80 columns unless there is some
> other reason not to do that.

I wasn't aware that checkpatch.pl does not complain if I exceed the 80 cols,
have fixed those now for an upcoming resubmission.

>>> +{
>>> +	__s64	last_media_change;	/* Timestamp of the last detected media
>>> +					 * change in ms. May be set by caller, updated
>>> +					 * upon successful return of ioctl.
>>> +					 */
>>> +	__u64	has_changed;		/* Set to 1 by ioctl if last detected media
>>>
>>> More overly long lines.  Also why is has_changed a u64 if it is used as
>>> a boolean flag?
>>
>> As this is not a packed struct, would not a smaller value still take up
>> the same space?
>
> Might as well be explicit about it and also make it obvious that there
> is some space available for other fields.

I had this as a __u8 in the first submission but Jens asked me to change it.
From his feedback on this:

"The struct layout should be modified such that there are no holes or
padding in it. Probably just make the has_changed a flags thing, and
make it u64 as well. Then you can define bit 0 to be HAS_CHANGED, and
that leaves you room to add more flags in the future."
https://lore.kernel.org/lkml/6d6c533d-465e-33ee-5801-cb7ea84924a8@kernel.dk/

I changed it to __u64 to address this. We could think about turning it
back to a __u8 (or bool) and add some explicit padding members
(a __u8 reserved[3]?), but honestly I don't see much real benefit in that
compared to how it is now.

Best regards,
Lukas
