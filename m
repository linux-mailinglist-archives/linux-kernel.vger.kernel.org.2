Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488FA38015A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 02:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhENA76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 20:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhENA75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 20:59:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 17:58:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a25so8790775edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 17:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEpqh0+EO79bqyW92GQVGh/KezzVRI3iqRzND7tXdzE=;
        b=VyF5KAItiyhVUDoQPuSpn+6qkikMk2hl7TC6nDAY80mlI9Pwy7//OIK5bwd8VWGAjs
         LUoreoxokhhvpsC25SgrDuwwdLCMzPghiNv3kOqWghcYl5s19lLz86umn84/uvFpCKn7
         n6j5Kjexq6ICXKWPVLPeY+Z0gp6cI4cx1JQy0lAmT8rvNRbRqn48xIqLSlwSGZTVWCQq
         rxE36ApIMC0sHpYnPcGGFDjlGk/HSZSYK5zf2Hf04Up+ZKs4cUiUAMxCnVpvmwmOSZy9
         U8aW8T72WmOxPlXTzQGozkxhMI8VANb8asaEs4wrZHB2dNGDeoSdVls4rCw/oBbn3Pb7
         k5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEpqh0+EO79bqyW92GQVGh/KezzVRI3iqRzND7tXdzE=;
        b=JNkIwmGRVLaht6b2ZGd2Hv2tLoDSz+nkV94WWPEBhaMGTB1tOqHL/Ya3GlvTrU1K+q
         +DA0Il1LsxVFrUHwlO0wlmHZsfPJ8YzAgQVJv27RhI5xYAkRvGOjPyPpG85MYZ9FVSZI
         W/WNyQZfMYUBBfEVRO/7eJqM9ZWiJ8yc/pnctcvNRjPWW4TNbVAdW2mEW1rvZ6w9Uoh/
         g9+wFCMnTH3T7Ef6g7bblXwqLPgyAPSuFwjh3JRDMDQQMHfoK7VJ6Ig+4X99nCPX+yM0
         nWLeeJlCR3EeSi72h9FtR0/RJ2va7k8HYxKyv/CFhc4GVWJh8lKvupntrBT/O8qSb9sN
         4PAQ==
X-Gm-Message-State: AOAM531CBC0pn2fLTufr8hXtzMWicRFv7TF9HuHBvNajavHccIDY1kAw
        OqVXqAffQSsANVxYK5Q2UMtMuwM8iHnjWKtvS1GJ7Q==
X-Google-Smtp-Source: ABdhPJzh0giSiEG3dqURONhskurpZE+LPObxwoKMA9HM9nAfG4jEWbjEzfSMDxLImnc7mtMejPt2UnMYiX/bADUi9Qs=
X-Received: by 2002:a05:6402:54e:: with SMTP id i14mr54897192edx.210.1620953925739;
 Thu, 13 May 2021 17:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161898872871.3406469.4054282559340528393.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 May 2021 17:58:37 -0700
Message-ID: <CAPcyv4jgkAze76c6TNJ1_OKM91xjH0c_UHpsYsvaLcw6-APGrA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move nvdimm mailing list
To:     linux-nvdimm <linux-nvdimm@lists.01.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        nvdimm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 12:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> After seeing some users have subscription management trouble, more spam
> than other Linux development lists, and considering some of the benefits
> of kernel.org hosted lists, nvdimm and persistent memory development is
> moving to nvdimm@lists.linux.dev.
>
> The old list will remain up until v5.14-rc1 and shutdown thereafter.
>

Events have transpired that require this schedule be expedited. So
once this patch ships in v5.13-rc2 the linux-nvdimm@lists.01.org list
will be shutdown and all future nvdimm correspondence must be sent to
nvdimm@lists.linux.dev.
