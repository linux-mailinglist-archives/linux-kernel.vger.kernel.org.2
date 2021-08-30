Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBCC3FB6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhH3N35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 09:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhH3N3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630330138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ez+5k1TtNoI6nPh1V3dLHo3m+sJYYxw8V1zq35K1XHI=;
        b=TY6K8hlT2vrz6V4K+M0EWNDjRSoEh7b2EbxjSdRZioM3pObHy439YBOhz27k0x5NbXqG9j
        81y8Sb3fmp4yeg0sLU4Tm2oPtF4P5ssNDHPWXcKidYDtoSVQqgkVpwlO8XvOdIaQBmS5VK
        1IeRUbfJ0sywlYyQfMu5rpVDlguuuNk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-VTVQhEtWMnmdertodZRWQw-1; Mon, 30 Aug 2021 09:28:56 -0400
X-MC-Unique: VTVQhEtWMnmdertodZRWQw-1
Received: by mail-wr1-f72.google.com with SMTP id h15-20020adff18f000000b001574654fbc2so3334430wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ez+5k1TtNoI6nPh1V3dLHo3m+sJYYxw8V1zq35K1XHI=;
        b=oQtvjpXmvVSbMSfpA6Z28oXeISn1pu8+TS7VPUnQDoR/pz+EjGG+dPLm+qTCv3ATFP
         4Pru3LjLUPYOl0xnxPB9d+EwNCj5auw4aQqUSlE1XiH5Lkrka2yWBnykIPU6iH+XO6xT
         LSQCuPbF+FXb2QzuwH/xVgi4NtGePKDSO6TwK+D0yksgIAUuxYJan0iT2WX1IQRzElfG
         kCmMb0LXa4kjN4h1++tZlZyx+ow2YA3vr6f9wjIOxSyEFL83N1TVu66UIRuwiGYlwlZq
         HyN+1joMbWcSWgMBXr4kk8kGIwLY2f2/hXGNpN0zXfJNQD8HAC1CdZR8rwSTWrLpkFjY
         zFQA==
X-Gm-Message-State: AOAM5329vcOtQ02vRiStSXRqbblqt7cDdTYPfLYvvmbJP3NjDsJBSSBE
        JnR7XFUFjvtoukpoL9qcJCXxxPoNz74AuZwmXUakhWAiGnbP/CBD+u4/uEGvwJ7UNtWwSi2eKKE
        K0rTFIR1mqYiEvRNmO0QNe3eS
X-Received: by 2002:a1c:2289:: with SMTP id i131mr4000649wmi.179.1630330135714;
        Mon, 30 Aug 2021 06:28:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+OujoBEbeY80CshwjTryhEU5GAUZs42gyK9zP8YR4b7TAWZsaMsMYLK4KfjVFVTq48leoTA==
X-Received: by 2002:a1c:2289:: with SMTP id i131mr4000637wmi.179.1630330135566;
        Mon, 30 Aug 2021 06:28:55 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de? ([2a0c:5a80:3c08:b500:afb2:5ebc:3fd2:26de])
        by smtp.gmail.com with ESMTPSA id g136sm10584091wmg.30.2021.08.30.06.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 06:28:55 -0700 (PDT)
Message-ID: <b7e9dc19babef0e6993fa95be183c598a2f49bbd.camel@redhat.com>
Subject: Re: [RFC PATCH v2 3/4] drivers/auxdisplay: senshat Raspberry Pi
 Sense HAT display driver
From:   nsaenzju@redhat.com
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Date:   Mon, 30 Aug 2021 15:28:51 +0200
In-Reply-To: <20210820180801.561119-4-cmirabil@redhat.com>
References: <20210820180801.561119-1-cmirabil@redhat.com>
         <20210820180801.561119-4-cmirabil@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On Fri, 2021-08-20 at 14:08 -0400, Charles Mirabile wrote:
> This patch implements control of the 8x8 RGB LED matrix display.

It'd be nice to get a more information on the i2c interface, and what each byte
is supposed to represent.

> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---

[...]

> +static long sensehat_display_ioctl(struct file *filp, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	struct sensehat *sensehat = container_of(filp->private_data, struct sensehat, display.mdev);
> +	struct sensehat_display *sensehat_display = &sensehat->display;
> +	void __user *user_ptr = (void __user *)arg;
> +	u8 temp[GAMMA_SIZE];
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
> +		return -ERESTARTSYS;
> +	switch (cmd) {
> +	case SENSEDISP_IOGET_GAMMA:
> +		if (copy_to_user(user_ptr, sensehat_display->gamma, GAMMA_SIZE)) {
> +			ret = -EFAULT;
> +			goto out_unlock;
> +		}
> +		ret = 0;
> +		goto out_unlock;
> +	case SENSEDISP_IOSET_GAMMA:
> +		if (copy_from_user(temp, user_ptr, GAMMA_SIZE)) {
> +			ret = -EFAULT;
> +			goto out_unlock;
> +		}
> +		ret = 0;
> +		goto out_update;
> +	case SENSEDISP_IORESET_GAMMA:
> +		if (arg < GAMMA_DEFAULT || arg >= GAMMA_PRESET_COUNT) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +		memcpy(temp, gamma_presets[arg], GAMMA_SIZE);
> +		ret = 0;
> +		goto out_update;
> +	default:
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +out_update:
> +	memcpy(sensehat_display->gamma, temp, GAMMA_SIZE);
> +	sensehat_update_display(sensehat);
> +out_unlock:
> +	mutex_unlock(&sensehat_display->rw_mtx);
> +	return ret;
> +}
> +
> +static const struct file_operations sensehat_display_fops = {
> +	.owner		= THIS_MODULE,
> +	.llseek		= sensehat_display_llseek,
> +	.read		= sensehat_display_read,
> +	.write		= sensehat_display_write,
> +	.unlocked_ioctl	= sensehat_display_ioctl,
> +};

I doubt this approach will make it upstream. This should use an already
existing kernel interface, or if not good enough, extend it. I'm sure this is
not the first RGB led matrix to show up anyway. Maybe drivers/leds has
infrastructure to deal with this. Or else a fb device?

I presume you want to keep the IOCTL in order to be able to run RPi specific
aplications/libraries. It'll be up to them to change once we settle on a proper
way of handling this, not the other way around. Note that the RPi engineers
have always preffered using official kernel interfaces when available, so I
don't think this'll be problematic.

Regards,
Nicolas

