Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0C37BDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhELNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231695AbhELNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620825153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkUtsmXhTln8ZuCPuyfmYtBmjG5e9wQzlcCwa1mE9Fg=;
        b=hIJS1Va3Gm4e1Pc/x8mHHeEgDo0xwprFOpxfLtk0IReJzXEPXuNEujtpzdmEBcUXUhaP0F
        UBoqE97poFXLzQ5EYAdp01ocjHU0AtOY5u+NpJFQa58DEm+wnP3vfKhCKMqUsZ7NtfocNX
        uZt+K573cCTx4bGu3AWxlOuTe8yJxRQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-oJyFmR5ANWuFjStT3Lv8Cg-1; Wed, 12 May 2021 09:12:29 -0400
X-MC-Unique: oJyFmR5ANWuFjStT3Lv8Cg-1
Received: by mail-wm1-f70.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso1407358wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xkUtsmXhTln8ZuCPuyfmYtBmjG5e9wQzlcCwa1mE9Fg=;
        b=IuBtANBXcRd/iVeLL+Bk7W4dymwyiVTCZj5j30/aae07siv+chnrxT77SuFPAbQ8iw
         X4sSurz/siG1OeTaPl3GHqC1yZ5AzrXaU3U4sxuOXr4OMOuUVhFXGF01Sv7CMjHClpKe
         49tqjzU1X0SUMqQLfyvguxTBDFB8M0BdC7a6L9OI7cfd/gw/nRtlu8CPTL/V4e+P/u3O
         zJ97/kZpIwGsV1Z2GIFOXF4fmZg2EYgbgs34lo4B5dDrtE2wSGKFryu3jsU1tr/CIIbJ
         ENz/84DsqK6dSY/Pn4ZWZCKqO9Q/Jvq8slcr9yFxniCxa+FkttcusIkMpBnicwBCvF3A
         XXcA==
X-Gm-Message-State: AOAM533tpO0jGT0FzMHRT8zZCPCBosJ9HCSbBQB6I0keTbAoIiCgH0cI
        81Mw9BNZD7JhHtIGNYxN2aQCMfbWvN0VNTAmTg41BVzwd3uCr2q9bBs/QurXXlgxFVVbU3G8JeD
        iSn3tByuu7pXPmiZirVSDDzQ9
X-Received: by 2002:adf:cc85:: with SMTP id p5mr44985786wrj.75.1620825148672;
        Wed, 12 May 2021 06:12:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN/bKM7tb3kGzV/c5fUH9I6/yF7gfmWH2UTCxgDB167HFBRdbQPq3VIR//MAPGfKngYzQmzw==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr44985731wrj.75.1620825148402;
        Wed, 12 May 2021 06:12:28 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65ab.dip0.t-ipconnect.de. [91.12.101.171])
        by smtp.gmail.com with ESMTPSA id z5sm1439367wrn.69.2021.05.12.06.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 06:12:27 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] binfmt: remove in-tree usage of MAP_EXECUTABLE
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Don Zickus <dzickus@redhat.com>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210421093453.6904-1-david@redhat.com>
 <20210421093453.6904-3-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <49a8cb62-e26d-a351-937e-6fb62a6f4a2e@redhat.com>
Date:   Wed, 12 May 2021 15:12:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421093453.6904-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.21 11:34, David Hildenbrand wrote:
> Ever since commit e9714acf8c43 ("mm: kill vma flag VM_EXECUTABLE and
> mm->num_exe_file_vmas"), VM_EXECUTABLE is gone and MAP_EXECUTABLE is
> essentially completely ignored. Let's remove all usage of
> MAP_EXECUTABLE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

[...]

> +++ b/fs/binfmt_aout.c
> @@ -222,7 +222,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
>   
>   		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
>   			PROT_READ | PROT_EXEC,
> -			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
> +			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;

As reported by kernel test robot, this line should end with a ","

>   			fd_offset);
>   
>   		if (error != N_TXTADDR(ex))
> @@ -230,7 +230,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
>   
>   		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
>   				PROT_READ | PROT_WRITE | PROT_EXEC,
> -				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE,
> +				MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE;
>   				fd_offset + ex.a_text);

dito


@Andrew, I think this resides your tree. Can you fix that up or shall I 
resend the series, or only this individual patch?

-- 
Thanks,

David / dhildenb

