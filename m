Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199D83BA3C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhGBR6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56725 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhGBR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625248532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBypdu+ASMiZiDbLrZB83GDc3oCus4O2i/SIdEpUxXA=;
        b=NIHxMa6A6CKul3RTlZvwzh28U57FbhlGIVhNfdefnBrUU1BPNpcS4hLl/EqbCmlDCD8th1
        rgOoeNmGp22kc4V5rpMHWLyQXUrHJIvbLINn+A9wK+KulCUBgp3OJ5hKxwWxlpQ/QYCTVZ
        xDkUzOmSTMMHVlD0H+V9/TjMnd2gVBE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-Znuagvu6MRODu8Kvx67Bcw-1; Fri, 02 Jul 2021 13:55:31 -0400
X-MC-Unique: Znuagvu6MRODu8Kvx67Bcw-1
Received: by mail-wr1-f70.google.com with SMTP id a4-20020adffb840000b02901304c660e75so1009930wrr.19
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 10:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EBypdu+ASMiZiDbLrZB83GDc3oCus4O2i/SIdEpUxXA=;
        b=jVwIw6jQFjF/U1iIP4CPi4Dk7qENVqCw7lbIR2f6vTOk8DeKvMTlai6BTN13gz42fz
         0vxgPU77857e4glhl2eC2gbcpaaaFZCgouL3OJsf0Twpez1ozAjz+fL+t+hW32S43Xm/
         s3MohsVu/uNbrEErTWxNzuGcs9loNtYVO2J9jCjp5h3nEIBsZ3qvA0lqiAUOTcjQs9vk
         7XIPh2A38bYeVHz+XgQSJpzbq5ked+i1lvFAMV4R6veEnTPZP28+naRsl2Uysh0H+AWJ
         al/20uMjCQ4xVYUgR/fNCRndnG++f4PkSjnANUY4BtXFWCKpATS8NQj5yl8AaWG+A5wU
         wFTA==
X-Gm-Message-State: AOAM532YNa9GmbPps1+wp4AIoxbYoKVG/oNFKaAVqpxTiJypnjGgTuNF
        AY9f3p2d9363bgUY9uE8lAKsMyUZ06kP6txCyQQpfI3MNYG7NBHZIkF78q00EwxB1GZjyu5ITtG
        97k5ZBKhMGuvL+OT6jOBk+RhyqsLGAu+vHysgFkQxzs+lak19afreo1+NrN/TQB990Qo3pD3z
X-Received: by 2002:a05:600c:4410:: with SMTP id u16mr708291wmn.143.1625248530020;
        Fri, 02 Jul 2021 10:55:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMXij4I0fjYvaniP3PS/apVcy+HgCgGmz62kIk3I3D3H5cGZi8XI5jal+6y8jN/bDf70Bn1w==
X-Received: by 2002:a05:600c:4410:: with SMTP id u16mr708268wmn.143.1625248529728;
        Fri, 02 Jul 2021 10:55:29 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23afb.dip0.t-ipconnect.de. [79.242.58.251])
        by smtp.gmail.com with ESMTPSA id w22sm13430546wmc.4.2021.07.02.10.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 10:55:29 -0700 (PDT)
Subject: Re: [PATCH 2/3] mm: sparse: pass section_nr to find_memory_block
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>, akpm@linux-foundation.org,
        mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
 <CGME20210702094457epcas1p40fba85e22861cf1cc85a085719030c24@epcas1p4.samsung.com>
 <20210702094132.6276-3-ohoono.kwon@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a03f502d-60e9-196a-0db8-88ce3a98a32c@redhat.com>
Date:   Fri, 2 Jul 2021 19:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702094132.6276-3-ohoono.kwon@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.21 11:41, Ohhoon Kwon wrote:
> With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
> mem_section to section_nr could be costly since it iterates all
> section roots to check if the given mem_section is in its range.
> 
> On the other hand, __nr_to_section() which converts section_nr to
> mem_section can be done in O(1).
> 
> Let's pass section_nr instead of mem_section ptr to
> find_memory_block() in order to reduce needless iterations.
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

