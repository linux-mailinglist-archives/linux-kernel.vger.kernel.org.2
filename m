Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB393E9033
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhHKMMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhHKMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:12:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD6BC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:12:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so1799885wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yoCWtKwlDNRD9ROpBelkaelY/UvqY2ElqOHk1uHudf8=;
        b=K8SSmR2Fa01OJdUVUumcfLT+V7PhebggZA4Em7LMqggl311D5ardFhJWLDSfDAxiCB
         AxV542o6ZNm/CHA9lo7q6kWvIK731dxlgvQvZuDtlZ4KTVFXZkMsU+1HwDMYYlATpz7s
         KpzePEoLOtcaYFL5Xbwqcu4GABL5F8k9L57h5beSVnE0j9K0c9Cd76xGlDUk8e3ktjgR
         XJhSuLlU7T/ytRonTP1nO3P5MZpFZMrLaTdc26ksrqWY61122X1DfLVe7twBpx/TvyFV
         eMs6s8sD0SF0ZRnyZGI11NmK0Ziyq6UJQSOXHkPyXHSHRo9caAMJltPJibs4NImDxNCj
         KssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yoCWtKwlDNRD9ROpBelkaelY/UvqY2ElqOHk1uHudf8=;
        b=bwWrDCOcbK5v9an2bf5ccYP3ScqX/gQl+LTN62IPZPZsT3BbOj1Ok55L908rMlEdIy
         3sXl+vxU8M+n27A6QJAk4YwF7Y/y7VzWv+uYhxsNIshhZoeykyOt2cT5t1QD/m8FbVBM
         AR2EIP26TpCwRjMdt1O484gu5nbJkoBRXYQsbfyN10gVtRxc0rH9AayMHsDZNTye/L5f
         Ry6txudXve2wqImPHKDHV7uuKeiOUEhi04pIGtbeZEwCmn+NCbNOnaktxVGVmh07jQcO
         hX9i2nzXQzjxHgBUyu+2AERmOsUnQDAAqex+P75L+THYZMRIPvaj5ImvSXz9jxNHYysh
         d4jA==
X-Gm-Message-State: AOAM530EPXNvGDKLX5XooefTef2MRntHDG39086QwCNy0z0cefitwxi0
        OWHNBQVSAidIPf/C/zq9xMksQQ==
X-Google-Smtp-Source: ABdhPJxRi7G7fwUjQEP2bwVd0UX1v9O1KCKy7zY+1XnWPx8XCvY9Ac4uvk5hXra7G1X5iEaFn3uVtw==
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr9877293wmq.82.1628683922223;
        Wed, 11 Aug 2021 05:12:02 -0700 (PDT)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id q203sm1798077wme.18.2021.08.11.05.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:12:01 -0700 (PDT)
Date:   Wed, 11 Aug 2021 13:12:00 +0100
From:   Jamie Iles <jamie@nuviainc.com>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH v1 01/20] x86/resctrl: Kill off alloc_enabled
Message-ID: <YRO+kCdb43EzXEBa@hazel>
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-2-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729223610.29373-2-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jul 29, 2021 at 10:35:51PM +0000, James Morse wrote:
> rdt_resources_all[] used to have extra entries for L2CODE/L2DATA entries.
> These were hidden from resctrl by the alloc_enabled value.
> 
> Now that the L2/L2CODE/L2DATA resources have been merged together,
> alloc_enabled doesn't mean anything, it always has the same value as
> alloc_capable which indicates CAT is supported by this cache.
> 
> Remove alloc_enabled and its helpers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

There's a comment referring to alloc_enabled in rdtgroup_create_info_dir 
that can be replaced with alloc_capable.

Thanks,

Jamie
