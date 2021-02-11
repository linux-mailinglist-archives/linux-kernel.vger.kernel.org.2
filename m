Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0410C319237
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhBKS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhBKSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:21:07 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C4DC061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:20:27 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z6so4211297pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 10:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=Cbm5t4xdDgYyvmuj01IggUGcS4IrsxtHX8PXqUxnE28=;
        b=XWzTE+8RvsXoeCQ0IyhZcgqQkYPgCp7ksaP/kTCA4QmYoO4obvjERd5b+xSDN2em/Z
         dxXVaifPZWrUxKSrf7+15z7bWxkQTltPnjvJoY0jAexkNi8LncYVLhVEfyHjaZh8ts77
         oRWEbx2eN/7VCOBDNekII5FePBfEaOdbXh3boPvEGccuC+zB0bNx8HPXgUTsGvgKgvdS
         DAllK/chVFom2LRDgx1NaE4hoQg88HHnYCMym16dA3wXJVriOhlMxXdBinn8R2zcxFs+
         hLQghen66SW68NjQDEErOEhPPETTPy3CDzBa1aYYgb12Cn9NA6N5GINQu+J0OY68SVU2
         K/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=Cbm5t4xdDgYyvmuj01IggUGcS4IrsxtHX8PXqUxnE28=;
        b=Rrq3X3tSx0iWzC0OOhxj8gZlGecALoR07HEfixI2t4vmNglbbTl67Jze3GgeNTMr/j
         vT75LrfdioImGPMrF/e1fxxSHxgTYvhr8riB80SFZH+XF9qV2NQ4wWOFoLeexOTCVcpX
         1kvkOQcIZGyunv8Lk767uFBnnzNhhs0qMlaJPVVTq8HVD4wxLXOxNlqCKiaoR/0Gol1s
         Z46NLb5UIcmv+RkmaEAOIeAQh/Mvn0heLlv6NVCQ+OgiSkXRb8kEI0LcbiGUg6YNFUK1
         1ZNQusZwy1EKegMo95pka7E6C0CDjllg+oPxuLcDSkvN601RoItboNjUUSjNmwhf/EJq
         QPEg==
X-Gm-Message-State: AOAM5330ONPLVOKDl3MrMXNorVI371fM9y8ss8eDPPou9SLTxYQag8P/
        IKQfPpjGiEnqBLO+fklWmjU=
X-Google-Smtp-Source: ABdhPJy//fsefWl6vy9iZ9e9dNlHE5806/umnwWzs21xaX4Mm7MQ+GxcwCp/7nZmkv1U5sFWhMBINg==
X-Received: by 2002:a62:2981:0:b029:1d4:ebcc:5001 with SMTP id p123-20020a6229810000b02901d4ebcc5001mr8910934pfp.46.1613067626766;
        Thu, 11 Feb 2021 10:20:26 -0800 (PST)
Received: from ?IPv6:2601:1c0:6c02:1d30:4920:87a0:85cd:f278? ([2601:1c0:6c02:1d30:4920:87a0:85cd:f278])
        by smtp.gmail.com with ESMTPSA id y2sm6044815pfe.118.2021.02.11.10.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 10:20:25 -0800 (PST)
Subject: Re: This reply comments on the patch to fixes the missing a blank
 line warning
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20210211072918.376837-1-adithya.chandrakasan@gmail.com>
 <bce53689-4a6e-c3c3-a09c-6e946a577f61@redhat.com>
From:   Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
Message-ID: <3512c272-dbec-2c0a-4476-203315341fe2@gmail.com>
Date:   Thu, 11 Feb 2021 10:20:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bce53689-4a6e-c3c3-a09c-6e946a577f61@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------A9ACC245C9C3245F988E54BC"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A9ACC245C9C3245F988E54BC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

On 2/11/21 2:36 AM, David Hildenbrand wrote:
> ^
>
> Please create proper patch subjects. Nobody has a glue what you are doing when looking at the subject.
>
> "mm/util: fix ??? warning"
>
> Which raises the question, what is ???
>
> Compiler? static code checker? ... ?
>
>
> Thanks
>
> On 11.02.21 08:29, Adithya Chandrakasan wrote:
>> FILE: mm/util.c:930: WARNING: Missing a blank line after declarations
>>
>> Signed-off-by: Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
>> ---
>>   mm/util.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index 8c9b7d1e7c49..60286876636d 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -927,6 +927,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>>       unsigned int len;
>>       struct mm_struct *mm = get_task_mm(task);
>>       unsigned long arg_start, arg_end, env_start, env_end;
>> +
>>       if (!mm)
>>           goto out;
>>       if (!mm->arg_end)
>>
>
>
Hi David,

Thanks for feedback. I have fixed the issues in the patch thread with
change in subject and also log message.

with regards,
Adithya Chandrakasan


--------------A9ACC245C9C3245F988E54BC
Content-Type: message/rfc822;
 name="[PATCH] Staging: mm: util.c: checkpatch.pl coding style warning
 fix.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="[PATCH] Staging: mm: util.c: checkpatch.pl coding style warn";
 filename*1="ing fix.eml"

Return-Path: <adithya.chandrakasan@gmail.com>
Received: from localhost ([2601:1c0:6c02:1d30:4920:87a0:85cd:f278])
        by smtp.gmail.com with ESMTPSA id c23sm6180015pfi.47.2021.02.11.09.59.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2021 09:59:23 -0800 (PST)
From: Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
To: akpm@linux-foundation.org
Cc: Adithya Chandrakasan <adithya.chandrakasan@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Staging: mm: util.c: checkpatch.pl coding style warning fix
Date: Thu, 11 Feb 2021 09:59:14 -0800
Message-Id: <0c1ce6d55fb011f29b2c22134f59829402eba175.1613066176.git.adithya.chandrakasan@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <bce53689-4a6e-c3c3-a09c-6e946a577f61@redhat.com>
References: <bce53689-4a6e-c3c3-a09c-6e946a577f61@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FILE: mm/util.c:930:
checkpatch.pl scripts basic coding style issues as below
WARNING: Missing a blank line after declarations

Signed-off-by: Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
---
 mm/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/util.c b/mm/util.c
index 8c9b7d1e7c49..60286876636d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -927,6 +927,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	unsigned int len;
 	struct mm_struct *mm = get_task_mm(task);
 	unsigned long arg_start, arg_end, env_start, env_end;
+
 	if (!mm)
 		goto out;
 	if (!mm->arg_end)
-- 
2.25.1


--------------A9ACC245C9C3245F988E54BC--
