Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19E34813E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhCXTIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbhCXTIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:08:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776A5C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:08:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l4so34690169ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqthZoZ24hBKip/rpytb3Jw5ErL/sxzA8WMYUKwyAfg=;
        b=uPYi4SzDipjalS815p3jLLVPTQE5hGgWicR3QBBRxyKplVZiA81He7VrpFCy7sIE5n
         85kmUU3Af3xU689pmoJGzXSvl7aybl6vw8WvgCeTHoPVUN5wQB46+llWYB9Ek/O+zqlq
         YWlG1eMjw5j/CWTSEn2ZnfMgAED7N59RO4OnV2o17EgmcVUkFXKnNf9WC+X0JNlx+Ffw
         ip53beNMgDyCFnAdTQdGjo22pWPpTcbuCpcYETFdsUjTjeWh3/yOWzyKyv1vMwZ0EmpQ
         lFztkPRLKq4E2VTgYlMxP0025WvafUkbUPZoAGVwVyYfAUAPhOnSDJThBU82PpO3nUdI
         GBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqthZoZ24hBKip/rpytb3Jw5ErL/sxzA8WMYUKwyAfg=;
        b=a1zafoCL/Lt4yR3j+itu8+oP+vIWRxgsdAt77OdXKDEairy+GiohbF3n5oyOTUjR2N
         1eV4S0SaFfFhCq+ny4mweQJ8jJ9EN5k6iGR4+Mze50ILHjiyateM7c7XNNVR4akPogUm
         pjPtJ9u5sL3TmE1tdx+vybJCI1tnuJQZU+5pG0tT+fugfEj3xWjX4Ys9QwkvWlE5Rb3B
         Hivaq0ZXtuKVz52bS6sh+Zhkj3k+JFKf51JGCQ0Q6PYCxeXUa5AxSpO49kreosirfRb2
         rjbkuzaWa9StmYZLeKLeMBxpYusUpGjuNLHckIWxqFDIc2uiApxPC2NhpoRDrjeO/8NY
         vUVw==
X-Gm-Message-State: AOAM5303o9yHx4HpXy3Hvl2QuhwfRwoUHPs3H284gf4Gfjj/sMKM1You
        4NepB9xHJRqATvxyswsssl1qCVUxcieuSUXGjEokaA==
X-Google-Smtp-Source: ABdhPJwLaZcOmB8Yla1Xr4tCyTq80RomQZM0ap0Otgk6RtHaE3ue8wlnH2Dno8OBfAXEhtzM0znVhi5j65z4fk7OxS8=
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr5403301eje.472.1616612911208;
 Wed, 24 Mar 2021 12:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210324141635.22335-1-rrichter@amd.com> <20210324184257.GV3014244@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210324184257.GV3014244@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 12:08:20 -0700
Message-ID: <CAPcyv4gNvnMEL3kOjTYJjYG=7-N=jUUg-5+EqVszEHgSvF+XOw@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Force array size of mem_commands[] to CXL_MEM_COMMAND_ID_MAX
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:43 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Wed, Mar 24, 2021 at 03:16:35PM +0100, Robert Richter wrote:
> > Typically the mem_commands[] array is in sync with 'enum { CXL_CMDS }'.
> > Current code works well.
> >
> > However, the array size of mem_commands[] may not strictly be the same
> > as CXL_MEM_COMMAND_ID_MAX. E.g. if a new CXL_CMD() is added that is
> > guarded by #ifdefs, the array could be shorter. This could lead then
> > further to an out-of-bounds array access in cxl_validate_cmd_from_user().
> >
> > Fix this by forcing the array size to CXL_MEM_COMMAND_ID_MAX. This
> > also adds range checks for array items in mem_commands[] at compile
> > time.
>
> Can't we use ARRAY_SIZE?

An ARRAY_SIZE() check in cxl_validate_cmd_from_user() would work too,
but it wouldn't give the compiler protection that Robert mentions for
going the other way where mem_commands tries to add an entry that is
out of bounds relative to CXL_CMDS.
