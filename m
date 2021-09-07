Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA94024DB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbhIGIHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhIGIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:07:15 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F24C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:06:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x19so7540002pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d/01MhQ8az2KsubiJsXOE3GvtoJpq/UsCghzy97xeIs=;
        b=W19V4SgXaBhfcRGI/YwgIiW/M2fm7L1sufN3+pvLeME1PocoeRMqHFIDgCEewYloKj
         7YAf3uH8dsYXb2wMrtXZRieaQUK9AUSZWosPfSgVZNwa1kJT451vaCAmZCHW+DGQEGk1
         1x3/rX6eePZmta2/oXgPHbyAQ5IVqPudQfyS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/01MhQ8az2KsubiJsXOE3GvtoJpq/UsCghzy97xeIs=;
        b=KngLpFgZfrzbhzIXJRLT8QfcCQ9nz+OBOe9TJwEhRPchmC0JboXREU178iN/CN2GnO
         Lg1O+mNgVlEkBNifd6gIHsfkCPf4AO0SKcCVNf7TX4K4jukbEM3gfMSM8zlsZ/i8CCal
         eiDp8hkls6OK9WMMiXtQTJT0gPt00RBe+e6ce9anniysNi5IbuHRet5x7CB6F7bxgF46
         jKUiqgK5JYKIk7I1tD+zcMX9/GkypkVX11Og610tn3O3gT2EhpT+1gVdyoXB2TDMltus
         ZB8txu4F2uYSXxXE2hez9/9G+iXqWoQIHbS2pZ0wEKn7DbgSKQFn11mLUGkByqTX0kLz
         tWdQ==
X-Gm-Message-State: AOAM53017HOXOrCF0vAEsRwvSQOAWEzZWjVN4gWS/KrLAbnfd/mhR3kg
        vgK8NYqVd+Z8QMbMC4FHjQCYYw==
X-Google-Smtp-Source: ABdhPJzDWNJzzE/YtzGMdaNz0PvSy18J7L4YpoLZeYLWSPCsDqC8NkD4y8/HKcmvH/NgmO1zF7ZKbA==
X-Received: by 2002:a62:5297:0:b0:3f4:263a:b078 with SMTP id g145-20020a625297000000b003f4263ab078mr15565156pfb.20.1631001969331;
        Tue, 07 Sep 2021 01:06:09 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4040:44a5:1453:e72c])
        by smtp.gmail.com with ESMTPSA id g3sm9838015pfi.197.2021.09.07.01.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 01:06:08 -0700 (PDT)
Date:   Tue, 7 Sep 2021 17:06:04 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ksmbd: remove unnecessary conditions
Message-ID: <YTcdbOgmB7758K+/@google.com>
References: <20210907073428.GD18254@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907073428.GD18254@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/09/07 10:34), Dan Carpenter wrote:
>  
>  		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
> -		if (id >= 0) {
> -			/*
> -			 * Translate raw sid into kuid in the server's user
> -			 * namespace.
> -			 */
> -			uid = make_kuid(&init_user_ns, id);
> -
> -			/* If this is an idmapped mount, apply the idmapping. */
> -			uid = kuid_from_mnt(user_ns, uid);
> -			if (uid_valid(uid)) {
> -				fattr->cf_uid = uid;
> -				rc = 0;
> -			}
> +		/*
> +		 * Translate raw sid into kuid in the server's user
> +		 * namespace.
> +		 */
> +		uid = make_kuid(&init_user_ns, id);

Can make_kuid() return INVALID_UID? IOW, uid_valid(uid) here as well?

> +
> +		/* If this is an idmapped mount, apply the idmapping. */
> +		uid = kuid_from_mnt(user_ns, uid);
> +		if (uid_valid(uid)) {
> +			fattr->cf_uid = uid;
> +			rc = 0;
>  		}

[..]

> +		/*
> +		 * Translate raw sid into kgid in the server's user
> +		 * namespace.
> +		 */
> +		gid = make_kgid(&init_user_ns, id);

Ditto.

> +		/* If this is an idmapped mount, apply the idmapping. */
> +		gid = kgid_from_mnt(user_ns, gid);
> +		if (gid_valid(gid)) {
> +			fattr->cf_gid = gid;
> +			rc = 0;
