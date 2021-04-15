Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025523615BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhDOWyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhDOWyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:54:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:54:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f8so29986675edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZPmXSJHlNJkGabrxCzQ+1bNVgcNhlvvFPZsThC87BQ=;
        b=0/Bv9AMjps8ZT69MpMit11F2p9twNVTVYb+XVv9QK0JxYFc5DvplRTa70eF1YbSfMu
         IBkP1v8RHWg08P2iK/miye29yig2XeDlud0R4CkYnz0EAOTuVpy+cX7jEx6dcHmdnzsC
         6DhGckcXW/uRc2ecX2R+QDWHPUPGMN2b7OZhI25TlWuDwO7+Y7BtCCGo+z1tHYpWubGh
         W6IOmdyWPbvgjU9ZxMQ2zo0MnTE+QTrwXHN2bNY/B/wuPeBSD8viT2PIlL34ggRpAtYF
         RFPmZfJFEWz3M/cDojI6+EXjosI04PgHYSlkQH/mCcaVIhycSv9J0ikMzMpmmbuP7qgb
         PPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZPmXSJHlNJkGabrxCzQ+1bNVgcNhlvvFPZsThC87BQ=;
        b=TiZPw6N08el3qvADp2gc39j3Dj0qB5mxkuFthqOaqObDjL9ghGDfDlwzojr5jzPO9L
         L4qU4jGxGjWYacOMEUTY31r9MC8HbYRp8YpqFJhshKMWoxWNPFp6cQRsZJB5BGGcOpW3
         RKADMLwLIWzrH/5h71y5LFBJuLJLybxBGv18Snv8QdCcfDL6dmMcCQg1bwxKxUPdDzQ5
         UHDMLK8EX2vMxNmE3OikBxiG0ikZNuc1GqOVZK3eN1I/RGviiuJwSC4SeNNjx8X7c2zg
         12BpH4bCbvenf+G3awYRkqvgKzN0ffRgtZ0M3aBmkMmN0jswRIKd31rvQpf09WrimHke
         md3Q==
X-Gm-Message-State: AOAM530lCGxQnvNIecE8Nc/F6LpiRBJ25czb0950nKY+L8Nf7jIAE3Dy
        t/CtEUyZEO/OXb4wkeUFjqbH9k8S1ujAWSiW6cosMw==
X-Google-Smtp-Source: ABdhPJz2afjkEzncwyQD1rDlPyo0Ht+aLitlIBNnnevfCO5TgZ+sU9A5sYUKn48QokZdzy1MDkhkJuwtfpo7kv0FJJg=
X-Received: by 2002:a50:e607:: with SMTP id y7mr7076665edm.18.1618527252572;
 Thu, 15 Apr 2021 15:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210407222625.320177-1-ben.widawsky@intel.com> <20210407222625.320177-7-ben.widawsky@intel.com>
In-Reply-To: <20210407222625.320177-7-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 15:54:00 -0700
Message-ID: <CAPcyv4huxaVj=Czk7KgbwfS=6_Dc_N3MmoN-=faB_hSuSt7u8w@mail.gmail.com>
Subject: Re: [PATCH 6/7] cxl/mem: Create a helper to setup device regs
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 3:26 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Memory devices have a list of required register regions within the
> register block, but this isn't required of all CXL components or
> devices. To make things more tidy, and allow for easily setting up other
> block types in this loop, the helper is introduced.

I don't understand the point of this or the organization choice.
cxl_setup_device_regs() *is* the core implementation so there
shouldn't be a "__" prefixed version wrapping it. I agree that some
users will not care that some of the device registers are not found,
but that won't be cxl_mem_setup_regs() making that call.
