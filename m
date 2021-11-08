Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6B9449C98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbhKHTk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 14:40:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237689AbhKHTk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 14:40:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 457096023D;
        Mon,  8 Nov 2021 19:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636400291;
        bh=eOvYYuUqHgmkEwJXqrsJPIzcicxL4jgciYvjJJbPF5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azoZfeQMePT9oZ0ohwUg5i69YqpODKwwPc4KofPFU1u9/ciSYQTXKaP6Ge/ingUZW
         L8SLsYQr3MKlkxmBmNdZkJJCF9Q1IuinYgkvX84qMTtLto2GAqhyJtztodFHNZmsNZ
         lAlRVBviwcFL0nM1wSkLcVTYAcFEwtDHRrCZmFREr4IE9dBMdYYf0gskqQceH0TohH
         bhRs2uqCkYJvEDgDcsYiWmxxezFjVVgaeyoqD0jrkpBf65A+MDAE9bKdriv+Xlnnif
         md7ffy2afW4uEyGaIm4aVJd+/GGJsWDa+bqxK/SIKA+u+HUazokC9srq4xgr6dylXW
         TtrCjFZD1GeFQ==
Date:   Mon, 8 Nov 2021 11:38:09 -0800
From:   Mark Gross <markgross@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     markpearson@lenovo.com, hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: think-lmi: Abort probe on analyze failure
Message-ID: <20211108193809.GH61200@T470>
References: <163639463588.1330483.15850167112490200219.stgit@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163639463588.1330483.15850167112490200219.stgit@omen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 11:03:57AM -0700, Alex Williamson wrote:
> A Lenovo ThinkStation S20 (4157CTO BIOS 60KT41AUS) fails to boot on
> recent kernels including the think-lmi driver, due to the fact that
> errors returned by the tlmi_analyze() function are ignored by
> tlmi_probe(), where  tlmi_sysfs_init() is called unconditionally.
> This results in making use of an array of already freed, non-null
> pointers and other uninitialized globals, causing all sorts of nasty
> kobject and memory faults.
> 
> Make use of the analyze function return value, free a couple leaked
> allocations, and remove the settings_count field, which is incremented
> but never consumed.
part of me would like to see this split into 2 patches, one to fix the memory
leaks, and one to fix the boot issue.  But, its so small its hard to argue for
splitting up.

Looks good enough to me:

Reviewed-by: Mark Gross <markgross@kernel.org>

> 
> Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support on Lenovo platforms")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/platform/x86/think-lmi.c |   13 ++++++++++---
>  drivers/platform/x86/think-lmi.h |    1 -
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 9472aae72df2..c4d9c45350f7 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -888,8 +888,10 @@ static int tlmi_analyze(void)
>  			break;
>  		if (!item)
>  			break;
> -		if (!*item)
> +		if (!*item) {
> +			kfree(item);
>  			continue;
> +		}
>  
>  		/* It is not allowed to have '/' for file name. Convert it into '\'. */
>  		strreplace(item, '/', '\\');
> @@ -902,6 +904,7 @@ static int tlmi_analyze(void)
>  		setting = kzalloc(sizeof(*setting), GFP_KERNEL);
>  		if (!setting) {
>  			ret = -ENOMEM;
> +			kfree(item);
>  			goto fail_clear_attr;
>  		}
>  		setting->index = i;
> @@ -916,7 +919,6 @@ static int tlmi_analyze(void)
>  		}
>  		kobject_init(&setting->kobj, &tlmi_attr_setting_ktype);
>  		tlmi_priv.setting[i] = setting;
> -		tlmi_priv.settings_count++;
>  		kfree(item);
>  	}
>  
> @@ -983,7 +985,12 @@ static void tlmi_remove(struct wmi_device *wdev)
>  
>  static int tlmi_probe(struct wmi_device *wdev, const void *context)
>  {
> -	tlmi_analyze();
> +	int ret;
> +
> +	ret = tlmi_analyze();
> +	if (ret)
> +		return ret;
> +
>  	return tlmi_sysfs_init();
>  }
>  
> diff --git a/drivers/platform/x86/think-lmi.h b/drivers/platform/x86/think-lmi.h
> index f8e26823075f..2ce5086a5af2 100644
> --- a/drivers/platform/x86/think-lmi.h
> +++ b/drivers/platform/x86/think-lmi.h
> @@ -55,7 +55,6 @@ struct tlmi_attr_setting {
>  struct think_lmi {
>  	struct wmi_device *wmi_device;
>  
> -	int settings_count;
>  	bool can_set_bios_settings;
>  	bool can_get_bios_selections;
>  	bool can_set_bios_password;
> 
> 
