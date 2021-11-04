Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA72E4451DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 11:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKDLCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhKDLCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:02:16 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C7C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 03:59:38 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bp7so5180264qkb.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 03:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yk5XgrdOGaW3p+sZvRRyB5VgAQCpuos1tmstcywTUC4=;
        b=XX1YBYYHmk1cGhVONndzHMCKWuohW4I4dM1TtuQ9FZOpOuKRiNQ7W8lU0mLOfMXMln
         tebH6GbKj86VppLGa3M9D3purC3zTa3kl4odzXyqfOMep4hmM3a0qwX/osMUd86fnJex
         U0DIvfNePhGdPEOvHNjDsXdK5/GWVJUwXUERwJiGXk/2e2mRrXAYzCD3Qpc+LQ/sb0Gb
         cThFB+zRxr3kmrwkLC58FnNMtAQW3aKy7QMCYwgjlB/2fidVHlkLUMDLdampm91nvXDi
         09TcE3LMsn5DCPDnkN07mT+vT4KeTjY8hiKaOrekAU9PQlcPpsIzBdCZ4ckpq+SnY5DM
         w6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yk5XgrdOGaW3p+sZvRRyB5VgAQCpuos1tmstcywTUC4=;
        b=kQFYaZfhTO7ilNTAWjQvY1qe8UruBS1CCVptlMyQnowz9co56pfIdNKET1VAFoFWAX
         lEhyoVsGgI5TnihgwAewAGhtI7EfAx0YyktAQaGrEpkTWdn+aFABdKwwr5IRJyDYfKwL
         XIEDZNz5WIENcj+p/RF2YEynGt+pjQiJPhMewN3wafIvJpBSza+gdlO8NCVc8czEhwdM
         vfOTuarUNMogKrNJCEZ/BSS1dJpa/BvHY4ytGnGhBeaYC276JLQLD3nkwbTLbgHOohZU
         WPgEpkb02hZThHs/uWzPslOq+ILj1800DPqnte8oT+d8ZL68bi8JKuwtP7ULpo+pkoNt
         sbrQ==
X-Gm-Message-State: AOAM532tL4hvX0WZaRtcA8XmO/1UpVH4q/NxGoOh2T3VqjWiXis4p4K4
        2RpN4A+o2MA2QtLAHOzIRqQNrQ==
X-Google-Smtp-Source: ABdhPJzhUAIh65nsdBGdq1eovhwrx6kLDOIqjGAzGexR5wn7UKV0JMgWgt2ucF4Fw2LrUUBhtCqJSg==
X-Received: by 2002:a05:620a:4086:: with SMTP id f6mr40328253qko.220.1636023577438;
        Thu, 04 Nov 2021 03:59:37 -0700 (PDT)
Received: from [192.168.1.173] (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
        by smtp.googlemail.com with ESMTPSA id v14sm101547qkp.9.2021.11.04.03.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 03:59:36 -0700 (PDT)
Message-ID: <4e602c87-9764-829c-4763-38f4ac057b7c@mojatatu.com>
Date:   Thu, 4 Nov 2021 06:59:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH v3 0/3] Introduce BPF map tracing capability
Content-Language: en-US
To:     Joe Burton <jevburton.kernel@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Joe Burton <jevburton@google.com>
References: <20211102021432.2807760-1-jevburton.kernel@gmail.com>
 <aa6081aa-9741-be05-8051-e01909662ff1@mojatatu.com>
 <CAN22DihBMX=xTMeTQ2-Z8Fa6r=1ynKshbfhFJJ5Jb=-ww_9hDQ@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
In-Reply-To: <CAN22DihBMX=xTMeTQ2-Z8Fa6r=1ynKshbfhFJJ5Jb=-ww_9hDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-03 13:12, Joe Burton wrote:
> That's a good point. Since the probe is invoked before the update takes
> place, it would not be possible to account for the possibility that the
> update failed.
> 
> Unless someone wants the `pre update' hook, I'll simply adjust the
> existing hooks' semantics so that they are invoked after the update.
> As discussed, this better suits the intended use case.
>

If the goal is to synchronize state between two maps (if i understood
correctly the intent) then it is more useful to go post-update.

cheers,
jamal
