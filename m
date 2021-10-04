Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250C6420499
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhJDBLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 21:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhJDBLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 21:11:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3424C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 18:09:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so273926pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 18:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=tYMVuRWh54bny2SjmrFoNW0MTZjKd5FtpbZYf3hiDKg=;
        b=MSZHOt0B9z/8H1fjEMG3UfL1M18TJupOsrTYHOIrVoZgM+Su8Yi/s1NrWF6N8UPyeY
         v3gORNxXHm4qrWA1cathG9c/iAX4D4FbWxen63qLtzjOns4Pf0p7AUmWf6VKqBpBfw3M
         6bKQwpAiPJ13hcQLvcJH5mgjpjNSftHkBioqZQwJjo2M201KKAzHCDAUQmlFI8o4Ig9l
         5DCwb7AUfmEtEVvRL78B+9ORNB+eVX+CvM82Fm16nHBcO+g30vY49t5ZODWwSvS5K4/e
         AyjrQO/+YbC2RQC7m1Ge1QLD7Q2yYLOCwUBiuKGcijGXI8ckICVHNW0znIRp8K4wMbQM
         j4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=tYMVuRWh54bny2SjmrFoNW0MTZjKd5FtpbZYf3hiDKg=;
        b=6uRxyhlyJRNbLLd4xPCw7UqTQOUwePrpVngisHZBstxtRIPboSJwRJcmB5QnK0Iiy3
         E61yY/4biAo1hTmmmjtsTCjbkTxOZAs5ggNIW1mlWEszAj9YhYcQBL7Vrs1cd08dlUDy
         0+EbhmuIxetww/HWr9mZ5THAD0ElV6eWc0iVqdzI6zQr1bDDR5y5nl/iEy1HiCVsScqg
         CUWVOCcCFCE/GQnFESyoNR7X2MvxD2a+IfEpAxIM73q14+c6O4caKQYCpI2DcGtyjDxj
         YfeyfYNSCVesNIBpmmX9qZ1CyWLJ9wfSEsO32FcNx0erdkqYAAW28KaohJPXGSF1Y9vd
         Re6w==
X-Gm-Message-State: AOAM530deElwBhTq+1TQexXAvXrqnHHaoyZwCbJlE16p1em8luEmcSmh
        uK1iL0FDFFtSJC4KegoYnTpxrA==
X-Google-Smtp-Source: ABdhPJz+LcM6lCI6zfz0/npAtZ2/gJ5dvVsOhmHTxZkxlXfzxzXN4iCrapVFQ0HwAlNrSzwliQPYSA==
X-Received: by 2002:a17:903:228b:b0:13c:94f8:d723 with SMTP id b11-20020a170903228b00b0013c94f8d723mr20837288plh.12.1633309768147;
        Sun, 03 Oct 2021 18:09:28 -0700 (PDT)
Received: from [2620:15c:17:3:4faa:17e6:3602:9e7d] ([2620:15c:17:3:4faa:17e6:3602:9e7d])
        by smtp.gmail.com with ESMTPSA id r8sm10526493pfg.91.2021.10.03.18.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:09:27 -0700 (PDT)
Date:   Sun, 3 Oct 2021 18:09:26 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Shi Lei <shi_lei@massclouds.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove useless lines in enable_cpucache()
In-Reply-To: <20210930034845.2539-1-shi_lei@massclouds.com>
Message-ID: <8b1d6cbc-67ff-bb4d-892e-2256ffe693fd@google.com>
References: <20210930034845.2539-1-shi_lei@massclouds.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021, Shi Lei wrote:

> These lines are useless, so remove them.
> 
> Signed-off-by: Shi Lei <shi_lei@massclouds.com>

Acked-by: David Rientjes <rientjes@google.com>
