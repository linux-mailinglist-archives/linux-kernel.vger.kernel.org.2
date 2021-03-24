Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB64E348107
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCXSzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbhCXSzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:55:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3618C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:55:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u21so16665333ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USTLtYBddABHrCkfh8cUV6zNpEAW0Ov01BpHFOTxbnQ=;
        b=w3abrHi+NxbMHphiQvyDtmRcFsDLtW5AQyYp20f3KJPpuwYsWX3fJsqfzMzYnMhH/R
         Fk30eR/4s0H8kaLLhRboOVth2XKChSMtBFt667SxwIvELjtVW1NdYqcPLcTXbDirW9su
         VV5Gdz9dQvlcw8JGpg5hiBoXgZz1a9odf4hgkD68ghazH32AXiLvt4ELIilfjsFwxh7o
         uRQv+KhH8FGKU5sEUSsj5ov2iRnQYKS8tLSWz24eQEl7hShVRBabZRvsmbULUdUQ79p3
         ETSLU+2C06bf+9iXAM9KoAFTxuBVHwyAZXeVzhfindb0zDHb6bg2iAUnxX15PsTyx+ET
         Yqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USTLtYBddABHrCkfh8cUV6zNpEAW0Ov01BpHFOTxbnQ=;
        b=TiwL3V+/CylMFzCjg2jEvG1c9dWG2NDObEIXSHa2vr6Cd9jOQKJ17hKUgEkVOYn+0n
         gnWwoIEbP/5bT6+DPrcK5dQd673PNlelpeUPZyZSc7bq4N7gve6k3essiAHt5um8pnO5
         VuA+IFDpRDFmPe1MyeTYFr0pmxzDtHUgUP4m7MH/MaCkvJyImVg0q7u6UOHNwYGAwQpP
         MuwdwYEoTUU35Su2sI1uua1xGTVI1UJSSvCDLRwnHAy0VEhUxYR8yn7B50qAhyeoh1PK
         bkLroBWJUD2h2sKk53iNMkOGL1AB7hBIV7rgO19U7NxWcTDnX9N40eqVQVC1WMnuId2h
         cQEw==
X-Gm-Message-State: AOAM5314vDjsqWtME6yzfOHD1R9p8BpP8pkJZx1tZ3B4/dj0LGXrPeyK
        6Aig3pwIXVz08aSJbRfaqBLkB8qM1dLW1KWz7rWp6w==
X-Google-Smtp-Source: ABdhPJw3o8Ig8Vtss2skp4YnpH1ywJ3FAhDAcKSwnmAXfzy6tPPsWUk2gtGLflW/kkKv9ppaUegpuDoH2a4TfjQRgBI=
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr5381135ejg.418.1616612110562;
 Wed, 24 Mar 2021 11:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210324141635.22335-1-rrichter@amd.com>
In-Reply-To: <20210324141635.22335-1-rrichter@amd.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 11:54:59 -0700
Message-ID: <CAPcyv4gQzTZHX+fO45V+U4onhOA-H-U6E+GeqySdxHvNcqYeUg@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Force array size of mem_commands[] to CXL_MEM_COMMAND_ID_MAX
To:     Robert Richter <rrichter@amd.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 7:17 AM Robert Richter <rrichter@amd.com> wrote:
>
> Typically the mem_commands[] array is in sync with 'enum { CXL_CMDS }'.
> Current code works well.
>
> However, the array size of mem_commands[] may not strictly be the same
> as CXL_MEM_COMMAND_ID_MAX. E.g. if a new CXL_CMD() is added that is
> guarded by #ifdefs, the array could be shorter. This could lead then
> further to an out-of-bounds array access in cxl_validate_cmd_from_user().

Good catch.

>
> Fix this by forcing the array size to CXL_MEM_COMMAND_ID_MAX. This
> also adds range checks for array items in mem_commands[] at compile
> time.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Thanks, applied.
