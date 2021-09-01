Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADC03FDDE8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbhIAOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:42:58 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36774 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbhIAOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:42:57 -0400
Received: by mail-wr1-f43.google.com with SMTP id q14so4923643wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 07:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=75eTzhMZRQumzcA86dOnNSzdyqipor7hBIbb15dKKgw=;
        b=ZNgfZxi8QhEGhrKwtJAqXkTmWSRfL+d0rBH+0zLG5QPcD2bdAza96pqTeNJeGhplpj
         ccyw+fF9A05Cg8deDhL5R25hiu+ejUM64kNqKmKvLsNT4hgO4qDsDl/fiQhVmX9i9Nam
         e3y15yM+xoJYg53/0+3N1ICvyV1f5LNL8MrO32Ewk8UtsO/F80eJtBW4HEqJElhkETo9
         uZXMgdrmobkbb00CItUApj2BtyVEU6L1pa/TP+D1hV99FTFMHas6cjRO7ERHTlImX7jL
         fPps49z2uvqOcv26KvQfChlsbnj7do6ugDwS0wBS3Krggf44b2sNImXAmoDFS04P4h+4
         TCpg==
X-Gm-Message-State: AOAM530WT52UG7EVKaL67s6BO4oUtFZhrSrnTRlT81wggRUN/lRg6R/7
        edVl5ez2clr1Hx40Ff0f458=
X-Google-Smtp-Source: ABdhPJyEJyVZM6vdLCp9873clDBls8KUS5Y+4MFspEO1g+MLQfiNrZ/rNYMODJaawdB/7e+MNUlr0Q==
X-Received: by 2002:adf:ba4d:: with SMTP id t13mr37812523wrg.424.1630507320183;
        Wed, 01 Sep 2021 07:42:00 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il. [109.186.228.184])
        by smtp.gmail.com with ESMTPSA id l7sm6058110wmj.9.2021.09.01.07.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 07:41:59 -0700 (PDT)
Subject: Re: [PATCH v1] nvme: avoid race in shutdown namespace removal
To:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20210830093618.97657-1-dwagner@suse.de>
 <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
 <742108c3-7c76-0bc3-fc13-06acf975c25c@suse.de>
 <YS+AYA+5/o8Qj08Q@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7677d695-aa57-ee91-3b32-65570cefdff4@grimberg.me>
Date:   Wed, 1 Sep 2021 17:41:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YS+AYA+5/o8Qj08Q@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Most likely. Do drop me a mail on how to create a reproducer for that; it's
>> not exactly trivial as you need to patch qemu for that
>> (and, of course, those patches will not go upstream as they again hit a
>> section which the maintainer deemed to be reworked any time now. So of
>> course he can't possibly apply them.)
>> (I seem to have a particular spell of bad luck, seeing that it's the _third_
>> time this happened to me :-( )
> 
> Soo.  What is the problem in simply checking in nvme_find_ns_head that
> h->list is non-empty?  E.g. this variant of the patch from Daniel:

Don't see why this won't work...

> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d535b00d65816..ce91655fa29bb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3523,7 +3523,9 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
>   	lockdep_assert_held(&subsys->lock);
>   
>   	list_for_each_entry(h, &subsys->nsheads, entry) {
> -		if (h->ns_id == nsid && nvme_tryget_ns_head(h))
> +		if (h->ns_id != nsid)
> +			continue;
> +		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
>   			return h;
>   	}
>   
> @@ -3835,7 +3837,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	mutex_unlock(&ns->ctrl->subsys->lock);
> +	if (list_empty(&ns->head->list)) {
> +		list_del_init(&ns->head->entry);
> +		last_path = true;
> +	}
> +	mutex_unlock(&ns->head->subsys->lock);
>   
>   	/* guarantee not available in head->list */
>   	synchronize_rcu();
> @@ -3855,13 +3861,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	list_del_init(&ns->list);
>   	up_write(&ns->ctrl->namespaces_rwsem);
>   
> -	/* Synchronize with nvme_init_ns_head() */
> -	mutex_lock(&ns->head->subsys->lock);
> -	if (list_empty(&ns->head->list)) {
> -		list_del_init(&ns->head->entry);
> -		last_path = true;
> -	}
> -	mutex_unlock(&ns->head->subsys->lock);
>   	if (last_path)
>   		nvme_mpath_shutdown_disk(ns->head);
>   	nvme_put_ns(ns);
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
