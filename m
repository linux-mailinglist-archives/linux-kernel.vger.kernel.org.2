Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4941974E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhI0PIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235064AbhI0PIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632755229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2YLjPWLjDxhksfVJJ0b+TgzS3sQ4uenpZKkXE6cLl8=;
        b=CI15DFoi3XIG0fxC6HpZG6pyA5oOq6qQXCz1annlYGBip6XeSk3NzkehCeJlkzIkUi9HGp
        JDcV5pFdkBEuUcerEwDz3JZ5DoIiqTJVuoHHYcaxm44gG0wNw9H+alFQ/KH92Dy02qiHGf
        hH+5RU37+2Zm/nE7Bm8V1SMkSENNy4U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-B0YnaLSvPCqEOL3NewCjoQ-1; Mon, 27 Sep 2021 11:07:06 -0400
X-MC-Unique: B0YnaLSvPCqEOL3NewCjoQ-1
Received: by mail-wm1-f69.google.com with SMTP id a137-20020a1c7f8f000000b0030cda9c0feeso361051wmd.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H2YLjPWLjDxhksfVJJ0b+TgzS3sQ4uenpZKkXE6cLl8=;
        b=0myWEMcPdv00ZTkmA9FfUFc24VHLprW+VefZ20m9dWgETFuBUupG31LH7eFgUZo74R
         E3yvchPypZypi4Jz/ZN/4Y8on225JS3z8rupnZhOCClTo1k4hHlctEA/S13povX10yPP
         DK7PWbLshtYMHPJtPKmwSI50fAlATe48YLnfXkTp2XigJA3PTiIpZesUJ/w0hZxgCi3L
         V1oGvCIY4L5bXAzO9pqbYJ82HcZ5Gy0q2XqCWJD7ZVRDV93O56UJGyeCXxDP1Q8qUw9G
         fFEyaGRjyQJIf+kWIQKYUvwpm0mZUXIJGTN0Sz+RUc7XKwuy5PMe8ZJXB8nme+eaIFQl
         0uzg==
X-Gm-Message-State: AOAM5325wOQ9t+xrOOlzBLayUQroed0EuIHQlZ7l3Uwv+nHbEx197ie3
        oUGuF40xs3zFfWrk9EMbC7cpe4ZacpNlvWFZlrEUu5M4+O+hQw7Xnh6bd+gS9B49fbzyviGff2I
        MA4H++Db4kc4ObvrwZB9Xfvn/
X-Received: by 2002:a5d:590a:: with SMTP id v10mr361564wrd.87.1632755224887;
        Mon, 27 Sep 2021 08:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy5wlKXLyU5BWf9WD/reu/rSzNLdsCLGLJ2WCZuEX7Xkvd9O/Z0HH1Erkz7+dZr/KU55FrDA==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr361519wrd.87.1632755224672;
        Mon, 27 Sep 2021 08:07:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id f9sm284908wmf.3.2021.09.27.08.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:07:04 -0700 (PDT)
Subject: Re: [PATCH v1 0/4] mm/memory_hotplug: full support for
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jianyong Wu <Jianyong.Wu@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-snps-arc@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
References: <20210927150518.8607-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d7d4ec92-7b9c-f466-6d3c-cfdd162d1dbf@redhat.com>
Date:   Mon, 27 Sep 2021 17:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210927150518.8607-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intended subject was "[PATCH v1 0/4] mm/memory_hotplug: full support for 
add_memory_driver_managed() with CONFIG_ARCH_KEEP_MEMBLOCK"

-- 
Thanks,

David / dhildenb

