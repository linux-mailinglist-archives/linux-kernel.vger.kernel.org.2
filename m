Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE7F42E268
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhJNUI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhJNUI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:08:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F0C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 13:06:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i76so4269077pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GJT+WyhKftBBM+eaXYuSKZOj3v7ZZ3RRSkVYUNQdn4=;
        b=aGQVLv3TbmguMFFItCAXFcKYXRfAQWISbVaWA0DuUGGGQRW+nZ2FEvR89nU8DfyGw3
         iJ5/R1lMYJAxOEbNwLSaTfRhwanwRY4Pu/+alTdIm/nStLf72rP2F+eTSDseEGwio3rg
         DtuZoP0ajhociz0DKwZpVY0WBcvBabuuqqBVsKMcZ0nXt1JccDnmh6SX/DDEq5sSLTUJ
         ILrPgaMngpKVOAtUzq5GwXFtZE53ZxPaZXFSmorbHcGAlcLLQBEf01AtZksIa6cGqmlK
         fXbaH3R0iNPbsFLBbDWS4lnPdJO/4ww3F108fjYEUEA/dWH8Y1PZzjBm538RvTwXj3Z/
         P7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GJT+WyhKftBBM+eaXYuSKZOj3v7ZZ3RRSkVYUNQdn4=;
        b=xn+HMTcY44A9Y/GsSq9x03BDEFDK0F8R7U6uhOasBJ7/S6BSlDuuYd9k6tVL2sng2z
         TgP512K43cBOi+Uh5BORhfZWs0zYsD7ClGPc+Vy2JFpy5DhkKVbIbqXYdGTBNC4tbzCP
         QEJbNkFk/S/Bqgydwra42IVoITDT02MbckNZlA/x3tHDzJtWOnUSSbwSs7u7P3exB4Gx
         Bvokt6weVrHY0AQGkr233s94Fa1e1FzO4I0Mo+MpFvDNvHWXN4+KvPETUzGCCJuAhraF
         nv883bGmuRIb05MD1EyeRNsU5sgWV1YehfHM2zdSNf5MAOEGGnMdo/nle/M0LdDvxumy
         fwJw==
X-Gm-Message-State: AOAM531SPXK4Y3fnom5iw1LTh5qEQuox3d3aGMJx07MW3hoq5Z3C2D74
        IoT8KL7+tw3kED/48yA+iAAgsh7Nh8EQqyCq66wSgQ==
X-Google-Smtp-Source: ABdhPJwvMlPJz0MbG30nUKV0pSC7JljmfT/iwaguyw2Dhm+5p/gZjBNGKGVyRFrrXK9FIKVRQz+qrBSIzzqtGxIauME=
X-Received: by 2002:a63:131c:: with SMTP id i28mr5698065pgl.396.1634242012407;
 Thu, 14 Oct 2021 13:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211013195825.3058275-1-almasrymina@google.com>
 <20211013195825.3058275-2-almasrymina@google.com> <2ad01712-1a2d-76dc-a2ef-2fc4650c74cf@oracle.com>
In-Reply-To: <2ad01712-1a2d-76dc-a2ef-2fc4650c74cf@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 14 Oct 2021 13:06:41 -0700
Message-ID: <CAHS8izOiBwrW2DzuKPFqk9xtx5B3k-vVV7CZQw9GF+Vokoj9_A@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] mm, hugepages: Add hugetlb vma mremap() test
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:21 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/13/21 12:58 PM, Mina Almasry wrote:
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> Thanks for adding the test!
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> How about adding this to the run_vmtests.sh script with something
> like the following:
>

Thank you! Added, and set out v8 with the Ack.

Mina
