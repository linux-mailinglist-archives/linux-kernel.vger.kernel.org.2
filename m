Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B08C3DB4E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhG3IHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhG3IG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:06:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE7C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:06:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d1so10193464pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zm9ze6NcDMmKTtzUJRmbUQg85ybXUDcN1daZdih1WjE=;
        b=onZBHEQbJavX+A5KRaetjgjzUwDmd3WCx9N9tbq25vGwq8nGrSKPYOUZvsmHEyOmWZ
         M+OOTZh5N2bVPdOJKKUW0J6lyGyB/gqr98pG3kRWp6HVtXZtkS3klXocUCX+WCWIt8oD
         +6eXSNqMZPOHcBKpetSx0mhW+ZpAp4LEt9PFIRVm/NHWfWJXAsy73etXU6K85KQHqWLb
         JaycqPhwfCq4En3t7KTHKtpBJWWDjmhnH8ugeLZwoW4SCKMBPDZWv3g69zS2Txoyi3z0
         /ajIPha64CrownvM58gbSPAOQ7kcQVbDTAw8K5AVvnznWduE+XeeQTiQbAed6jWcke8j
         jweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zm9ze6NcDMmKTtzUJRmbUQg85ybXUDcN1daZdih1WjE=;
        b=kOrxiMzrD6dlasHOIouIH2GLNlsSpEVJgIGgXnX1y5XiA6phKDAaGyE/0ZMYRDTPBd
         dOhnbwAy26a7QNrrRJYQ0q33Jy6ndgCzZjJl7wFHKz766Tp5Lt0Q6gcrIhFBjRzKMT3h
         3bTK6oRoR6rglov3GslKJw6mO1hX9162Q5oZwg97CXvzO9a03ZYOo4IapXx1QoAFdu9h
         JSEsFsXPGD6tTVgvg9OATA7jLgeAn8Yh6kUA1caqHHd7wP9NH2EWuj4MxM/J9QxABMvs
         ELH1gXFjoMb62f/tYkGNxNBtHt4BGHpEb+eJPIt8K/XH15OSfag4BLlBuOdbbxXo6SEX
         Me7Q==
X-Gm-Message-State: AOAM532SCuuqccbIzP1cQS6ogQBv0XUJoDXmUwjN18jHHjU9ithJImM3
        WZasBBIA78inLth7qKqsxMo=
X-Google-Smtp-Source: ABdhPJyjRArgqkf3xuf3FtJ1loWdS7BbIoDktTv4OVnTPGAPLzlWFDLZqp+Y+Y7pidu7lZiihP0LDQ==
X-Received: by 2002:a63:5506:: with SMTP id j6mr1211210pgb.19.1627632410498;
        Fri, 30 Jul 2021 01:06:50 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id e8sm1295050pfm.218.2021.07.30.01.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 01:06:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm: add lockdep assert to
 drm_is_current_master_locked
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
 <20210730041515.1430237-3-desmondcheongzx@gmail.com>
 <YQOXTW8kSHdNjhiY@boqun-archlinux>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <35518f4b-5e4a-b284-1f86-5cba64941211@gmail.com>
Date:   Fri, 30 Jul 2021 16:06:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQOXTW8kSHdNjhiY@boqun-archlinux>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/7/21 2:08 pm, Boqun Feng wrote:
> On Fri, Jul 30, 2021 at 12:15:15PM +0800, Desmond Cheong Zhi Xi wrote:
>> In drm_is_current_master_locked, accessing drm_file.master should be
>> protected by either drm_file.master_lookup_lock or
>> drm_device.master_mutex. This was previously awkward to assert with
>> lockdep.
>>
>> Following patch ("locking/lockdep: Provide lockdep_assert{,_once}()
>> helpers"), this assertion is now convenient so we add it in.
>>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> ---
>>   drivers/gpu/drm/drm_auth.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
>> index 9c24b8cc8e36..6f4d7ff23c80 100644
>> --- a/drivers/gpu/drm/drm_auth.c
>> +++ b/drivers/gpu/drm/drm_auth.c
>> @@ -63,9 +63,9 @@
>>   
>>   static bool drm_is_current_master_locked(struct drm_file *fpriv)
>>   {
>> -	/* Either drm_device.master_mutex or drm_file.master_lookup_lock
>> -	 * should be held here.
>> -	 */
>> +	lockdep_assert_once(lockdep_is_held(&fpriv->master_lookup_lock) ||
>> +			    lockdep_is_held(&fpriv->minor->dev->master_mutex));
>> +
> 
> I think it's better to also add the lockdep_assert() of & (i.e. both
> held) in the updater side, and have comments pointing to each other.
> 
> Is it convenient to do in this patchset? If the updater side doesn't
> need to put the lockdep_assert() (maybe the lock acquire code and the
> update code are in the same function), it's still better to add some

Thanks for the feedback, Boqun.

Yeah, I think the updater side maybe doesn't need new lockdep_assert()
because what currently happens is either

	lockdep_assert_held_once(&dev->master_mutex);
	/* 6 lines of prep */
	spin_lock(&fpriv->master_lookup_lock);
	fpriv->master = new_value;
or
	mutex_lock(&dev->master_mutex);
	/* 3 lines of checks */
		spin_lock(&file_priv->master_lookup_lock);
		file_priv->master = new_value;

> comments like:
> 
> 	/*
> 	 * To update drm_file.master, both drm_file.master_lookup_lock
> 	 * and drm_device.master_mutex are needed, therefore holding
> 	 * either of them is safe and enough for the read side.
> 	 */
> 
> Just feel it's better to explain the lock design either in the
> lockdep_assert() or comments.
> 

But clarifying the lock design in the documentation sounds like a really
good idea.

Probably a good place for this would be in the kerneldoc where we also
explain the lifetime rules and usage of the pointer outside drm_auth.c:

diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 726cfe0ff5f5..a3acb7ac3550 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -233,6 +233,10 @@ struct drm_file {
  	 * this only matches &drm_device.master if the master is the currently
  	 * active one.
  	 *
+	 * To update @master, both &drm_device.master_mutex and
+	 * @master_lookup_lock need to be held, therefore holding either of
+	 * them is safe and enough for the read side.
+	 *
  	 * When dereferencing this pointer, either hold struct
  	 * &drm_device.master_mutex for the duration of the pointer's use, or
  	 * use drm_file_get_master() if struct &drm_device.master_mutex is not

Best wishes,
Desmond

> Regards,
> Boqun
> 
>>   	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
>>   }
>>   
>> -- 
>> 2.25.1
>>

