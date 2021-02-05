Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D367B3117EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBFApS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhBEKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612519726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQAmpeiwjTLNRxNDH8Fc0DNgLit8cCAihA/yreIw74s=;
        b=TY8z2R9p4EdqnOciRu4LJm1D8MiqkQGRaxXWLzF3+C9maBovIWrMQDfTmZontpJ7WnvS/X
        ewjBrlT2VMA4skrp5UA75ZcfWSeNnmVOjLE5nl1KBsFTXa17U4xWUyLDv3C0Dfg2S5bhbq
        DiO3XbR30wxnzrSUkyrBlo/t68UxDJk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-0DmaeaI6OAaFPDLX89jPJQ-1; Fri, 05 Feb 2021 05:08:43 -0500
X-MC-Unique: 0DmaeaI6OAaFPDLX89jPJQ-1
Received: by mail-wm1-f70.google.com with SMTP id z188so5384659wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XQAmpeiwjTLNRxNDH8Fc0DNgLit8cCAihA/yreIw74s=;
        b=ou6eARKs70dMmTpUd58ZOtvfoIM/Pj71UpARh0tGi97xfMwQEUqt040ONPCiuW7sGv
         h6sAqysH+odrsf2USY6H12uo8Shba/LE0A+HFzEOp5njcgEVmXlBDt9Trx+AwFwHw+Hj
         gYUJojPPeZnULKXDdDNvbD+jL9PwhxiJJFMcjFdx0Kv1gLG1agy4OG0GFiSuWGf1JwFk
         TZ8mP1gAw7s4ei55uufo0+OQU0Z3dN7q4Q/+ebhp12ztqG/nQsYwP6RGh94wYqfxtYws
         j6Pp+KX7EInJToCIFj+rdFXkOw+gIjuC/X+6cQqrfp+oWci8EbrZ12quoAiMRrdvZkUV
         drDw==
X-Gm-Message-State: AOAM531AG1KXv2CRjUklBOyWhiH1b0GmI/a3YlGaJCPWbeZVH1cNJKCd
        cH63YXuquIKTQzTPIK5mDj3xlglZqf1wcSzMkxz8v0y9qC9rIkpIiRmlc7Z505m5hjj3bTE0rKg
        VSPC4j+njjeqd0rv3VyAmQGE7
X-Received: by 2002:adf:f303:: with SMTP id i3mr4098911wro.60.1612519721754;
        Fri, 05 Feb 2021 02:08:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygnV5PVQbw8IB48V2+j6ejVS7WeCWn7No/UZJIzRZQZzqTlpByGGeGJZYMFj/b3HUjRWFm7w==
X-Received: by 2002:adf:f303:: with SMTP id i3mr4098899wro.60.1612519721586;
        Fri, 05 Feb 2021 02:08:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y63sm8267192wmd.21.2021.02.05.02.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 02:08:40 -0800 (PST)
To:     Stephen Rothwell <sfr@canb.auug.org.au>, KVM <kvm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210205160224.279c6169@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: linux-next: build failure after merge of the kvm tree
Message-ID: <cac800cb-2e3e-0849-1a97-ef10c29b4e10@redhat.com>
Date:   Fri, 5 Feb 2021 11:08:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205160224.279c6169@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 06:02, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kvm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ERROR: modpost: ".follow_pte" [arch/powerpc/kvm/kvm.ko] undefined!
> 
> Caused by commit
> 
>    bd2fae8da794 ("KVM: do not assume PTE is writable after follow_pfn")
> 
> follow_pte is not EXPORTed.
> 
> I have used the kvm tree from next-20210204 for today.
> 

Stephen, can you squash in the following for the time being?

diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..15cbd10afd59 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4775,6 +4775,7 @@ int follow_pte(struct mm_struct *mm, unsigned long 
address,
  out:
  	return -EINVAL;
  }
+EXPORT_SYMBOL_GPL(follow_pte);

  /**
   * follow_pfn - look up PFN at a user virtual address

A similar patch has been posted already, but Jason Gunthorpe asked to 
add some kerneldoc comments.  Therefore it will not be in kvm/next for a 
few more days.

Paolo

