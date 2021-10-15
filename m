Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5753C42FCE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 22:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbhJOUSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242977AbhJOUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:18:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0956C061766
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y4so7107947plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLrCUjMS6PpGbtB+8mhXMW1Ydnsrl8bMCJvRUQizels=;
        b=WVmWXqed83hwr0BldYX/afwa2GbpIGZwQjPSy/t/0JCMx9AA3HwxPAEoNSxpJnB0Yx
         fik28dWjsco5sZcynW6vCxEOGuDCcJkT3iUqTzko4G0XSQOOqA+QSRlWvgPkUzZ8V9vT
         4xwMKveUV/iuXskzwET7y/xGFKIkQhDlpaDHWOyGcvlA1O1xIIHo8ciWtrekXQ8bvaal
         alYpuUsz7ne8h38wf9qOthjsznOmfoClqe3jgW9ABNzMY2OCsxJTyAIrylM7Fevvghsz
         UpnlHNCPaziwRwsJVKVa9CXVQb/qVr+HtLg3/tKYpQyECxNGKlOz4xssnXiOuRWJeOcA
         R8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLrCUjMS6PpGbtB+8mhXMW1Ydnsrl8bMCJvRUQizels=;
        b=Xm2XTb1YB4cdQmTLM+XRL5mIMr2oIqJ3y6Qek6R8/82RKlhor3cBD1SH3DxzzHqQrl
         40Uoxdg3TJKPK1OB2sBWXxzMf+x24j2VJWb+LBnq7P4Xw3Kt35CovOt4Piet2e2+IZcJ
         q0WaQw7uKRiWYUooP4/oDBa+pKnwVvnw66C/bF+oOZdTZj9Xmyc15OK7F6Y5n/fPb0Tq
         X+cjTlAF6xBxT6Ij9lIWRpbFUKNJbA/aNojEuAkAKRmjnQ1v109RNFa2PXbyuimv7Cyy
         wL0yOTDax8UQcZEWXu/OuXidDDTgxifhjFRL+Rn6pXw7a/TT94Rr2ab+0zhleFQ5Dffu
         ppIQ==
X-Gm-Message-State: AOAM53198n5IRoSdVs/Bm8hdR4TIYAzL/gpTNkATJnfxJlIKBWTsWVoJ
        rOX+kGhnOfioGocmQOVJAd1kw75K5OHnYOerc19rgg==
X-Google-Smtp-Source: ABdhPJyqO7cyxR1HWTwbNFXiy3gHcuBypDcdwk0AxuecjBTkJfqydJHqiG8cOEwJT7yATjZpuEurgvMIvodG41/Bexc=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr29951880pjp.8.1634329003303;
 Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379785305.692348.7804260538462033304.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211015171507.000010dd@Huawei.com>
In-Reply-To: <20211015171507.000010dd@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Oct 2021 13:16:34 -0700
Message-ID: <CAPcyv4hOyXdoDcVUu8+x=xQCTfQQbafWZwA_wqmHq57K5DpEBw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] cxl/pci: Fix NULL vs ERR_PTR confusion
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, stable <stable@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 9:16 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 9 Oct 2021 09:44:13 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > cxl_pci_map_regblock() may return an ERR_PTR(), but cxl_pci_setup_regs()
> > is only prepared for NULL as the error case.
> >
>
> What's the logic behind doing this rather than adjusting the call site to
> check for an error pointer?

Minimize the fix for the stable backport. In the later patches the
cxl_pci_map_regblock() => cxl_map_regblock() conversion goes from
returning a pointer to an error code.

> Either approach is fine as far as I'm concerned though so this is really
> just a request for a bit more info in this patch description.

I can include that note above to clarify.

>
> FWIW
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.
