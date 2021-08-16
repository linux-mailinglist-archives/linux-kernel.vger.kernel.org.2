Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DB3EDC96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhHPRtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231479AbhHPRtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629136159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plJNW7Y67eXvnax8oo8FvgYyj0Iw4c1g2Thy+LmnVB4=;
        b=IVWtlu5NVqaHmoEvbNQ2sRc2Y/7IIXo9aDuZveJo7vlg+rVj3wFmZvowcISMNV5+nHKhJB
        7oZz9YyAXC/7mfpp0MYCVaPeDvFlMFY4pjp+cVXq0v1aG5Py7JaivMu6Yx+AE66Og6sFT4
        A8fZ5GMoQB+/+ANUrU7cVqW3D28wR4I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-55u96XS9NRy3e-OqhfOC4g-1; Mon, 16 Aug 2021 13:49:17 -0400
X-MC-Unique: 55u96XS9NRy3e-OqhfOC4g-1
Received: by mail-wr1-f69.google.com with SMTP id m5-20020a5d6a050000b0290154e83dce73so5675901wru.19
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 10:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=plJNW7Y67eXvnax8oo8FvgYyj0Iw4c1g2Thy+LmnVB4=;
        b=r2Q5owQDLUE+JpnMGGUyhxCUo/zRYQQqwX8FrFugExWWy0GGNhZWTqqEPIUUlomnde
         33WnkCKuvFYcH05Owp8DjxRO4Bw/2WtrpzHDo1y1u9mxPCEJ8QlwiFWQC4cjyGZRdFCj
         QC06nEuMZwmS4248KaV7sTP5CNBrunHp/csKY+qVGVVnBzaZgaSngj6GW1R8fiKN2bid
         83We7jL1/HH+OA57BMB8suNmiLIJSAt/Kko1T6le32K+4zS6fZF7BBp71eu5uy+sJS96
         EanLS+KK89bCiY7fL9811vdR4/kyefEONoeJnCBMHAobV3O/Uz8X7hYvlvAGnwhtsX4D
         5+Sw==
X-Gm-Message-State: AOAM532tSe9p0e+fziPumHdhL9WUwm1jBHuSkC3rhFtqp+Z3kpBLub7d
        BaThRF7+A7jNKPB+3zvL6soYvU4wy24UuLSjd8WWuedc4k+NGz+9lFLSurtQUJUZ7U+TKbA5Guz
        ynvLm88VVpX7heRnb6ah8fXhc
X-Received: by 2002:a5d:4852:: with SMTP id n18mr19855634wrs.10.1629136156650;
        Mon, 16 Aug 2021 10:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGGjFxu2Sr4hF+9rlDSFKl2PRwrlX7LDhBhekAWq72hyPIIxvsoLI+OzsZA9j8gnxfP8E0Pg==
X-Received: by 2002:a5d:4852:: with SMTP id n18mr19855622wrs.10.1629136156447;
        Mon, 16 Aug 2021 10:49:16 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id l2sm11417288wrx.2.2021.08.16.10.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 10:49:16 -0700 (PDT)
To:     Jiri Olsa <jolsa@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <YRqhqz35tm3hA9CG@krava>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [BUG] general protection fault when reading /proc/kcore
Message-ID: <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
Date:   Mon, 16 Aug 2021 19:49:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRqhqz35tm3hA9CG@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.21 19:34, Jiri Olsa wrote:
> hi,
> I'm getting fault below when running:
> 
> 	# cat /proc/kallsyms | grep ksys_read
> 	ffffffff8136d580 T ksys_read
> 	# objdump -d --start-address=0xffffffff8136d580 --stop-address=0xffffffff8136d590 /proc/kcore
> 
> 	/proc/kcore:     file format elf64-x86-64
> 
> 	Segmentation fault
> 
> any idea? config is attached

Just tried with a different config on 5.14.0-rc6+

[root@localhost ~]# cat /proc/kallsyms | grep ksys_read
ffffffff8927a800 T ksys_readahead
ffffffff89333660 T ksys_read

[root@localhost ~]# objdump -d --start-address=0xffffffff89333660 
--stop-address=0xffffffff89333670

a.out:     file format elf64-x86-64



The kern_addr_valid(start) seems to fault in your case, which is weird, 
because it merely walks the page tables. But it seems to complain about 
a non-canonical address 0xf887ffcbff000

Can you post your QEMU cmdline? Did you test this on other kernel versions?

Thanks!

-- 
Thanks,

David / dhildenb

