Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B554D3CED6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384451AbhGSS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357173AbhGSSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:05:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CEBC061766
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:31:15 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o9so8892610qvu.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gVSVogAXROTPh3Dssd0UNY8nOlWjhPggt2vXEoxEy3U=;
        b=oydbKBWLfMAN9YjAsnWY1riBcENGN55t7esTwa86bYBQusYt5haJf44rKAdNZgprlR
         NNtNSMrpy0XZUzl6fgTZTIBA62XF2R4XNlMQBbd/FJ/pmzsZvpmjeMsSsBV3kFuRndr/
         KIAYISKEzbnLWgj47t4BrcD+EGmS5zfijzU0zhnKUAYgD3qfakhN+Ufr1W07GABWpWav
         nKqxGYL1aY4W+EyEYa0RCW0CaUteZqhYW4L9NCA8kNSyDvR8eRMYea6yESkA/j+O5Jq7
         lU/GyjEvL9J+Q4NKZoBVVqd1KYexU6bLsvy6LMUneuRyHyeVJnJnyoSg6W7E8/FaEJWf
         /erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gVSVogAXROTPh3Dssd0UNY8nOlWjhPggt2vXEoxEy3U=;
        b=E7DrVUgRviY7Qfs/2vbqqYP6NRxmMC81wQbcghnfiHr2kKsp7zH+0h7vLSfijXGyBB
         Y5nLBh9yevraMIiUO5WvPp30zWYVFmwBSk/uP6Tn73Uc9TI/0bgdtv4F3jc8Ya9RS/8B
         fFTUzrejBXtVvVuG7lQJsroSdFZy/FSeDPp1EFBJ3u22RSwu0MWfm+WKqoRLRXfXaw6Y
         t6qQJSpCqizPbkzLbEDAowaC3NbbCt0KZTKf24AASNg/0gefMeH5cqK02VVvY9q5HQYq
         o9WTSDG3TmitjPNOquwP5Lkf2zjnPJ2PiwYwVl2HB5gAu/Hi+V767zvCJy3kDDl0VIHs
         mmgg==
X-Gm-Message-State: AOAM5308mGx4Vp5uhQPZmVJ9CQqwtECcMed9mj2XuVS2Itw0jLPc0inS
        F4iKNGQjUtXq4nZqRiX5Y3U=
X-Google-Smtp-Source: ABdhPJyHxmWj4jRy+IaYfbUTtp+JlyfSuTdFWpuyI6w/20JYm0iGpz1vIYlNh7ENCzyfsSCrPoqRZw==
X-Received: by 2002:a0c:8c0c:: with SMTP id n12mr26495316qvb.13.1626720220683;
        Mon, 19 Jul 2021 11:43:40 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:92eb:ffdf:6b35:b94d:258? ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id n13sm558843qtx.92.2021.07.19.11.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:43:40 -0700 (PDT)
Message-ID: <c289fe19580ece6941fc74563d301c4fb3ab9125.camel@gmail.com>
Subject: Re: [PATCH v5 01/11] powerpc/pseries/iommu: Replace hard-coded page
 shift
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 19 Jul 2021 15:43:59 -0300
In-Reply-To: <d96c25e1-41da-881b-da35-87ffb28ce335@linux.ibm.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-2-leobras.c@gmail.com>
         <d96c25e1-41da-881b-da35-87ffb28ce335@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-19 at 15:48 +0200, Frederic Barrat wrote:
> 
> 
> On 16/07/2021 10:27, Leonardo Bras wrote:
> > Some functions assume IOMMU page size can only be 4K (pageshift ==
> > 12).
> > Update them to accept any page size passed, so we can use 64K
> > pages.
> > 
> > In the process, some defines like TCE_SHIFT were made obsolete, and
> > then
> > removed.
> > 
> > IODA3 Revision 3.0_prd1 (OpenPowerFoundation), Figures 3.4 and 3.5
> > show
> > a RPN of 52-bit, and considers a 12-bit pageshift, so there should
> > be
> > no need of using TCE_RPN_MASK, which masks out any bit after 40 in
> > rpn.
> > It's usage removed from tce_build_pSeries(), tce_build_pSeriesLP(),
> > and
> > tce_buildmulti_pSeriesLP().
> > 
> > Most places had a tbl struct, so using tbl->it_page_shift was
> > simple.
> > tce_free_pSeriesLP() was a special case, since callers not always
> > have a
> > tbl struct, so adding a tceshift parameter seems the right thing to
> > do.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> 
> FWIW,
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> 

Thanks!

