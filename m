Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A772033298E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhCIPCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:02:17 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:50635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhCIPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:14 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUpCz-1lAfYm2lqT-00QlD2 for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021
 16:02:09 +0100
Received: by mail-oi1-f179.google.com with SMTP id d16so5939996oic.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 07:02:09 -0800 (PST)
X-Gm-Message-State: AOAM533ViUwU4TIbXSkRwKW0oJaEp2axrH8sKbU4rZzD64Fcsp4ZhISi
        l7dLjrGxNIEQL4TPGKneKIvl4tprDMBnILdcIk0=
X-Google-Smtp-Source: ABdhPJzTIgM2fhVY5j6KXohVaJlyghdcSYqc1Jc61vayF8YxU4DK4jWmIKbs6BsV89X+/uMZC3n/SV3WzmVi2ZNMQyc=
X-Received: by 2002:aca:bf44:: with SMTP id p65mr2059537oif.11.1615302128507;
 Tue, 09 Mar 2021 07:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20210303114511.927078317@linutronix.de>
In-Reply-To: <20210303114511.927078317@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Mar 2021 16:01:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2QjKiBZEM9GDQZRgfGu4MkOqxzaJKiwFB_NtWzD=Nhqg@mail.gmail.com>
Message-ID: <CAK8P3a2QjKiBZEM9GDQZRgfGu4MkOqxzaJKiwFB_NtWzD=Nhqg@mail.gmail.com>
Subject: Re: [patch 0/2] highmem/ARM: kmap_atomic cleanups
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WAdKh3BLHpht8hi8edOIaHzaB3FCIrveUKrgWZlNh/fKrzSnN+s
 r+oqF28yJB6c/5ZC6mDBQQIy5IX3S9WwjUaD+WboOkzuV5QWlDhcpdGEbe5DDfvoVEUXd+9
 2SZwyYMHlpqq4FH+Owcz98qdv54PuvvWZfhSNu/xqKqY7I7qlRHBYg556lql/oZzXoDBdJp
 bkBFLB8d+ZHNYxb2+vDUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mnKFy83s0Tc=:vCD6mC/2nRsVHdjEHopWtc
 CCO7+PGDmTM7cLuYnFdPeviORA1RfgYI4qV5WKTfjnw5n4lSyoEbwCbKtaZabW4Idp642FLpU
 MYj7qUsGsySwIL2jJoYljOiuvw7m1fpDu+AKhgOjfw/ddCUJeN/h6mVvX1QWKNkNsLDb3TGAY
 BF350QcwgqzZgk5uePo6igvl9B+daeX01uyQlP/M70R86AJ+IA9b/kJihFoHOMb9+0ZqQbGKT
 HkfhPGJrGaL3uEa7RxrlUIox4ZPpTZWnHa6DgXgNVq+GQ0e84oZ1bbFwrGGe9mT7CXp+27YKA
 HSDb6tbsxCRMp1mQFaOKpMIl1zcRgCeAWvnHbJSmrGsHlv+jWTWskDPJpe5bEZ0abYUwZXgph
 V2tLTGTH1+vdFisLxHCpBsDpF1bjOALLkOI72J3/RQQZD8aA+KhRbmLFQ6ZkNskQ1d7Ek1vkj
 +RjWO6oBGo1FvfmYRlBRBU9XmTW//jwjxcadg70r9ZxQ3+RGIi3X
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 12:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The last users of kmap_atomic_pfn() are in arch/arm and none of them
> requires the kmap_atomic semantics. Replace them with kmap_local_pfn() and
> remove kmap_atomic_pfn().

Looks good to me, both patches

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
