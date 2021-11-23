Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720AC45A9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhKWRUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhKWRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:20:33 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE99BC061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:17:25 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id v2so15418342qve.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dC7uVzt5MrM2Gpk9LsKlRUHiHwvI+5kbQiNrhRQEF6A=;
        b=HM1ELBL6+qrvalddZKiZw/V6FXnHcMyFZLZfs67w7amsPIslJxelFU4TMjYnUqS5mW
         8NGMFJ7vfDrM/iIXSd6jsaSLlTg0VQj+QMdCvE41WvkoCQBAGaDgpZRmoNmqkXvsB1cJ
         QgaGAk/Av+gjr7UM7Zq7HZnZkL2lyALAZbInsSeNoJir4dw7UbP1UIjcPig45faa/64/
         jvC+pTThM3ceUYvLfwJ1+QSyuWBdAknmdurKpKyDdLKAg+5N3alo4Ec3Wbpm2S8/Uv2w
         AYnn8nIrJjy1LY7CJh3Z1dDw4IS8yETG0cN3IlthsDTwSlINDkSJBQLctYDFC3FUmN8E
         3+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dC7uVzt5MrM2Gpk9LsKlRUHiHwvI+5kbQiNrhRQEF6A=;
        b=gQ6s8wZobXHN3by9xOi24IpgQYUdO+yVSWLBIVqIwzsDorfO0DrENVBRyJF7QxGDMQ
         Os2DpwxVEHg6l5TG8TYgCMmWbMu/FI/ai8CmRDDGQxBofs0gvkXwz5UPFWEQx2Gjob1y
         izbh4Vari0IzBm/zAueQ9bY7YxIBap6bpLVDWM9Q9HzSBz7BWIFLL8mKSaCP7jVvbbfh
         ryU9w23BkfZoGdRGVdVT2rePFkWl+HkE4RRg/EkwHimwzkWjPkdIE3Aqh2jQgylyvx5E
         2a3qicGPCi5kGGDGPjghgoz0pAeqV7Stuc7aG3+bbcRD8JwzI7EzNTicNU0fAfXJGoWG
         UuPQ==
X-Gm-Message-State: AOAM5313liR6qcX9Ybu9gEGBemRzRFHxWN2lYMJehOu9Ed6GKzYBngRD
        MiFHyHZZ2wxUWNxu44DkKyZDZA==
X-Google-Smtp-Source: ABdhPJxtD1ArRYMjSPPd0YoD13PmNVq/BXBvjflzk5qi5Q9ez9zBHlK3Jkepb5uP7WHDg9Rr2wTk4Q==
X-Received: by 2002:a05:6214:246e:: with SMTP id im14mr8350503qvb.14.1637687844906;
        Tue, 23 Nov 2021 09:17:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x21sm6354233qkf.77.2021.11.23.09.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 09:17:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mpZQ3-000Dij-2a; Tue, 23 Nov 2021 13:17:23 -0400
Date:   Tue, 23 Nov 2021 13:17:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <20211123171723.GD5112@ziepe.ca>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <6de78894-8269-ea3a-b4ee-a5cc4dad827e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de78894-8269-ea3a-b4ee-a5cc4dad827e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:06:02AM +0100, Paolo Bonzini wrote:

> I think it's great that memfd hooks are usable by more than one subsystem,
> OTOH it's fair that whoever needs it does the work---and VFIO does not need
> it for confidential VMs, yet, so it should be fine for now to have a single
> user.

I think adding a new interface to a core kernel subsystem should come
with a greater requirement to work out something generally useful and
not be overly wedded to a single use case (eg F_SEAL_GUEST)

Especially if something like 'single user' is not just a small
implementation artifact but a key design tennant of the whole eventual
solution.

Jason
