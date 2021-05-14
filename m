Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4071380692
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhENJ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbhENJ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620986250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rzJBsGwhabN6jmugEogWwENANkkfJK8/J4mWGWKpXU=;
        b=WbHpA5Qp7iSepViXgW5hsyY6DLRSYzaUxmAk+inLG/zaMHIxnAsqruNtZsbsv50vX3xEuF
        Z4BzTt0IHe202Np1aM/Rr3sOpRhGedMjhatrq09qCbyxNF4xkgI4EfiieOLjRJi0C+jAAb
        Gd+u7Bv90fR3kWttAgt8FmYkhDOqeaI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-QtgbUvR2OtKzi1E-lBkyug-1; Fri, 14 May 2021 05:57:28 -0400
X-MC-Unique: QtgbUvR2OtKzi1E-lBkyug-1
Received: by mail-ej1-f69.google.com with SMTP id sd18-20020a170906ce32b02903cedf584542so3347249ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 02:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8rzJBsGwhabN6jmugEogWwENANkkfJK8/J4mWGWKpXU=;
        b=bsy04jZxXbw2M2gGB8zZsvhblpI37xBwJ+6bVyXvIJF/lZeZcZ9vBsB7scu+OLf5q5
         qxe7NwL3Iwou13mY3AgMJzugh6QS/LDcRCiOSFKUlYRRfvg7JMi5JCIGdwbBFyBPWmzD
         6vFZ08b0szWlEgpMdlPQSEU6Vjc3SASA8Rbpo1opIDJVCLGimhFUzHBXdSY7wFDU31qk
         54IO/hbWpSJ5uYAZVPNiSdwuZrhe6PKzgDDQvMU+GIhW72ZLQdWKXb1Tl777E0aI4c6g
         sh1X2rAO7Q09FC24QfIs80jtZ66ASXKqt0vXCvAC2OaJlQKajk/Up/Xqrj5VjHeQo0Bo
         Polg==
X-Gm-Message-State: AOAM531jKgR5o4GX9uCNU0k0cn03aQwPSQcp4HEkLfCXpozxgy6rSv+/
        iMqE0zYs0IhmBVRRO35w+Nw/lKW9qGehS0/4znLpVwiirpVmdo8UnF6InRsNs6pVAOj3f8L0xvi
        3CRQlbniOrLlDA92Vruvs4RiG
X-Received: by 2002:a17:907:7747:: with SMTP id kx7mr31478207ejc.400.1620986247255;
        Fri, 14 May 2021 02:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrSoRF79fxMuEqrHhj6EHjL5Zsyke7AE/1JPBWbafFqeSeIeeKtVnbLG/x5jm0octAFZwKQQ==
X-Received: by 2002:a17:907:7747:: with SMTP id kx7mr31478183ejc.400.1620986247091;
        Fri, 14 May 2021 02:57:27 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id ju17sm3413760ejc.72.2021.05.14.02.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 02:57:26 -0700 (PDT)
Subject: Re: [PATCH 01/22] mm: Add vma_lookup()
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
 <20210510165839.2692974-2-Liam.Howlett@Oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <99e04b50-7210-8a2f-4eda-08747b8570fb@redhat.com>
Date:   Fri, 14 May 2021 11:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510165839.2692974-2-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.21 18:58, Liam Howlett wrote:
> he third use of find_vma() is by developers who do not know that the
> function starts searching at the provided address upwards for the next
> vma.  This results in a bug that is often overlooked for a long time.
> 
> Adding the new vma_lookup() function will allow for cleaner code by

Sounds helpful to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

