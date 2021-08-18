Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA223EFE50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhHRH4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238342AbhHRH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629273326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYRAiIatE3uIXVhGsrzHYNlVabGLMIXPtsHVU4zwers=;
        b=RM8dQVkP1XsKFCIfkhlsUJIh/Fx3eYQUnKMo8PZOVXIjRnMCnuLzC35y4/L5MvuWcuNwT4
        3ll+GFakHo03yLz5IfWZ4aGB17u+LkKEYDz8WpilGYGrzAYrDs43bVNAlYPwNwWkmOJU8F
        ps9fBdWwrahyFJQFIEQi8HEl7hoOWCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-SP69ypUdO9uQyp7jTfjP-A-1; Wed, 18 Aug 2021 03:55:25 -0400
X-MC-Unique: SP69ypUdO9uQyp7jTfjP-A-1
Received: by mail-wm1-f71.google.com with SMTP id b196-20020a1c80cd0000b02902e677003785so1935907wmd.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BYRAiIatE3uIXVhGsrzHYNlVabGLMIXPtsHVU4zwers=;
        b=B0IJKOFHe1t4q8pJ3WqsBXBgXOGqHLhj6nIV+nAPyj6MYxEl3IMwXCIRg6XGTupubr
         vI4wQmmp3TDRL4QY10pC1BYqnsHQfsTnPUCdHHO+rwVFpHOJtkdRApg2KxIZtUqgXHPT
         yXTzOQ4fc39z+fg1JF/okry3df2SbfJkRWH5aeTlQxfk7L2Fko0VO1M9oDgcKLVb9fp7
         8R3wH7muWdhr7wWywmQBKmHKsgJJXTSxY6VOxQFAHPGkGojSv+ayzuu7rg2cgvX1NyAz
         Hn67/tk3fI/egilMOw7x+lceLJxvrbUD0TaKg/9xVSMxTUCF5lzryybkYhYImnYo3HiG
         LVgg==
X-Gm-Message-State: AOAM530ilmtOFbu36Rl4haukQX+ge281kQaui8loVc72lbrTZkAJidw6
        O669lHfJsa7LuV7SJv2gEdkDpf4gdoFQMQh9POqFMX0euKD6f73bx2j+hcTYz7JVkIxY5JN7h01
        dBhPF/9HRqkWTmtiR99Ba4vCGw0cdjhwNVhbngvXYenNJvICvXMpzvy/lzGFIGKeJqIsDvL3L
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr6960275wmq.171.1629273324135;
        Wed, 18 Aug 2021 00:55:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykaIJUh3V6bo2I6EXx8+Adkp+WDStWpE1etNSQpAJhhF9uRfYxFYFKYgNeDxWvPw4aK9wI0g==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr6960251wmq.171.1629273323924;
        Wed, 18 Aug 2021 00:55:23 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id c9sm5018941wrm.43.2021.08.18.00.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:55:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Yang Shi <shy828301@gmail.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210816180909.3603-1-shy828301@gmail.com>
 <20210818063042.GA2310427@u2004>
 <dd225992-ec89-a911-b318-f4a91c70ed42@redhat.com>
 <20210818075316.GB501393@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c0082d37-dd36-5d83-f759-cf05a9e00b77@redhat.com>
Date:   Wed, 18 Aug 2021 09:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818075316.GB501393@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.21 09:53, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Aug 18, 2021 at 09:24:01AM +0200, David Hildenbrand wrote:
> ...
>>
>> Might we want to add a TODO in the code? We have a similar one in
>> mm/page_isolation.c:set_migratetype_isolate() and it's certainly a reminder
>> that something of value is missing.
> 
> Yes, that will be helpful.  The below's what's in my mind, but if someone
> has better idea, that's fine.
> 
> @@ -296,11 +296,9 @@ void shake_page(struct page *p, int access)
>   	}
>   	
>   	/*
> -	 * Only call shrink_node_slabs here (which would also shrink
> -	 * other caches) if access is not potentially fatal.
> +	 * TODO: Could shrink slab caches here if a lightweight range-based
> +	 * shrinker will be available.
>   	 */
> -	if (access)
> -		drop_slab_node(page_to_nid(p));
>   }
>   EXPORT_SYMBOL_GPL(shake_page);

Just what I had in mind, thanks!


-- 
Thanks,

David / dhildenb

