Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB3E355D09
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbhDFUnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235692AbhDFUnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617741788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABBXBhlUARaxNFBWCMnGkuMbTapmBL2uS8R+F500nIk=;
        b=JTwZZGs8FKHaasPCYUYfA7h/HAzfgEkDNYAw1MDyv+dPdB15igL15/P6AvMhY0ECOxz4Fq
        zoBOcDW+976/3XPf8kakhPn40K+fL5jh3V9faGBiuzQ+IOdzxdgJblUSWw5uF3zTpVBEnn
        HO7TbVp2F33/S66eaC10fbiNuXrwbGQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-xry_VL0APIWRqAdGTpadlg-1; Tue, 06 Apr 2021 16:43:04 -0400
X-MC-Unique: xry_VL0APIWRqAdGTpadlg-1
Received: by mail-wr1-f71.google.com with SMTP id l3so5736965wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ABBXBhlUARaxNFBWCMnGkuMbTapmBL2uS8R+F500nIk=;
        b=XUR4CkxomDMdry9SJFlWlUoo+HDLax3vvZfzunIHX2laa04la8Mh7gGvC5CLXgwrMT
         F62JgelbIo8L7sCVscOpOM8Xfzd4nzeM8uuBPu4q0P+eB5tFn9Q/DRjPWdPVolsmbqn1
         Apkv21QR+UTH7FYcdzVuXka8TKgsCKxEdhMCqKdgfxYPGWcPfT664YwPfE/4h9SnOt5H
         o4329XrUWrJbq14ZhbDbIk9XKedY7cZbwjgZFXkDp0YDQz6Gyi6udW5YhKKLi0VqBLlH
         n7B3ET5S6NmQQHVRFg8yf0jfL5+0bQxsszhDXnOXw7v3l3Gs0eEwBef5EdpzNNaMa5cS
         7YZw==
X-Gm-Message-State: AOAM533a4yf3kVag7rzZdc8sE4ZjfyBvg2nAD5RrKfo3DmCpxWh63GxH
        IRvWNezXi61SkHpQ3bMDlHxVDbF+hzos2PxGMU1ANtRsCeACJhQK4oh37IcGVvOV2GzsGm/cboe
        IPsR9P4pkDZr6eTUfb7nCvZ2m
X-Received: by 2002:a1c:2781:: with SMTP id n123mr3351445wmn.64.1617741783532;
        Tue, 06 Apr 2021 13:43:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi8P3V1Fc945skdd7Z39U7VGP6wyqLM61CVsa2i65JB/d0PTHRzVoE1kDrMQA3cxs62iQfMA==
X-Received: by 2002:a1c:2781:: with SMTP id n123mr3351436wmn.64.1617741783308;
        Tue, 06 Apr 2021 13:43:03 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c64ee.dip0.t-ipconnect.de. [91.12.100.238])
        by smtp.gmail.com with ESMTPSA id v189sm4609990wme.39.2021.04.06.13.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 13:43:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 2/8] mm,memory_hotplug: Relax fully spanned sections check
Date:   Tue, 6 Apr 2021 22:43:01 +0200
Message-Id: <59A04B1D-08D6-4E71-A382-F5503A6E0AF7@redhat.com>
References: <df9bdb5157d6ad2f4a922d396ddf0c07@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <df9bdb5157d6ad2f4a922d396ddf0c07@suse.de>
To:     Oscar Salvador <osalvador@suse.de>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 06.04.2021 um 18:34 schrieb Oscar Salvador <osalvador@suse.de>:
>=20
> =EF=BB=BFOn 2021-04-06 17:32, David Hildenbrand wrote:
>> I'd only relax start_pfn. That way the function is pretty much
>> impossible to abuse for sub-section onlining/offlining.
>> if (WARN_ON_ONCE(!nr_pages ||
>>         !IS_ALIGNED(start_pfn, pageblock_nr_pages))
>>         !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
>=20
> But this is not going to work.
> When using memmap_on_memory, the nr of pages that online_pages() and offli=
ne_pages() get might be less than PAGES_PER_SECTION, so this check will alwa=
ys blow us up.

But not end_pfn as given in my version or what am I missing?


> --=20
> Oscar Salvador
> SUSE L3
>=20

