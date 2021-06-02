Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD99B39815C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhFBGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:48:57 -0400
Received: from mail1.perex.cz ([77.48.224.245]:36674 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhFBGsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:48:55 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9B59FA003F;
        Wed,  2 Jun 2021 08:47:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9B59FA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1622616430; bh=9oZydlE7ZvsDH6T9qh0iMZKszEstZjjcoeV/i59z/mE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M2C6beweJKaC2OtGnhH8ZlHfEitgurkfioMrWGLO3yHZrVOeHi0nDavbWPLAIzGaF
         kdMhKP9KO5i1XnOua7KzrGJpqA0cS2i5AozuSx59u1uu/+rPfZJWztqlKKzVhouRQT
         vr23yqiL0CihyZawpR6EH90q0w/AAiov7hiBiNsY=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed,  2 Jun 2021 08:47:04 +0200 (CEST)
Subject: Re: [PATCH v2] ALSA: control led: fix memory leak in
 snd_ctl_led_register
To:     Dongliang Mu <mudongliangabcd@gmail.com>, tiwai@suse.com,
        dan.carpenter@oracle.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
References: <20210602034136.2762497-1-mudongliangabcd@gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <1032c823-90aa-0144-eb7a-ff1a019c3094@perex.cz>
Date:   Wed, 2 Jun 2021 08:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602034136.2762497-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 06. 21 5:41, Dongliang Mu wrote:
> The snd_ctl_led_sysfs_add and snd_ctl_led_sysfs_remove should contain
> the refcount operations in pair. However, snd_ctl_led_sysfs_remove fails
> to decrease the refcount to zero, which causes device_release never to
> be invoked. This leads to memory leak to some resources, like struct
> device_private. In addition, we also free some other similar memory
> leaks in snd_ctl_led_init/snd_ctl_led_exit.
> 
> Fix this by replacing device_del to device_unregister
> in snd_ctl_led_sysfs_remove/snd_ctl_led_init/snd_ctl_led_exit.
> 
> Note that, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device will
> call kobject_release and delay the release of kobject, which will cause
> use-after-free when the memory backing the kobject is freed at once.
> 
> Reported-by: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com
> Fixes: a135dfb5de1 ("ALSA: led control - add sysfs kcontrol LED marking layer")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Many thanks to you and Dan to cover this.

Revieved-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
