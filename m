Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C4E422E94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhJEQ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhJEQ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:58:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CF4C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:56:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r4-20020a7bc084000000b0030d6fc48bd2so2198793wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mQFSk5tNjh4yCNVgqgn0pPU/iicxGTaTGaLZV1ngF6o=;
        b=NmjIr+evRVGz3FpBPYGjxl07PquOQFm8veryi8RVz2WSCJVw2pNEeETWTPgHr3cSzR
         Rmg/5OOITJdzZdqQwAYvSDcfu3vCowjZaQvM+cZlwCMyVvN1cVa6A0OW4WQVYv+d0YfG
         P6mhj1qcThlp4+SsrV34x8mqHOP6e+aUmvMkhLfszmKF8tOeJev1LwDwgbQeKpeUFOve
         47EUEZ2aXmgAn02Brt43g6XAj2++jo9YN+y9xafOphJAeNHxEiuv7+U/VSrTGAmQrvIT
         cVvjZISDbpBaTJijBQsReqAQBv7bNqi2IPbY9yIxYXrgENZkdTQhVsRKMmgALnCguLnt
         xt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mQFSk5tNjh4yCNVgqgn0pPU/iicxGTaTGaLZV1ngF6o=;
        b=K8foZuKUyflQDsE/hkgWiDFemSqh8bkYABqsHNMTB/be5tg6q5n29MwH0eLld77RhE
         H8NSYkzgPOXzXgf/yrytfOPwrmnnfMs2WBDZ4WC1Fq6lpgRptchHGZPBwkp1RRngP04+
         TivWLruJprPSgMAb3bOjeS/Dw4ryMmfEkUNYJ54teWsWFMTWkR6dfYqPRVooxIMoWWZk
         XgLYWa6p0IMrqPPUDakgO/X3SaY6Dboe2+tQWpGErdMHCiiizrU1kEqoKpsior1vIcM5
         u/rpThbpjZ4sI2KSiNKcdqb06A8jCxpW0hoslgXwoAD0OUQS10hoDddnxBSAsNN50vfj
         IcKw==
X-Gm-Message-State: AOAM530Fr1DrgbxlNuP/CLJmSyymmMqVmulcFJTYK6E+2YwF0kjolV5S
        OJtik/3SoSOjRLmjmnInpOR0KvgrJHM=
X-Google-Smtp-Source: ABdhPJwgM/2m3d9xlLAAJIUunA9JW0qFlTzStAqG+c+91t7z355sML/E+68BSs4WM8sakKf4fSXXRQ==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr4586724wml.9.1633453010540;
        Tue, 05 Oct 2021 09:56:50 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id u2sm17830629wrr.35.2021.10.05.09.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 09:56:50 -0700 (PDT)
Subject: Re: [PATCH] x86: move arch_get_vdso_data under CONFIG_TIME_NS
To:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>
References: <20211005164827.103876-1-avagin@gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <db24ba19-28b1-db09-c055-9bf5b9184a4f@gmail.com>
Date:   Tue, 5 Oct 2021 17:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005164827.103876-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 5:48 PM, Andrei Vagin wrote:
> This patch fixes the warning:
>>> vma.c:32:19: warning: no previous prototype for 'arch_get_vdso_data'
>       32 | struct vdso_data *arch_get_vdso_data(void *vvar_page)
>          |                   ^~~~~~~~~~~~~~~~~~
> 
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks for a fast fix!

-- 
            Dima
