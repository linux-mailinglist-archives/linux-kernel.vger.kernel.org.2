Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E423A2915
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFJKNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:13:54 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39819 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFJKNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:13:52 -0400
Received: by mail-wm1-f41.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6167425wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ZeqK3HUGMU0I48g2CrdimQGpsG/P2Fm0SB2rJBA/ig=;
        b=aGMbzbK1h0Cd5C0t9Z3TF/pasVGK/w7r/+ch+aAz14hUy40O+6QVoqnFZNjaC55ljP
         4GUNwDrHQSKJlfOx8+UdoGm4fzDfKYDrlhtpHvPhS48xm1xIUrr8RoImy7ZCnPMAUjKw
         sgoqEt6SSmGZnYnIznUd1/Pf96LsWkqPvGayU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5ZeqK3HUGMU0I48g2CrdimQGpsG/P2Fm0SB2rJBA/ig=;
        b=APEleBz86hVXx/iKQqXwpEqeSX624PhkLkEO9q9bcWobJ7PfjTpwOafw40GtCk/zoM
         M/q3tyitIQC7xqMD6MxLv0ymoABr8HYcfpJ57Ow/YQN+pXdPs3EM/IaA30TnpYuV2UuX
         zA4cDTpnRwijHlf2P3CAQqS5MRlO+5iAVPDIDhUe56nrYkQFTzZtR9mj6pt/O/dPKZG7
         6zni41bAH3mTUDNGtt8JONMYsjM2duWaOrSohjDOuRg7+uk/W8VYqqwfmHQvFqIDdY2A
         oph4GNlNumP0tHEy9FapLeN3+GyFPWcomq6SbxPKx9xhg2C/DE6X0pfTTJPjcM9MD8fN
         ZhAg==
X-Gm-Message-State: AOAM533pAf7G3qMiNnp82zD/V7BSQylRMEuxV4rctCQivZsXW7syNoRd
        MMCcwdjnA+T4IBIn3iCL5fRY+w==
X-Google-Smtp-Source: ABdhPJx8m3+mYf6GO8iNd3ecqDNmRAG+tsOPxNYY58+AEcXlbsFNNcsRKOlwZ/kVSeNufh93SOrIVQ==
X-Received: by 2002:a1c:ed03:: with SMTP id l3mr4353737wmh.130.1623319856112;
        Thu, 10 Jun 2021 03:10:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f5sm3386554wrf.22.2021.06.10.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:10:55 -0700 (PDT)
Date:   Thu, 10 Jun 2021 12:10:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] drm: Lock pointer access in drm_master_release()
Message-ID: <YMHlLQHRLWgWlXTs@phenom.ffwll.local>
Mail-Followup-To: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210609092119.173590-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609092119.173590-1-desmondcheongzx@gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 05:21:19PM +0800, Desmond Cheong Zhi Xi wrote:
> This patch eliminates the following smatch warning:
> drivers/gpu/drm/drm_auth.c:320 drm_master_release() warn: unlocked access 'master' (line 318) expected lock '&dev->master_mutex'
> 
> The 'file_priv->master' field should be protected by the mutex lock to
> '&dev->master_mutex'. This is because other processes can concurrently
> modify this field and free the current 'file_priv->master'
> pointer. This could result in a use-after-free error when 'master' is
> dereferenced in subsequent function calls to
> 'drm_legacy_lock_master_cleanup()' or to 'drm_lease_revoke()'.
> 
> An example of a scenario that would produce this error can be seen
> from a similar bug in 'drm_getunique()' that was reported by Syzbot:
> https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803
> 
> In the Syzbot report, another process concurrently acquired the
> device's master mutex in 'drm_setmaster_ioctl()', then overwrote
> 'fpriv->master' in 'drm_new_set_master()'. The old value of
> 'fpriv->master' was subsequently freed before the mutex was unlocked.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

Thanks a lot. I've done an audit of this code, and I found another
potential problem in drm_is_current_master. The callers from drm_auth.c
hold the dev->master_mutex, but all the external ones dont. I think we
need to split this into a _locked function for use within drm_auth.c, and
the exported one needs to grab the dev->master_mutex while it's checking
master status. Ofc there will still be races, those are ok, but right now
we run the risk of use-after free problems in drm_lease_owner.

Are you up to do that fix too?

I think the drm_lease.c code also needs an audit, there we'd need to make
sure that we hold hold either the lock or a full master reference to avoid
the use-after-free issues here.

Patch merged to drm-misc-fixes with cc: stable.
-Daniel

> ---
>  drivers/gpu/drm/drm_auth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index f00e5abdbbf4..b59b26a71ad5 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -315,9 +315,10 @@ int drm_master_open(struct drm_file *file_priv)
>  void drm_master_release(struct drm_file *file_priv)
>  {
>  	struct drm_device *dev = file_priv->minor->dev;
> -	struct drm_master *master = file_priv->master;
> +	struct drm_master *master;
> 
>  	mutex_lock(&dev->master_mutex);
> +	master = file_priv->master;
>  	if (file_priv->magic)
>  		idr_remove(&file_priv->master->magic_map, file_priv->magic);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
