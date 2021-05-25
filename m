Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8000D3905AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhEYPmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229704AbhEYPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621957235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYdCAhRdnwXkmqxWxUZgNfbsA4SMUJILVv4b2pn+/Es=;
        b=NEIGORZqgRIYnyjQhkO1V210id8vwZk5wHXHAadsJSsh2q0s7Ujk8Xx2tOxppioGe2Bo9T
        nU+ocLx0pH0JvbCAI57UpDClmGa2DgImPvPyNlY0YmA+hjDnnzqgDsvcg5OUs2dbPlApJb
        ZOvzrcyNeBZySaYsFKhNoU0cyYXzal8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-AnxD9QXUMpadOqZlvtPl7g-1; Tue, 25 May 2021 11:40:31 -0400
X-MC-Unique: AnxD9QXUMpadOqZlvtPl7g-1
Received: by mail-wm1-f72.google.com with SMTP id h9-20020a1cb7090000b029016d3f0b6ce4so4645040wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SYdCAhRdnwXkmqxWxUZgNfbsA4SMUJILVv4b2pn+/Es=;
        b=FXFaqcvvpe0Woh1+LtFoVu+TvOM/+5a2sKl2712IJceCx3X2MX0zP48dQ0dsBSulrQ
         Pjz+ePyzHvFqQNhdhAs9EO7wwPVglU/8JrFBtnuJLfdGVjZy+856Uik++bfH96NmzV3t
         z95dzWCljVobSXRfw3JEhRztFi9UsliVHb01FHj1L/GT+OhLYZo4QyY0theT/3pSzYq8
         UEbeSwfMnAepgkdxHOUKq041Kq2QiuIkcBNvBbhAV1ALUjVAzA1Q113imVvy2lWnpqfw
         v8SOg5rwP2hoQHZv0DVbMDQL+T2zwrBAiYZSEBE4136ssheAdOtb3uIdWqcPOdGSSNQL
         b6bQ==
X-Gm-Message-State: AOAM533Ds/4nY6OJwGsszEULVwLUhwWji00vBhZgO3bVZMkaeo70voyr
        05r9Hd7U9MK03oCJK59El96edLl0g2mhg8G/HwTGhtKLcVMmylEAt+W4EOarH3ybgfrD8B9DlIL
        C+ZNbd6aWIzx/jkkMYBRPmXtJaO0X9f63sN6QLYNnsQREJSAXcT8U91eKDmLjPgqLG6dba8E2
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr4425185wmc.33.1621957229987;
        Tue, 25 May 2021 08:40:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgA6I4UKYmaq2QfqxI0w7/EGBR072QtppwfyKItJHrUwFPAGPC9fwG3B6eKAW9a9bNGu8vJQ==
X-Received: by 2002:a1c:67c1:: with SMTP id b184mr4425151wmc.33.1621957229725;
        Tue, 25 May 2021 08:40:29 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id b7sm16111484wri.83.2021.05.25.08.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:40:29 -0700 (PDT)
Subject: Re: Arm64 crash while online/offline memory sections
To:     "Qian Cai (QUIC)" <quic_qiancai@quicinc.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b34499c5-a330-1bfc-d564-8ebffb3236cd@redhat.com>
Date:   Tue, 25 May 2021 17:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <DM5PR0201MB35576EF9B568FEE05FE58CF08E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.21 17:36, Qian Cai (QUIC) wrote:
> Reverting the patchset "Allocate memmap from hotadded memory (per device)" [1] from today's linux-next fixed a crash while online/offline memory sections.

Do we know which patch in particular is problematic?


-- 
Thanks,

David / dhildenb

