Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B9437EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhJVT52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 15:57:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhJVT51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:57:27 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHXSD-1mQYEb2aZt-00DWRX for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021
 21:54:56 +0200
Received: by mail-wr1-f45.google.com with SMTP id e12so87135wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 12:54:56 -0700 (PDT)
X-Gm-Message-State: AOAM532RgcPfsd3E10wah+hRNxHP8t1bxk3CMWN2U/7EOv2K5rt0TW8p
        cj80uGqikkBIq7e+eSnPvcnubtFJPCnPbx/XCcs=
X-Google-Smtp-Source: ABdhPJxaBoY+j7evAJR9nKHPeSqSpIWsO9lvFcI+piIA0yZoVJhYPemgz55zc/SnlURZX+C7pDp9Gk55MCbMvJ8lpW0=
X-Received: by 2002:adf:e292:: with SMTP id v18mr2180860wri.369.1634932496330;
 Fri, 22 Oct 2021 12:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211022010027.11866-1-leoyang.li@nxp.com>
In-Reply-To: <20211022010027.11866-1-leoyang.li@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Oct 2021 21:54:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a35adaG9OzWWFSvjJcQo+hEnEJuLCL-8je-m+78JfjWxQ@mail.gmail.com>
Message-ID: <CAK8P3a35adaG9OzWWFSvjJcQo+hEnEJuLCL-8je-m+78JfjWxQ@mail.gmail.com>
Subject: Re: [GIT PULL] soc/fsl drivers changes for fix(v5.15)
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Diana Craciun <diana.craciun@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:niigE9SUguy9iIEO+QBnEtiZsR3EvE1qxGPJk0C0G7bRSIGxYOj
 PUu5kszQ1ozzgcemRqokmIBA9fL19nW/W7eUA/LJzhCz3Kjy9XpJ8KPNmkdEIvVmeHTQkxP
 YwbEl7/RE/IHBYxctopNs80Vbrgcf9sYasYVwJriASJTfk9PI8flapsYiAtzn1c3OR9kRUf
 fsKx5MlQtMWtWTiiVOt8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+wFLdvmtpSU=:QDGytyCGudjfsTCnl21RBd
 zk3IGoK8gfJ+n3MwteVQy1Cz13I/rMDQ0GfgZXuN+9nVsL54r55xQaezsa2BUW4HkMDgZ5uUC
 f0dZc8Vhpf+AxVgKh3JvlNMJAViWq+AqYh1mSWbSduZXQzq+qLQL3mwKI0nb7kbxWAsIiM2wJ
 +Mz8wDAJqPOrroMWb9ZdujkIUtWA6sIeTOiGt7M0VWhjS4b8/E496r9nYiJdU0yKdndtAe2Hr
 KJoxYhpda2YrxXltNg8oZdNiARfPxwnSmF9cM4lED+DSxnZS8FdwiBoWy18dNQgBvUxUtKlxV
 y44IErIS4t/If1ANFDlayommJC31dlaFq1ea+L4oGUTU6Y2BAlt3vkBC5T8FfadMNNTCTYdxS
 /oalWipx/M9O/xYkurTlb4P7BCXHkeZ3WG2w7dQhSbMfxJUqWBEz8oG4+4Gma7V3HJeJEgYrB
 iD9WfgHK+pfiVE+ZQ/Vxjif3zGgBTQOePCFAKjMPs60ebzqqlHhghtSxn9m6x/t7e8fEEFoF5
 JLfZUZkZ4XfFux20Qyhz5dyOLJK3i7OsL97mmComwTSJOGQkRr6vT5Fcp18VVx8JnCS9b4gr3
 d7Mxka3KRTns6CeCV9Y0MfGRI60QQ34tdz8aaTtLx/XaDE0mW2OU2XZn804GuGp9ZPgIboepg
 Y+p/dMV6b24OXdzuVaiUtL7YI56eYxHrxZonP7Z9hKEreYVGtga/7l+Xwo35vWC7gyUg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 3:00 AM Li Yang <leoyang.li@nxp.com> wrote:
> ----------------------------------------------------------------
> NXP/FSL SoC driver fixes for v5.15

> - fix qbman alignment error in the virtualization context

This patch looks very suspicious to me, I don't think it's generally safe to
use memcpy_toio() on a normal pointer, as the __iomem tokens may
be in a separate address range, even though this currently works
on arm64. Adding the  (__iomem void *) cast without a comment that
explains why it's added seems similarly wrong, and finally the
changeset text does not seem to match what the code does:

According to the text, the pointer is to a virtual address mapped as
"device memory" (i.e. PROT_DEVICE_nGnRE or PROT_DEVICE_nGnRnE),
but the code suggests it's actually write-combining normal
(PROT_NORMAL_NC).

I don't see any discussion of this patch on the mailing list either, so
please resend the pull request without this patch, while we try to figure
out what the driver should actually be doing here.

       Arnd
