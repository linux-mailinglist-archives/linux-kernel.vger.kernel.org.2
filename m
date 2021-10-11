Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2AE428CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhJKM1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235265AbhJKM1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633955114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3zAWzIKdBqZq9Xwiz2ll75TQr/yx0cu//oyDWg5EQ8=;
        b=V/EtmyBmfqMIYMlDT5Sw0vyh5vzIul7Z23yCVzq56BJ2Ti7ITheNwBl5vs6pO75iviBlSr
        yYrp5lBPd/xUglZoXyyO5Yes8p2wQqLdFjMU/AGSokkFnZNt+2fqSdYQ3MssgJNRtZtQAP
        L/GCZTtwaYyfTuyLA8F3RyyIqNrn2lQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-ZteybFLvNlOtmUhw8-0vaw-1; Mon, 11 Oct 2021 08:25:12 -0400
X-MC-Unique: ZteybFLvNlOtmUhw8-0vaw-1
Received: by mail-ed1-f69.google.com with SMTP id u24-20020aa7db98000000b003db57b1688aso10347730edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T3zAWzIKdBqZq9Xwiz2ll75TQr/yx0cu//oyDWg5EQ8=;
        b=vQGFvhMRG1OGk4SB25aVY63BFgWjaD6Ua1Hys3KIrF9om1aMrZ4cWpEoE48Zss9u+e
         9v+6Hf5odejDH/zSN1lsq9SxR9zzTz3QZgkxqgqyQYKByTBVLHb2hIJXGkBOctt4y6ma
         ILhrXj/016rD3DZlhhVxcq3QYeIZlg0eEOMyvfxQwoGfhMmp4vSUkFlt8O282CpbVTKF
         AcGtzxeVUk6LvNoU/MgpVyNvUTeK7FvHYK0x7yYJuMUs6J5y562kpJOxPwNwW7APvhg3
         EUzYIlqPRYod20HMDHioeoNLSSyhG8oQOUXaTdOaKV8UQhxIIogVjgdyz/No9I6UcOBb
         Hljw==
X-Gm-Message-State: AOAM532mkLQg7xNPpDUgXsNwJai1sI1YxzPFf3NjgFGvQT4SEZxYMMey
        5a4aJqWVolJs/RUnHi/Jct/HYn8dTjqmb+EBxPg5b7Ii+2DNBuRisk9h6neccpKjC+gETO46W4N
        gM69nXkX/DqFRIkB3uQ8MQ3Zj
X-Received: by 2002:a17:906:7c4:: with SMTP id m4mr25582745ejc.553.1633955111394;
        Mon, 11 Oct 2021 05:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMkKRUivOyezCE/Qq49qiXBy/5IKJPHBk/2vxQg4LVt9cwI4vY6x2I3qgFIDLIirERgFgLzg==
X-Received: by 2002:a17:906:7c4:: with SMTP id m4mr25582712ejc.553.1633955111251;
        Mon, 11 Oct 2021 05:25:11 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id p25sm2162321edt.23.2021.10.11.05.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 05:25:10 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org,
        akpm@linux-foundation.org, hawk@kernel.org,
        ilias.apalodimas@linaro.org, peterz@infradead.org,
        yuzhao@google.com, will@kernel.org, willy@infradead.org,
        jgg@ziepe.ca, mcroce@microsoft.com, willemb@google.com,
        cong.wang@bytedance.com, pabeni@redhat.com, haokexin@gmail.com,
        nogikh@google.com, elver@google.com, memxor@gmail.com,
        vvs@virtuozzo.com, linux-mm@kvack.org, edumazet@google.com,
        alexander.duyck@gmail.com, dsahern@gmail.com
Subject: Re: [PATCH net-next -v5 3/4] mm: introduce __get_page() and
 __put_page()
To:     John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
References: <20211009093724.10539-1-linyunsheng@huawei.com>
 <20211009093724.10539-4-linyunsheng@huawei.com>
 <62106771-7d2a-3897-c318-79578360a88a@nvidia.com>
Message-ID: <89bcc42a-ad95-e729-0748-bf394bf770be@redhat.com>
Date:   Mon, 11 Oct 2021 14:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <62106771-7d2a-3897-c318-79578360a88a@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2021 21.49, John Hubbard wrote:
> So in case it's not clear, I'd like to request that you drop this one
> patch from your series.

In my opinion as page_pool maintainer, you should also drop patch 4/4 
from this series.

I like the first two patches, and they should be resend and can be 
applied without too much further discussion.

--Jesper

