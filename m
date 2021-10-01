Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD69641E7DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352432AbhJAHDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352443AbhJAHDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:03:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C4C06177B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 00:01:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i19so31745206lfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GAfZt0MoHwEJLBdGh3slmVs3mLy3iUfAjh3mV36d5Ls=;
        b=ROdphRH6lMiRvMmn1nm8oaMaiETamysG3Q0ngWjuTaJIRPQKI5fSRbTZ4rw0TUP847
         Pi0wslg6s/LWyZkzrxDcolOlhxrdfgGttEI+JQwcPX/qFBQBXriLXNO40SiKLvdfFgdo
         Kvfkwr7+GAZthgQ8GYGf+5TMgmfbyOmHcvkfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GAfZt0MoHwEJLBdGh3slmVs3mLy3iUfAjh3mV36d5Ls=;
        b=AyayPsHtNPrW4Y9lLKgAari9iZkGSZ1UNxyeo+7lBQJEhSNIUCu7WeeO76X1rQ+LNG
         tmYbk/Yg9t/ZaF3QXvMKg2TxeFecRnwggdiq4xM2bYCFdbIaOdSTjbeW/q0OLO+kXcwq
         nln1zCwjj88KNhB3kgnwqAkTg1sejbDVrWrA0EXxcaoUyOIsventYq5HGZRHcAYnOsbe
         33vgEkeG1RcTSF7WFtLygZC1BpzHYkJstYd6lTZfNDP2RJoKCkailf7amn+a29N2LmkU
         1PIfPc9/VoBSScMFNSPcAYozwGNkw0ea5VhLn+UDFY4/bqoJQztM+Cqx+OQ6X+i6cfK4
         qmhw==
X-Gm-Message-State: AOAM531xlOfui7nMU59ARp6z2lFGT02/rL4ki3B4Rgly5C3hdqeuNqnB
        ziZuBCcuTtpx/iw6spld5LoOHA==
X-Google-Smtp-Source: ABdhPJyXXUEJmAjiOjBr8lgw5nWSpdbiu6T6G5ePA3Lbwqd6VdlF8fBVEdmGWS9e5qpsKpJFjDh9yQ==
X-Received: by 2002:a2e:1557:: with SMTP id 23mr10790432ljv.84.1633071686513;
        Fri, 01 Oct 2021 00:01:26 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q22sm447517lfp.174.2021.10.01.00.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 00:01:25 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
References: <20210902231813.3597709-1-surenb@google.com>
 <20210902231813.3597709-2-surenb@google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d8619a98-2380-ca96-001e-60fe9c6204a6@rasmusvillemoes.dk>
Date:   Fri, 1 Oct 2021 09:01:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902231813.3597709-2-surenb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2021 01.18, Suren Baghdasaryan wrote:
> From: Colin Cross <ccross@google.com>
> 
> 
> changes in v9
> - Changed max anon vma name length from 64 to 256 (as in the original patch)
> because I found one case of the name length being 139 bytes. If anyone is
> curious, here it is:
> dalvik-/data/dalvik-cache/arm64/apex@com.android.permission@priv-app@GooglePermissionController@GooglePermissionController.apk@classes.art

I'm not sure that's a very convincing argument. We don't add code
arbitrarily just because some userspace code running on some custom
kernel (ab)uses something in that kernel. Surely that user can come up
with a name that doesn't contain GooglePermissionController twice.

The argument for using strings and not just a 128 bit uuid was that it
should (also) be human readable, and 250-byte strings are not that.
Also, there's no natural law forcing this to be some power-of-two, and
in fact the implementation means that it's actually somewhat harmful
(give it a 256 char name, and we'll do a 260 byte alloc, which becomes a
512 byte alloc). So just make the limit 80, the kernel's definition of a
sane line length. As for the allowed chars, it can be relaxed later if
convincing arguments can be made.


> +/* mmap_lock should be read-locked */
> +static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
> +					 const char *name)
> +{
> +	const char *vma_name = vma_anon_name(vma);
> +
> +	if (likely(!vma_name))
> +		return name == NULL;
> +
> +	return name && !strcmp(name, vma_name);

It's probably preferable to spell this

  /* either both NULL, or pointers to same refcounted string */
  if (vma_name == name)
      return true;

  return name && vma_name && !strcmp(name, vma_name);

so you have one less conditional in the common case.

Rasmus
