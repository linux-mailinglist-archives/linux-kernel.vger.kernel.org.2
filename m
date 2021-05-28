Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB6039433A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhE1NKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234961AbhE1NKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622207343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEX/rBmiVlJyVxednzmK+k/yMHjRZkeckV9ZqXD+m/8=;
        b=MNyGBoh0cL4TzrI1ziwLdoGwdeTCtLUmyO//u3geKMukCjq3XtuXWjW94qI03xcdDfNyQH
        wUSUSbpvOu4cZseKd0bmML4GvNCf8oF7msmwOdrMI+O1+pJHHvaqhhM6blqv3bZtj8+rkl
        xJJuJs8fw0Rti303cfnO5/dz9Qrn+54=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-bK8e8y_8PnmrC5-vUI9S6Q-1; Fri, 28 May 2021 09:09:01 -0400
X-MC-Unique: bK8e8y_8PnmrC5-vUI9S6Q-1
Received: by mail-ed1-f70.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so2106828edb.17
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 06:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EEX/rBmiVlJyVxednzmK+k/yMHjRZkeckV9ZqXD+m/8=;
        b=rm+o5OgNDkRs6X4SHIe2RElLfD8rLqYyHGnbOKWomEJwUjgBIGQJZ4BzQHPIhT4ekY
         IuTvW1cUlqADz1Rjh0lZ6oXZL2+y4r2+IwR32kSFtvhqws/wrhF53MuB5sFajwxt6gfl
         S8JZQkkKqJ8L7lARsZAS+av1WUpxThOrZHJ4xArVxVCaNR9sH+sIutnmkSni2auzMSRl
         XwVR8ISzFa/FPhEUIBV+flck/LgQPqDvZ/kKlVpd33Kyq5b/kEdLNgYqyz4LuGZKrj+G
         Pki6/BjVb7OhQuRzij5YERH2ouAtSU8JSNgmpDv/SA+bhNH5B1JCn6czYN02lp+3uzXc
         BEpw==
X-Gm-Message-State: AOAM533rHXFZKXOqaMcDKUEOJOSP/ZApaqOgmWntwq38lJCWIaS2Sxmn
        24vC6/TvrBhYOenfkCFc3RIlAVap3KA4IeuIOVvlzszRrO+FRUCWDRYQZzjGwGq3npaxKm/+eLr
        cWAJXdGvgYl/deGKiZqBge32F
X-Received: by 2002:a17:906:bb0e:: with SMTP id jz14mr8813946ejb.285.1622207340275;
        Fri, 28 May 2021 06:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvtx+PlUXKNPCQkb3twdze1odjjLz+/TX1k+GLWLnk8MeS0QSt7e+7UCMbEfcmkCbx2WKBPw==
X-Received: by 2002:a17:906:bb0e:: with SMTP id jz14mr8813933ejb.285.1622207340099;
        Fri, 28 May 2021 06:09:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6870.dip0.t-ipconnect.de. [91.12.104.112])
        by smtp.gmail.com with ESMTPSA id w14sm2742416edj.6.2021.05.28.06.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 06:08:59 -0700 (PDT)
To:     torvic9@mailbox.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <1825464932.40588.1622203733380@office.mailbox.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [Question] mm/vmpressure.c: ilog2 calculation in constant
Message-ID: <7a34c010-9f2a-431b-3c49-8f0d387f1cba@redhat.com>
Date:   Fri, 28 May 2021 15:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1825464932.40588.1622203733380@office.mailbox.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.21 14:08, torvic9@mailbox.org wrote:
> Hello,
> 
> in mm/vmpressure.c, we have defined this constant:
> 
>    static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
> 
> My question is: Why do we calculate ilog2 instead of simply setting the constant to '3'?

My best guess is that it's in place to a) increase readability b) make 
it easier to adjust. The compiler will optimize it out either way, so we 
don't really care.

Having that said: it doesn't increase readability on my end. But I only 
took a quick glimpse. Maybe the "100 / 10 == 10" here is the magic bit 
also mentioned in the comment "when scanning depth is ~10%". So it can 
be adjusted "more easily" eventually ... at least not by me.

-- 
Thanks,

David / dhildenb

