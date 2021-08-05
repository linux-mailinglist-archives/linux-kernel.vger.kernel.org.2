Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FB13E1811
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbhHEPcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238390AbhHEPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628177517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XV4AF0UpnLmBc+Fh+YmTYjMPTRS2XET0QYrYDq9QVQ4=;
        b=RFpcSCcAThZSTA3NuSmPdl5Lo2EwzqDhlWQ70D8c+d9raFR1rbnsc1GNb0sPqjqT7V/jmO
        WRJCcJJOh3lAkZJ3HnaYZnbYVCpp4bKwhO6zvlW9KZnPYFjTT0a3h3B8Dy4ch2KTR7C4KB
        WIBdwObzufb5PZx5VAl1scnJLTCOKTY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-vUg4GRzdOTKayR-xSIfYBg-1; Thu, 05 Aug 2021 11:31:55 -0400
X-MC-Unique: vUg4GRzdOTKayR-xSIfYBg-1
Received: by mail-wr1-f69.google.com with SMTP id l7-20020a5d48070000b0290153b1557952so2067006wrq.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 08:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XV4AF0UpnLmBc+Fh+YmTYjMPTRS2XET0QYrYDq9QVQ4=;
        b=GV6imAeq7HwHqKor9FqV33U0sV7OWtiPPaqtG1hWwG0WpQgCCr9MuXc3VmzIZAmlv4
         Exy0tnW1s08p/YgwyBHXDfThQAJw4futm5BfcJNAdi1NnF1CwuRr+lG+Te7Kdgd6+TZ3
         aJJ3Oo8seaaQaEZ9k8DZUkTYDAAn7wIPKtLDBKub5ohaNvkCQIhsRwOLp3yX/yjsQ1tj
         rmB/3Jw03QwBArc9DQbu5ZHXfMNSvoDCo7CvCv9sxxdObJIM9zq8fzwH/BqYD6/EnS5m
         tVFiY5HoOfKamKRaV7+81h04JlGkKXUVnCwgoI1aR92V4wqdmk77ZV1WgOUve2BZupqS
         vzwQ==
X-Gm-Message-State: AOAM53272SBa9HCWlDd2CWkfjP9C/JyRrjEk2eMI1v0p49pWEy1zMxgC
        /AnODuwcrTpfl/0/FOgIY6V7fw8YyPPEBo8jzQXDYB2AuLURBu+a0xGz+Mq02tRSwB06gmXEepe
        jPXaGe0sURQ5ed95s5bHtZmsN
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr5843721wrx.103.1628177514816;
        Thu, 05 Aug 2021 08:31:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL+c7DSbQHjkb0FtmxNUduwf5gjcrc+ZMVTSumUYHvO7/lb4YldM6LsmAOL1KmYiFk9LQcfA==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr5843709wrx.103.1628177514670;
        Thu, 05 Aug 2021 08:31:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c630b.dip0.t-ipconnect.de. [91.12.99.11])
        by smtp.gmail.com with ESMTPSA id h4sm6824700wru.2.2021.08.05.08.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 08:31:54 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
References: <20210804185004.1304692-1-surenb@google.com>
 <YQuO36AeQUwsAyU1@dhcp22.suse.cz>
 <CAJuCfpF1JSTSRu5v8s9wG0J-S+-p57tMO+0dUF+P16_6yYV7Mg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c67c89a2-02b3-a226-97ae-897f704b337e@redhat.com>
Date:   Thu, 5 Aug 2021 17:31:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpF1JSTSRu5v8s9wG0J-S+-p57tMO+0dUF+P16_6yYV7Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I see. Let me update the patch and will ask Andrew to remove the
> previous version from mm tree.

No need to ask. Just resend and Andrew will (usually) replace the old 
version automatically :)


-- 
Thanks,

David / dhildenb

