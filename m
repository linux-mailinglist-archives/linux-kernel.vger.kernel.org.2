Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C894020A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 22:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhIFUMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 16:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhIFUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 16:12:47 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80823C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 13:11:42 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a13so9956618iol.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zAdXfDTvryQt4FtZIaGOXyUST/diufZ95iA28xgBTpo=;
        b=IISLLH1wSSkJZ36CYwONT85esiu9Hqum+xe4Imku6mkZWyZxEVc6gEPOqTM4MPsY1L
         87zIVLUooi3GGAM9Hj8Ig0mZ/MeaIclnAu8AA5gPb+dzJcI6meegA6/ZqZ56aUSdupKG
         uuLm2lJlI994SQ2liedhBdsNAt0ylRxl9G2vEmWvHtkGlt8g0cMrjjXooW86zXKmxaUR
         7TkKf4ryIgkiYAXVaSQphR9Um2MZry/9arLMrCiQG4rpfBfIlaHJphJN5YdUaLT0WApq
         XZbTxTyU5t4mPKsz50igacZj3b4bP2l13G3EHKinGm6cJ8mFyPnwFotxv6FmVfQvjDoD
         TzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zAdXfDTvryQt4FtZIaGOXyUST/diufZ95iA28xgBTpo=;
        b=tiuKoe8uevTBmtmsYIvwiiavN+Ur5rA/vf7UhtQ83bnUWZsYLHRfWWFAWVSYepzuBL
         rm6E6T1N33HCvVK5WyAUeXUiF/abKfaN4DaAw1K1eZSF8xZcYid+0a/NuviU6SZYQSE2
         MVFUCZKuE+nZZLMRlAqFxhUy0nTqDLHAOboH98iCpGnbCVLGGc8j8yJeiGYvJoDmYHgk
         HKBt+//SHzlf/iPuD712JEK7CRJ5S+g1NuBGm8x74vfu18l0QPh7hQdjrdCFmWkJrt25
         jBZQvoFRoU0Uu1pH+psVQnLSuwS6Fo19wTZ7XBPwL2hyjADDLgQLyC3RsXFH2Y7QGBxo
         DwBA==
X-Gm-Message-State: AOAM5309YLUyQejFVhejWXJ/SagdKWcwkNeZ5/A68mNwiGF6CjsGJLW1
        xUg7DjvvwtUL8uH09olNbkU/2A==
X-Google-Smtp-Source: ABdhPJyJ+lKrjL2cXtHBj0R7rU6d6dd0NTzj3eR+lEmyRgYKPArFo2Du1/tDV2zP2jLLqjH8samxtw==
X-Received: by 2002:a02:ad17:: with SMTP id s23mr12072768jan.135.1630959101382;
        Mon, 06 Sep 2021 13:11:41 -0700 (PDT)
Received: from [172.19.131.146] ([8.46.73.118])
        by smtp.gmail.com with ESMTPSA id u10sm5111611ilg.15.2021.09.06.13.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 13:11:41 -0700 (PDT)
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
To:     Lukas Prediger <lumip@lumip.de>
Cc:     linux-kernel@vger.kernel.org,
        Phillip Potter <phil@philpotter.co.uk>
References: <20210829143735.512146-1-lumip@lumip.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65bf6d1a-f65d-910c-60c7-0a4911a52e9a@kernel.dk>
Date:   Mon, 6 Sep 2021 14:11:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210829143735.512146-1-lumip@lumip.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 8:37 AM, Lukas Prediger wrote:
> The current implementation of the CDROM_MEDIA_CHANGED ioctl relies on
> global state, meaning that only one process can detect a disc change
> while the ioctl call will return 0 for other calling processes afterwards
> (see bug 213267 ).
> 
> This introduces a new cdrom ioctl, CDROM_TIMED_MEDIA_CHANGE, that
> works by maintaining a timestamp of the last detected disc change instead
> of a boolean flag: Processes calling this ioctl command can provide
> a timestamp of the last disc change known to them and receive
> an indication whether the disc was changed since then and the updated
> timestamp.
> 
> I considered fixing the buggy behavior in the original
> CDROM_MEDIA_CHANGED ioctl but that would require maintaining state
> for each calling process in the kernel, which seems like a worse
> solution than introducing this new ioctl.

This looks pretty good to me now. Adding Phillip to the CC, he's the new
CDROM maintainer. Leaving the rest of the message below intact because
of that.


> Signed-off-by: Lukas Prediger <lumip@lumip.de>
> ---
> Second version based on your feedback for the first
> attempt. Please let me know if further changes are required.
> ---
>  Documentation/cdrom/cdrom-standard.rst      | 11 ++++
>  Documentation/userspace-api/ioctl/cdrom.rst |  3 ++
>  drivers/cdrom/cdrom.c                       | 56 +++++++++++++++++++--
>  include/linux/cdrom.h                       |  1 +
>  include/uapi/linux/cdrom.h                  | 15 ++++++
>  5 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/cdrom/cdrom-standard.rst b/Documentation/cdrom/cdrom-standard.rst
> index 5845960ca382..52ea7b6b2fe8 100644
> --- a/Documentation/cdrom/cdrom-standard.rst
> +++ b/Documentation/cdrom/cdrom-standard.rst
> @@ -907,6 +907,17 @@ commands can be identified by the underscores in their names.
>  	specifies the slot for which the information is given. The special
>  	value *CDSL_CURRENT* requests that information about the currently
>  	selected slot be returned.
> +`CDROM_TIMED_MEDIA_CHANGE`
> +	Checks whether the disc has been changed since a user supplied time
> +	and returns the time of the last disc change.
> +
> +	*arg* is a pointer to a *cdrom_timed_media_change_info* struct.
> +	*arg->last_media_change* may be set by calling code to signal
> +	the timestamp of the last known media change (by the caller).
> +	Upon successful return, this ioctl call will set
> +	*arg->last_media_change* to the latest media change timestamp (in ms)
> +	known by the kernel/driver and set *arg->has_changed* to 1 if
> +	that timestamp is more recent than the timestamp set by the caller.
>  `CDROM_DRIVE_STATUS`
>  	Returns the status of the drive by a call to
>  	*drive_status()*. Return values are defined in cdrom_drive_status_.
> diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> index 3b4c0506de46..bac5bbf93ca0 100644
> --- a/Documentation/userspace-api/ioctl/cdrom.rst
> +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> @@ -54,6 +54,9 @@ are as follows:
>  	CDROM_SELECT_SPEED	Set the CD-ROM speed
>  	CDROM_SELECT_DISC	Select disc (for juke-boxes)
>  	CDROM_MEDIA_CHANGED	Check is media changed
> +	CDROM_TIMED_MEDIA_CHANGE	Check if media changed
> +					since given time
> +					(struct cdrom_timed_media_change_info)
>  	CDROM_DRIVE_STATUS	Get tray position, etc.
>  	CDROM_DISC_STATUS	Get disc type, etc.
>  	CDROM_CHANGER_NSLOTS	Get number of slots
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index feb827eefd1a..a040a867f6a2 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -344,6 +344,12 @@ static void cdrom_sysctl_register(void);
>  
>  static LIST_HEAD(cdrom_list);
>  
> +static void signal_media_change(struct cdrom_device_info *cdi)
> +{
> +	cdi->mc_flags = 0x3; /* set media changed bits, on both queues */
> +	cdi->last_media_change_ms = ktime_to_ms(ktime_get());
> +}
> +
>  int cdrom_dummy_generic_packet(struct cdrom_device_info *cdi,
>  			       struct packet_command *cgc)
>  {
> @@ -616,6 +622,7 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
>  	ENSURE(cdo, generic_packet, CDC_GENERIC_PACKET);
>  	cdi->mc_flags = 0;
>  	cdi->options = CDO_USE_FFLAGS;
> +	cdi->last_media_change_ms = ktime_to_ms(ktime_get());
>  
>  	if (autoclose == 1 && CDROM_CAN(CDC_CLOSE_TRAY))
>  		cdi->options |= (int) CDO_AUTO_CLOSE;
> @@ -1421,8 +1428,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
>  		cdi->ops->check_events(cdi, 0, slot);
>  
>  	if (slot == CDSL_NONE) {
> -		/* set media changed bits, on both queues */
> -		cdi->mc_flags = 0x3;
> +		signal_media_change(cdi);
>  		return cdrom_load_unload(cdi, -1);
>  	}
>  
> @@ -1455,7 +1461,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
>  		slot = curslot;
>  
>  	/* set media changed bits on both queues */
> -	cdi->mc_flags = 0x3;
> +	signal_media_change(cdi);
>  	if ((ret = cdrom_load_unload(cdi, slot)))
>  		return ret;
>  
> @@ -1521,7 +1527,7 @@ int media_changed(struct cdrom_device_info *cdi, int queue)
>  	cdi->ioctl_events = 0;
>  
>  	if (changed) {
> -		cdi->mc_flags = 0x3;    /* set bit on both queues */
> +		signal_media_change(cdi);
>  		ret |= 1;
>  		cdi->media_written = 0;
>  	}
> @@ -2391,6 +2397,46 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
>  	return ret;
>  }
>  
> +/*
> + * Media change detection with timing information.
> + *
> + * arg is a pointer to a cdrom_timed_media_change_info struct.
> + * arg->last_media_change may be set by calling code to signal
> + * the timestamp (in ms) of the last known media change (by the caller).
> + * Upon successful return, ioctl call will set arg->last_media_change
> + * to the latest media change timestamp known by the kernel/driver
> + * and set arg->has_changed to 1 if that timestamp is more recent
> + * than the timestamp set by the caller.
> + */
> +static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
> +		unsigned long arg)
> +{
> +	int ret;
> +	struct cdrom_timed_media_change_info __user *info;
> +	struct cdrom_timed_media_change_info tmp_info;
> +
> +	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
> +		return -ENOSYS;
> +
> +	info = (struct cdrom_timed_media_change_info __user *)arg;
> +	cd_dbg(CD_DO_IOCTL, "entering CDROM_TIMED_MEDIA_CHANGE\n");
> +
> +	ret = cdrom_ioctl_media_changed(cdi, CDSL_CURRENT);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_from_user(&tmp_info, info, sizeof(tmp_info)) != 0)
> +		return -EFAULT;
> +
> +	tmp_info.has_changed = ((tmp_info.last_media_change - cdi->last_media_change_ms) < 0);
> +	tmp_info.last_media_change = cdi->last_media_change_ms;
> +
> +	if (copy_to_user(info, &tmp_info, sizeof(*info)) != 0)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
>  		unsigned long arg)
>  {
> @@ -3375,6 +3421,8 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
>  		return cdrom_ioctl_eject_sw(cdi, arg);
>  	case CDROM_MEDIA_CHANGED:
>  		return cdrom_ioctl_media_changed(cdi, arg);
> +	case CDROM_TIMED_MEDIA_CHANGE:
> +		return cdrom_ioctl_timed_media_change(cdi, arg);
>  	case CDROM_SET_OPTIONS:
>  		return cdrom_ioctl_set_options(cdi, arg);
>  	case CDROM_CLEAR_OPTIONS:
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index f48d0a31deae..7c10b564db29 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -64,6 +64,7 @@ struct cdrom_device_info {
>  	int for_data;
>  	int (*exit)(struct cdrom_device_info *);
>  	int mrw_mode_page;
> +	__s64 last_media_change_ms;
>  };
>  
>  struct cdrom_device_ops {
> diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
> index 6c34f6e2f1f7..9b17868667ed 100644
> --- a/include/uapi/linux/cdrom.h
> +++ b/include/uapi/linux/cdrom.h
> @@ -147,6 +147,8 @@
>  #define CDROM_NEXT_WRITABLE	0x5394	/* get next writable block */
>  #define CDROM_LAST_WRITTEN	0x5395	/* get last block written on disc */
>  
> +#define CDROM_TIMED_MEDIA_CHANGE   0x5396  /* get the timestamp of the last media change */
> +
>  /*******************************************************
>   * CDROM IOCTL structures
>   *******************************************************/
> @@ -295,6 +297,19 @@ struct cdrom_generic_command
>  	};
>  };
>  
> +/* This struct is used by CDROM_TIMED_MEDIA_CHANGE */
> +struct cdrom_timed_media_change_info
> +{
> +	__s64	last_media_change;	/* Timestamp of the last detected media
> +					 * change in ms. May be set by caller, updated
> +					 * upon successful return of ioctl.
> +					 */
> +	__u64	has_changed;		/* Set to 1 by ioctl if last detected media
> +					 * change was more recent than
> +					 * last_media_change set by caller.
> +					 */
> +};
> +
>  /*
>   * A CD-ROM physical sector size is 2048, 2052, 2056, 2324, 2332, 2336, 
>   * 2340, or 2352 bytes long.  
> 


-- 
Jens Axboe

