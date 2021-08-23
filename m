Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6572E3F4C46
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhHWOYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHWOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:24:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:23:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e1so3299668plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=WtsUEsqMTxeu0ASY9ZGldGWSKXK/Bt2mBtS4t1K1jok=;
        b=Twno2VV6Mfpk9mFt1zef4nXG4k9+uk+hiqK3q7qn6xzeS8fqb9Sd0RsRYk+AW49Sup
         kwtvnA0rQxXUqxgPFcN5FFmZ1DHdc6mRIoougB08bPum5ctx5mGdYBLMBllI20ZQwywX
         GsosFTC7bkpcR7C+TuJ+4VIi+eYChTNMCf2uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=WtsUEsqMTxeu0ASY9ZGldGWSKXK/Bt2mBtS4t1K1jok=;
        b=j9dA29FElsHTIQJETlxwztUlHdxGaD2mZuwaSYYihucRkFLNFyKKgG5olUNdK9IbQN
         hCr5EyWYl/xjZUqUXoTlj4YM5xWCjyfRZwtC9D9H1kWh3hKmXbDpoepfGfE1pPMTXU3j
         LeehIzbh8+c44mIC69dwvgaxabCcmFc7GiqB7vttnagxU1UGdKGkfDxmREBCrekl11ee
         Z9fX2sXxqVt7EVDDSgYRHHwhizoVRmkDXA5x54qjYhysP0/TZzD0N2VtBXdbzUgW+gqF
         Ar89oG/lXmKyTLclpNQMKOBoYX1oDMcnJ9Js54qhZ2rPqxJiYUyvrIz807W+lPBVmufL
         Xj0g==
X-Gm-Message-State: AOAM532rWoiidMyRTEY/vbspd6HTO5WW5DSP2cQfuouwqmwxHS7pyB5/
        z/G70ETOF+3dSHi199GEcnnzww==
X-Google-Smtp-Source: ABdhPJyi22ur2sPI/DYF4luwUXxBY5gmZaV71bLC6h6PGLbA+cDZDfqrOe18jGG3kcfwjHp+QTWrPQ==
X-Received: by 2002:a17:90b:4b84:: with SMTP id lr4mr20672140pjb.32.1629728601332;
        Mon, 23 Aug 2021 07:23:21 -0700 (PDT)
Received: from [127.0.0.1] ([67.219.225.50])
        by smtp.gmail.com with ESMTPSA id 10sm16158814pjc.41.2021.08.23.07.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 07:23:20 -0700 (PDT)
Date:   Mon, 23 Aug 2021 07:23:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
CC:     "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        Jiawei Gu <Jiawei.Gu@amd.com>, Evan Quan <evan.quan@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        Sathishkumar S <sathishkumar.sundararaju@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        David M Nieto <David.Nieto@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        John Clements <John.Clements@amd.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_drm/amd/pm=3A_And_destina?= =?US-ASCII?Q?tion_bounds_checking_to_struct_copy?=
User-Agent: K-9 Mail for Android
In-Reply-To: <4922d89d-1293-7b32-d684-c731c246e6c1@amd.com>
References: <20210819201441.3545027-1-keescook@chromium.org> <4922d89d-1293-7b32-d684-c731c246e6c1@amd.com>
Message-ID: <FB2A077F-78CB-4D84-A8F2-C63C57923496@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On August 22, 2021 11:28:54 PM PDT, "Christian K=C3=B6nig" <christian=2Eko=
enig@amd=2Ecom> wrote:
>
>
>Am 19=2E08=2E21 um 22:14 schrieb Kees Cook:
>> [=2E=2E=2E]
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh b/drivers/gpu/drm/am=
d/amdgpu/amdgpu=2Eh
>> index 96e895d6be35=2E=2E4605934a4fb7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh
>> @@ -1446,4 +1446,29 @@ static inline int amdgpu_in_reset(struct amdgpu_=
device *adev)
>>   {
>>   	return atomic_read(&adev->in_gpu_reset);
>>   }
>> +
>> +/**
>> + * memcpy_trailing - Copy the end of one structure into the middle of =
another
>> + *
>> + * @dst: Pointer to destination struct
>> + * @first_dst_member: The member name in @dst where the overwrite begi=
ns
>> + * @last_dst_member: The member name in @dst where the overwrite ends =
after
>> + * @src: Pointer to the source struct
>> + * @first_src_member: The member name in @src where the copy begins
>> + *
>> + */
>> +#define memcpy_trailing(dst, first_dst_member, last_dst_member,		   \
>> +		        src, first_src_member)				   \
>
>Please don't add a function like this into amdgpu=2Eh, especially when it=
=20
>is only used by the SMU code=2E

Sure, I'm happy to move it=2E It wasn't clear to me which headers were con=
sidered "immutable"=2E Which header should I put this in?

>And please give it an amdgpu_ prefix so that we are not confusing it=20
>with a core function=2E

Sure, I will include that=2E

>Apart from that looks good to me=2E

Thanks!

-Kees
