Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3B39C147
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhFDUZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:25:59 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:41703 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhFDUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:25:58 -0400
Received: by mail-wm1-f41.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so6285217wmq.0;
        Fri, 04 Jun 2021 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SOgSjwplSQaGaeKR78okqGy1QKXL8/7pkqKSZnhTCo4=;
        b=t87x6tZ048918Vgu34pX/qy6o29CJVE3leoxgprqo9EmsjdvAbpHHzEypY866q/0iP
         Drm4wPLjRXnxUtRcOKlKI/Yq6PQmGlquTTiPbcBRnQmwKz9Kkp7cdhIY6zhuojV1GfSP
         WxeYdAJeE69OkOZDMvnASAS3SfRRRLFYdg1jhyoSv8wsIwpo45UKmrmJ7qcOMdEHOplS
         hNESd0UrmX5knec4D8feVdGW0xkaA9ziIQFwRpHTFfpT+jFj223c1fWf6jab55LOcOZk
         0B1Ekxr9u+cdoOUVooscDwPNuIZLaS26+m2HKi1nrYUJifTuSI/sevdauEwAufncTYAm
         29Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SOgSjwplSQaGaeKR78okqGy1QKXL8/7pkqKSZnhTCo4=;
        b=R9dOL1hn5qnJ9arNiua1QzzC5/tUwRAhfYRlBD5rIqqcHl/9IIojQiFH1DdQ775+MD
         vqN+HfwrUZ2x8taQhmJK+JLbmpbhvxJp3QaLHdE30toOuZRZKxxmQvJ0I3t9Y+/TkDap
         4b6kYJN2zvHDj5hrzW3WOdgvcuy46rrbc5xenhnotSeE0VEYGWxnxQ5quMsuP7WYIz6t
         8zuzBWtBrik6U4VZH0rmSNcOVttVcwVFddQ/2efSEky43TgCjNQiCxpcnTLqu67VMYkF
         N1ay3U1bhSUR8YjjT9xz6iprqMJjvJ9cjuKUYdF7gyHGBwow9EfLviELkPi391rja5fg
         VORA==
X-Gm-Message-State: AOAM531pLy7Ft5GO4OEYAjdgl7HKgUu3RQRu2omOoQ7TlI7IOvnFrlJB
        gXxb1sXC9zUOGkInp26RILQ//2ntlZQ=
X-Google-Smtp-Source: ABdhPJxWeQeHa0LWDw82bHGU+XKLzPLptt9ieyfX9tY2uuk3ccOaeee1W7Evfs3urMXKedxqJj4yhA==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr5312430wmh.86.1622838179255;
        Fri, 04 Jun 2021 13:22:59 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id q19sm9298706wmc.44.2021.06.04.13.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 13:22:58 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] platform/surface: aggregator: Allow enabling of
 events without notifiers
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210604134755.535590-1-luzmaximilian@gmail.com>
 <20210604134755.535590-3-luzmaximilian@gmail.com>
 <44e65839-0ee5-98d3-20dd-edfc40f6818e@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <93470d5d-a720-8ed9-f050-65c16bb0fbca@gmail.com>
Date:   Fri, 4 Jun 2021 22:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <44e65839-0ee5-98d3-20dd-edfc40f6818e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 10:13 PM, Hans de Goede wrote:
> Hi,
> 
> On 6/4/21 3:47 PM, Maximilian Luz wrote:

[...]

>> +static int ssam_nf_refcount_enable(struct ssam_controller *ctrl,
>> +				   struct ssam_nf_refcount_entry *entry, u8 flags)
>> +{
>> +	const struct ssam_event_registry reg = entry->key.reg;
>> +	const struct ssam_event_id id = entry->key.id;
>> +	struct ssam_nf *nf = &ctrl->cplt.event.notif;
>> +	int status;
>> +
>> +	lockdep_assert_held(&nf->lock);
>> +
>> +	ssam_dbg(ctrl, "enabling event (reg: %#04x, tc: %#04x, iid: %#04x, rc: %d)\n",
>> +		 reg.target_category, id.target_category, id.instance, entry->refcount);
>> +
>> +	if (entry->refcount == 1) {
>> +		status = ssam_ssh_event_enable(ctrl, reg, id, flags);
>> +		if (status)
>> +			return status;
>> +
>> +		entry->flags = flags;
>> +
>> +	} else if (entry->flags != flags) {
>> +		ssam_warn(ctrl,
>> +			  "inconsistent flags when enabling event: got %#04x, expected %#04x (reg: %#04x, tc: %#04x, iid: %#04x)\n",
>> +			  flags, entry->flags, reg.target_category, id.target_category,
>> +			  id.instance);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ssam_nf_refcount_enable() - Disable event for reference count entry if it is
> 
> s/ssam_nf_refcount_enable/ssam_nf_refcount_disable_free/
> 
> No need to resend, I'll fix this up when merging this series.

Oh right, thanks!

Regards,
Max
