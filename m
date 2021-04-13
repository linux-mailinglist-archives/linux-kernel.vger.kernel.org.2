Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270D035E4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347122AbhDMRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347118AbhDMRIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:08:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00FC061574;
        Tue, 13 Apr 2021 10:08:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so8160399wrt.12;
        Tue, 13 Apr 2021 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=K/kiVlWr9jXTw6l1mfaywK3J5oBfrjHUAoZh2g85M0w=;
        b=XED4oB6RsgA4wpo+b6abLPediKo9oasX8Sx58+/FjuOA9VqncW09qfnpEFg675hYYS
         37IsYdS/2p/SDCVXUifyYfTAmpU2GP8aQ1BaDPFgcirbn4oM8FE2Ld5topCMnRDBM4Nq
         PcUfmhAcCJp+Vtnrum16aLe720VQFhCGhASJRAXoMVJSkvIBB//rzO2WjsOoW8tD0P/e
         H3OjcdZ/ZI8qp2nFNtajq+EynV2SLhOGuBG0I84V6iqSCw7DPeG8OXwvQvRVa69HLGJA
         BTTi9tOeqKrtXrgawdhxW7iHMKji8wfBVi68l1jwhOw/bUCG8q33mmjNfRBAHksBmHQW
         87Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K/kiVlWr9jXTw6l1mfaywK3J5oBfrjHUAoZh2g85M0w=;
        b=ibWoy/X/+MFeAKIiYr1k6ZoFn5hPRNG3A7bGkHewoE8ZN+bsVIVjevR3ZIPythMveT
         2/DX+FU3as7amBxt0bR/oZEVkL/k7zNnDnxuBg1zhK+CTg5vRo+5hGhnJ/glLdJmmlXy
         BJWf/1qQfg+AWPdoiRktiEntEU8VCA10PzqslwYo4kf2unHh1A7kgFJH1qyCwr1vuBPd
         15hBr0x1acsHX+HQLeHcPfXDeQud55Ca8i01Zdl00iseWK62tf7CuBeyhDFjh6PocXRp
         hRZTSJjbpyRJWr7C5HQ3VbfTIPE8G2VLGhx4LN1FYLkimJGDxzBCL/1CZCJ+6LRPV+Yj
         2xZQ==
X-Gm-Message-State: AOAM532jPRCktjwyMKkcRA635DHdLRxvcvkKfy/1bnnpVo99bbtsr1eF
        V0RlaIKxRlC/ZD0QKhE6Pls=
X-Google-Smtp-Source: ABdhPJx3Uajeisnjyscy0g3utepSDCitXthgN6FMpqs5KrWDHciona1jpI6xn1PD20iDPvtwbRJvrw==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr39073342wrr.302.1618333695126;
        Tue, 13 Apr 2021 10:08:15 -0700 (PDT)
Received: from 192.168.10.5 ([39.46.65.172])
        by smtp.gmail.com with ESMTPSA id i12sm879580wmd.3.2021.04.13.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:08:14 -0700 (PDT)
Message-ID: <3caf81e242edacd91e32217261e2d21ceb5d4dc7.camel@gmail.com>
Subject: Re: [PATCH] xen/pciback: Fix incorrect type warnings
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com,
        dan.carpenter@oracle.com
Cc:     musamaanjum@gmail.com
Date:   Tue, 13 Apr 2021 22:08:10 +0500
In-Reply-To: <c619fb6c-6957-5b87-b0a1-6be96f8771db@suse.com>
References: <20210326181442.GA1735905@LEGION>
         <c619fb6c-6957-5b87-b0a1-6be96f8771db@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reminder!

On Mon, 2021-03-29 at 09:24 +0200, Juergen Gross wrote:
> On 26.03.21 19:14, Muhammad Usama Anjum wrote:
> > Correct enum pci_channel_io_normal should be used instead of putting
> > integer value 1.
> > 
> > Fix following smatch warnings:
> > drivers/xen/xen-pciback/pci_stub.c:805:40: warning: incorrect type in argument 2 (different base types)
> > drivers/xen/xen-pciback/pci_stub.c:805:40:    expected restricted pci_channel_state_t [usertype] state
> > drivers/xen/xen-pciback/pci_stub.c:805:40:    got int
> > drivers/xen/xen-pciback/pci_stub.c:862:40: warning: incorrect type in argument 2 (different base types)
> > drivers/xen/xen-pciback/pci_stub.c:862:40:    expected restricted pci_channel_state_t [usertype] state
> > drivers/xen/xen-pciback/pci_stub.c:862:40:    got int
> > drivers/xen/xen-pciback/pci_stub.c:973:31: warning: incorrect type in argument 2 (different base types)
> > drivers/xen/xen-pciback/pci_stub.c:973:31:    expected restricted pci_channel_state_t [usertype] state
> > drivers/xen/xen-pciback/pci_stub.c:973:31:    got int
> > 
> > Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> 
> Juergen

